//
//  NotificationClient.swift
//  QDCCustomerApp
//
//  Created by Maahi on 10/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit
import Alamofire
import Foundation


class NotificationClient: NSObject {

    // MARK: - Injections
    internal let networkClient = NetworkClient.shared
    
    
    //get getStoreInfo
    func getNotificationList(completion:@escaping ([NotificationsModel]?,String)->())  {
        
        let custId = QDCUserDefaults.getCustomerId()
        let clientID = QDCUserDefaults.getClientID()
        let branchID = QDCUserDefaults.getBranchId()
        let token = QDCUserDefaults.getAccessToken()
        
        let apiname = NOTIFICATION_RELATIVE_URL + clientID + "/" + branchID + "/" + custId
        let headers = ["token": "\(token)"] as [String:String]
        
        networkClient.callAPIWithAlamofire(apiname: apiname,
                                           requestType: .get,
                                           params: nil,
                                           headers: headers,
                                           success: { (data, httpResponse) in
                                            
                                            if let notificationsModel = decodeJSON(type: [NotificationsModel].self, from: data) {
                                                completion(notificationsModel, "Success")
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
