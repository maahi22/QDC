//  CommonUtilities.swift
//  QDCCustomerApp
//
//  Created by shashank sharma on 15/10/16.
//  Copyright © 2016 QuickDryCleaning. All rights reserved.
//

import UIKit

class CommonUtilities: NSObject {
    
    
    
    class func getSideMenuArray() -> NSArray {
        return ["DASHBOARD", " REQUEST PICKUP", "MY REQUEST", "DUE AMOUNT", "MY ORDERS", "PRICE LIST", "OFFERS", "FEEDBACK", "SETTING", "ABOUT US"]
    }
    
    class func getSideMenuImageArray() -> NSArray {
        return ["Side Offer Icons","Side My PickupsIcon","Side Request Pick Up Icon","Side Due Amount Icon","Side My Order Icon","Side Price List Icon","Offer Icon","Side Feedback Icon","Setting.png","Side Request Pick Up Icon"]
    }
    
    class func getEncodedUserToken() -> String {
        
            let normalString:String = QDCUserDefaults.getDataBaseName() + "-" + QDCUserDefaults.getBranchId() + "-" + QDCUserDefaults.getCustomerId() + ":hello@123"
        
        let encodedString = normalString.data(using: String.Encoding.utf8)
        
        let base64String = encodedString!.base64EncodedString(options: .init(rawValue: 0))

        //let base64String = encodedString!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        
        QDCUserDefaults.setUserEncodedId(customerId: base64String)
            
            return base64String
        }
    
   class func getWeekDayFromString(dateString:String) -> String {
        
    let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
    
    let dateObj = dateFormatter.date(from: dateString)
        
        dateFormatter.dateFormat = "EEE"
    
    return dateFormatter.string(from: dateObj!)
    }
    
    class func getTwoPreviousDaysFromString(dateString:String) -> (dayOne:PickUpDateModel, dayTwo:PickUpDateModel) {

        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"

        let dateObj = dateFormatter.date(from: dateString)
        
        let oneDaysAgo =  calendar.date(byAdding: .day, value: -1, to: dateObj!)
        let twoDaysAgo = calendar.date(byAdding: .day, value: -2, to: dateObj!)

        dateFormatter.dateFormat = "dd MMM yyyy"

        let oneDays = PickUpDateModel(PickUpDate: dateFormatter.string(from: oneDaysAgo!), PickUpTime: [])
        let twoDays = PickUpDateModel(PickUpDate: dateFormatter.string(from: twoDaysAgo!), PickUpTime: [])
        return (oneDays,twoDays)
    }
    
    
    class func getTwoPreviousDaysFromStringForDropOFF(dateString:String) -> (dayOne:DropOffModel, dayTwo:DropOffModel) {
        
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        
        let dateObj = dateFormatter.date(from: dateString)
        
        let oneDaysAgo =  calendar.date(byAdding: .day, value: -1, to: dateObj!)
        let twoDaysAgo = calendar.date(byAdding: .day, value: -2, to: dateObj!)
        
        dateFormatter.dateFormat = "dd MMM yyyy"
        
        let oneDays = DropOffModel(DropDateDate: dateFormatter.string(from: oneDaysAgo!), DropOffTime: [])
        let twoDays = DropOffModel(DropDateDate: dateFormatter.string(from: twoDaysAgo!), DropOffTime: [])
        return (oneDays,twoDays)
    }
    
    
//    class func isValidEmail(testStr:String) -> Bool {
//
//        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
//        let range = testStr.rangeOfString(emailRegEx, options:.RegularExpressionSearch)
//        let result = range != nil ? true : false
//        return result
//    }
    
    class func isValidMobileNumber(value: String) -> Bool {
        
        if value.characters.count == 10 {
                return true
            }
        return false
    }
    
    class func isOtpEnteredCorrectly() -> Bool {

        return UserDefaults.standard.bool(forKey: USER_DEFAULT_OTP_CORRECT_KEY)
    }

    
    
    
    class func getDateFromString(dateString:String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.date(from: dateString)  as! Date
    }
    
    
    class func getDateFromStringAddedDay(dateString:String, day:Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        let date =  dateFormatter.date(from: dateString) as! Date
        
        let NewDate = date.add(days: day)
        return dateFormatter.string(from: NewDate)
    }
    
    
    
}
