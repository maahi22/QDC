//
//  CustomerSummaryClient.swift
//  QDCCustomerApp
//
//  Created by Amit Pant on 07/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import Foundation

import Alamofire
class CustomerSummaryClient: NSObject {
    // MARK: - Injections
    internal let networkClient = NetworkClient.shared
    
    func getCustomerSummary(completion:@escaping (CustomerSummaryModel?,String)->())  {
        
        let clientID = QDCUserDefaults.getClientID()
        let branchID = QDCUserDefaults.getBranchId()
        let customerCode = QDCUserDefaults.getCustomerId()
        let token = QDCUserDefaults.getAccessToken()
        
        let apiname = CUSTOMER_HOME_RELATIVE_URL + "\(clientID)/\(branchID)/\(customerCode)"
        let headers = ["token": "\(token)"] as [String:String]
        
        networkClient.callAPIWithAlamofire(apiname: apiname,
                                           requestType: .get,
                                           params: nil,
                                           headers: headers,
                                           success: { (data, httpResponse) in
                                            
                                            if let customerSummaryModel = decodeJSON(type: CustomerSummaryModel.self, from: data) {
                                                completion(customerSummaryModel, "Success")
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
