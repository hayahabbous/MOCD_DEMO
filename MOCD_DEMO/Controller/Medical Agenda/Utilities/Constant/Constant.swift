//
//  Constant.swift
//  SwiftDatabase
//
//  Created by indianic on 02/01/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import Foundation
import UIKit
import SSZipArchive
import SwiftyDropbox
import SVProgressHUD



let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
let ddMMyyyyEEEE = "dd/MM/yyyy EEEE"
let EEEE = "EEEE"
let ddMMyyyy = "dd/MM/yyyy"
let yyyyMMdd = "yyyy-MM-dd"
let yyyyMMddback = "yyyy/MM/dd"
let dd = "dd"
let HHmm = "HH:mm"

let DropboxAppkey = "y3f539qz7g8hd5d"
let DropboxAppSecret = "2nhvepqcwe7vc9j "

var aDateChecklist : Date?
var aDateChecklistEvent : Date?
var isBoolTodayDay: Bool = false

var strStartEndDateOfMonth = [String]()
// Database tables enum.
enum SmartAgenda: Int {
    case Disease = 1
    case Ind_Daily_Activities = 2
    case Medicine_Plan = 3
    case Appointment = 4
    case Social_Activities = 5
}

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
    
    case week = "Weekly"
    case month = "Monthly"
    case day = "Daily"
    case none = ""
}


func showAlert(_ controller: UIViewController, message: String)  -> Void {
    let alertController = UIAlertController(title:  JMOLocalizedString(forKey: "", value: ""), message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: JMOLocalizedString(forKey: "OK", value: ""), style: .default, handler: nil)
    alertController.addAction(okAction)
    controller.present(alertController, animated: true, completion: nil)
}

func IS_ARABIC() -> Bool {
    
    var is_arabic : Bool = false
    
    let aStrUserdefultLanguage = UserDefaults.standard.value(forKey: "Language") as? String
    
    if(aStrUserdefultLanguage != nil && aStrUserdefultLanguage == "ar")
    {
        is_arabic = true
    }
    else{
        is_arabic = false
    }
    
    return is_arabic
}

func setTextFieldPadding(textfield: UITextField, padding: Int) {
    let paddingView = UIView()
    paddingView.frame = CGRect(x: 0, y: 0, width: padding, height: 30)
    textfield.leftView=paddingView;
    textfield.leftViewMode = UITextField.ViewMode.always

}

func getTodayDateString(_ format : String) -> String {
    let todaysDate:Date = Date()
    let dateFormatter:DateFormatter = DateFormatter()
//    dateFormatter.timeZone = TimeZone(identifier: "UTC")
    dateFormatter.timeZone = NSTimeZone.local

    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = format
    let todayString:String = dateFormatter.string(from: todaysDate)
    return todayString
}

func getStringFromDate(_ format : String , date : Date) -> String {
    
    let dateFormatter  = DateFormatter()
    dateFormatter.dateFormat = format
    dateFormatter.timeZone = NSTimeZone.local
    
    //        dateFormatter.timeZone = TimeZone(identifier: "UTC")
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//    dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone!

    return dateFormatter.string(from: date)
}

func getStringFromDateusingUTC(_ format : String , date : Date) -> String {
    
    let dateFormatter  = DateFormatter()
    dateFormatter.dateFormat = format
    //        dateFormatter.timeZone = TimeZone(identifier: "UTC")
//    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.locale = Locale.current
    if AppConstants.isArabic() {
//        dateFormatter.locale = NSLocale(localeIdentifier: "ar") as Locale!
        dateFormatter.locale = NSLocale(localeIdentifier: "en") as? Locale
    }else{
        dateFormatter.locale = NSLocale(localeIdentifier: "en") as? Locale
    }
//    dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone!
//    dateFormatter.timeZone = NSTimeZone.local
    
    
    return dateFormatter.string(from: date)
}


