//
//  QDCUserDefaults.swift
//  QDCCustomerApp
//
//  Created by shashank sharma on 28/10/16.
//  Copyright © 2016 QuickDryCleaning. All rights reserved.
//

import UIKit

class QDCUserDefaults: NSObject {

    
    
    class func setPinCode(pin:String){
        
        UserDefaults.standard.set(pin, forKey: USER_DEFAULT_PIN_CODE_KEY)
        UserDefaults.standard.synchronize()

    }
    
    class func getPinCode() -> String{
        
        var tempStr = UserDefaults.standard.object(forKey: USER_DEFAULT_PIN_CODE_KEY)
        if (tempStr == nil) {
            tempStr = ""
        }
        return tempStr as! String
    }
    
    class func setUserName(userName:String){
        
        UserDefaults.standard.set(userName, forKey: USER_DEFAULT_USER_NAME_KEY)
        UserDefaults.standard.synchronize()

    }
    
    class func getUserName() -> String{
        
        var tempStr = UserDefaults.standard.object(forKey: USER_DEFAULT_USER_NAME_KEY)
        if (tempStr == nil) {
            tempStr = ""
        }
        return tempStr as! String
    }
    
    class func setUserEmail(email:String){
        
        UserDefaults.standard.set(email, forKey: USER_DEFAULT_USER_EMAIL_KEY)
        UserDefaults.standard.synchronize()
        
    }
    
    class func getUserEmail() -> String{
        
        var tempStr = UserDefaults.standard.object(forKey: USER_DEFAULT_USER_EMAIL_KEY)
        if (tempStr == nil) {
            tempStr = ""
        }
        return tempStr as! String
    }
    
    class func setUserMobile(mobile:String){
        
        UserDefaults.standard.set(mobile, forKey: USER_DEFAULT_USER_MOBILE_KEY)
        UserDefaults.standard.synchronize()
        
    }
    
    class func getUserMobile() -> String{
        
        var tempStr = UserDefaults.standard.object(forKey: USER_DEFAULT_USER_MOBILE_KEY)
        if (tempStr == nil) {
            tempStr = ""
        }
        return tempStr as! String
    }
    
    
    class func setUserAddress(adress:String){
        
        UserDefaults.standard.set(adress, forKey: USER_DEFAULT_USER_ADDRESS_KEY)
        UserDefaults.standard.synchronize()
        
    }
    
    class func getUserAddress() -> String{
        
        var tempStr = UserDefaults.standard.object(forKey: USER_DEFAULT_USER_ADDRESS_KEY)
        if (tempStr == nil) {
            tempStr = ""
        }
        return tempStr as! String
    }
    
    class func setUserSubAddress(adress:String){
        
        UserDefaults.standard.set(adress, forKey: USER_DEFAULT_USER_SUB_ADDRESS_KEY)
        UserDefaults.standard.synchronize()
        
    }
    
    class func getUserSubAddress() -> String{
        
        var tempStr = UserDefaults.standard.object(forKey: USER_DEFAULT_USER_SUB_ADDRESS_KEY)
        if (tempStr == nil) {
            tempStr = ""
        }
        return tempStr as! String
    }
    
    class func setCustomerId(customerId:String){
        
        UserDefaults.standard.set(customerId, forKey: USER_DEFAULT_CUSTOMER_ID_KEY)
        UserDefaults.standard.synchronize()
        
    }
    
    class func getCustomerId() -> String{
        
        var tempStr = UserDefaults.standard.object(forKey: USER_DEFAULT_CUSTOMER_ID_KEY)
        if (tempStr == nil) {
            tempStr = ""
        }
        return tempStr as! String
    }
    
    class func setUserEncodedId(customerId:String){
        
        UserDefaults.standard.set(customerId, forKey: USER_DEFAULT_USER_ENCODED_ID_KEY)
        UserDefaults.standard.synchronize()
        
    }
    class func getUserEncodedId() -> String{
        
        var tempStr = UserDefaults.standard.object(forKey: USER_DEFAULT_USER_ENCODED_ID_KEY)
        if (tempStr == nil) {
            tempStr = ""
        }
        return tempStr as! String
    }
    
    class func setUserImgUrl(_ image:String){
        
        UserDefaults.standard.set(image, forKey: USER_DEFAULT_USER_IMAGE_URL_KEY)
        UserDefaults.standard.synchronize()
        
    }
    
    class func getUserImgUrl() -> String{
        
        var tempStr = UserDefaults.standard.object(forKey: USER_DEFAULT_USER_IMAGE_URL_KEY)
        if (tempStr == nil) {
            tempStr = ""
        }
        return tempStr as! String
    }

    
    class func setDataBaseName(dbName:String){
        
        UserDefaults.standard.set(dbName, forKey: USER_DEFAULT_DATABASE_NAME_KEY)
        UserDefaults.standard.synchronize()

    }
    
    class func getDataBaseName() -> String{
        
