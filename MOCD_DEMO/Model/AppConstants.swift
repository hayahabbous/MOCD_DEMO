//
//  AppConstants.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 6/17/19.
//  Copyright © 2019 Datacellme. All rights reserved.
//

import Foundation
import UIKit


enum CHILD_AGES : Int{
    case none = 0
    case two = 2
    case four = 4
    case six = 6
    case eight = 8
    case ten = 10
    case noNeedForTest = 12
    
    
    
    
    
}
enum MOCD_ERROR : Int {
    case invlide_USERNAME_AND_PASSWORD = 101
    case invlide_EMAIL = 125
    case no_EMAIL_FOUND = 205
    case username_TAKEN = 202
    case useremail_TAKEN = 203
    case no_INTERNET_CONNECTION_1 = 1
    case no_INTERNET_CONNECTION_2 = 2
    case no_INTERNET_CONNECTION_4 = 4
    case no_INTERNET_CONNECTION__1 = -1
    case no_INTERNET_CONNECTION_100 = 100
    case no_INTERNET_CONNECTION_124 = 124
    case domin_ERROR = 3840
}

enum CHILD_STATUS : Int {
    case NEED_TEST = 0
    case FINE = 1
    case UN_HEALTH = 2
    case DANGER = 3
    
    
    
}

enum ROUTINE_TIME: Int  {
    case FIVE_AM_TOW_PM = 0
    case TOW_PM_FIVE_PM = 1
    case FIVE_PM_NINE_PM = 2
    case NINE_PM_FIVE_AM_NEXT_DAY = 3
    case NONE = 4
    
}

extension CHILD_STATUS {
    init?(value: String) {
        switch value {
        case "":
            self.init(rawValue: 0) // need test
        case "green":
            self.init(rawValue: 1) // green
        case "orange":
            self.init(rawValue: 2) // orange
        case "red":
            self.init(rawValue: 3) // red
        default:
            self.init(rawValue: 3)
        }
    }
}


extension ROUTINE_TIME {
    init?(value: String) {
        switch value {
        case "":
            self.init(rawValue: 4) // NONE
        case "1","5","12","9":
            self.init(rawValue: 0)
        case "2","6","8":
            self.init(rawValue: 1)
        case "7","10","11":
            self.init(rawValue: 2)
        case "3","13","4":
            self.init(rawValue: 3)
            
            
        default:
            self.init(rawValue: 4)
        }
    }
}
class AspectElement: NSObject {
    var title = ""
    var objectId = ""
}
class AppConstants: NSObject {
    
    
    
    static var isNemowEnabled = "isNemowEnabled"
    static var isEdkharEnabled = "isEdkharEnabled"
    static var isMGEnabled = "isMGEnabled"
    static var isStoriesEnabled = "isStoriesEnabled"
    
    
    
    static let MOCDUserData = "MOCDUserData"
    static var AssessmentsArray:[AspectElement] = []
    static let WEB_SERVER_IMAGE_MOCD_URL: String  = "http://mocdservices.dcxportal.com"
    static let WEB_SERVER_MOCD_URL: String  = "http://mocdservices.dcxportal.com/api/"
    static let DToken: String = "6RGT36D10Q637059759964359851B1I1"
    static let WEB_SERVER_URL: String = "https://sale96.back4app.io/classes/"
    static let APPLICATION_ID: String = "756mkuKktWxGeQt2ZupZyUMUH4kfNg4HQ6mfs9HH"
    static let REST_API_KEY = "4g0eU8HeVt8VYwVzcpPCBIYJZ9fDDmSNPaHXC6ud"
    static let CLIENT_KEY = "OCe3sifHGVUJJGIWk7RttTVuIQuAOkaSxVEmYQeJ"
    static let APPLE_LANGUAGE_KEY = "AppleLanguages"
    

    static let firstBrownColor = UIColor(red: 170/256 , green: 121/256, blue: 66/256, alpha: 1.0)
    static let secondBrownColor = UIColor(red: 207/256 , green: 179/256, blue: 63/256, alpha: 1.0)
    
    
    static let BROWN_COLOR = UIColor(red: 162/256 , green: 112/256, blue: 41/256, alpha: 1.0)
    static let FIRST_GREEN_COLOR = UIColor(red: 111/256 , green: 187/256, blue: 119/256, alpha: 1.0)
    static let PURPLE_COLOR = UIColor(red: 90/256 , green: 93/256, blue: 173/256, alpha: 1.0)
    static let RED_COLOR = UIColor(red: 205/256 , green: 47/256, blue: 102/256, alpha: 1.0)
    static let SECOND_GREEN_COLOR = UIColor(red: 147/256 , green: 202/256, blue: 90/256, alpha: 1.0)
    
    
    static let YELLOW_COLOR = UIColor(red: 241/256, green: 207/256, blue: 83/256, alpha: 1.0)
    static let F_RED_COLOR = UIColor(red: 222/256, green: 92/256, blue: 82/256, alpha: 1.0)
    static let GRAY_COLOR = UIColor(red: 187/256, green: 187/256, blue: 187/256, alpha: 1.0)
    static let F_PURPLE_COLOR = UIColor(red: 112/256, green: 103/256, blue: 181/256, alpha: 1.0)
    static let ORANGE_COLOR =  UIColor(red: 239/256, green: 138/256, blue: 52/256, alpha: 1.0)
    static let GREEN_COLOR = UIColor(red: 170/256, green: 199/256, blue: 71/256, alpha: 1.0)
    
    
    
    static let YELLOW_1_COLOR = UIColor(red: 212/256, green: 176/256, blue: 22/256, alpha: 1.0)
    static let YELLOW_2_COLOR = UIColor(red: 231/256, green: 217/256, blue: 23/256, alpha: 1.0)
    
    static let E_COLOR =  UIColor(red: 83/256, green: 27/256, blue: 147/256, alpha: 1.0)
    static let N_COLOR = UIColor(red: 170/256, green: 199/256, blue: 71/256, alpha: 1.0)
    
    
    static let GIRL_IMAGE = UIImage(named: "smiling-girl")
    static let BOY_IMAGE = UIImage(named: "boy-smiling")
    
    static func isArabic() -> Bool {
        
        //print("language is : \(NSLocale.preferredLanguages[0])")
        //print("language in standard is : \(NSLocale.preferredLanguages[0])  ")
        return NSLocale.preferredLanguages[0].range(of:"ar") != nil
    }
    
    
    //morning
    //night
    //evening
    //afternoon
    
    
    static var backgroundImage: UIImage = UIImage(named: "morning")!
}

class Helper {
    class func validateEmail(enteredEmail:String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
}
