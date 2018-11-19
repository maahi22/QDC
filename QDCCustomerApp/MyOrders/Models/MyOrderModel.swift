//
//  MyOrderModel.swift
//  QDCCustomerApp
//
//  Created by Maahi on 11/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import Foundation


struct OrderModel:Codable {
    
    let OrderSummary : [OrderSummaryModel]?
    let OrderDetails : [OrderDetailsModel]? 
    
    
    
}

struct OrderSummaryModel:Codable {
    let TotalOrder : String?
    let TotalAmount : String?
    let ProcessCloth : String?
    let ReadyCloth : String?
}


struct OrderDetailsModel:Codable {
    let BranchID : String?
    let StoreCode : String?
    let StoreName : String?
    let OrderNo : String?
    let OrderDate : String?
    let DueDate : String?
    let TotalGarments : String?
    let TotalAmount : String?
    let PendingGarment : String?
    let PendingAmount : String?
    let Status : String?
    
    
}


