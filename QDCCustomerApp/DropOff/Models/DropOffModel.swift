//
//  DropOffModel.swift
//  QDCCustomerApp
//
//  Created by Maahi on 10/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import Foundation

struct DropOffModel:Codable{
    
    let DropDateDate:String
    let DropOffTime:[DropOffTimeModel]
    
}



struct DropOffTimeModel:Codable {
    let Slots:String
}

struct ScheduleDropOffModel:Codable {
    let Status:String
    let Reason:String
    //let DropOffDateAndTimeSlot:String
}

/*struct ScheduleDetailsModel:Codable {
    let ExpressDelivery1: [ExpressDelivery]
    let ExpressDelivery2: [ExpressDelivery]
    
    let ShowDropOff:String
    let DropOffRequired:String
}

struct ExpressDelivery:Codable {
    let Key:String
    let Value:String
}*/
