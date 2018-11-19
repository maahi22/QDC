//
//  MyRequestModel.swift
//  QDCCustomerApp
//
//  Created by Maahi on 10/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import Foundation

struct MyRequestModel:Codable{
    
    let ClientID:String?
    let BranchID:String?
    let StoreCode:String?
    let StoreName:String?
    let PickUpNumber:String?
    let PickUpDate:String?
    let PickUpTime:String?
    let Status:String?
    let ExpressDeliveryKey:String?
    let ExpressDeliveryValue:String?
    let SpecialInstruction:String?
    
}

