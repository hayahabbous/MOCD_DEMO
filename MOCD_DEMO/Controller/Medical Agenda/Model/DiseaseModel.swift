//
//  DiseaseModel.swift
//  SmartAgenda
//
//  Created by indianic on 05/01/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit


class DiseasesReminderModel: NSObject {
    
    var disease_id : Int!
    var disease_title : String!
    var disease_schedule : String!
    var disease_isbyuser : Int!
    var disease_id2 : Int!
    var disease_id3 : Int!
    
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
    
    var time2: String?
    var time3: String?
}


class DiseaseModel: NSObject {

    var disease_id : Int!
    var disease_title : String!
    var disease_schedule : String!
    var disease_isbyuser : Int!
    
    var mutArrDiseaseReminderList = [DiseasesReminderModel]()
    var mutDisease = [DiseaseModel]()
    func getDiseaseList(complition: (([DiseasesReminderModel]) -> Void)) {
        

//        let aStrGetAllQuery = "SELECT * FROM disease INNER JOIN reminder ON disease.disease_id=reminder.type_id AND reminder.type='1'"
        let aStrGetAllQuery = "SELECT * FROM disease"
        
        
        let aMutArrDiseaseReminderlist : [[String : AnyObject]] = Database().selectAllfromTable(query: aStrGetAllQuery) { (status) in
        }
        
        if self.mutArrDiseaseReminderList.count > 0 {
            self.mutArrDiseaseReminderList.removeAll()
        }
        
        if aMutArrDiseaseReminderlist.count > 0 {
            
            for aDictDiseaseInfo in aMutArrDiseaseReminderlist {
                
                let objGetDiseaseReminder = DiseasesReminderModel()
                objGetDiseaseReminder.disease_id = aDictDiseaseInfo["disease_id"] as? Int
                objGetDiseaseReminder.disease_title = aDictDiseaseInfo["disease_title"] as? String
                objGetDiseaseReminder.disease_schedule = aDictDiseaseInfo["disease_schedule"] as? String
                objGetDiseaseReminder.disease_isbyuser = aDictDiseaseInfo["disease_schedule"] as? Int
                
                objGetDiseaseReminder.time2 = ""
                objGetDiseaseReminder.time3 = ""
                
                objGetDiseaseReminder.reminderID = aDictDiseaseInfo["reminder_id"] as? Int
                objGetDiseaseReminder.type = aDictDiseaseInfo["type"] as? Int
                objGetDiseaseReminder.typeID = aDictDiseaseInfo["type_id"] as? Int
                objGetDiseaseReminder.reminderTxt = aDictDiseaseInfo["reminder_txt"] as? String
                objGetDiseaseReminder.reminderTime = aDictDiseaseInfo["reminder_time"] as? String
                objGetDiseaseReminder.reminderFrequency = aDictDiseaseInfo["reminder_frequency"] as? String
                objGetDiseaseReminder.reminderWithNotification = aDictDiseaseInfo["reminder_with_notification"] as? Int
                objGetDiseaseReminder.reminderDate = aDictDiseaseInfo["reminder_date"] as? String
                objGetDiseaseReminder.reminderEndDate = aDictDiseaseInfo["reminder_end_date"] as? String
                objGetDiseaseReminder.reminderWeaklyDay = aDictDiseaseInfo["reminder_weakly_day"] as? String
                objGetDiseaseReminder.reminderMonthlyDay = aDictDiseaseInfo["reminder_monthly_day"] as? String
                
                self.mutArrDiseaseReminderList.append(objGetDiseaseReminder)
            }
        }
        
        complition(self.mutArrDiseaseReminderList)
    }
    
