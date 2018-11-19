//
//  NotificationViewModel.swift
//  QDCCustomerApp
//
//  Created by Maahi on 10/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class NotificationViewModel: NSObject {
    
    
    @IBOutlet private var notificationClient:NotificationClient!
    var notificationsModel:[NotificationsModel]?
    
    func getNotifications(completion:@escaping(Bool,String)->())  {
        
        
        notificationClient.getNotificationList { [weak self] (notificationsModel, message) in
            guard let strongSelf = self else{return}
            if let notificationsModel = notificationsModel{
                strongSelf.notificationsModel = notificationsModel
                completion(true,message)
            }else{
                completion(false,message)
            }
        }
        
    }

    
    
    
    func numberOffers() -> Int {
        guard let notificationsModel = notificationsModel else { return 0 }
        return notificationsModel.count
    }
    
    func offersAt(for cellAtIndex:IndexPath) -> NotificationsModel? {
        guard let list = notificationsModel else { return nil }
        return list[cellAtIndex.row]
        
    }
    
    
    
}
