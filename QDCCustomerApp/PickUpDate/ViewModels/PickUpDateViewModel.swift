//
//  PickUpDateViewModel.swift
//  QDCCustomerApp
//
//  Created by Amit Pant on 07/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import Foundation
class PickUpDateViewModel: NSObject {
    @IBOutlet private var pickUpDateClient:PickUpDateClient!
    var pickUpDates:[PickUpDateModel]?
    
    func getPickUpDate(completion:@escaping(Bool,String)->())  {
        pickUpDateClient.getPickUpDate { [weak self](pickUpDateModels, message) in
            guard let strongSelf = self else{return}
            if let pickUpDateModels = pickUpDateModels{
                strongSelf.pickUpDates = pickUpDateModels
                let selectedDate = pickUpDateModels[0].PickUpDate
                let dates =  CommonUtilities.getTwoPreviousDaysFromString(dateString: selectedDate)
                strongSelf.pickUpDates?.insert(dates.dayTwo, at: 0)
                strongSelf.pickUpDates?.insert(dates.dayOne, at: 1)
                
                completion(true,"Success")
            }else{
                completion(false,message)
            }
        }
    }
    
    
    func numberOfPickUpDate() -> Int {
        guard let pickUpDates = pickUpDates else { return 0 }
        return pickUpDates.count
    }
    
    func pickUpFirstDate() -> String? {
        guard let pickUpDates = pickUpDates else { return nil }
        return pickUpDates[2].PickUpDate
    }
    
    func pickUpFirstTime() -> String? {
        guard let pickUpDates = pickUpDates else { return nil }
        let date =  pickUpDates[2].PickUpDate
    
        let pickUpTime = pickUpDates.filter({ (pickUpDateModel) -> Bool in
            return pickUpDateModel.PickUpDate == date
        })
        return pickUpTime[0].PickUpTime[0].Slots
    }
    
    
    func pickUpDate(for cellAtIndex:IndexPath) -> String? {
        guard let pickUpDates = pickUpDates else { return nil }
        return pickUpDates[cellAtIndex.item].PickUpDate
        
    }
    
    func numberOfPickUpTime(pickUpDate:String) -> Int {
        guard let pickUpDates = pickUpDates else { return 0 }
         let pickUpTime = pickUpDates.filter({ (pickUpDateModel) -> Bool in
            return pickUpDateModel.PickUpDate == pickUpDate
        })
        
        return pickUpTime[0].PickUpTime.count
    }
    
    func pickUpTime(for cellAtIndex:IndexPath, pickUpDate:String) -> String? {
        guard let pickUpDates = pickUpDates else { return nil }
        
        let pickUpTime = pickUpDates.filter({ (pickUpDateModel) -> Bool in
            return pickUpDateModel.PickUpDate == pickUpDate
        })
        
        return pickUpTime[0].PickUpTime[cellAtIndex.item].Slots
        
    }

}
