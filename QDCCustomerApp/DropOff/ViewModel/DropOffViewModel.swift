//
//  DropOffViewModel.swift
//  QDCCustomerApp
//
//  Created by Maahi on 10/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class DropOffViewModel: NSObject {

    @IBOutlet private var dropOffClient:DropOffClient!
    var dropOffDates:[DropOffModel]?
    
    func getDropOff(pickupDateKey:String ,pickupTimeKey:String, completion:@escaping(Bool,String)->())  {
       
        
        dropOffClient.fetchDropOff(pickupDateKey,pickupTimeKey) { [weak self](dropOffDateModels, message) in
            guard let strongSelf = self else{return}
            if let dropOffDateModels = dropOffDateModels{
                strongSelf.dropOffDates = dropOffDateModels
                let selectedDate = dropOffDateModels[0].DropDateDate
                let dates =  CommonUtilities.getTwoPreviousDaysFromStringForDropOFF(dateString: selectedDate)
                strongSelf.dropOffDates?.insert(dates.dayTwo, at: 0)
                strongSelf.dropOffDates?.insert(dates.dayOne, at: 1)
                
                completion(true,"Success")
            }else{
                completion(false,message)
            }
            
        }
    }
    
    
    func numberOfDropOffDate() -> Int {
        guard let dropOffDates = dropOffDates else { return 0 }
        return dropOffDates.count
    }
    
    func dropOffFirstDate() -> String? {
        guard let dropOffDates = dropOffDates else { return nil }
        return dropOffDates[2].DropDateDate
    }
    
    func dropOffFirstTime() -> String? {
        guard let dropOffDates = dropOffDates else { return nil }
        let date =  dropOffDates[2].DropDateDate
        
        let dropOffTime = dropOffDates.filter({ (dropOffDateModels) -> Bool in
            return dropOffDateModels.DropDateDate == date
        })
        return dropOffTime[0].DropOffTime[0].Slots
    }
    
    
    func dropOffDate(for cellAtIndex:IndexPath) -> String? {
        guard let dropOffDates = dropOffDates else { return nil }
        return dropOffDates[cellAtIndex.item].DropDateDate
        
    }
    
    func numberOfDropOffTime(dropOffDate:String) -> Int {
        
        if dropOffDate == "" {
            return 0
        }
        
        guard let dropOffDates = dropOffDates else { return 0 }
        let dropOffTime = dropOffDates.filter({ (dropOffDateModels) -> Bool in
            return dropOffDateModels.DropDateDate == dropOffDate
        })
        
        return dropOffTime[0].DropOffTime.count
    }
    
    func dropOffTime(for cellAtIndex:IndexPath, dropOffDate:String) -> String? {
        guard let dropOffDates = dropOffDates else { return nil }
        
        let dropOffTime = dropOffDates.filter({ (dropOffDateModels) -> Bool in
            return dropOffDateModels.DropDateDate == dropOffDate
        })
        
        return dropOffTime[0].DropOffTime[cellAtIndex.item].Slots
        
    }
}
