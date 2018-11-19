//
//  AboutUsViewModel.swift
//  QDCCustomerApp
//
//  Created by Maahi on 10/07/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import UIKit

class AboutUsViewModel: NSObject {

    @IBOutlet private var aboutUsClient:AboutUsClient!
    var aboutUs:AboutUsModel?
    
    
    func getAboutUsinformation(completion:@escaping(Bool,String)->())  {
        
        
        aboutUsClient.getAboutUs { [weak self] (aboutUs, message) in
            guard let strongSelf = self else{return}
            if let aboutUs = aboutUs{
                strongSelf.aboutUs = aboutUs
                completion(true,message)
            }else{
                completion(false,message)
            }
        }
        
    }
    
    
    
    func numberOfInformation() -> Int {
        guard let aboutUs = aboutUs else { return 0 }
        var count = 0
        let mirror = Mirror(reflecting: aboutUs)
        for child in mirror.children  {
           // print("key: \(child.label), value: \(child.value)")
            if ((child.label)?.contains("Heading"))! {
                count = count + 1
            }
        }
        
        return count
    }
    
    /*func InformationAt(for cellAtIndex:IndexPath) -> AboutUsModel? {
        guard let offers = offersList else { return nil }
        return offers[cellAtIndex.row]
        
    }*/
    
}
