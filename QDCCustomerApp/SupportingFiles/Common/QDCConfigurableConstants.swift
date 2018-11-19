//
//  QDCConfigurableConstants.swift
//  QDCCustomerApp
//


//

import UIKit

enum APP_DISPLAYNAME: String {
    case DRYGREEN = "DRY GREEN"
    case PERFECT = "PERFECT"
    case MYHOLLYWOODLAUNDRY = "MY HOLLYWOOD LAUNDRY"
    case MOMENTUM = "MOMEMTUM"
    case CARE4WEAR = "CARE4WEAR"
    case ANANKE = "ananke"
    case TEST = "QDC ON DEMAND"
}

enum APP_SLUG: String {
    case DRYGREEN = "DRYGREEN"//537005073384157
    case PERFECT = "PERFECT"//295373224618596
    case MYHOLLYWOODLAUNDRY = "MYHOLLYWOODLAUNDRY"//2152228414857423
    case MOMENTUM = "MOMENTUM"//247265599242335
    case CARE4WEAR = "CARE4WEAR"//652665868468172
    case ANANKE = "ananke"
    case TEST = "qdctesting"
}



enum fb_APP_ID: String {
    case DRYGREEN = "537005073384157"
    case PERFECT = "295373224618596"
    case MYHOLLYWOODLAUNDRY = "2152228414857423"
    case MOMENTUM = "247265599242335"
    case CARE4WEAR = "652665868468172"
    case ANANKE = "179505039659599"
    case TEST = "qdctesting"
}


enum APP_BASEURL: String {
    case LIVE = "http://quickdrycleaningclients.com:9002/api/7.0/"
    case TEST = "http://quickdrycleaningclients.com:9002/api/testing/"
    
}

enum APP_PINCODE:String{
    case TEST = "123456"
    case DRYGREEN = "133301"
    case PERFECT = "110018"
    case MYHOLLYWOODLAUNDRY = "700001"
    case MOMENTUM = "900211"
    case CARE4WEAR = "care4wear"
    case ANANKE = "Columbo"
}

enum API_NOTIFICATION_BASE_URL: String {
    case DRYGREEN = "http://quickdrycleaningclients.com:9002/api/7.0/dryGreen/"
    case PERFECT = "http://quickdrycleaningclients.com:9002/api/7.0/Perfect/"
    case MYHOLLYWOODLAUNDRY = "http://quickdrycleaningclients.com:9002/api/7.0/myhollywoodlaundry/"
    case MOMENTUM = "http://quickdrycleaningclients.com:9002/api/Testing/Momentum/"
    case CARE4WEAR = "http://quickdrycleaningclients.com:9002/api/Testing/care4wear/"
    case ANANKE = "http://quickdrycleaningclients.com:9002/api/7.0/ananke/"
    
}

enum APP_COLOR {
    case DRYGREEN
    case PERFECT
    case MYHOLLYWOODLAUNDRY
    case MOMENTUM
    case CARE4WEAR
    case ANANKE
}

extension APP_COLOR {
    var value: UIColor {
        get {
            switch self {
            case .DRYGREEN:
                return #colorLiteral(red: 0.5405771136, green: 0.7574445605, blue: 0.2278534472, alpha: 1)
            case .PERFECT:
                return #colorLiteral(red: 0.05098039216, green: 0.2, blue: 0.6196078431, alpha: 1)
            case .MYHOLLYWOODLAUNDRY:
                return #colorLiteral(red: 0.06442032009, green: 0.1647019982, blue: 0.5130925775, alpha: 1)
            case .MOMENTUM:
                return #colorLiteral(red: 0.662745098, green: 0.662745098, blue: 0.662745098, alpha: 1)
            case .CARE4WEAR:
                return #colorLiteral(red: 0.3805294633, green: 0.7483190894, blue: 0.8935837746, alpha: 1)
            case .ANANKE:
                return #colorLiteral(red: 0.5215686275, green: 0.6941176471, blue: 0.2, alpha: 1)
                
        }
        }
    }
}




enum menuBGColor {
    case DRYGREENAPP
    case PERFECTAPP
    case myhollywoodlaundry
    case Momentum
    case ANANKE
}

extension menuBGColor {
    var value: UIColor {
        get {
            switch self {
            case .DRYGREENAPP:
                return #colorLiteral(red: 0.1411764706, green: 0, blue: 0.6392156863, alpha: 1)
            case .PERFECTAPP:
                return #colorLiteral(red: 0.1411764706, green: 0, blue: 0.6392156863, alpha: 1)
            case .myhollywoodlaundry:
                return #colorLiteral(red: 0.1411764706, green: 0, blue: 0.6392156863, alpha: 1)
            case .Momentum:
                return #colorLiteral(red: 0.1411764706, green: 0, blue: 0.6392156863, alpha: 1)
            case .ANANKE:
                return #colorLiteral(red: 0.6509803922, green: 0.7725490196, blue: 0.3607843137, alpha: 1)
            }
        }
    }
}


let DRYGREENAPP                 = #colorLiteral(red: 0.5405771136, green: 0.7574445605, blue: 0.2278534472, alpha: 1)
let PERFECTAPP                  = #colorLiteral(red: 0.06442032009, green: 0.1647019982, blue: 0.5130925775, alpha: 1)


//MARK: - Theme

let mainColor: UIColor = APP_COLOR.ANANKE.value
let buttonBGColor: UIColor = APP_COLOR.ANANKE.value

let mainNavBarColor:UIColor = APP_COLOR.ANANKE.value

let heightForHeaderInSection:CGFloat = 180.0

let PINCODE                              = APP_PINCODE.ANANKE.rawValue
let APPSLUG                              = APP_SLUG.ANANKE.rawValue
let QDC_BASE_URL                         =  APP_BASEURL.LIVE.rawValue

let QDC_NOTIFICATION_BASE_URL            = API_NOTIFICATION_BASE_URL.ANANKE.rawValue

let APP_NAME                    = APP_DISPLAYNAME.ANANKE.rawValue
let APP_LOGO                    = "app_image"

let PRIMARY_COLOUR              = APP_COLOR.ANANKE.value

let PICK_UP_SCREEN_COLOUR       = ""
let BUTTON_COLOUR               = APP_COLOR.ANANKE.value
let APP_ICON_COLOUR             = APP_COLOR.ANANKE.value
let CURRENCY_PREFIX             = ""
let ADDRESS_LABEL               = ""
let LOCALITY_LABEL              = ""
let COLOUR_ON_BUTTON            = UIColor.white
let GRAY_COLOUR_ON_BUTTON       = UIColor.darkGray
let DROPOFF_SCREEN_BASE_COLOUR  = ""
let ENABLE_PAYMENT              = ""
let FORCE_PINCODE               = "UAE"
let PINCODE_BYPASS              = true
let TEXT_FIELD_COLOUR           = UIColor.black
let NAV_TITLE_COLOUR            = UIColor.white
let REGISTRATION_SCREEN_COLOUR  = UIColor.init(red: 232.0/255, green: 232.0/255, blue: 232.0/255, alpha: 1)
