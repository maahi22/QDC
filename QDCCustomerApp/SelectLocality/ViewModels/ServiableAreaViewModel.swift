//
//  ServiableAreaViewModel.swift
//  QDCCustomerApp
//
//  Created by Amit Pant on 23/06/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import Foundation
class ServiableAreaViewModel: NSObject {
    @IBOutlet var servicableAreaClient:ServicableAreaClient!
    var servicableAreas:[ServicableAreaModel]?
    
    func getServicableArea(completion:@escaping (Bool, String)->())  {
        
        servicableAreaClient.fetchServiceableAreaList { [weak self] (servicableAreas, message) in
            guard let strongSelf = self else{return}
            if let servicableAreas = servicableAreas{
                strongSelf.servicableAreas = servicableAreas
                completion(true,message)
            }else{
                completion(false,message)
            }
        }
        
    }
    
    func numberOfServicableAreas() -> Int {
        guard let servicableAreas = servicableAreas else { return 0 }
        return servicableAreas.count
    }
    
    func servicableAreaForIndexPath(_ indexPath:IndexPath) -> ServicableAreaModel? {
        guard let servicableAreas = servicableAreas else { return nil }
        return servicableAreas[indexPath.row]
    }
}
