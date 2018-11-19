//
//  ServicableAreaModel.swift
//  QDCCustomerApp
//
//  Created by Amit Pant on 23/06/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import Foundation

struct ServicableAreaModel:Codable{
    let DatabaseName:String?
    let BranchID:String?
    let Pincode:String?
    let Locality:String?
    let SubLocality:String?
    let CountryCode:String?
    let PackageName:String?
    let ClientID:String?
}
