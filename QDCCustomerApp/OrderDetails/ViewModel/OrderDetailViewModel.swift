//
//  OrderDetailViewModel.swift
//  QDCCustomerApp
//
//  Created by Maahi on 11/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class OrderDetailViewModel: NSObject {

    
    @IBOutlet private var orderDetailClient:OrderDetailClient!
    var orderSubDetailModel:[OrderSubDetailModel]?
    
    
    
    
    
    func getMyOrder(_ orderId:String, completion:@escaping(Bool,String)->())  {
        
        orderDetailClient.featchOrderDetails(orderId) { [weak self] (orderSubDetailModel, message) in
            
            guard let strongSelf = self else{return}
            if let orderSubDetailModel = orderSubDetailModel{
                strongSelf.orderSubDetailModel = orderSubDetailModel
                completion(true,message)
            }else{
                completion(false,message)
            }
        }
        
    }
    
    func numberOfmyOrder() -> Int {
        guard let orderSubDetailModel = orderSubDetailModel else { return 0 }
        
        return orderSubDetailModel.count
    }
    
    func myOrderForIndexPath(_ indexPath:IndexPath) -> OrderSubDetailModel? {
        guard let orderSubDetailModel = orderSubDetailModel else { return nil }
        return orderSubDetailModel[indexPath.row]
        
        
    }
    
    
    
}
