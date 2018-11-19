//
//  MyRequestViewModel.swift
//  QDCCustomerApp
//
//  Created by Maahi on 10/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class MyRequestViewModel: NSObject {

    
    @IBOutlet  var schedulePickUpDateClient:SchedulePickUpDateClient!
    @IBOutlet  var ScheduleDropOffClient:ScheduleDropOffClient!
    
    @IBOutlet private var myRequestClient:MyRequestClient!
    var myRequestModel:[MyRequestModel]?
    
    
    func getMyRequest(completion:@escaping(Bool,String)->())  {
        
        myRequestClient.fetchMyRequest { [weak self] (myRequestModel, message) in
            guard let strongSelf = self else{return}
            if let myRequestModel = myRequestModel{
                strongSelf.myRequestModel = myRequestModel
                completion(true,message)
            }else{
                completion(false,message)
            }
        }
    }
    
    
    
    func numberMyRequest() -> Int {
        guard let myRequestModel = myRequestModel else { return 0 }
        return myRequestModel.count
    }
    
    
    func myRequestAt(for cellAtIndex:IndexPath) -> MyRequestModel? {
        guard let myRequestModel = myRequestModel else { return nil }
        return myRequestModel[cellAtIndex.row]
        
    }
    
    
    
    func cancelPickUpRequest(_ cancelReason:String , index:IndexPath ,completion:@escaping(Bool,String)->()) {
        
        guard let pickupModel = myRequestModel else {   completion(false ,"Something went wrong please try again later");         return  }
        
        // guard let selectedMyRequestDropOffModel = dropOffModel[index.row] else { return  }
        let pickUpObj = pickupModel[index.row]
        
        
        guard
            let pickUpDate = pickUpObj.PickUpDate,
            let pickUpTime = pickUpObj.PickUpTime,
            let pickUpNumber = pickUpObj.PickUpNumber
            else {
             completion(false ,"Something went wrong please try again later");   return
        }
        
        schedulePickUpDateClient.getSchedulePickup(pickupDate:pickUpDate ,
                                                   pickupTime:pickUpTime ,
                                                   flag: 3,
                                                   pickupNumber:pickUpNumber ,
                                                   expressDeliveryID: "",
                                                   specialInstruction: "",
                                                   dropOffDate: "",
                                                   dropOffTime: "",
                                                   cancelReason: cancelReason) { [weak self] (schedulePickUpModel, message) in
                                                    guard let strongSelf = self else{return}
                                                    if let schedulePickUpModel = schedulePickUpModel {
                                                        
                                                        if schedulePickUpModel.Status == "Done" {
                                                            
                                                            strongSelf.myRequestModel?.remove(at: index.row)
                                                            completion(true ,"Pick up successfully cancelled")
                                                        }else{
                                                            completion(false ,"Something went wrong please try again later")
                                                        }
                                                        
                                                    }else{
                                                        completion(false ,"Something went wrong please try again later")
                                                    }
        }
        
    }
    
   
    
    //DropOff
    @IBOutlet private var myDropOffClient:MyDropOffClient!
    var dropOffModel:[MyRequestDropOffModel]?
    
    
    func getDropOff(completion:@escaping(Bool,String)->())  {
        
        myDropOffClient.fetchMyDropOff { [weak self] (dropOffModel, message) in
           
            guard let strongSelf = self else{return}
            if let dropOffModel = dropOffModel{
                strongSelf.dropOffModel = dropOffModel
                completion(true,message)
            }else{
                completion(false,message)
            }
        }
    }
    
    
    
    func numberMyRequestDropOff() -> Int {
        guard let dropOffModel = dropOffModel else { return 0 }
        return dropOffModel.count
    }
    
    
    func myRequestDropOffAt(for cellAtIndex:IndexPath) -> MyRequestDropOffModel? {
        guard let dropOffModel = dropOffModel else { return nil }
        return dropOffModel[cellAtIndex.row]
        
    }
    
    
    func cancelDropOffRequest(_ cancelReason:String , index:IndexPath ,completion:@escaping(Bool,String)->()) {
        
        guard let dropOffModel = dropOffModel else {   completion(false ,"Something went wrong please try again later");         return  }
        
        // guard let selectedMyRequestDropOffModel = dropOffModel[index.row] else { return  }
        let dropOffObj = dropOffModel[index.row]
        
        guard
            let dropoffUpDate = dropOffObj.DropDate,
            let dropOffTime = dropOffObj.DropOffTime,
            let dropOffNumber = dropOffObj.DropOffNumber
            else {
                completion(false ,"Something went wrong please try again later")
                return
        }
        
        
        ScheduleDropOffClient.getScheduleDropOff(dropOffDate: dropoffUpDate,
                                                 dropOffTime: dropOffTime,
                                                 flag: 3,
                                                 pickupNumber: "",
                                                 bookingNo: "",
                                                 dropOffNumber: dropOffNumber,
                                                 cancelReason: cancelReason) { [weak self] (scheduleDropOffModel, message) in
                                                    
                                                    guard let strongSelf = self else{return}
                                                    
                                                    if let scheduleDropOffModel = scheduleDropOffModel {
                                                        
                                                        
                                                        //var message = ""
                                                        if scheduleDropOffModel.Status == "Done" {
                                                            strongSelf.dropOffModel?.remove(at: index.row)
                                                           
                                                            completion(true ,"Drop off successfully cancelled")
                                                            //message = "Pick up successfully cancelled"
                                                        }else{
                                                            completion(false ,"Something went wrong please try again later")
                                                            //message = "Something went wrong please try again later"
                                                        }
                                                        
                                                        // showAlertMessage(vc: strongSelf, title: .Message, message: message)
                                                        
                                                        
                                                    }else{
                                                        completion(false ,"Something went wrong please try again later")
                                                        //showAlertMessage(vc: strongSelf, title: .Error, message: "Something went wrong please try again later")
                                                    }
                                                    
        }
    }
    
}
