//
//  PriceListModel.swift
//  QDCCustomerApp
//
//  Created by Maahi on 09/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import Foundation


struct PriceListModel:Codable {
    let Garment:String?
    let Dry_Cleaning:Int?
    let Steam_Press:Int?
    let TINTORERIA:Int?
    
    enum CodingKeys:String,CodingKey {
        case Garment
        case Dry_Cleaning = "Dry Cleaning"
        case Steam_Press = "Steam Press"
        case TINTORERIA
    }
}