func getDateFromString(_ formate : String , aStrDate : String) -> Date{
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = yyyyMMdd

    //    dateFormatter.dateFormat = ddMMyyyyEEEE
    //        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
    
    //dateFormatter.locale = Locale.current
    //dateFormatter.timeZone = NSTimeZone.local
    //dateFormatter.locale = Locale(identifier: "en_US_POSIX")

    var dateObj = Date()
    if aStrDate == "2017-03-31" {
        dateFormatter.dateFormat = yyyyMMdd
        dateFormatter.timeZone = TimeZone(identifier: "UTC")!
        dateObj = dateFormatter.date(from: aStrDate)!
    }else{
        dateObj = dateFormatter.date(from: aStrDate)!
    }
    
    
    //dateFormatter.dateFormat = formate
    
    return dateObj
}


func getDateFromStringByFormate(_ formate : String , aStrDate : String) -> Date{
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = yyyyMMdd
    dateFormatter.locale = Locale.current
    dateFormatter.timeZone = NSTimeZone.local
    
    dateFormatter.dateFormat = formate
    let dateObj = dateFormatter.date(from: aStrDate)
    
    dateFormatter.dateFormat = formate
    
    return dateObj!
}


func getTimeFromString(_ formate : String , aStrDate : String) -> Date{
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = formate
    //    dateFormatter.dateFormat = ddMMyyyyEEEE
    //        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
    dateFormatter.locale = Locale.current
    dateFormatter.timeZone = NSTimeZone.local
    
    let dateObj = dateFormatter.date(from: aStrDate)
    
    dateFormatter.dateFormat = formate
    
    return dateObj!
}



func daysBetweenDates(startDate: Date, endDate: Date) -> Int
{
    let calendarobj = Calendar.current
    let unitFlags = Set<Calendar.Component>([.day])
    let components = calendarobj.dateComponents(unitFlags , from: startDate, to: endDate)
    return components.day!
}

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
}

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

func getCurrentYearStartDate()->String? {
    
    let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
    let myComponents = myCalendar.components(.year, from: Date())
    let weekYear = myComponents.year
    
    let aStrYearStartDate = String.init(format: "%d-01-01", weekYear!)
    
    return aStrYearStartDate
    
}

func convertNumberToEnglish(aStr: String) -> String{
    let Formatter: NumberFormatter = NumberFormatter()
    Formatter.locale = Locale.init(identifier: "EN")
    if let final = Formatter.number(from: aStr) {
        print(final)
        return final.stringValue
    }
    return ""
}




func getMonthFromDate(aDate : Date) -> Int {
    
    let month = Calendar.current.component(.month, from: aDate)
    return month
}

func getDayFromDate(aDate : Date) -> Int {
    
    let Day = Calendar.current.component(.day, from: aDate)
    return Day
}

func getYearFromDate(aDate : Date) -> Int {
    
    let month = Calendar.current.component(.year, from: aDate)
    return month
}



func convertNumberToArabic(aStr: String) -> String{
    let Formatter: NumberFormatter = NumberFormatter()
    Formatter.locale = Locale.init(identifier: "AR")
    if let final = Formatter.number(from: aStr) {
        print(final)
        return final.stringValue
    }
    return ""
}


func validateBlank(strVal: String) -> Bool {
    
    let strValue = removeWhiteSpace(strVal: strVal)
    
    if (strValue.count <= 0) {
        return false
    }
    return true
}

func removeWhiteSpace(strVal: String) -> String {
    let strValue = strVal.trimmingCharacters(in: NSMutableCharacterSet.whitespaceAndNewline() as CharacterSet)
    return strValue
}


