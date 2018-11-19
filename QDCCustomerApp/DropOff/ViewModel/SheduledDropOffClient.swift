//
//  ScheduleDropOffClient.swift
//  QDCCustomerApp
//
//  Created by Maahi on 10/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class ScheduleDropOffClient: NSObject {
    // MARK: - Injections
    internal let networkClient = NetworkClient.shared
    
    
    
    
    
    
    
    
    
    
    
    //schedule details
    func getScheduleDropOff( dropOffDate:String,
                            dropOffTime:String,
                            flag:Int,
                            pickupNumber:String,
                            bookingNo:String,
                            dropOffNumber:String,
                            cancelReason:String?,
                            completion:@escaping (ScheduleDropOffModel?,String)->())  {
        
        let clientID = QDCUserDefaults.getClientID()
        let branchID = QDCUserDefaults.getBranchId()
        let customerCode = QDCUserDefaults.getCustomerId()
        let token = QDCUserDefaults.getAccessToken()
        
        var params = ["ClientID": clientID,
                      "BranchID":branchID,
                      "CustomerCode": customerCode,
                      "DropOffDate" :dropOffDate,
                      "DropOffTime" : dropOffTime,
                      "Flag":flag ,
                      "PickupNumber":pickupNumber,
                      "BookingNo":bookingNo,
                      "DropOffNumber":dropOffNumber,
                      ] as [String:Any]
        if let cancelReason = cancelReason {
            params["CancelReason"] = cancelReason
        }
        let headers = ["token": "\(token)", "Content-Type": "application/json"] as [String:String]
        
        let apiname = REQUEST_DROPOFF_RELATIVE_URL + "/\(clientID)/\(branchID)"
        
        networkClient.callAPIWithAlamofire(apiname: apiname,
                                           requestType: .post,
                                           params: params,
                                           headers: headers,
                                           success: { (data, httpResponse) in
                                            
                                            if let scheduleDropOffModel = decodeJSON(type: ScheduleDropOffModel.self, from: data) {
                                                completion(scheduleDropOffModel, "Success")
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
