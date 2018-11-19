//
//  Section.swift
//  IMMTradersClub
//
//  Created by Maxtra Technologies P LTD on 19/09/17.
//  Copyright © 2017 Maxtra Technologies P LTD. All rights reserved.
//

import Foundation
enum MenuItemType{
    case home
    case pickUp
    case myRequest
    case dueAmount
    case myOrder
    case mywallet
    case contact
    case email
    case signout
    case feepaymenthistory
    case none
    case profile

    case priceList
    case offers
    case feedback
    case settings
    case aboutUs
}
struct Section {
    
    let name:String
    let items:[String]
    let image:String
    let selImage:String
    let expanded:Bool
    let itemType:MenuItemType
  
}