func UploadFileToDropboxAC() -> Void {
    
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
    let url = NSURL(fileURLWithPath: path)
    let filePath = url.appendingPathComponent("SmartAgenda.sqlite")?.path
    let fileManager = FileManager.default
    
    let zipPath =  path.appendingFormat("/MyZipFiles")
    let zipPathCopy =  path.appendingFormat("/MyZipFiles/SmartAgenda.sqlite")
    let success = fileManager.fileExists(atPath: zipPath) as Bool
    if success == false {
        do {
            try! fileManager.createDirectory(atPath: zipPath, withIntermediateDirectories: false, attributes: nil)
            
        }
    }else{
        try! fileManager.removeItem(atPath: zipPath)
        do {
            try! fileManager.createDirectory(atPath: zipPath, withIntermediateDirectories: false, attributes: nil)
            
        }
    }
    
    let successok = fileManager.fileExists(atPath: zipPathCopy) as Bool
    if successok == false {
        do {try! fileManager.copyItem(atPath: filePath!, toPath: zipPathCopy)}
    }
    
    let archivePath = path.appendingFormat("/SmartAgenda.zip") // Sample folder is going to zip with name Demo.zip
    
    let successfile = fileManager.fileExists(atPath: archivePath) as Bool
    if successfile == true {
        do {
            try! fileManager.removeItem(atPath: archivePath)
            
        }
    }
    SSZipArchive.createZipFile(atPath: archivePath, withContentsOfDirectory:zipPath)
    
    print("zip archivePath = \(archivePath)")
    print("zip zipPath = \(zipPath)")
    
    
    if fileManager.fileExists(atPath: archivePath) {
        
        print("FILE AVAILABLE")
        
        // Verify user is logged into Dropbox
        let fileURL =  NSURL(fileURLWithPath: archivePath) as URL
        
        if let client = DropboxClientsManager.authorizedClient {
            
            client.files.deleteV2(path: "/SmartAgenda.zip")
            
            client.files.upload(path: "/SmartAgenda.zip", mode: .overwrite, autorename: false, clientModified: nil, mute: true, input: fileURL).response { response, error in
                if let metadata = response {
                    print("*** Upload file ****")
                    print("Uploaded file name: \(metadata.name)")
                    print("Uploaded file revision: \(metadata.rev)")
                    client.files.getMetadata(path: "/SmartAgenda.zip").response { response, error in
                        print("*** Get file metadata ***")
                        if let metadata = response {
                            if let file = metadata as? Files.FileMetadata {
                                print("This is a file with path: \(file.pathLower)")
                                print("File size: \(file.size)")
                            } else if let folder = metadata as? Files.FolderMetadata {
                                print("This is a folder with path: \(folder.pathLower)")
                            }
                        } else {
                            print(error!)
                        }
                    }
                }
            }
            
        }
        
        SVProgressHUD.dismiss()
        
    } else {
        print("FILE NOT AVAILABLE")
        showAlert(appDelegate.topMostController(), message: JMOLocalizedString(forKey: "the backup process failed", value: ""))
    }
    
}