        var tempStr = UserDefaults.standard.object(forKey: USER_DEFAULT_DATABASE_NAME_KEY)
        if (tempStr == nil) {
            tempStr = ""
        }
        return tempStr as! String
    }
    
    class func setBranchId(branchId:String){
        
        UserDefaults.standard.set(branchId, forKey: USER_DEFAULT_BRANCH_ID_KEY)
        UserDefaults.standard.synchronize()

    }
    
    class func getBranchId()-> String{
        
        var tempStr = UserDefaults.standard.object(forKey: USER_DEFAULT_BRANCH_ID_KEY)
        if (tempStr == nil) {
            tempStr = ""
        }
        return tempStr as! String
    }
    
    class func setAccessToken(token:String){
        
        UserDefaults.standard.set(token, forKey: USER_DEFAULT_USER_TOKEN_KEY)
        UserDefaults.standard.synchronize()
        
    }
    
    class func getAccessToken()-> String{
        
        var tempStr = UserDefaults.standard.object(forKey: USER_DEFAULT_USER_TOKEN_KEY)
        if (tempStr == nil) {
            tempStr = ""
        }
        return tempStr as! String
    }
    
    class func setDeviceNotificationToken(token:String){
        
        UserDefaults.standard.set(token, forKey: USER_DEFAULT_DEVICE_TOKEN_KEY)
        UserDefaults.standard.synchronize()
        
    }
    
    class func getDeviceNotificationToken()-> String{
        
        var tempStr = UserDefaults.standard.object(forKey: USER_DEFAULT_DEVICE_TOKEN_KEY)
        if (tempStr == nil) {
            tempStr = "6789"
        }
        return tempStr as! String
    }
    
    class func setClientPhoneNumber(phoneNo:String){
        
        UserDefaults.standard.set(phoneNo, forKey: USER_DEFAULT_CLIENT_PHONE_KEY)
        UserDefaults.standard.synchronize()
        
    }
    
    class func getClientPhoneNumber()-> String{
        
        var tempStr = UserDefaults.standard.object(forKey: USER_DEFAULT_CLIENT_PHONE_KEY)
        if (tempStr == nil) {
            tempStr = ""
        }
        return tempStr as! String
    }
    
    class func setClientEmail(email:String){
        
        UserDefaults.standard.set(email, forKey: USER_DEFAULT_CLIENT_EMAIL_KEY)
        UserDefaults.standard.synchronize()
        
    }
    
    class func getClientEmail()-> String{
        
        var tempStr = UserDefaults.standard.object(forKey: USER_DEFAULT_CLIENT_EMAIL_KEY)
        if (tempStr == nil) {
            tempStr = ""
        }
        return tempStr as! String
    }
    
    class func setAppLink(appLink:String){
        
        UserDefaults.standard.set(appLink, forKey: USER_DEFAULT_APPSTORE_LINK_KEY)
        UserDefaults.standard.synchronize()
        
    }
    
    class func getAppLink()-> String{
        
        var tempStr = UserDefaults.standard.object(forKey: USER_DEFAULT_APPSTORE_LINK_KEY)
        if (tempStr == nil) {
            tempStr = ""
        }
        return tempStr as! String
    }
    
    class func setClientAddress(address:String){
        
        UserDefaults.standard.set(address, forKey: USER_DEFAULT_CLIENT_ADDRESS_KEY)
        UserDefaults.standard.synchronize()
        
    }
    
    class func getClientAddress()-> String{
        
        var tempStr = UserDefaults.standard.object(forKey: USER_DEFAULT_CLIENT_ADDRESS_KEY)
        if (tempStr == nil) {
            tempStr = ""
        }
        return tempStr as! String
    }
    
    class func setLocality(locality:String){
        
        UserDefaults.standard.set(locality, forKey: USER_DEFAULT_LOCALITY_KEY)
        UserDefaults.standard.synchronize()
        
    }
    
    class func getLocality()-> String{
        
        var tempStr = UserDefaults.standard.object(forKey: USER_DEFAULT_LOCALITY_KEY)
        if (tempStr == nil) {
            tempStr = ""
        }
        return tempStr as! String
    }
    
    class func setSubLocality(locality:String){
        
        UserDefaults.standard.set(locality, forKey: USER_DEFAULT_SUB_LOCALITY_KEY)
        UserDefaults.standard.synchronize()
        
    }
    
    class func getSubLocality()-> String{
        
        var tempStr = UserDefaults.standard.object(forKey: USER_DEFAULT_SUB_LOCALITY_KEY)
        if (tempStr == nil) {
            tempStr = ""
        }
        return tempStr as! String
    }
    
    class func setClientID(clientID:String){
        
        UserDefaults.standard.set(clientID, forKey: USER_DEFAULT_CLIENT_ID_KEY)
        UserDefaults.standard.synchronize()
        
    }
    
    class func getClientID() -> String{
        
        var tempStr = UserDefaults.standard.object(forKey: USER_DEFAULT_CLIENT_ID_KEY)
        if (tempStr == nil) {
            tempStr = ""
        }
        return tempStr as! String
    }
}
