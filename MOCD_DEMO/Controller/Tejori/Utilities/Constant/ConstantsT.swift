//
//  Constant.swift
//  Edkhar
//
//  Created by indianic on 02/01/17.
//  Copyright © 2017 demo. All rights reserved.
//

import Foundation
import UIKit
/*

var currentViewContoller :  UIViewController? = nil
var ISDropboxRestore :  Bool? = false

let DropboxAppkey = "7hv4r0lpjpvyh34"
let DropboxAppSecret = "itr3htdnq5mew69"


let ddMMyyyyEEEE = "dd/MM/yyyy EEEE"
let yyyyMMdd = "yyyy-MM-dd"

let Light = "light"
let Medium = "Medium"
let Bold = "Bold"
let SemiBold = "SemiBold"
let Black = "Black"
let Cond = "Cond"
let SemiCn = "SemiCn"

*/
var aStrChecklistDate : String = ""
var aStrChecklistEventDate : String = ""
var aStrSelectedMonth : String = ""
var aStrSelectedYear : String = ""

// Database tables enum.
enum Edkhar: Int {
    case Disease = 1
    case Ind_Daily_Activities = 2
    case Medicine_Plan = 3
    case Appointment = 4
    case Social_Activities = 5
}

// Reminder Identifiers
/*
struct Identifiers {
    static let reminderCategory = "reminder"
    static let cancelAction = "cancel"
}
*/

// Application Fonts enum.
enum AppFonts: String {
    
    case kGESSUltraLight = "GESSTextUltraLight-UltraLigh"
    case kGESSMedium = "GESSTextMedium-Medium"
    case kGESSBold = "GESSTextBold-Bold"
    
    case kMyriadProLight = "MyriadPro-Light"
    case kMyriadProMedium = "MyriadPro-Regular"
    case kMyriadProBold = "MyriadPro-Bold"
    case kMyriadProBlack = "MyriadPro-Black"
    case kMyriadProCond = "MyriadPro-Cond"
    case kMyriadProSemibold = "MyriadPro-Semibold"
    case kMyriadProSemiCn = "MyriadPro-SemiCn"
    
}

enum GraphColour: String {
    
    case kYello = "fff692"
    case kGreen = "c6fd92"
    case kOrange = "fed191"
    case kBlue = "90ebfe"
    
}
/*
enum WeekDaysName: Int {
    
    case Sunday = 1
    case Monday = 2
    case Tuesday = 3
    case Wednesday = 4
    case Thursday = 5
    case Friday = 6
    case Satudrday = 7
}

enum ReminderFrequency: String {
    
    case week = "week"
    case month = "month"
    case day = "day"
    case none = ""
}*/

