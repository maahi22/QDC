//
//  ServicableAreaClient.swift
//  QDCCustomerApp
//
//  Created by Amit Pant on 23/06/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import Foundation
import Alamofire
class ServicableAreaClient: NSObject {
    
    // MARK: - Injections
    internal let networkClient = NetworkClient.shared
    
    func fetchServiceableAreaList(completion:@escaping ([ServicableAreaModel]?,String)->())  {
        
        
        var pincode = PINCODE
        if QDCUserDefaults.getPinCode().count > 0{
            pincode = QDCUserDefaults.getPinCode()
        }
        let apiname = GET_LICENSE_DETAIL_RELATIVE_URL +   pincode + "/" + APPSLUG
       networkClient.callAPIWithAlamofire(apiname: apiname,
                                          requestType: .get,
                                          params: nil,
                                          headers: nil,
                                          success: { (data, httpResponse) in
                                            if let servicableAreaModels = decodeJSON(type: [ServicableAreaModel].self, from: data) {
                                                completion(servicableAreaModels, "Success")
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
