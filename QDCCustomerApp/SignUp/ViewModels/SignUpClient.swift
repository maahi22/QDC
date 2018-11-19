//
//  SignUpClient.swift
//  QDCCustomerApp
//
//  Created by Amit Pant on 23/06/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import Foundation
import Alamofire
class SignUpClient: NSObject {
    
    // MARK: - Injections
    internal let networkClient = NetworkClient.shared
    
    func checkExistingCustomer(_ ClientID:String,branchid:String,FaceBookID:String,EmailID:String,MobileNo:String, completion:@escaping (CheckExistingCustomerModel?,String)->())  {
        let apiname = GET_CUSTOMER_DETAIL_RELATIVE_URL + "ClientID=\(ClientID)&branchid=\(branchid)&FaceBookID=\(FaceBookID)&EmailID=\(EmailID)&MobileNo=\(MobileNo)"
        networkClient.callAPIWithAlamofire(apiname: apiname,
                                           requestType: .get,
                                           params: nil,
                                           headers: nil,
                                           success: { (data, httpResponse) in
                                            if let checkExistingCustomerModel = decodeJSON(type: CheckExistingCustomerModel.self, from: data) {
                                                completion(checkExistingCustomerModel, "Success")
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
    
    func customerCreation(_ Name: String,
                          Address:String,
                          ClientID:String,
                          BranchID:String,
                          FaceBookID:String,
                          EmailId:String,
                          Mobile:String,
                          DeviceToken:String,
                          completion:@escaping (CustomerCreationModel?,String)->())  {
       
        let apiname = REGISTER_NEW_CUSTOMER_RELATIVE_URL
        let params = [ "CustomerSalutation": "",
                       "Name": "\(Name)",
            "Address": "\(Address)",
            "Phone": "",
            "Mobile": "\(Mobile)",
            "EmailId": "\(EmailId)",
            "CustomerPriority": "0",
            "DefaultDiscountRate": "0",
            "Remarks": "",  "BirthDate": "",  "AreaLocation": "",  "CommunicationMeans": "NA",
            "MemberShipId": "",  "RateListId": "0",  "HomeDelivery": "False",
            "FacebookID": "\(FaceBookID)",
            "BranchID": "\(BranchID)",
            "GCMKey": "",
            "DeviceToken": "\(DeviceToken)",
            "ClientID": "\(ClientID)",
            "CustomerRefferedBy": "",
            "GSTIN": "",
            "AnniversaryDate": "",
            "StateID": "0"  ] as [String:Any]
        let headers = ["Content-Type": "application/json"] as [String:String]
        networkClient.callAPIWithAlamofire(apiname: apiname,
                                           requestType: .post,
                                           params: params,
                                           headers: headers,
                                           success: { (data, httpResponse) in
                                            
                                            
                                            if let customerCreationModel = decodeJSON(type: CustomerCreationModel.self, from: data),
                                                let customerCode = httpResponse.allHeaderFields["CustomerCode"] as? String
                                                {
                                                 completion(customerCreationModel, customerCode)
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
    
    //GetCustomerToken
    func getCustomerToken(_ ClientID:String,BranchID:String,CustomerCode:String,
                          completion:@escaping (Bool,String)->())  {
        let apiname = GET_CUSTOMER_TOKEN_RELATIVE_URL
        let params = ["ClientID": "\(ClientID)",
            "BranchID": "\(BranchID)",
            "CustomerCode":"\(CustomerCode)"] as [String:Any]
        
        
        let headers = ["Content-Type": "application/json"] as [String:String]
        networkClient.callAPIWithAlamofire(apiname: apiname,
                                           requestType: .post,
                                           params: params,
                                           headers: headers,
                                           success: { (data, httpResponse) in
                                            if httpResponse.statusCode.isSuccessHTTPCode,let token = httpResponse.allHeaderFields["Token"] as? String{
                                                
                                                completion(true, "\(token)")
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
    
    //OTPCheck
    func OTPCheck(_ ClientID:String,BranchID:String,CustomerCode:String, OTP:String, token:String,
                          completion:@escaping (OTPCheckModel?,String)->())  {
        let apiname = CHECK_CUSTOMER_OTP_RELATIVE_URL + "\(ClientID)/\(BranchID)/\(CustomerCode)/\(OTP)"
        let headers = ["token": "\(token)"] as [String:String]
        
        networkClient.callAPIWithAlamofire(apiname: apiname,
                                           requestType: .get,
                                           params: nil,
                                           headers: headers,
                                           success: { (data, httpResponse) in
                                            
                                            if let otpCheckModel = decodeJSON(type: OTPCheckModel.self, from: data) {
                                                completion(otpCheckModel, "Success")
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

    //ReSendOTP
    
    func reSendOTP(_ ClientID:String,BranchID:String,CustomerCode:String,
                          completion:@escaping (Bool,String)->())  {
        let apiname = RESEND_OTP_RELATIVE_URL
        let params = ["ClientID": "\(ClientID)",
            "BranchID": "\(BranchID)",
            "CustomerCode":"\(CustomerCode)"] as [String:Any]
        
        let token = QDCUserDefaults.getAccessToken()
        let headers = ["Content-Type": "application/json",
                       "token": "\(token)"
                       ] as [String:String]
        networkClient.callAPIWithAlamofire(apiname: apiname,
                                           requestType: .post,
                                           params: params,
                                           headers: headers,
                                           success: { (data, httpResponse) in
                                            if httpResponse.statusCode.isSuccessHTTPCode{
                                                
                                                completion(true, "Success")
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
