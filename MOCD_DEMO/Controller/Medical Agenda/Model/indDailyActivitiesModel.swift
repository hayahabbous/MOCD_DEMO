//
//  Ind_Daily_Activities_Model.swift
//  SwiftDatabase
//
//  Created by indianic on 31/12/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit



class indDailyReminderModel
{
    var identifier : Int!
    var title : String!
    var date : String!
    
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
    
    
}

class indDailyActivitiesModel: NSObject {

    var identifier : Int!
    var title : String!
    var date : String!
    
    
    var mutArrIndependentList = [indDailyReminderModel]()
    
    func getAllIndependentList(complition: (([indDailyReminderModel])-> Void))  {
        
        let aStrGetAllQuery = "SELECT * FROM ind_activities INNER JOIN reminder ON ind_activities.ind_activity_id=reminder.type_id AND reminder.type='2'"
        
        let aMutArrIndependentlist : [[String : AnyObject]] = Database().selectAllfromTable(query: aStrGetAllQuery) { (status) in
        }
        
        if self.mutArrIndependentList.count > 0 {
            self.mutArrIndependentList.removeAll()
        }
        
        if aMutArrIndependentlist.count > 0 {
            
            for aDictIndependentInfo in aMutArrIndependentlist {
                
                let objGetIndependentReminder = indDailyReminderModel()
                objGetIndependentReminder.identifier = aDictIndependentInfo["ind_activity_id"] as? Int
                objGetIndependentReminder.title = aDictIndependentInfo["ind_activity_title"] as? String
                objGetIndependentReminder.date = aDictIndependentInfo["ind_activity_date"] as? String
                
                objGetIndependentReminder.reminderID = aDictIndependentInfo["reminder_id"] as? Int
                objGetIndependentReminder.type = aDictIndependentInfo["type"] as? Int
                objGetIndependentReminder.typeID = aDictIndependentInfo["type_id"] as? Int
                objGetIndependentReminder.reminderTxt = aDictIndependentInfo["reminder_txt"] as? String
                objGetIndependentReminder.reminderTime = aDictIndependentInfo["reminder_time"] as? String
                objGetIndependentReminder.reminderFrequency = aDictIndependentInfo["reminder_frequency"] as? String
                objGetIndependentReminder.reminderWithNotification = aDictIndependentInfo["reminder_with_notification"] as? Int
                objGetIndependentReminder.reminderDate = aDictIndependentInfo["reminder_date"] as? String
                objGetIndependentReminder.reminderEndDate = aDictIndependentInfo["reminder_end_date"] as? String
                objGetIndependentReminder.reminderWeaklyDay = aDictIndependentInfo["reminder_weakly_day"] as? String
                objGetIndependentReminder.reminderMonthlyDay = aDictIndependentInfo["reminder_monthly_day"] as? String
                
                self.mutArrIndependentList.append(objGetIndependentReminder)
            }
        }
        
        complition(self.mutArrIndependentList)
        
    }
    

    func insertIndependent(objIndDailyActivitiesModel: indDailyActivitiesModel, aObjReminder: ReminderModel, flageUpdate: Bool, complition: ((_ success: Bool)  -> Void)){
        
        if flageUpdate {
            // Update
            
            let updateSQL = "UPDATE ind_activities SET ind_activity_title='\(objIndDailyActivitiesModel.title!)', ind_activity_date='\(objIndDailyActivitiesModel.date!)' WHERE ind_activity_id=\(objIndDailyActivitiesModel.identifier!)"
            
            print(updateSQL)
            
            Database.sharedInstance.update(query: updateSQL, success: {
                
                // Success.
                let aResult = ReminderModel().updateInReminder(aObjReminder: aObjReminder, typeid: objIndDailyActivitiesModel.identifier!)
                
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
            let insertSQL = "INSERT INTO ind_activities (ind_activity_title, ind_activity_date) VALUES ('\(objIndDailyActivitiesModel.title!)', '\(objIndDailyActivitiesModel.date!)')"
            
            print(insertSQL)
            
            Database.sharedInstance.insert(query: insertSQL, success: {
                
                // Success.
                // Get count from appointment table
                Database.sharedInstance.getRecordCount(query: "select MAX(ind_activity_id) from ind_activities", success: { (count: Int) in
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
                
                
            }, failure: {
                // failure.
                complition(false)
            })
            
            
        }
    }
    
    
    
    func deleteIndpendent(deleteID: Int, complition: ((Bool)  -> Void)) {
        
        let sqlDeleteAppointment =  "DELETE FROM ind_activities WHERE ind_activity_id='\(deleteID)'"
        let sqlDeleteReminder =  "DELETE FROM reminder WHERE type_id='\(deleteID)' AND type='2'"
        
        Database().delete(query: sqlDeleteAppointment, success: { (success: Bool) in
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

    
    
    
}
