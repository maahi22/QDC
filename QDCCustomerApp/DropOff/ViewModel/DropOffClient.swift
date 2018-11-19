//
//  DropOffClient.swift
//  QDCCustomerApp
//
//  Created by Maahi on 10/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class DropOffClient: NSObject {

    // MARK: - Injections
    internal let networkClient = NetworkClient.shared
    
    
    
    static var requestParamDict:NSDictionary?
    //pick up date
    func fetchDropOff(_ dropOffDateKey:String ,_ dropOffTimeKey:String,    completion:@escaping ([DropOffModel]?,String)->())  {
        
        let clientID = QDCUserDefaults.getClientID()
        let branchID = QDCUserDefaults.getBranchId()
        let token = QDCUserDefaults.getAccessToken()
        
        let dbName = QDCUserDefaults.getDataBaseName()
        
        
        
     var encodedPickupDate = ""
        if let str = dropOffDateKey.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed){
            encodedPickupDate = str
        }
        
        var encodedPickupTime = ""
        if let str2 = dropOffTimeKey.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed){
            encodedPickupTime = str2
        }
        
        
        let apiname  = DROPOFF_DATE_AND_TIME_RELATIVE_URL + "ClientID=\(clientID)&BranchID=\(branchID)&PickUpDate=\(encodedPickupDate)&PickUpTime=\(encodedPickupTime)"
            
            
        let headers = ["token": "\(token)"] as [String:String]
        
        networkClient.callAPIWithAlamofire(apiname: apiname,
                                           requestType: .get,
                                           params: nil,
                                           headers: headers,
                                           success: { (data, httpResponse) in
                                            
                                            if let dropOffModel = decodeJSON(type: [DropOffModel].self, from: data) {
                                                completion(dropOffModel, "Success")
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
