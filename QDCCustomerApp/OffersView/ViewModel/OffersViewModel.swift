//
//  OffersViewModel.swift
//  QDCCustomerApp
//
//  Created by Maahi on 09/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class OffersViewModel: NSObject {

    @IBOutlet private var offersClient:OffersClient!
    var offersList:[OfferModel]?
    
    
    func getOffers(completion:@escaping(Bool,String)->())  {
       
        
        offersClient.getOffers { [weak self] (offersList, message) in
            guard let strongSelf = self else{return}
            if let offersList = offersList{
                strongSelf.offersList = offersList
                completion(true,message)
            }else{
                completion(false,message)
            }
        }
        
    }
    
    
    
    func numberOffers() -> Int {
        guard let offers = offersList else { return 0 }
        return offers.count
    }
    
    func offersAt(for cellAtIndex:IndexPath) -> OfferModel? {
        guard let offers = offersList else { return nil }
        return offers[cellAtIndex.row]
        
    }
    
}
