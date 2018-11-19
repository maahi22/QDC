//
//  ActivePaymentModel.swift
//  QDCCustomerApp
//
//  Created by Amit Pant on 23/09/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import Foundation
struct ActivePaymentModel:Codable{
    let PaymentMethodID:Int
    let PaymentMethodName:String
    let PaymentMethodDescription:String
    let Active:String
    let IsSameConfig:String
    let PaymentVariables:[PaymentVariable]
}

struct PaymentVariable:Codable {
    let Key:String
    let Value:String
}
