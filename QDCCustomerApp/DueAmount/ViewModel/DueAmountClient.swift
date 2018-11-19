//
//  DueAmountClient.swift
//  QDCCustomerApp
//
//  Created by Maahi on 09/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit
import Alamofire
class DueAmountClient: NSObject {

    // MARK: - Injections
    internal let networkClient = NetworkClient.shared
    
    func getDueAmount(completion:@escaping (CustomerSummaryModel?,String)->())  {
        
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
    
    
    func getActivePaymentMethodDetails(completion:@escaping ([ActivePaymentModel]?,String)->())  {
        
        let clientID = QDCUserDefaults.getClientID()
        let branchID = QDCUserDefaults.getBranchId()
        
        let token = QDCUserDefaults.getAccessToken()
        
        let apiname = ACTIVE_PAYMENT_METHOD_DETAILS + "\(clientID)/\(branchID)/"
        let headers = ["token": "\(token)"] as [String:String]
        
        networkClient.callAPIWithAlamofire(apiname: apiname,
                                           requestType: .get,
                                           params: nil,
                                           headers: headers,
                                           success: { (data, httpResponse) in
                                            
                                            if let activePaymentModel = decodeJSON(type: [ActivePaymentModel].self, from: data) {
                                                completion(activePaymentModel, "Success")
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
    
    
    
    
    //schedule details
    func updatePayment( paymentResponseData:String,
                             amount:String,
                             orderNumber:String,
                             completion:@escaping (Bool,String)->())  {
        
        let clientID = QDCUserDefaults.getClientID()
        let branchID = QDCUserDefaults.getBranchId()
        //let customerCode = QDCUserDefaults.getCustomerId()
        let token = QDCUserDefaults.getAccessToken()
        
        
                let params = ["ClientID": clientID,
                      "BranchID":branchID,
                      "PaymentMethodID": "2",
                      "OrderNumber" :"\(orderNumber)",
                      "ResponseData" : paymentResponseData,
                      "Amount":amount
                      ] as [String:Any]
        
        let headers = ["token": "\(token)", "Content-Type": "application/json"] as [String:String]
        
        let apiname = PAYMENT_UPDATE
        
        networkClient.callAPIWithAlamofire(apiname: apiname,
                                           requestType: .post,
                                           params: params,
                                           headers: headers,
                                           success: { (data, httpResponse) in
                                            
                                            completion(true,"")
                                            
        }) { (error, message) in
            
            completion(false,message)
            
        }
    }
}
