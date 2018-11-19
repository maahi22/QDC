//
//  CustomerSummaryResponse.swift
//  QDCCustomerApp
//
//  Created by Amit Pant on 07/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import Foundation
struct CustomerSummaryModel:Codable {
    let PendingGarments:String
    let PendingAmount:String
    let Currency:String
}