func DownloadFileFromDropboxAC() -> Bool {
    
    var aDownloadRestoreStatus = false
    
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
    
    let fileManager = FileManager.default
    let dbfilepath =  path.appendingFormat("/SmartAgenda.sqlite")
    let dbfilezippath =  path.appendingFormat("/SmartAgenda.zip")
    
    if fileManager.fileExists(atPath: path.appendingFormat("%@","/")) {
        
        print("FILE AVAILABLE")
        
        // Verify user is logged into Dropbox
        
        
        if let client = DropboxClientsManager.authorizedClient {
            // Download to URL
            let directoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let destURL = directoryURL.appendingPathComponent("SmartAgenda.zip")
            let destination: (URL, HTTPURLResponse) -> URL = { temporaryURL, response in
                return destURL
            }
            
            let url = URL(fileURLWithPath: path)
            let unzipfilepath = path + "/SmartAgenda"
            let unzipfilepathurl = URL(fileURLWithPath: unzipfilepath)
            
            do {
                try FileManager.default.createDirectory(at: unzipfilepathurl, withIntermediateDirectories: true, attributes: nil)
            } catch {
                
            }
            
            
            client.files.download(path: "/SmartAgenda.zip", overwrite: true, destination: destination)
                .response { response, error in
                    if let response = response {
                        
                        print(response)
                        
                        let success = fileManager.fileExists(atPath: dbfilepath) as Bool
                        if success == true {
                            do {
                                try! fileManager.removeItem(atPath: dbfilepath)
                                
                            }
                        }
                        

                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                            
                            let success = SSZipArchive.unzipFile(atPath: dbfilezippath, toDestination: unzipfilepathurl.path)
                            
                            if success {
                                
                                let successok = fileManager.fileExists(atPath: unzipfilepath + "/SmartAgenda.sqlite") as Bool
                                let filePath = url.appendingPathComponent("SmartAgenda.sqlite").path
                                
                                if successok == true {
                                    do {try! fileManager.copyItem(atPath: unzipfilepath + "/SmartAgenda.sqlite", toPath: filePath
                                        )}
                                    
                                    aDownloadRestoreStatus = true
                                    
                                let zipsuccess = fileManager.fileExists(atPath: dbfilezippath) as Bool
                                
                                    if zipsuccess == true {
                                    do {
                                        try! fileManager.removeItem(atPath: dbfilezippath)
                                        try! fileManager.removeItem(atPath: path + "/SmartAgenda")
    
                                    }
                                }
                                    
                                    
                                    if currentViewContoller != nil{
                                        
                                        appDelegate.aDropboxBackup = 1
                                        currentViewContoller?.viewWillAppear(true)
                                        
                                    }
                                }
                                
                                return
                            }
                            
                        })
                    }
                    else if let error = error {
                        print(error)
                        
                        let errorCode = error.description
                        
                        if errorCode.range(of:"not_found") != nil{
                            print("dropbox file not exist..")
                            
                            showAlert(appDelegate.topMostController(), message: JMOLocalizedString(forKey: "No Backup found to restore", value: ""))
                        }else{
                            showAlert(appDelegate.topMostController(), message: JMOLocalizedString(forKey: "backup process failed", value: ""))
                        }

                        aDownloadRestoreStatus = false
                    }
                }
                .progress { progressData in
                    print(progressData)
            }
            
            
        }
        
        
    } else {
        print("FILE NOT AVAILABLE")
         showAlert(appDelegate.topMostController(), message: JMOLocalizedString(forKey: "No Backup found to restore", value: ""))
    }
    
    return aDownloadRestoreStatus
}

