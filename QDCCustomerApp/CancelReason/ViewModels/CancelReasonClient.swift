//
//  CancelReasonClient.swift
//  QDCCustomerApp
//
//  Created by Amit Pant on 07/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import Foundation
class CancelReasonClient: NSObject {
    // MARK: - Injections
    internal let networkClient = NetworkClient.shared
    
    func getCancelReason(completion:@escaping ([CancelReasonModel]?,String)->())  {
        
        let clientID = QDCUserDefaults.getClientID()
        let token = QDCUserDefaults.getAccessToken()
        
        let apiname = GET_CANCEL_REASON_RELATIVE_URL + "\(clientID)/"
        
        let headers = ["token": "\(token)"] as [String:String]
        
        networkClient.callAPIWithAlamofire(apiname: apiname,
                                           requestType: .get,
                                           params: nil,
                                           headers: headers,
                                           success: { (data, httpResponse) in
                                            
                                            if let cancelReasonModel = decodeJSON(type: [CancelReasonModel].self, from: data) {
                                                completion(cancelReasonModel, "Success")
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