/*
func AppConstants.isArabic() -> Bool {
    
    var is_arabic : Bool = false
    
    let aStrUserdefultLanguage = UserDefaults.standard.value(forKey: "Language") as? String!
    
    if(aStrUserdefultLanguage != nil && aStrUserdefultLanguage == "ar")
    {
        is_arabic = true
        
    }
    else{
        is_arabic = false
    }
    
    return is_arabic
}
*//*
func getTodayDateString(_ format : String) -> String {
    let todaysDate:Date = Date()
    let dateFormatter:DateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(identifier: "UTC")
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = format
    let todayString:String = dateFormatter.string(from: todaysDate)
    return todayString
}
*//*
func getStringFromDate(_ format : String , date : Date) -> String {
    
    let dateFormatter  = DateFormatter()
    dateFormatter.dateFormat = format
    //        dateFormatter.timeZone = TimeZone(identifier: "UTC")
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    return dateFormatter.string(from: date)
}*//*

func getDateFromString(_ formate : String , aStrDate : String) -> Date{
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = yyyyMMdd
    //        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
    let dateObj = dateFormatter.date(from: aStrDate)
    
    dateFormatter.dateFormat = formate
    
    return dateObj!
}
*//*
func daysBetweenDates(startDate: Date, endDate: Date) -> Int
{
    let calendarobj = Calendar.current
    let unitFlags = Set<Calendar.Component>([.day])
    let components = calendarobj.dateComponents(unitFlags , from: startDate, to: endDate)
    return components.day!
}
*//*
func dayOfTheWeek(_ aDate : Date) -> String? {
    let weekdays = [
        "Sunday",
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Satudrday,"
    ]
    
    let calendar: NSCalendar = NSCalendar.current as NSCalendar
    let components: NSDateComponents = calendar.components(.weekday, from: aDate) as NSDateComponents
    return weekdays[components.weekday - 1]
}*/
/*
func GetWeekDayNumber(_ aStrWeekDay : String) -> Int {
    
    var aWeekDayNumber : Int = 1
    
    if aStrWeekDay == "Sunday" {
        aWeekDayNumber = 1
    }
    else if aStrWeekDay == "Monday" {
        aWeekDayNumber = 2
    }
    else if aStrWeekDay == "Tuesday" {
        aWeekDayNumber = 3
    }
    else if aStrWeekDay == "Wednesday" {
        aWeekDayNumber = 4
    }
    else if aStrWeekDay == "Thursday" {
        aWeekDayNumber = 5
    }
    else if aStrWeekDay == "Friday" {
        aWeekDayNumber = 6
    }else {
        aWeekDayNumber = 7
    }
    
    return aWeekDayNumber
}
*/
func GetMonthNameFromNumber(_ aIntMonthNo : Int) -> String {
    
    var aMonthName : String = ""
    
    if aIntMonthNo == 1 || aIntMonthNo == 01 {
        if AppConstants.isArabic(){
            aMonthName = "يناير"
        }else{
            aMonthName = "JAN"
        }
        
    }
    else if aIntMonthNo == 2 || aIntMonthNo == 02 {
        
        if AppConstants.isArabic(){
            aMonthName = "فبراير"
        }else{
            aMonthName = "FEB"
        }
    }
    else if aIntMonthNo == 3 || aIntMonthNo == 03 {
        
        if AppConstants.isArabic(){
            aMonthName = "مارس"
        }else{
            aMonthName = "MAR"
        }
    }
    else if aIntMonthNo == 4 || aIntMonthNo == 04 {
        
        if AppConstants.isArabic(){
            aMonthName = "أبريل"
        }else{
            aMonthName = "APR"
        }
    }
    else if aIntMonthNo == 5 || aIntMonthNo == 05 {
        
        if AppConstants.isArabic(){
            aMonthName = "مايو"
        }else{
            aMonthName = "MAY"
        }
    }
    else if aIntMonthNo == 6 || aIntMonthNo == 06 {
        
        if AppConstants.isArabic(){
            aMonthName = "يونيو"
        }else{
            aMonthName = "JUN"
        }
    }
    else if aIntMonthNo == 7 || aIntMonthNo == 07 {
        
        if AppConstants.isArabic(){
            aMonthName = "يوليو"
        }else{
            aMonthName = "JUL"
        }
    }
    else if aIntMonthNo == 8 || aIntMonthNo == 08 {
        
        if AppConstants.isArabic(){
            aMonthName = "أغسطس"
        }else{
            aMonthName = "AUG"
        }
    }
    else if aIntMonthNo == 9 || aIntMonthNo == 09 {
        
        if AppConstants.isArabic(){
            aMonthName = "سبتمبر"
        }else{
            aMonthName = "SEP"
        }
    }
    else if aIntMonthNo == 10 {
        
        if AppConstants.isArabic(){
            aMonthName = "أكتوبر"
        }else{
            aMonthName = "OCT"
        }
    }
    else if aIntMonthNo == 11 {
        
        if AppConstants.isArabic(){
            aMonthName = "نوفمبر"
        }else{
            aMonthName = "NOV"
        }
    }
    else {
        
        if AppConstants.isArabic(){
            aMonthName = "ديسمبر"
        }else{
            aMonthName = "DEC"
        }
    }
    
    return aMonthName
}
/*
func getCurrentYearStartDate()->String? {
    
    let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
    let myComponents = myCalendar.components(.year, from: Date())
    let weekYear = myComponents.year
    
    let aStrYearStartDate = String.init(format: "%d-01-01", weekYear!)
    
    return aStrYearStartDate
    
}


struct Color {
    static let selectedText = UIColor.white
    static let text = UIColor(red: 84.0/255.0, green: 84.0/255.0, blue: 84.0/255.0, alpha: 1.0) // UIColor.black // KP
    static let textDisabled = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0) // UIColor.gray // KP
    static let selectionBackground = UIColor(red: 251.0/255.0, green: 199.0/255.0, blue: 0.0/255.0, alpha: 1.0) // UIColor(red: 0.2, green: 0.2, blue: 1.0, alpha: 1.0) // KP
    static let sundayText = text // UIColor(red: 1.0, green: 0.2, blue: 0.2, alpha: 1.0) // KP
    static let sundayTextDisabled = textDisabled // UIColor(red: 1.0, green: 0.6, blue: 0.6, alpha: 1.0) // KP
    static let sundaySelectionBackground = UIColor(red: 247.0/255.0, green: 182.0/255.0, blue: 44.0/255.0, alpha: 1.0) // sundayText // KP
}


// Font Sizes
enum FontSizes: Float {
    case Large = 14.0
    case Small = 10.0
}
*/
class ConstantsT: NSObject {
    
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
    
}


public extension UIDevice {
    /*
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
    }*/
}