func IsCalenderEvent(_ aArrAppoinetmentList : [ReminderModel] , date: Date) -> Int {
    
//One time 
    // Month
    // Weekly
    // Daily
    
    var eventCount : Int = 0
    
    if aArrAppoinetmentList.count > 0 {
        
        for aObjReminderModel in aArrAppoinetmentList {
            
            var aStrReminderFrequency = ""
            if aObjReminderModel.reminderFrequency != nil {
                aStrReminderFrequency = aObjReminderModel.reminderFrequency!
                
            }
            
            print("aStrReminderFrequency == \(aStrReminderFrequency)")
            
            var aaOjbStartDate = Date()
            if (aObjReminderModel.reminderDate == nil || aObjReminderModel.reminderDate == ""){
                aaOjbStartDate = getDateFromString(ddMMyyyyEEEE, aStrDate: "2017-01-01")
            }else{
                aaOjbStartDate = getDateFromString(ddMMyyyyEEEE, aStrDate: aObjReminderModel.reminderDate)
            }
            
            var aaOjbEndDate = Date()
            
            if (aObjReminderModel.reminderEndDate == nil || aObjReminderModel.reminderEndDate == ""){
                aaOjbEndDate = getDateFromString(ddMMyyyyEEEE, aStrDate: "2018-01-01")
            }
            else{
                aaOjbEndDate = getDateFromString(ddMMyyyyEEEE, aStrDate: aObjReminderModel.reminderEndDate)
            }
            
            // ============================================================================
            // ============================================================================
            if aStrReminderFrequency == ReminderFrequency.week.rawValue {
                
                // weekly events..
                var aWeekDayInComparion : Int = 1
                
                if !(aObjReminderModel.reminderWeaklyDay.isEmpty) {
                    aWeekDayInComparion = GetWeekDayNumber(aObjReminderModel.reminderWeaklyDay)
                }
                
                let eventCountvalue = CheckEventsForWeek(aaOjbStartDate, aaOjbEndDate: aaOjbEndDate, aWeekDayInComparion: aWeekDayInComparion, date: date)
                
                if eventCountvalue == 1 {
                    
                    print(AppDelegate().appDelegateShared().strCurrentMonth)
                    AppDelegate().appDelegateShared().arrEventOnlyDay.append(Int(getStringFromDate(dd, date: date))!)
                    
                    eventCount = 1
                }
                else{
                    if eventCount != 1 {
//                        eventCount = 0
                    }
                }
                
            }
            else if aStrReminderFrequency == ReminderFrequency.month.rawValue {
                
                //                // month events..
                
                var aMonthDayInComparion : Int = 0
                
                if !(aObjReminderModel.reminderMonthlyDay.isEmpty) {
                    aMonthDayInComparion = Int(aObjReminderModel.reminderMonthlyDay)!
                }
                
                
                let eventCountvalue = CheckEventsForMonth(aaOjbStartDate, aaOjbEndDate: aaOjbEndDate, aMonthDayInComparion: aMonthDayInComparion, date: date)
//
                if eventCountvalue == 1 {
                    
                    AppDelegate().appDelegateShared().arrEventOnlyDay.append(Int(getStringFromDate(dd, date: date))!)
                    eventCount = 2
                    print("Month = \(eventCount)")
                    
                }
                else{
                    if eventCount != 1 {
//                        eventCount = 0
                    }
                }
            }
            else if aStrReminderFrequency == ReminderFrequency.day.rawValue{
                // day events..
                
                
                if (date >= aaOjbStartDate) && (date <= aaOjbEndDate)
                {
                    
                    AppDelegate().appDelegateShared().arrEventOnlyDay.append(Int(getStringFromDate(dd, date: date))!)
                    
                    eventCount = 3  
                }
                
            }
            else{
                // none only single day event..
                
                if (getStringFromDate(ddMMyyyy, date: date) == getStringFromDate(ddMMyyyy, date: aaOjbStartDate)) //&& (date == aaOjbEndDate)
                {
                    AppDelegate().appDelegateShared().arrEventOnlyDay.append(Int(getStringFromDate(dd, date: date))!)
                    
                    eventCount = 4
                }
            }
        }
    }
    //    else{
    //        if eventCount != 1 || eventCount != 2 || eventCount != 3 || eventCount != 4 {
    //            eventCount = 0
    //        }
    //    }
    print("eventCount = \(eventCount)")
    
    return eventCount
}


func CheckEventsForWeek(_ aaOjbStartDate:Date , aaOjbEndDate:Date , aWeekDayInComparion : Int ,date: Date ) -> Int {
    
   // let gregorian: NSCalendar! = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian)
    
   // let differenceDays = daysBetweenDates(startDate: aaOjbStartDate, endDate: aaOjbEndDate)
    var eventCount : Int = 0
    var aDayInComparion = 0
    if aWeekDayInComparion != 0 {
        aDayInComparion = aWeekDayInComparion
    }
    
  /*  if differenceDays != 0 {
        
        for var i in (0...(differenceDays-1)) {
            
            var aaaOjbStartDate = Date()
          
            if(i==0)
            {
                aaaOjbStartDate = aaOjbStartDate
            }
            else{
                aaaOjbStartDate = gregorian.date(byAdding: .day, value: 1, to: aaOjbStartDate, options: .init(rawValue: 0))!
            }
            
            if (date < aaaOjbStartDate) || (date > aaOjbEndDate)
            {
                if eventCount != 1 {
//                    eventCount = 0
                }
            }
            else{
                let weekDay = NSCalendar.current.component(.weekday, from: date)
                if (weekDay == aDayInComparion){
                    eventCount = 1
                }
                else{
                    if eventCount != 1 {
//                        eventCount = 0
                    }
                }
            }
            
        }
    }else{
 */
        if (date < aaOjbStartDate) || (date > aaOjbEndDate)
        {
            if eventCount != 1 {
//                eventCount = 0
            }
        }
        else{
            let weekDay = NSCalendar.current.component(.weekday, from: date)
            
            if (weekDay == aDayInComparion){
                eventCount = 1
            }
            else{
                if eventCount != 1 {
//                    eventCount = 0
                }
            }
        }
   // }
    
    return eventCount
}