    func getDiseaseListBasedOnTypeID(typeID:String, complition: (([DiseasesReminderModel]) -> Void)) {
        
//        let aStrGetAllQuery = "SELECT * FROM disease INNER JOIN reminder ON disease.disease_id=reminder.type_id AND reminder.type='1'"

        let aStrGetAllQuery = "SELECT * FROM reminder WHERE type_id=\(typeID) AND reminder.type='1' order by reminder_id"
//        let aStrGetAllQuery = "SELECT * FROM disease"
        
        
        let aMutArrDiseaseReminderlist : [[String : AnyObject]] = Database().selectAllfromTable(query: aStrGetAllQuery) { (status) in
        }
        
        if self.mutArrDiseaseReminderList.count > 0 {
            self.mutArrDiseaseReminderList.removeAll()
        }
        
        if aMutArrDiseaseReminderlist.count > 0 {
            
            for aDictDiseaseInfo in aMutArrDiseaseReminderlist {
                
                let objGetDiseaseReminder = DiseasesReminderModel()
                objGetDiseaseReminder.disease_id = aDictDiseaseInfo["disease_id"] as? Int
                objGetDiseaseReminder.disease_title = aDictDiseaseInfo["disease_title"] as? String
                objGetDiseaseReminder.disease_schedule = aDictDiseaseInfo["disease_schedule"] as? String
                objGetDiseaseReminder.disease_isbyuser = aDictDiseaseInfo["disease_schedule"] as? Int
                
                objGetDiseaseReminder.time2 = ""
                objGetDiseaseReminder.time3 = ""
                
                objGetDiseaseReminder.reminderID = aDictDiseaseInfo["reminder_id"] as? Int
                objGetDiseaseReminder.type = aDictDiseaseInfo["type"] as? Int
                objGetDiseaseReminder.typeID = aDictDiseaseInfo["type_id"] as? Int
                objGetDiseaseReminder.reminderTxt = aDictDiseaseInfo["reminder_txt"] as? String
                objGetDiseaseReminder.reminderTime = aDictDiseaseInfo["reminder_time"] as? String
                objGetDiseaseReminder.reminderFrequency = aDictDiseaseInfo["reminder_frequency"] as? String
                objGetDiseaseReminder.reminderWithNotification = aDictDiseaseInfo["reminder_with_notification"] as? Int
                objGetDiseaseReminder.reminderDate = aDictDiseaseInfo["reminder_date"] as? String
                objGetDiseaseReminder.reminderEndDate = aDictDiseaseInfo["reminder_end_date"] as? String
                objGetDiseaseReminder.reminderWeaklyDay = aDictDiseaseInfo["reminder_weakly_day"] as? String
                objGetDiseaseReminder.reminderMonthlyDay = aDictDiseaseInfo["reminder_monthly_day"] as? String
                
                self.mutArrDiseaseReminderList.append(objGetDiseaseReminder)
            }
        }
        
        complition(self.mutArrDiseaseReminderList)
    }
    
    
    func getDiseaseListByDate(_ fromDate : String , toDate: String,complition: (([DiseasesReminderModel]) -> Void)) {
        
        
        let aStrGetAllQuery = "SELECT * FROM disease INNER JOIN reminder ON disease.disease_id=reminder.type_id AND reminder.type='1' order by disease.disease_id"
        
//        let aStrGetAllQuery = String(format: "SELECT * FROM disease INNER JOIN reminder ON disease.disease_id=reminder.type_id AND reminder.type='1' AND (reminder.reminder_date  BETWEEN \"%@\" AND \"%@\")","\(fromDate)","\(toDate)")
        
        
        let aMutArrDiseaseReminderlist : [[String : AnyObject]] = Database().selectAllfromTable(query: aStrGetAllQuery) { (status) in
        }
        
        if self.mutArrDiseaseReminderList.count > 0 {
            self.mutArrDiseaseReminderList.removeAll()
        }
        
        if aMutArrDiseaseReminderlist.count > 0 {
            
            for aDictDiseaseInfo in aMutArrDiseaseReminderlist {
                
                let objGetDiseaseReminder = DiseasesReminderModel()
                objGetDiseaseReminder.disease_id = aDictDiseaseInfo["disease_id"] as? Int
                objGetDiseaseReminder.disease_title = aDictDiseaseInfo["disease_title"] as? String
                objGetDiseaseReminder.disease_schedule = aDictDiseaseInfo["disease_schedule"] as? String
                objGetDiseaseReminder.disease_isbyuser = aDictDiseaseInfo["disease_schedule"] as? Int
                
                objGetDiseaseReminder.time2 = ""
                objGetDiseaseReminder.time3 = ""
                
                objGetDiseaseReminder.reminderID = aDictDiseaseInfo["reminder_id"] as? Int
                objGetDiseaseReminder.type = aDictDiseaseInfo["type"] as? Int
                objGetDiseaseReminder.typeID = aDictDiseaseInfo["type_id"] as? Int
                objGetDiseaseReminder.reminderTxt = aDictDiseaseInfo["reminder_txt"] as? String
                objGetDiseaseReminder.reminderTime = aDictDiseaseInfo["reminder_time"] as? String
                objGetDiseaseReminder.reminderFrequency = aDictDiseaseInfo["reminder_frequency"] as? String
                objGetDiseaseReminder.reminderWithNotification = aDictDiseaseInfo["reminder_with_notification"] as? Int
                objGetDiseaseReminder.reminderDate = aDictDiseaseInfo["reminder_date"] as? String
                objGetDiseaseReminder.reminderEndDate = aDictDiseaseInfo["reminder_end_date"] as? String
                objGetDiseaseReminder.reminderWeaklyDay = aDictDiseaseInfo["reminder_weakly_day"] as? String
                objGetDiseaseReminder.reminderMonthlyDay = aDictDiseaseInfo["reminder_monthly_day"] as? String
                
                self.mutArrDiseaseReminderList.append(objGetDiseaseReminder)
            }
        }
        
        complition(self.mutArrDiseaseReminderList)
    }

    
    
