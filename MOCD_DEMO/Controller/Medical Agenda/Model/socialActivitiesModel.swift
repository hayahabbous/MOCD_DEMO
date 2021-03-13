//
//  Social_Activities_Model.swift
//  SwiftDatabase
//
//  Created by indianic on 31/12/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit


class getSocialReminder: NSObject {
    var identifier : Int!
    var title : String!
    var comment : String!
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


class socialActivitiesModel: NSObject {

    var identifier : Int!
    var title : String!
    var comment : String!
    var date : String!
    
    
}

class socialActivity: NSObject {
    
    var mutArrSocialList = [getSocialReminder]()

    
    func GetAllSocialList(complition: (([getSocialReminder])-> Void)) {
        
        
        let aStrGetAllQuery = "SELECT * FROM social_activities INNER JOIN reminder ON social_activities.social_activities_id=reminder.type_id AND reminder.type='5'"
        //        select * from reminder where type = 2 AND reminder_date >= '01/01/2017' AND reminder_end_date <= '31/01/2017'
        //        let aStrGetAllQuery = "select * from reminder where type = 2 AND reminder_date >= '01/01/2017' AND reminder_end_date <= '31/01/2017'"
        
        
        let aMutArrSocialList : [[String : AnyObject]] = Database().selectAllfromTable(query: aStrGetAllQuery) { (status) in
        }
        
        if self.mutArrSocialList.count > 0 {
            self.mutArrSocialList.removeAll()
        }
        
        if aMutArrSocialList.count > 0 {
            
            for aDictAppointmentInfo in aMutArrSocialList {
                
                let objGetSocialReminder = getSocialReminder()
                objGetSocialReminder.identifier = aDictAppointmentInfo["social_activities_id"] as? Int
                objGetSocialReminder.title = aDictAppointmentInfo["social_activities_title"] as? String
                objGetSocialReminder.date = aDictAppointmentInfo["social_activities_date"] as? String
                objGetSocialReminder.comment = aDictAppointmentInfo["social_activities_comment"] as? String
                
                objGetSocialReminder.reminderID = aDictAppointmentInfo["reminder_id"] as? Int
                objGetSocialReminder.type = aDictAppointmentInfo["type"] as? Int
                objGetSocialReminder.typeID = aDictAppointmentInfo["type_id"] as? Int
                objGetSocialReminder.reminderTxt = aDictAppointmentInfo["reminder_txt"] as? String
                objGetSocialReminder.reminderTime = aDictAppointmentInfo["reminder_time"] as? String
                objGetSocialReminder.reminderFrequency = aDictAppointmentInfo["reminder_frequency"] as? String
                objGetSocialReminder.reminderWithNotification = aDictAppointmentInfo["reminder_with_notification"] as? Int
                objGetSocialReminder.reminderDate = aDictAppointmentInfo["reminder_date"] as? String
                objGetSocialReminder.reminderEndDate = aDictAppointmentInfo["reminder_end_date"] as? String
                objGetSocialReminder.reminderWeaklyDay = aDictAppointmentInfo["reminder_weakly_day"] as? String
                objGetSocialReminder.reminderMonthlyDay = aDictAppointmentInfo["reminder_monthly_day"] as? String
                
                self.mutArrSocialList.append(objGetSocialReminder)
            }
            

        }
        complition(self.mutArrSocialList)

    }

    
    
    
    func insertINTOSocialActivity(object: socialActivitiesModel, aObjReminder: ReminderModel, isInsert: Bool
        , completion:((Bool)-> Void)) {
        
        
        if !isInsert {
            
        // Insert
            
        let insert = "INSERT INTO social_activities (social_activities_title, social_activities_comment, social_activities_date) VALUES ('\(object.title!)','\(object.comment!)', '\(object.date!)')"
        
        Database.sharedInstance.insert(query: insert, success: {
            
            // Success.
            // Get count from appointsocial_activitiesment table
            Database.sharedInstance.getRecordCount(query: "select MAX(social_activities_id) from social_activities", success: { (count: Int) in
                print(count)
                
                let aResult = ReminderModel().insertInReminder(aObjReminder: aObjReminder, count: count)
                
                if aResult {
                    completion(true)
                }else{
                    completion(false)
                }
            }, failure: {
                // failure.
                completion(false)
            })
            
            
        }, failure: {
            // failure.
            completion(false)
        })
        
        }else{
            // Update
            
            updateInSocialActity(object: object, aObjReminder: aObjReminder, completion: { (success: Bool) in
                completion(success)
            })
        }
    }
    

    func updateInSocialActity(object: socialActivitiesModel, aObjReminder: ReminderModel, completion:((Bool)-> Void)) {
    
        let update = "UPDATE social_activities SET social_activities_title='\(object.title!)', social_activities_comment='\(object.comment!)', social_activities_date='\(object.date!)' WHERE social_activities_id='\(object.identifier!)'"
        
        print(update)
        
        Database.sharedInstance.update(query: update, success: {
            
            // Success.
            let aResult = ReminderModel().updateInReminder(aObjReminder: aObjReminder, typeid: object.identifier!)
            
            if aResult {
                completion(true)
            }else{
                completion(false)
            }
            
        }, failure: {
            // failure.
            completion(false)
        })

        
        
        
    }
    
    
    func deleteSocialActivity(deleteID: Int, complition: ((Bool)  -> Void)) {
        
        let sqlDeleteSocialActivity =  "DELETE FROM social_activities WHERE social_activities_id='\(deleteID)'"
        let sqlDeleteReminder =  "DELETE FROM reminder WHERE type_id='\(deleteID)' AND type='5'"
        
        Database().delete(query: sqlDeleteSocialActivity, success: { (success: Bool) in
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