func CheckEventsForMonth(_ aaOjbStartDate:Date , aaOjbEndDate:Date , aMonthDayInComparion : Int ,date: Date ) -> Int {
    
    let gregorian: NSCalendar! = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian)
    
    let differenceDays = daysBetweenDates(startDate: aaOjbStartDate, endDate: aaOjbEndDate)
    var eventCount : Int = 0
    var aDayInComparion = 0
    if aMonthDayInComparion != 0 {
        aDayInComparion = aMonthDayInComparion
    }
    
   /*
   if differenceDays != 0 {
        
        for var i in (0...(differenceDays-1)){
            
            var aaaOjbStartDate = Date()
            if(i==0)
            {
                aaaOjbStartDate = aaOjbStartDate
            }
            else{
                aaaOjbStartDate = gregorian.date(byAdding: .day, value: 1, to: aaOjbStartDate, options: .init(rawValue: 0))!
            }
            
            if (date < aaaOjbStartDate) || (date > aaOjbEndDate)
            {
                if eventCount != 1 {
//                    eventCount = 0
                }
            }
            else{
                let weekDay = NSCalendar.current.component(.day, from: date)
                if (weekDay == aDayInComparion){
                    eventCount = 1
                    
                }
                else{
                    if eventCount != 1 {
//                        eventCount = 0
                    }
                }
            }
        }
    }else{
     */
        if (date < aaOjbStartDate) || (date > aaOjbEndDate)
        {
            if eventCount != 1 {
//                eventCount = 0
            }
        }
        else{
            let weekDay = NSCalendar.current.component(.day, from: date)
            
            if (weekDay == aDayInComparion){
                eventCount = 1
                
            }
            else{
                if eventCount != 1 {
//                    eventCount = 0
                }
            }
      //  }
    }
    
    return eventCount
}





//func ManageStartDateEndDate(_ aStartDate : String , aEndDate : String) -> (aStrStartDate : String , aStrEndDate : String) {
//    
//    if aStartDate == nil {
//       aStartDate = "2000-01-01"
//    }else if aEndDate == nil {
//        aEndDate = "3000-01-01"
//    }
//    
//    return (aStartDate,aEndDate)
//}

struct Color {
    static let selectedText = UIColor.white
    static let text = UIColor(red: 84.0/255.0, green: 84.0/255.0, blue: 84.0/255.0, alpha: 1.0) // UIColor.black // KP
    static let textDisabled = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0) // UIColor.gray // KP
    static let selectionBackground = UIColor(red: 251.0/255.0, green: 199.0/255.0, blue: 0.0/255.0, alpha: 1.0) // UIColor(red: 0.2, green: 0.2, blue: 1.0, alpha: 1.0) // KP
    static let sundayText = text // UIColor(red: 1.0, green: 0.2, blue: 0.2, alpha: 1.0) // KP
    static let sundayTextDisabled = textDisabled // UIColor(red: 1.0, green: 0.6, blue: 0.6, alpha: 1.0) // KP
    static let sundaySelectionBackground = UIColor(red: 247.0/255.0, green: 182.0/255.0, blue: 44.0/255.0, alpha: 1.0) // sundayText // KP
}


extension String {
    mutating func replace(_ originalString:String, with newString:String) {
        self = self.replacingOccurrences(of: originalString, with: newString)
    }
}

//extension NSDate {
//    func dayOfTheWeek() -> String? {
//        let weekdays = [
//            "Sunday",
//            "Monday",
//            "Tuesday",
//            "Wednesday",
//            "Thursday",
//            "Friday",
//            "Satudrday,"
//        ]
//        
//        let calendar: NSCalendar = NSCalendar.currentCalendar as NSCalendar
//        let components: NSDateComponents = calendar.components(.weekday, fromDate: self as Date)
//        return weekdays[components.weekday - 1]
//    }
//}


