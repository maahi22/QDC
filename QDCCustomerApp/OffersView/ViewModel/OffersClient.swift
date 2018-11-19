//
//  OffersClient.swift
//  QDCCustomerApp
//
//  Created by Maahi on 09/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit
import Alamofire
import Foundation

class OffersClient: NSObject {
    // MARK: - Injections
    internal let networkClient = NetworkClient.shared
    
    
    //get offers
    func getOffers(completion:@escaping ([OfferModel]?,String)->())  {
        
        let branchName = QDCUserDefaults.getDataBaseName()
        let clientID = QDCUserDefaults.getClientID()
        let branchID = QDCUserDefaults.getBranchId()
        let token = QDCUserDefaults.getAccessToken()
        
        //let apiname = GET_OFFERS_RELATIVE_URL + branchName + "/" + branchID
        let apiname = GET_OFFERS_RELATIVE_URL + clientID + "/" + branchID
        let headers = ["token": "\(token)"] as [String:String]
        
        networkClient.callAPIWithAlamofire(apiname: apiname,
                                           requestType: .get,
                                           params: nil,
                                           headers: headers,
                                           success: { (data, httpResponse) in
                                            
                                            if let offerModel = decodeJSON(type: [OfferModel].self, from: data) {
                                                completion(offerModel, "Success")
                                            }
                                            else if let messageModel = decodeJSON(type: MessageModel.self, from: data) {
                                                completion(nil, messageModel.Message ?? "")
                                            }
                                                
                                            else{
                                                completion(nil,"failed")
                                            }
                                            
        }) { (error, message) in
            
            completion(nil,message)
            
        }
    }
}
