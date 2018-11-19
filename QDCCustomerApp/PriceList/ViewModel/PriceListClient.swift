//
//  PriceListClient.swift
//  QDCCustomerApp
//
//  Created by Maahi on 10/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit
import Alamofire



class PriceListClient: NSObject {

    // MARK: - Injections
    internal let networkClient = NetworkClient.shared
    
    func fetchPriceList(completion:@escaping ([PriceListModel]?,String)->())  {
        
        //let branchName = QDCUserDefaults.getDataBaseName()
        let branchID = QDCUserDefaults.getBranchId()
        let clientID = QDCUserDefaults.getClientID()
        let token = QDCUserDefaults.getAccessToken()
        
        
        let apiname = PRICE_LIST_RELATIVE_URL + "\(clientID)/\(branchID)"//+ branchName + "/" + branchId
        let headers = ["token": "\(token)"] as [String:String]
        
        
        networkClient.callAPIWithAlamofire(apiname: apiname,
                                           requestType: .get,
                                           params: nil,
                                           headers: headers,
                                           success: { (data, httpResponse) in
                                            if let priceListModel = decodeJSON(type: [PriceListModel].self, from: data) {
                                                completion(priceListModel, "Success")
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
