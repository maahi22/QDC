//
//  PriceListViewModel.swift
//  QDCCustomerApp
//
//  Created by Maahi on 10/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class PriceListViewModel: NSObject {

    @IBOutlet private var priceListClient:PriceListClient!
    var priceListModel:[PriceListModel]?
    let servicesArr = NSMutableArray()
    
    
    func getPriceList(completion:@escaping(Bool,String)->())  {
        
        priceListClient.fetchPriceList { [weak self] (priceListModel, message) in
            guard let strongSelf = self else{return}
            if let priceListModel = priceListModel{
                strongSelf.priceListModel = priceListModel
               
              guard let priceList = strongSelf.priceListModel else { return  }
                let model  = priceList[0]
                
                
                let mirror = Mirror(reflecting: model)
                for child in mirror.children  {
                    // print("key: \(child.label), value: \(child.value)")
                    if !((child.label)?.contains("Garment"))! {
                        
                        if let val = child.label{
                            strongSelf.servicesArr.add(val)
                        }
                        
                    }
                }
                
                
                
                
                
                completion(true,message)
            }else{
                completion(false,message)
            }
        }
        
    }
    
    func numberOfPriceItemsList() -> Int {
        let mutableArray = NSMutableArray()
        //let garmentCategorySet = NSMutableSet()
        
        guard let priceListModel = priceListModel else { return 0 }
        
        for priceModel in priceListModel{
        
            if let garment = priceModel.Garment{
                let arr = garment.components(separatedBy: "-")
                
                if !mutableArray.contains(arr[0]){
                    mutableArray.add(arr[0])
                }
            }
        }
        
        
        
        return mutableArray.count
    }
    
    func priceListItemsForIndexPath(_ indexPath:IndexPath) -> String? {
        
        let mutableArray = NSMutableArray()
        
        guard let priceListModel = priceListModel else { return nil }
        
        let sortedArr = priceListModel.sorted { (id1, id2) -> Bool in
            return id1.Garment!.lowercased() > id2.Garment!.lowercased() // Use > for Descending order
        }
        
        for priceModel in sortedArr{
            
            if let garment = priceModel.Garment{
                let arr = garment.components(separatedBy: "-")
                
                let catName:String = arr[0]
                
                if !mutableArray.contains(catName){
                    mutableArray.add(catName)
                }
            }
        }
        
        return mutableArray[indexPath.item] as? String//Amit Please check
    }
    
    
    
    
    
    
    
    
    func numberOfPriceList(_ selectCat:String) -> Int {
        let mutableArray = NSMutableArray()
        //let garmentCategorySet = NSMutableSet()
        
        guard let priceListModel = priceListModel else { return 0 }
        
        for priceModel in priceListModel{
            
            if let garment = priceModel.Garment{
                let arr = garment.components(separatedBy: "-")
                
                if (arr[0] == selectCat){
                    mutableArray.add(arr[1])
                }
            }
        }
        
        return mutableArray.count
    }
    
    
    
   // func priceListForIndexPath(_ selectCat:String, serviceType:PriceListModel.CodingKeys, Index:IndexPath) -> (item:String? ,qty:String?){
    func priceListForIndexPath(_ selectCat:String, selectedService:String,  Index:IndexPath) -> (item:String? ,qty:String?){
        
        let mutableArray = NSMutableArray()
        let mutableArray2 = NSMutableArray()
        
        guard let priceListModel = priceListModel else { return (nil, nil) }
        for priceModel in priceListModel{
            
            if let garment = priceModel.Garment{
                let arr = garment.components(separatedBy: "-")
                
                let catName:String = arr[0]
                
                if (catName == selectCat){
                    mutableArray.add(arr[1])
                    if selectedService.lowercased().hasPrefix("dry")  {
                        mutableArray2.add(priceModel.Dry_Cleaning ?? 0)
                    }
                    else if selectedService.lowercased().hasPrefix("steam") {
                        mutableArray2.add(priceModel.Steam_Press ?? 0)
                    }
                        
                    else if selectedService.lowercased().hasPrefix("tint") {
                        mutableArray2.add(priceModel.TINTORERIA ?? 0)
                    }
                }
                
               

            }
        }
        
        let item = mutableArray[Index.row] as? String
        let iQty = mutableArray2[Index.row] as? Int
        let qty = "\(iQty ?? 0)"
        
        return  (item,qty)//Amit Please check
    }
}
