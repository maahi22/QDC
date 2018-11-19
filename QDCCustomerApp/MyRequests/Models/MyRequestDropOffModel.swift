//
//  DropOffModel.swift
//  QDCCustomerApp
//
//  Created by Maahi on 10/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import Foundation


struct MyRequestDropOffModel:Codable{

    let ClientID:String?
    let BranchID:String?
    let StoreCode:String?
    let StoreName:String?
    
    var DropOffNumber : String?
    var DropDate : String?
    var DropOffTime : String?
    var Status : String?
    var PickUpNumber : String?
    var PickUpDate : String?
    var PickUpTime : String?
    var History : [HistoryModel]? //this will be the array of dropoffHistory model
    
}
