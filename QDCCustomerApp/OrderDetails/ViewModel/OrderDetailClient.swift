//
//  OrderDetailClient.swift
//  QDCCustomerApp
//
//  Created by Maahi on 11/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class OrderDetailClient: NSObject {

    // MARK: - Injections
    internal let networkClient = NetworkClient.shared
    
    func featchOrderDetails(_ orderId :String ,completion:@escaping ([OrderSubDetailModel]?,String)->())  {
        
        let branchName = QDCUserDefaults.getDataBaseName()
        let branchID = QDCUserDefaults.getBranchId()
        let clientID = QDCUserDefaults.getClientID()
        let token = QDCUserDefaults.getAccessToken()
        let custId = QDCUserDefaults.getCustomerId()
        
        
        let apiname = ORDER_DETAILS_RELATIVE_URL + "\(clientID)/\(branchID)/\(orderId)"
        let headers = ["token": "\(token)"] as [String:String]
        
        
        networkClient.callAPIWithAlamofire(apiname: apiname,
                                           requestType: .get,
                                           params: nil,
                                           headers: headers,
                                           success: { (data, httpResponse) in
                                            if let myOrderViewModel = decodeJSON(type: [OrderSubDetailModel].self, from: data) {
                                                completion(myOrderViewModel, "Success")
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
