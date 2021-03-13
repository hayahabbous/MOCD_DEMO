//
//  ReminderModel.swift
//  SmartAgenda
//
//  Created by indianic on 05/01/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit

class ReminderModel: NSObject {

    var reminderID : Int!
    var type : Int!
    var typeID : Int!
    var reminderTxt : String!
    var reminderTime : String!
    var reminderFrequency : String?
    var reminderWithNotification : Int!
    var reminderDate : String!
    var reminderEndDate : String!
    var reminderWeaklyDay : String!
    var reminderMonthlyDay : String!
    var intOrder: Int!
    var aQueryExcutionStatus : Bool!
    var mutArrReminderList = [ReminderModel]()
    var mutArrGetSelectedData = [ReminderModel]()
    var isBoolSelected: Int!
    
    func GetAllReminderListForCalender(_ aStrStartDateOfMonth : String, aStrEndDateOfMonth : String, aReminderType : Int, completion: ([ReminderModel]) -> Void)  {
        
        
        let aStrGetAllQuery = "select * from reminder where type = '\(aReminderType)' AND (reminder_date BETWEEN '\(aStrStartDateOfMonth)' AND '\(aStrEndDateOfMonth)' OR reminder_date IS NULL OR reminder_date IS '') AND (reminder_end_date >= '\(aStrStartDateOfMonth)' OR reminder_end_date IS NULL OR reminder_end_date IS '')"
        
        print("aStrGetAllQuery = \(aStrGetAllQuery)")
        
        let tempmutArrReminderList : [[String : AnyObject]] = Database().selectAllfromTable(query: aStrGetAllQuery) { (status) in
        }
        
        if self.mutArrReminderList.count > 0 {
            self.mutArrReminderList.removeAll()
        }
        
        if tempmutArrReminderList.count > 0 {
            
            for aDictReminderInfo in tempmutArrReminderList {
                
                let objReminderModel = ReminderModel()
                
                objReminderModel.reminderID = aDictReminderInfo["reminder_id"] as? Int
                objReminderModel.type = aDictReminderInfo["type"] as? Int
                objReminderModel.typeID = aDictReminderInfo["type_id"] as? Int
                objReminderModel.reminderTxt = aDictReminderInfo["reminder_txt"] as? String
                objReminderModel.reminderTime = aDictReminderInfo["reminder_time"] as? String
                objReminderModel.reminderFrequency = aDictReminderInfo["reminder_frequency"] as? String
                objReminderModel.reminderWithNotification = aDictReminderInfo["reminder_with_notification"] as? Int
                objReminderModel.reminderDate = aDictReminderInfo["reminder_date"] as? String
                objReminderModel.reminderEndDate = aDictReminderInfo["reminder_end_date"] as? String
                objReminderModel.reminderWeaklyDay = aDictReminderInfo["reminder_weakly_day"] as? String
                objReminderModel.reminderMonthlyDay = aDictReminderInfo["reminder_monthly_day"] as? String
                
                if JMOLocalizedString(forKey: objReminderModel.reminderFrequency!, value: "") == "" {
                    // One day
                    objReminderModel.intOrder = 1
                }else if JMOLocalizedString(forKey: objReminderModel.reminderFrequency!, value: "") == JMOLocalizedString(forKey: Recurring.MonthlyRecurr.rawValue, value: "") {
                    // Month
                    objReminderModel.intOrder = 2
                }else if JMOLocalizedString(forKey: objReminderModel.reminderFrequency!, value: "") == JMOLocalizedString(forKey: Recurring.WeeklyRecurr.rawValue, value: "") {
                    // Week
                    objReminderModel.intOrder = 3
                }else if JMOLocalizedString(forKey: objReminderModel.reminderFrequency!, value: "") == JMOLocalizedString(forKey: Recurring.DailyRecurr.rawValue, value: "") {
                    // Daily
                    objReminderModel.intOrder = 4
                }
                
                if objReminderModel.reminderDate == nil {
                    print("sss")
                }
                
                self.mutArrReminderList.append(objReminderModel)
            }
            
            completion (self.mutArrReminderList)

        }else{
            completion (self.mutArrReminderList)

        }
    }
    
