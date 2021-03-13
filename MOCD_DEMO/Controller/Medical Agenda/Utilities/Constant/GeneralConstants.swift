//
//  Constants.swift
//  ConstantsAndUtilities
//
//  Created by indianic on 29/12/16.
//  Copyright © 2016 manish. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

// Cell Identifire
enum CellIdentifire: String {
    
    case CellAppointment = "AppointmentCell"
    case CellSocialActivities = "SocialActivitiesCell"
    case CellMedicinPlan = "MedicinPlanCell"
    case CellDisease = "DiseaseCell"
    case CellIndependent = "IndependentCell"
    case CellNotes = "NotesCell"
    
}



// Font Sizes
enum FontSizes: Float {
    case kFont24 = 24.0
    case kFont30 = 30.0
    case kFont23 = 23.0
    case kFont22 = 22.0
    case kFont225 = 22.5
    case kFont26 = 26.0
    
}

// Font Name
enum FontName: String {
    
    case kMyriadProRegular = "MyriadPro-Regular"
    case kMyriadProBold = "MyriadPro-Bold"
    case kMyriadProLight = "MyriadPro-Light"
    case kMyriadProCond = "MyriadPro-Cond"
    case kMyriadProSemibold = "MyriadPro-Semibold"
    case kMyriadProSemiCn = "MyriadPro-SemiCn"
    case kMyriadProBlack = "MyriadPro-Black"
    
    case kGESSBold = "GESSTextBold-Bold"
    case kGESSMedium = "GESSTextMedium-Medium"
    case kGESSLightItalic = "GE SS Light Italic"
    case kGESSUltraLight = "GESSTextUltraLight-UltraLigh"
    
}




// Segue Identifiers
enum SegueIdentifiers: String {
    
    case kSegueAppointment = "segueAppointment"
    case ksegueFeedback = "segueFeedback"
    case ksegueNotes = "segueNotes"
    case ksegueSocialActivities = "segueSocialActivities"
    case ksegueMedical = "segueMedicinplan"
    case ksegueDisease = "segueDisease"
    case ksegueIndependent = "segueIndependent"
    
    case kAddAppointment = "addAppointment"
    case kMainStoryboard = "MedicalAgenda"
    case kLanguageSelectionVC = "LanguageSelectionVC"
    case kSideMenuVC = "SideMenuVC"
    case kSideMenuRightVC = "SideMenuRightVC"
    case kTabbarVC = "TabbarVC"
    case kRootNavigationController = "RootNavigationController"
    case kMMDrawer = "MMDrawer"
    case ksegueSocialActivity = "segueSocialActivity"
    case ksegueAddSocial = "segueAddSocial"
    case ksegueAddMedicine = "segueAddMedical"
    case ksegueMedicalVC = "segueMedical"
    case ksegueAddDisease = "addDisease"
    case ksegueAddIndependent = "addIndependent"
    case ksegueAddNotes = "segueAddNotes"
}

class GeneralConstants: NSObject {
    
    let mail = MFMailComposeViewController()
    
    struct ScreenHW {
        
        static let kWidth = UIScreen.main.bounds.size.width
        static let kHeight = UIScreen.main.bounds.size.height
        
    }
    
    
    // Color Constant
    struct ColorConstants {
        
        static let kColor_Red: UIColor = .red
        static let kColor_Green: UIColor = .green
        static let kColor_Blue: UIColor = .blue
        static let kColor_Gray: UIColor = .gray
        static let kColor_LightGray: UIColor = .lightGray
        static let kColor_DarkGray: UIColor = .darkGray
        static let kColor_Black: UIColor = .black
        static let kColor_Brown: UIColor = .brown
        static let kColor_Clear: UIColor = .clear
        static let kColor_Cyan: UIColor = .cyan
        static let kColor_Megenta: UIColor = .magenta
        static let kColor_Orange: UIColor = .orange
        static let kColor_Purple: UIColor = .purple
        static let kColor_White: UIColor = .white
        static let kColor_Yellow: UIColor = .yellow
        
        static let kColor_Custom : UIColor = UIColor(red: 123.0/255.0, green: 123.0/255.0, blue: 123.0/255.0, alpha: 1.0)
        static let kColor_PlaceHolder : UIColor = UIColor(red: 199.0/255.0, green: 199.0/255.0, blue: 205.0/255.0, alpha: 1.0)
        
        static let kTop = "#ad343e"
        
        static let k_Button_Background_Color = "#e0e0ce"
        
        static let k_Quote_Background_Color = "#e0e0ce"
        
        static let k_Calendar_Background_Color = "#f2f2f2"
        
        static let k_Language_Font_Color_48_Bold = "#222222"
        
        static let k_Top_Heading_Font_Size_60Regular = "#FFF"
        static let k_Top_Tabs_Font_Size_48_Regular_ = "#FFF"
        static let k_Top_Tabs_Font_Size_48_Bold_Selected = "#ad343e"
        
        static let k_Calendar_Current_Date_Font_Size_60_Regular = "#222222"
        static let k_Calendar_Current_Day_Font_Size_48_Regular = "#4e4e38"
        static let k_Calendar_Day_Heading_46_Regular = "#1d1d26"
        static let k_Calendar_Date_55_Light = "#1d1d26"
        
        static let k_Event_Colors_Used_1 = "#f2af29" // Yellois orange
        static let k_Event_Colors_Used_2 = "#29adf2" // Blue
        static let k_Event_Colors_Used_3 = "#cf29f2" //purpul
        
        static let k_Quote_Color_44_Regular = "#6e6e58"
        static let k_Quote_Owner_Name_Font_44_Bold = "#ad343e"
        
        static let k_Input_Field_Place_Holder_Font_45_Regular = "#9b9b9b"
        
        static let k_PickerColor = "#9b9b9b"
        
        static let k_Button_Font_52_Bold = "#222222"
        
        static let k_Signup_Page_Background_Color = "#f2f2f2"
        
        static let themeColor = "#AD343E" // btn selection
        static let btnUnselected = "#E0DFCD"  // setting // btn unselection
    }
    
    // Get Screen Size
    struct ScreenSize
    {
        static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
    
    // Get Device Type
    struct DeviceType
    {
        static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
        static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
        static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
        static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
        static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    }
    
    class func trimming(_ string: String) -> Bool {
        var trimmedString = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if trimmedString.count <= 0 {
            
            return false
        }
        return true
    }
    
    class func trimmingString(_ string: String) -> String {
        return string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    class func checkLength(_ string: String, length: Int) -> Bool {
        
        if string.count > length {
            return false
        }
        return true
    }
    
    
    class func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func sendEmail(setData: ((Bool, MFMailComposeViewController)-> Void)) {
        
        if MFMailComposeViewController.canSendMail() {
            
            mail.setToRecipients(["mocd.support@mocd.gov.ae"])
            mail.setSubject(JMOLocalizedString(forKey: "MOCD- Medical Agenda- Contact", value: ""))
            mail.setMessageBody(JMOLocalizedString(forKey: "Please type your message bellow then press on Send button.", value: ""), isHTML: false)
            
            setData(true, mail)
            
        } else {
            // show failure alert
            setData(false, mail)
            
        }
    }
}


public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else {
                return identifier
            }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4", "iPad6,7", "iPad6,8":return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
}

