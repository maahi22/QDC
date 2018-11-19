//
//  SettingsClient.swift
//  QDCCustomerApp
//
//  Created by Maahi on 10/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit
import Alamofire
import Foundation


class SettingsClient: NSObject {

    // MARK: - Injections
    internal let networkClient = NetworkClient.shared
    
    
    //get getStoreInfo
    func getStoreInfo(completion:@escaping (StoreModel?,String)->())  {
        
        
        let clientID = QDCUserDefaults.getClientID()
        let branchID = QDCUserDefaults.getBranchId()
        let token = QDCUserDefaults.getAccessToken()
        
        let apiname = GET_STORE_DETAIL_RELATIVE_URL + clientID + "/" + branchID
        let headers = ["token": "\(token)"] as [String:String]
        
        networkClient.callAPIWithAlamofire(apiname: apiname,
                                           requestType: .get,
                                           params: nil,
                                           headers: headers,
                                           success: { (data, httpResponse) in
                                            
                                            if let storeModel = decodeJSON(type: StoreModel.self, from: data) {
                                                completion(storeModel, "Success")
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
