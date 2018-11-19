//
//  SettingsViewModel.swift
//  QDCCustomerApp
//
//  Created by Maahi on 10/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class SettingsViewModel: NSObject {

    @IBOutlet private var settingsClient:SettingsClient!
    var storeModel:StoreModel?
    
    func getSettingsinformation(completion:@escaping(Bool,String)->())  {
        
        
        settingsClient.getStoreInfo { [weak self] (storeModel, message) in
            guard let strongSelf = self else{return}
            if let storeModel = storeModel{
                strongSelf.storeModel = storeModel
                if let BranchEmail = storeModel.BranchEmail{
                    QDCUserDefaults.setClientEmail(email: BranchEmail)
                }
                
                if let BranchAddress = storeModel.BranchAddress{
                    QDCUserDefaults.setClientAddress(address: BranchAddress)
                }
                
                if let CallcenterMobileNo = storeModel.CallcenterMobileNo{
                    QDCUserDefaults.setClientPhoneNumber(phoneNo: CallcenterMobileNo)
                }
                
                if let ShareMessage = storeModel.IosShareMessage{
                    QDCUserDefaults.setAppLink(appLink: ShareMessage)
                }

                completion(true,message)
            }else{
                completion(false,message)
            }
        }
        
    }
    
    
    
    func numberOfInformation() -> Int {
        
        
        return 0
    }
    
}
