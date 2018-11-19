//
//  HistoryModel.swift
//  QDCCustomerApp
//
//  Created by Maahi on 12/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import Foundation


struct HistoryModel:Codable{
    
    let EventDate:String?
    let EventTime:String?
    let EventType:String?
    let FromDate:String?
    var ToDate : String?
    var FromTime : String?
    var ToTime : String?
   
    
}