    func insertDisese(objDisease: DiseaseModel, aObjReminder: ReminderModel, flageUpdate: Bool, complition: ((_ success: Bool)  -> Void)){
        
        if flageUpdate {
            // Update
            
            let updateSQLUpdate = "UPDATE disease SET disease_title ='\(objDisease.disease_title!)', disease_schedule='\(objDisease.disease_schedule!)', disease_isbyuser='\(objDisease.disease_isbyuser!)' WHERE disease_id='\(objDisease.disease_id!)'"
            
            print(updateSQLUpdate)
            
            Database.sharedInstance.update(query: updateSQLUpdate, success: {
                
                // Success.
                let aResult = ReminderModel().updateInReminder(aObjReminder: aObjReminder, typeid: objDisease.disease_id!)
                
                if aResult {
                    complition(true)
                }else{
                    complition(false)
                }
                
            }, failure: {
                // failure.
                complition(false)
            })
            
            
        }else{
            // Insert into appointment table
            let insertSQLDisease = "INSERT INTO disease (disease_title, disease_schedule, disease_isbyuser) VALUES ('\(objDisease.disease_title!)', '\(objDisease.disease_schedule!)', '\(objDisease.disease_isbyuser!)')"
            
            Database.sharedInstance.insert(query: insertSQLDisease, success: {

            print(insertSQLDisease)
            
            complition(true)
                
                
            }, failure: {
                // failure.
                complition(false)
            })
            
            
        }
    }