    private let dayFormatterEEEE: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter
    }()
    
    private let dayFormatterDD: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter
    }()
    
    func GetAllReminderListForChecklist(_ aDateOfEvent : Date, strStartEndDateOfMonth : [String], complete: (([ReminderModel])-> Void)) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        var dateSelected = dateFormatter.string(from: aDateOfEvent)
        
        let aStrSelectedDat = dayFormatterEEEE.string(from: aDateOfEvent)
        var aDay = dayFormatterDD.string(from: aDateOfEvent)
        
        print(aStrSelectedDat)
        print(aDay)
        

        // Weekly:
        //  select * from reminder where  reminder_frequency = 'Weekly' AND reminder_weakly_day = 'Monday'
        let aStrQueryForWeekly = "select * from reminder where reminder_frequency = 'Weekly' AND (reminder_weakly_day = '\(aStrSelectedDat)') AND (reminder_end_date >= '\(dateSelected)' OR reminder_end_date IS NULL OR reminder_end_date IS '') AND (reminder_date <= '\(dateSelected)' OR reminder_date IS NULL OR reminder_date IS '')"
        
        // Monthly:
        // select * from reminder where reminder_frequency = 'Monthly' AND reminder_monthly_day='2'
        
        switch aDay {
        case "01", "02", "03", "04", "05", "06", "07", "08", "09":
            aDay = "\(aDay.last!)"

        default:
            print("ss")
        }
        let aStrQueryForMonthly = "select * from reminder where reminder_frequency = 'Monthly' AND reminder_monthly_day='\(aDay)' AND (reminder_end_date >= '\(dateSelected)' OR reminder_end_date IS NULL OR reminder_end_date IS '') AND (reminder_date <= '\(dateSelected)' OR reminder_date IS NULL OR reminder_date IS '')"

        /*
         let aStrGetAllQuery = String(format: "SELECT * FROM reminder where (reminder_date BETWEEN '\(dateSelected)' AND '\(dateSelected)' OR reminder_date IS NULL OR reminder_date IS '') AND (reminder_end_date == '\(dateSelected)' OR reminder_end_date IS NULL OR reminder_end_date IS '') AND (reminder_frequency IS NULL OR reminder_frequency IS '' OR  reminder_frequency IS 'Daily')")

         */
        let aStrGetAllQuery = String(format: "SELECT * FROM reminder where (reminder_date <= '\(dateSelected)' OR reminder_date IS NULL OR reminder_date IS '') AND (reminder_end_date >= '\(dateSelected)' OR reminder_end_date IS NULL OR reminder_end_date IS '') AND (reminder_frequency IS NULL OR reminder_frequency IS '' OR  reminder_frequency IS 'Daily')")
        
        print("aStrQueryForWeekly = \(aStrQueryForWeekly)")

        print("aStrQueryForMonthly = \(aStrQueryForMonthly)")

        print("aStrGetAllQuery = \(aStrGetAllQuery)")
        
        
        if self.mutArrReminderList.count > 0 {
            self.mutArrReminderList.removeAll()
        }
        
        getChecklistData(aStrGetAllQuery: aStrGetAllQuery) { (obj: [ReminderModel]) in
            getChecklistData(aStrGetAllQuery: aStrQueryForWeekly, complete: { (obj: [ReminderModel]) in
                getChecklistData(aStrGetAllQuery: aStrQueryForMonthly, complete: { (obj: [ReminderModel]) in
                    
                    complete (self.mutArrReminderList)
                })
        })
            
            
        }
        
    }
    
    private func getChecklistData(aStrGetAllQuery: String, complete: (([ReminderModel])-> Void)) {
        let tempmutArrReminderList : [[String : AnyObject]] = Database().selectAllfromTable(query: aStrGetAllQuery) { (status) in
        }
        
        if tempmutArrReminderList.count > 0 {
            
            for aDictReminderInfo in tempmutArrReminderList {
                
                let objReminderModel = ReminderModel()
                
                objReminderModel.reminderID = aDictReminderInfo["reminder_id"] as? Int
                objReminderModel.type = aDictReminderInfo["type"] as? Int
                objReminderModel.typeID = aDictReminderInfo["type_id"] as? Int
                objReminderModel.reminderTxt = aDictReminderInfo["reminder_txt"] as? String
                objReminderModel.reminderTime = aDictReminderInfo["reminder_time"] as? String
                objReminderModel.reminderFrequency = aDictReminderInfo["reminder_frequency"] as? String
                objReminderModel.reminderWithNotification = aDictReminderInfo["reminder_with_notification"] as? Int
                objReminderModel.reminderDate = aDictReminderInfo["reminder_date"] as? String
                objReminderModel.reminderEndDate = aDictReminderInfo["reminder_end_date"] as? String
                objReminderModel.reminderWeaklyDay = aDictReminderInfo["reminder_weakly_day"] as? String
                objReminderModel.reminderMonthlyDay = aDictReminderInfo["reminder_monthly_day"] as? String
                print(objReminderModel.reminderTxt)
                self.mutArrReminderList.append(objReminderModel)
            }
        }
        
        complete(self.mutArrReminderList)
    }
    
    
    func insertInReminder(aObjReminder: ReminderModel, count: Int) -> Bool{
        
        var aQueryExcutionStatus : Bool!

        aObjReminder.typeID = count
        if (aObjReminder.reminderTime == nil) { aObjReminder.reminderTime = "" }
        if (aObjReminder.reminderFrequency == nil) { aObjReminder.reminderFrequency = "" }
        if (aObjReminder.reminderWithNotification == nil) { aObjReminder.reminderWithNotification = 0 }
        if (aObjReminder.reminderDate == nil) { aObjReminder.reminderDate = "" }
        if (aObjReminder.reminderEndDate == nil) { aObjReminder.reminderEndDate = "" }
        if (aObjReminder.reminderWeaklyDay == nil) { aObjReminder.reminderWeaklyDay = "" }
        if (aObjReminder.reminderMonthlyDay == nil) { aObjReminder.reminderMonthlyDay = "" }
        
        // Insert into reminder table
        let insertSQLInReminder = "INSERT INTO reminder (type, type_id, reminder_time, reminder_frequency, reminder_with_notification, reminder_date, reminder_end_date, reminder_weakly_day, reminder_monthly_day, reminder_txt) VALUES ('\(aObjReminder.type!)','\(aObjReminder.typeID!)','\(aObjReminder.reminderTime!)','\(aObjReminder.reminderFrequency!)','\(aObjReminder.reminderWithNotification!)','\(aObjReminder.reminderDate!)','\(aObjReminder.reminderEndDate!)','\(aObjReminder.reminderWeaklyDay!)','\(aObjReminder.reminderMonthlyDay!)','\(aObjReminder.reminderTxt!)')"
        
        print(insertSQLInReminder)
        
        Database.sharedInstance.insert(query: insertSQLInReminder, success: {
            // Success.
            aQueryExcutionStatus = true
            
        }, failure: {
            // failure
            aQueryExcutionStatus = false
            
        })

        return aQueryExcutionStatus
        
    }

    
    
    func updateInReminder(aObjReminder: ReminderModel, typeid: Int) -> Bool{
        
        var aQueryExcutionStatus : Bool!
        
        aObjReminder.typeID = typeid
        if (aObjReminder.reminderTime == nil) { aObjReminder.reminderTime = "" }
        if (aObjReminder.reminderFrequency == nil) { aObjReminder.reminderFrequency = "" }
        if (aObjReminder.reminderWithNotification == nil) { aObjReminder.reminderWithNotification = 0 }
        if (aObjReminder.reminderDate == nil) { aObjReminder.reminderDate = "" }
        if (aObjReminder.reminderEndDate == nil) { aObjReminder.reminderEndDate = "" }
        if (aObjReminder.reminderWeaklyDay == nil) { aObjReminder.reminderWeaklyDay = "" }
        if (aObjReminder.reminderMonthlyDay == nil) { aObjReminder.reminderMonthlyDay = "" }
        
        // Insert into reminder table
        let updateSQLInReminder = "UPDATE reminder SET type='\(aObjReminder.type!)', type_id='\(aObjReminder.typeID!)', reminder_time='\(aObjReminder.reminderTime!)', reminder_frequency='\(aObjReminder.reminderFrequency!)', reminder_with_notification='\(aObjReminder.reminderWithNotification!)', reminder_date='\(aObjReminder.reminderDate!)', reminder_end_date='\(aObjReminder.reminderEndDate!)', reminder_weakly_day='\(aObjReminder.reminderWeaklyDay!)', reminder_monthly_day='\(aObjReminder.reminderMonthlyDay!)', reminder_txt='\(aObjReminder.reminderTxt!)' WHERE type_id='\(aObjReminder.typeID!)' AND type='\(aObjReminder.type!)'"
        
        print(updateSQLInReminder)
        
        Database.sharedInstance.insert(query: updateSQLInReminder, success: {
            // Success.
            aQueryExcutionStatus = true
            
        }, failure: {
            // failure
            aQueryExcutionStatus = false
            
        })
        
        return aQueryExcutionStatus
        
    }
    
    
    func getAllFromReminderBasedOnSelectedData(typrID: String, identifire: String, completion: (([ReminderModel]) -> Void )){

        let aStrQuery = "select * from reminder where type = \(typrID) and type_id = '\(identifire)'"
        print(aStrQuery)
        var aMutTemp: [[String: AnyObject]] = Database().selectAllfromTable(query: aStrQuery) { (result: String) in
            
        }

        
        if mutArrGetSelectedData.count > 0 {
           mutArrGetSelectedData.removeAll()
        }
        
        for aDictReminderInfo in aMutTemp {
            
            let objReminderModel = ReminderModel()
            
            objReminderModel.reminderID = aDictReminderInfo["reminder_id"] as? Int
            objReminderModel.type = aDictReminderInfo["type"] as? Int
            objReminderModel.typeID = aDictReminderInfo["type_id"] as? Int
            objReminderModel.reminderTxt = aDictReminderInfo["reminder_txt"] as? String
            objReminderModel.reminderTime = aDictReminderInfo["reminder_time"] as? String
            objReminderModel.reminderFrequency = aDictReminderInfo["reminder_frequency"] as? String
            objReminderModel.reminderWithNotification = aDictReminderInfo["reminder_with_notification"] as? Int
            objReminderModel.reminderDate = aDictReminderInfo["reminder_date"] as? String
            objReminderModel.reminderEndDate = aDictReminderInfo["reminder_end_date"] as? String
            objReminderModel.reminderWeaklyDay = aDictReminderInfo["reminder_weakly_day"] as? String
            objReminderModel.reminderMonthlyDay = aDictReminderInfo["reminder_monthly_day"] as? String
            
            if objReminderModel.reminderDate == nil {
                print("sss")
            }
            
            self.mutArrGetSelectedData.append(objReminderModel)
        }
            
            completion(self.mutArrGetSelectedData)

    }
    
    
    
    func getAllReminder(completion: (([ReminderModel]) -> Void )){
        
        let aStrQuery = "select * from reminder where reminder_with_notification = 1"
        print(aStrQuery)
        var aMutTemp: [[String: AnyObject]] = Database().selectAllfromTable(query: aStrQuery) { (result: String) in
            
        }
        
        
        if mutArrGetSelectedData.count > 0 {
            mutArrGetSelectedData.removeAll()
        }
        
        for aDictReminderInfo in aMutTemp {
            
            let objReminderModel = ReminderModel()
            
            objReminderModel.reminderID = aDictReminderInfo["reminder_id"] as? Int
            objReminderModel.type = aDictReminderInfo["type"] as? Int
            objReminderModel.typeID = aDictReminderInfo["type_id"] as? Int
            objReminderModel.reminderTxt = aDictReminderInfo["reminder_txt"] as? String
            objReminderModel.reminderTime = aDictReminderInfo["reminder_time"] as? String
            objReminderModel.reminderFrequency = aDictReminderInfo["reminder_frequency"] as? String
            objReminderModel.reminderWithNotification = aDictReminderInfo["reminder_with_notification"] as? Int
            objReminderModel.reminderDate = aDictReminderInfo["reminder_date"] as? String
            objReminderModel.reminderEndDate = aDictReminderInfo["reminder_end_date"] as? String
            objReminderModel.reminderWeaklyDay = aDictReminderInfo["reminder_weakly_day"] as? String
            objReminderModel.reminderMonthlyDay = aDictReminderInfo["reminder_monthly_day"] as? String
            
            if objReminderModel.reminderDate == nil {
                print("sss")
            }
            
            self.mutArrGetSelectedData.append(objReminderModel)
        }
        
        completion(self.mutArrGetSelectedData)
        
    }
    
    
    
    func getAllMedicationReminder(completion: (([ReminderModel]) -> Void )){
        
        let aStrQuery = "select * from reminder where reminder_with_notification = 1 AND type = 3"
        print(aStrQuery)
        var aMutTemp: [[String: AnyObject]] = Database().selectAllfromTable(query: aStrQuery) { (result: String) in
            
        }
        
        
        if mutArrGetSelectedData.count > 0 {
            mutArrGetSelectedData.removeAll()
        }
        
        for aDictReminderInfo in aMutTemp {
            
            let objReminderModel = ReminderModel()
            
            objReminderModel.reminderID = aDictReminderInfo["reminder_id"] as? Int
            objReminderModel.type = aDictReminderInfo["type"] as? Int
            objReminderModel.typeID = aDictReminderInfo["type_id"] as? Int
            objReminderModel.reminderTxt = aDictReminderInfo["reminder_txt"] as? String
            objReminderModel.reminderTime = aDictReminderInfo["reminder_time"] as? String
            objReminderModel.reminderFrequency = aDictReminderInfo["reminder_frequency"] as? String
            objReminderModel.reminderWithNotification = aDictReminderInfo["reminder_with_notification"] as? Int
            objReminderModel.reminderDate = aDictReminderInfo["reminder_date"] as? String
            objReminderModel.reminderEndDate = aDictReminderInfo["reminder_end_date"] as? String
            objReminderModel.reminderWeaklyDay = aDictReminderInfo["reminder_weakly_day"] as? String
            objReminderModel.reminderMonthlyDay = aDictReminderInfo["reminder_monthly_day"] as? String
            
            if objReminderModel.reminderDate == nil {
                print("sss")
            }
            
            self.mutArrGetSelectedData.append(objReminderModel)
        }
        
        completion(self.mutArrGetSelectedData)
        
    }
    
    
    func getAllAppointmentReminder(completion: (([ReminderModel]) -> Void )){
        
        let aStrQuery = "select * from reminder where reminder_with_notification = 1 AND type = 4"
        print(aStrQuery)
        var aMutTemp: [[String: AnyObject]] = Database().selectAllfromTable(query: aStrQuery) { (result: String) in
            
        }
        
        
        if mutArrGetSelectedData.count > 0 {
            mutArrGetSelectedData.removeAll()
        }
        
        for aDictReminderInfo in aMutTemp {
            
            let objReminderModel = ReminderModel()
            
            objReminderModel.reminderID = aDictReminderInfo["reminder_id"] as? Int
            objReminderModel.type = aDictReminderInfo["type"] as? Int
            objReminderModel.typeID = aDictReminderInfo["type_id"] as? Int
            objReminderModel.reminderTxt = aDictReminderInfo["reminder_txt"] as? String
            objReminderModel.reminderTime = aDictReminderInfo["reminder_time"] as? String
            objReminderModel.reminderFrequency = aDictReminderInfo["reminder_frequency"] as? String
            objReminderModel.reminderWithNotification = aDictReminderInfo["reminder_with_notification"] as? Int
            objReminderModel.reminderDate = aDictReminderInfo["reminder_date"] as? String
            objReminderModel.reminderEndDate = aDictReminderInfo["reminder_end_date"] as? String
            objReminderModel.reminderWeaklyDay = aDictReminderInfo["reminder_weakly_day"] as? String
            objReminderModel.reminderMonthlyDay = aDictReminderInfo["reminder_monthly_day"] as? String
            
            if objReminderModel.reminderDate == nil {
                print("sss")
            }
            
            self.mutArrGetSelectedData.append(objReminderModel)
        }
        
        completion(self.mutArrGetSelectedData)
        
    }
    
    func getAllDiseasesReminder(completion: (([ReminderModel]) -> Void )){
        
        let aStrQuery = "select * from reminder where reminder_with_notification = 1 AND type = 1"
        print(aStrQuery)
        var aMutTemp: [[String: AnyObject]] = Database().selectAllfromTable(query: aStrQuery) { (result: String) in
            
        }
        
        
        if mutArrGetSelectedData.count > 0 {
            mutArrGetSelectedData.removeAll()
        }
        
        for aDictReminderInfo in aMutTemp {
            
            let objReminderModel = ReminderModel()
            
            objReminderModel.reminderID = aDictReminderInfo["reminder_id"] as? Int
            objReminderModel.type = aDictReminderInfo["type"] as? Int
            objReminderModel.typeID = aDictReminderInfo["type_id"] as? Int
            objReminderModel.reminderTxt = aDictReminderInfo["reminder_txt"] as? String
            objReminderModel.reminderTime = aDictReminderInfo["reminder_time"] as? String
            objReminderModel.reminderFrequency = aDictReminderInfo["reminder_frequency"] as? String
            objReminderModel.reminderWithNotification = aDictReminderInfo["reminder_with_notification"] as? Int
            objReminderModel.reminderDate = aDictReminderInfo["reminder_date"] as? String
            objReminderModel.reminderEndDate = aDictReminderInfo["reminder_end_date"] as? String
            objReminderModel.reminderWeaklyDay = aDictReminderInfo["reminder_weakly_day"] as? String
            objReminderModel.reminderMonthlyDay = aDictReminderInfo["reminder_monthly_day"] as? String
            
            if objReminderModel.reminderDate == nil {
                print("sss")
            }
            
            self.mutArrGetSelectedData.append(objReminderModel)
        }
        
        completion(self.mutArrGetSelectedData)
        
    }
    
    func getAllFromReminderIDByDiseaseID(typrID: String, completion: (([ReminderModel]) -> Void )){
//        SELECT reminder_id FROM reminder INNER JOIN disease ON reminder.type_id AND reminder.type='1'
        
//        let aStrQuery = "SELECT reminder_id FROM reminder INNER JOIN disease ON reminder.type_id AND reminder.type='\(typrID)'"
        let aStrQuery = "SELECT reminder_id FROM reminder where type = '1' AND type_id = '\(typrID)'"
        
        
        print(aStrQuery)
        var aMutTemp: [[String: AnyObject]] = Database().selectAllfromTable(query: aStrQuery) { (result: String) in
            
        }
        
        
        if mutArrGetSelectedData.count > 0 {
            mutArrGetSelectedData.removeAll()
        }
        
        for aDictReminderInfo in aMutTemp {
            
            let objReminderModel = ReminderModel()
            
            objReminderModel.reminderID = aDictReminderInfo["reminder_id"] as? Int
            
            if objReminderModel.reminderDate == nil {
                print("sss")
            }
            
            self.mutArrGetSelectedData.append(objReminderModel)
        }
        
        completion(self.mutArrGetSelectedData)
        
    }
    
    func getAllFromReminderIDByMedicine_plans(typrID: String, completion: (([ReminderModel]) -> Void )){
        //        SELECT reminder_id FROM reminder where type = '3' AND type_id = '2'
        
        let aStrQuery = "SELECT reminder_id FROM reminder where type = '3' AND type_id = '\(typrID)'"
//        let aStrQuery = "SELECT reminder_id FROM reminder INNER JOIN medicine_plans ON reminder.type_id AND reminder.type='\(typrID)'"
        
        
        print(aStrQuery)
        var aMutTemp: [[String: AnyObject]] = Database().selectAllfromTable(query: aStrQuery) { (result: String) in
            
        }
        
        
        if mutArrGetSelectedData.count > 0 {
            mutArrGetSelectedData.removeAll()
        }
        
        for aDictReminderInfo in aMutTemp {
            
            let objReminderModel = ReminderModel()
            
            objReminderModel.reminderID = aDictReminderInfo["reminder_id"] as? Int
            
            if objReminderModel.reminderDate == nil {
                print("sss")
            }
            
            self.mutArrGetSelectedData.append(objReminderModel)
        }
        
        completion(self.mutArrGetSelectedData)
        
    }
    
    
}
