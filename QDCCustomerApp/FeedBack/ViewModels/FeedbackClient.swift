//
//  FeedbackClient.swift
//  QDCCustomerApp
//
//  Created by Maahi on 08/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class FeedbackClient: NSObject {

    // MARK: - Injections
    internal let networkClient = NetworkClient.shared
    
    
    
    
    //schedule details
    func sendFeedBack( messageString:String,
                            completion:@escaping (Bool,String)->())  {
        
       let clientID = QDCUserDefaults.getClientID()
        let branchID = QDCUserDefaults.getBranchId()
        let customerCode = QDCUserDefaults.getCustomerId()
        let token = QDCUserDefaults.getAccessToken()
       // let dbName = QDCUserDefaults.getDataBaseName()
        
        let apiname = FEEDBACK_RELATIVE_URL
        
        
        let params = ["Message": messageString,
                      "BranchID":branchID,
                      "CustomerCode": customerCode,
                      "ClientID" :clientID] as [String:Any]
        
        let headers = ["token": "\(token)", "Content-Type": "application/json"] as [String:String]
        
        networkClient.callAPIWithAlamofire(apiname: apiname,
                                           requestType: .post,
                                           params: params,
                                           headers: headers,
                                           success: { (data, httpResponse) in
                                            
                                            if httpResponse.statusCode == 200 {
                                                completion(true, "Thank you for your valuable feedback.")
                                            }
                                            else if let messageModel = decodeJSON(type: MessageModel.self, from: data) {
                                                completion(false, messageModel.Message ?? "")
                                            }
                                                
                                            else{
                                                completion(false,"failed")
                                            }
                                            
        }) { (error, message) in
            
            completion(false,message)
            
        }
    }
}