    func insertInToReminderForDisease(objDisease: DiseaseModel, aObjReminder: ReminderModel, flageUpdate: Bool, complition: ((_ success: Bool)  -> Void)){ 
        // Success.
        // Get count from appointment table
        Database.sharedInstance.getRecordCount(query: "select MAX(disease_id) from disease", success: { (count: Int) in
            print(count)
            
            let aResult = ReminderModel().insertInReminder(aObjReminder: aObjReminder, count: count)
            
            if aResult {
                complition(true)
            }else{
                complition(false)
            }
            
            
        }, failure: {
            // failure.
            complition(false)
        })
        
}
    
    
    func getMaxCount(complitionCount: ((String)-> Void)) {
        // Get count
        //select MAX(reminder_id) from reminder
        //select MAX(disease_id) from disease
        Database.sharedInstance.getRecordCount(query: "select MAX(reminder_id) from reminder", success: { (count: Int) in
            
            print(count)
            
            complitionCount("\(count)")
        }, failure: {
            // failure.
        })
    }
    func deleteDisease(deleteID: Int, complition: ((Bool)  -> Void)) {
        
        let sqlDeleteDisease =  "DELETE FROM disease WHERE disease_id='\(deleteID)'"
        let sqlDeleteReminder =  "DELETE FROM reminder WHERE type_id='\(deleteID)' AND type='1'"
        
        Database().delete(query: sqlDeleteDisease, success: { (success: Bool) in
            // Delete from Appointment table
            Database().delete(query: sqlDeleteReminder, success: { (success: Bool) in
                // Delete from reminder table
                
                complition(true)
            }) { (failure: Bool) in
                complition(false)
            }
            
        }) { (failure: Bool) in
            complition(false)
        }
    }
    
    
    func getOnlyDiseaseList(complition: (([DiseaseModel])-> Void)) {
        
        let aStrGetAllQuery = "SELECT * FROM disease"
        
        let aMutArrDiseaseList : [[String : AnyObject]] = Database().selectAllfromTable(query: aStrGetAllQuery) { (status) in
        }
        
        if self.mutDisease.count > 0 {
            self.mutDisease.removeAll()
        }
        
        if aMutArrDiseaseList.count > 0 {
            
            for aDictDiseaseInfo in aMutArrDiseaseList {
                
                let objGetDisease = DiseaseModel()
                objGetDisease.disease_id = aDictDiseaseInfo["disease_id"] as? Int
                objGetDisease.disease_title = aDictDiseaseInfo["disease_title"] as? String
                objGetDisease.disease_schedule = aDictDiseaseInfo["disease_schedule"] as? String
                objGetDisease.disease_isbyuser = aDictDiseaseInfo["disease_schedule"] as? Int
                
                self.mutDisease.append(objGetDisease)
            }
        }
        complition(self.mutDisease)

    }
    
    
    func getBloodPS() -> [DiseasesReminderModel] {
        
        // SELECT * FROM disease INNER JOIN reminder ON disease.disease_id=reminder.type_id AND reminder.type='1' AND (disease_id ='4' OR disease_id ='5')
        
        let aStrGetAllQuery = "SELECT * FROM disease INNER JOIN reminder ON disease.disease_id=reminder.type_id AND reminder.type='1' AND (disease_id ='4' OR disease_id ='5') "
        
        
        let aMutArrDiseaseReminderlist : [[String : AnyObject]] = Database().selectAllfromTable(query: aStrGetAllQuery) { (status) in
        }
        
        if self.mutArrDiseaseReminderList.count > 0 {
            self.mutArrDiseaseReminderList.removeAll()
        }
        
        if aMutArrDiseaseReminderlist.count > 0 {
            
            for aDictDiseaseInfo in aMutArrDiseaseReminderlist {
                
                let objGetDiseaseReminder = DiseasesReminderModel()
                objGetDiseaseReminder.disease_id = aDictDiseaseInfo["disease_id"] as? Int
                objGetDiseaseReminder.disease_title = aDictDiseaseInfo["disease_title"] as? String
                objGetDiseaseReminder.disease_schedule = aDictDiseaseInfo["disease_schedule"] as? String
                objGetDiseaseReminder.disease_isbyuser = aDictDiseaseInfo["disease_schedule"] as? Int
                
                objGetDiseaseReminder.time2 = ""
                objGetDiseaseReminder.time3 = ""
                
                objGetDiseaseReminder.reminderID = aDictDiseaseInfo["reminder_id"] as? Int
                objGetDiseaseReminder.type = aDictDiseaseInfo["type"] as? Int
                objGetDiseaseReminder.typeID = aDictDiseaseInfo["type_id"] as? Int
                objGetDiseaseReminder.reminderTxt = aDictDiseaseInfo["reminder_txt"] as? String
                objGetDiseaseReminder.reminderTime = aDictDiseaseInfo["reminder_time"] as? String
                objGetDiseaseReminder.reminderFrequency = aDictDiseaseInfo["reminder_frequency"] as? String
                objGetDiseaseReminder.reminderWithNotification = aDictDiseaseInfo["reminder_with_notification"] as? Int
                objGetDiseaseReminder.reminderDate = aDictDiseaseInfo["reminder_date"] as? String
                objGetDiseaseReminder.reminderEndDate = aDictDiseaseInfo["reminder_end_date"] as? String
                objGetDiseaseReminder.reminderWeaklyDay = aDictDiseaseInfo["reminder_weakly_day"] as? String
                objGetDiseaseReminder.reminderMonthlyDay = aDictDiseaseInfo["reminder_monthly_day"] as? String
                
                self.mutArrDiseaseReminderList.append(objGetDiseaseReminder)
            }
        }
        return self.mutArrDiseaseReminderList

    }
    
    
    func updateSettingReminderTime(reminderTm: String, type: Int, typeID: Int, reminderID: Int) {
        
    var query = "UPDATE reminder SET reminder_time='\(reminderTm)' WHERE type_id='\(typeID)' AND type='\(type)' AND reminder_id='\(reminderID)'"
        
        print(query)
        
        Database().update(query: query, success: {
            // Success
            
        }) { 
            // Failure
            
        }
        
    }
    
}


