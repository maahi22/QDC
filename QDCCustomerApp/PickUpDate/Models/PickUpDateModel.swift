//
//  PickUpDateModel.swift
//  QDCCustomerApp
//
//  Created by Amit Pant on 07/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import Foundation

struct PickUpDateModel:Codable {
    let PickUpDate:String
    let PickUpTime:[PickUpTimeModel]
}

struct PickUpTimeModel:Codable {
    let Slots:String
}

struct SchedulePickupModel:Codable {
    let Status:String
    let Reason:String
    let DropOffDateAndTimeSlot:String
}

struct ScheduleDetailsModel:Codable {
    let ExpressDelivery1: [ExpressDelivery]
    let ExpressDelivery2: [ExpressDelivery]
    
    let ShowDropOff:String
    let DropOffRequired:String
}

struct ExpressDelivery:Codable {
    let Key:String
    let Value:String
}
