//
//  ProfileClient.swift
//  QDCCustomerApp
//
//  Created by Maahi on 11/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class ProfileClient: NSObject {

    // MARK: - Injections
    internal let networkClient = NetworkClient.shared
    
    
    
    func updateProfile( areaLocation:String,
                            name:String,
                            address:String,
                            
                            completion:@escaping (Bool,CustomerCreationModel?,String)->())  {
        
        let dbName = QDCUserDefaults.getDataBaseName()
        let clientID = QDCUserDefaults.getClientID()
        let branchID = QDCUserDefaults.getBranchId()
        let customerCode = QDCUserDefaults.getCustomerId()
        let token = QDCUserDefaults.getAccessToken()
        // {"ClientID":"1677",BranchID:"5",CustomerCode: "Cust34", Name:"dfgfdhgdh",Address:"Delhi,Area","AreaLocation":"Ashok Vihar"}
        var params = ["AreaLocation": areaLocation,
                      "Name":name,
                      "Address": address,
                      "CustomerCode" :customerCode,
                      "ClientID" : clientID,
                      "BranchID":branchID ] as [String:Any]
        
        let headers = ["token": "\(token)", "Content-Type": "application/json"] as [String:String]
        
        let apiname = UPDATE_CUSTOMER_PROFILE_RELATIVE_URL
        
        networkClient.callAPIWithAlamofire(apiname: apiname,
                                           requestType: .post,
                                           params: params,
                                           headers: headers,
                                           success: { (data, httpResponse) in
                                            
                                            
                                            if httpResponse.statusCode == 200 {
                                                
                                                completion(true,nil, "Profile update successfully")
                                                return
                                                
                                                
                                                if let customerCreationModel = decodeJSON(type: CustomerCreationModel.self, from: data) {
                                                    completion(true,customerCreationModel, "Success")
                                                }else if let messageModel = decodeJSON(type: MessageModel.self, from: data) {
                                                    completion(false,nil, messageModel.Message ?? "")
                                                }
                                                    
                                                else{
                                                    completion(false,nil,"failed")
                                                }
                                                
                                                
                                            }
                                            else if let messageModel = decodeJSON(type: MessageModel.self, from: data) {
                                                completion(false,nil, messageModel.Message ?? "")
                                            }
                                                
                                            else{
                                                completion(false,nil,"failed")
                                            }

                                            
                                            
                                            
                                           
                                                
                                                
                                                
                                            
                                            
        }) { (error, message) in
            
            completion(false,nil,message)
            
        }
    }
    
    
}
