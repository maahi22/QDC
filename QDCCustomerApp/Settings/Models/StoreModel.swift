//
//  StoreModel.swift
//  QDCCustomerApp
//
//  Created by Maahi on 10/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import Foundation


struct StoreModel:Codable {
    let BranchName:String?
    let BranchCity:String?
    let BranchLocation:String?
    let BranchAddress:String?
    let BusinessName:String?
    let BranchMobile:String?
    let BranchEmail:String?
    let PickUpStartTime:String?
    let PickUpEndTime:String?
    let PickUpTimeDiff:String?
    let HolidayDate:[HolidayDateModel]
    
    let ShareMessage:String?
    let AppURL:String?
    let CallcenterMobileNo:String?
    let IosAppURL:String?
    let IosShareMessage:String?
    
}


struct HolidayDateModel:Codable {
    let Holiday:String
}
