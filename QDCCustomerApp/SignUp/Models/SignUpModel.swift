//
//  SignUpModel.swift
//  QDCCustomerApp
//
//  Created by Amit Pant on 23/06/18.
//  Copyright © 2018 QuickDryCleaning. All rights reserved.
//

import Foundation

struct CheckExistingCustomerModel:Codable {
    let IsCustExist:String?
    let CustCode:String?
    let FacebookId:String?
    let CustomerEmailId:String?
    let CustomerMobile:String?
    let CustomerAddress:String?
    let FirstPickUp:String?
    let PhoneVerified:String?
    let CustomerName:String?
    let CustomerImgUrl:String?
    let AreaLocation:String?
    let BranchID:String?
    let ClientID:String?
    let Configuration:[Configuration]
}
struct Configuration:Codable {
    let IsDisableDropoff:String
}


///Customer Creation
struct CustomerCreationModel:Codable {
    let CustomerCode:String?
    let CustomerSalutation:String?
    let Name:String?
    let Address:String?
    let Phone:String?
    let Mobile:String?
    let EmailId:String?
    let CustomerPriority:String?
    let DefaultDiscountRate:String?
    let Remarks:String?
    let BirthDate:String?
    let City:String?
    let AreaLocation:String?
    let Profession:String?
    let CommunicationMeans:String?
    let IsWebsite:String?
    let MemberShipId:String?
    let BarCode:String?
    let RateListId:String?
    let HomeDelivery:String?
    let Password:String?
    let FacebookID:String?
    let Source:String?
    let DataBaseName:String?
    let BranchID:String?
    let SubLocality:String?
    let Pincode:String?
    let GCMKey:String?
    let DeviceToken:String?
    let AppPlatform:String?
    let ClientID:String?
    let CustomerRefferedBy:String?
    let GSTIN:String?
    let AnniversaryDate:String?
    let StateID:String?
}
//OTPCHECK
struct OTPCheckModel:Codable {
    let OTPMatch:String
}


