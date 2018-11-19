//
//  MyOrderViewModel.swift
//  QDCCustomerApp
//
//  Created by Maahi on 11/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class MyOrderViewModel: NSObject {

    @IBOutlet private var myOrderClient:MyOrderClient!
    var orderModel:[OrderModel]?
  
    func getMyOrder(completion:@escaping(OrderSummaryModel?,String)->())  {
        
        myOrderClient.featchMyOrder { [weak self] (orderModel, message) in
            guard let strongSelf = self else{return}
            if let orderModel = orderModel, let orderSummary = orderModel.first?.OrderSummary?.first{
                strongSelf.orderModel = orderModel
                completion(orderSummary,message)
            }else{
                completion(nil,"No data found!")
            }
        }
        
    }
    
    func numberOfmyOrder() -> Int {
        guard let orderModel = orderModel else { return 0 }
        //guard let orderModel = orderModel.orderDetailsModel else { return 0 }
        guard let myOrderdetailModel = orderModel[0].OrderDetails else { return 0 }
        return myOrderdetailModel.count
    }
    
    func myOrderForIndexPath(_ indexPath:IndexPath) -> OrderDetailsModel? {
        guard let orderModel = orderModel else { return nil }
        guard let myOrderdetailModel = orderModel[0].OrderDetails else { return nil }
        return myOrderdetailModel[indexPath.row]
    }
    
    
}
