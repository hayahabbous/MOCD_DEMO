//
//  ReminderModel.swift
//  SmartTejoori
//
//  Created by indianic on 05/01/17.
//  Copyright © 2017 demo. All rights reserved.
//

import UIKit

class ReminderModelT: NSObject {
    
    var identifier : Int!
    var reminderType : String!
    var reminderNote : String!
    var reminderTime : String!
    var reminderWithNotification : Int!
    var reminderDate : String!
    var reminderEndDate : String!
    var reminderWeaklyDay : String!
    var reminderMonthlyDay : String!
    var reminderMoneyGoalAmount: String!
    var reminderMoneyGoalTitle: String!
    
    var aQueryExcutionStatus : Bool!
    var mutArrReminderList = [ReminderModelT]()
    
    func GetAllReminderList() -> [ReminderModelT] {
        
        let aStrGetAllQuery = String(format: "select * from reminder ORDER BY reminder_id DESC")
        
        let mutArrReminderList : [[String : AnyObject]] = DatabaseEdkhar().selectAllfromTable(query: aStrGetAllQuery) { (status) in
        }
        
        if self.mutArrReminderList.count > 0 {
            self.mutArrReminderList.removeAll()
        }
        
        if mutArrReminderList.count > 0 {
            
            for aDictReminderInfo in mutArrReminderList {
                
                let objReminderModel = ReminderModelT()
                
                objReminderModel.identifier = NSInteger((aDictReminderInfo["reminder_id"] as! String))
                objReminderModel.reminderType = aDictReminderInfo["reminder_type"] as? String
                objReminderModel.reminderNote = aDictReminderInfo["reminder_note"] as? String
                objReminderModel.reminderTime = aDictReminderInfo["reminder_time"] as? String
                objReminderModel.reminderWithNotification = NSInteger((aDictReminderInfo["reminder_with_notification"] as! String))
                objReminderModel.reminderDate = aDictReminderInfo["reminder_date"] as? String
                objReminderModel.reminderEndDate = aDictReminderInfo["reminder_end_date"] as? String
                objReminderModel.reminderWeaklyDay = aDictReminderInfo["reminder_weakly_day"] as? String
                objReminderModel.reminderMonthlyDay = aDictReminderInfo["reminder_monthly_day"] as? String
                objReminderModel.reminderMoneyGoalAmount = aDictReminderInfo["reminder_money_goal_amount"] as? String
                objReminderModel.reminderMoneyGoalTitle = aDictReminderInfo["reminder_money_goal_title"] as? String
                
                self.mutArrReminderList.append(objReminderModel)
            }
        }
        return self.mutArrReminderList
    }
    
    func InsertReminderInfo(objReminderModel : ReminderModelT) -> Bool {
        
        let insertSQL = "INSERT INTO reminder (reminder_type,reminder_note,reminder_time,reminder_with_notification,reminder_date,reminder_end_date,reminder_weakly_day,reminder_monthly_day, reminder_money_goal_amount, reminder_money_goal_title) VALUES ('\(objReminderModel.reminderType!)', '\(objReminderModel.reminderNote!)','\(objReminderModel.reminderTime!)','\(objReminderModel.reminderWithNotification!)','\(objReminderModel.reminderDate!)','\(objReminderModel.reminderEndDate!)','\(objReminderModel.reminderWeaklyDay!)','\(objReminderModel.reminderMonthlyDay!)','\(objReminderModel.reminderMoneyGoalAmount!)','\(objReminderModel.reminderMoneyGoalTitle!)')"
        
        DatabaseEdkhar.sharedInstance.insert(query: insertSQL, success: {
            // Success.
            aQueryExcutionStatus = true
        }, failure: {
            // failure.
            aQueryExcutionStatus = false
        })
        
        return aQueryExcutionStatus
    }
    
    func UpdateReminderInfo(objReminderModel : ReminderModelT) -> Bool {
        
        let UpdateSQL = "Update reminder Set reminder_type = '\(objReminderModel.reminderType!)', reminder_note = '\(objReminderModel.reminderNote!)', reminder_time = '\(objReminderModel.reminderTime!)', reminder_with_notification = '\(objReminderModel.reminderWithNotification!)', reminder_date = '\(objReminderModel.reminderDate!)', reminder_end_date = '\(objReminderModel.reminderEndDate!)', reminder_weakly_day = '\(objReminderModel.reminderWeaklyDay!)', reminder_monthly_day = '\(objReminderModel.reminderMonthlyDay!)', reminder_money_goal_amount = '\(objReminderModel.reminderMoneyGoalAmount!)', reminder_money_goal_title = '\(objReminderModel.reminderMoneyGoalTitle!)' where reminder_id = '\(objReminderModel.identifier!)'"
        
        DatabaseEdkhar.sharedInstance.update(query: UpdateSQL, success: {
            // Success.
            aQueryExcutionStatus = true
        }, failure: {
            // failure.
            aQueryExcutionStatus = false
        })
        
        return aQueryExcutionStatus
    }
    
    func DeleteReminderInfo(objReminderModel : ReminderModelT) -> Bool {
        
        let DeleteSQL = String.init(format: "delete FROM reminder where reminder_id = %d", objReminderModel.identifier)
        
        DatabaseEdkhar.sharedInstance.delete(query: DeleteSQL, success: { (status) in
            // Success.
            aQueryExcutionStatus = true
        }) { (status) in
            aQueryExcutionStatus = false
        }
        return aQueryExcutionStatus
    }
    
    func getReminderId(objReminderModel : ReminderModelT) -> Int{
        var reminderId: Int = 0
        let aStrGetQuery = "select * from reminder where reminder_type = '\(objReminderModel.reminderType!)' AND reminder_note = '\(objReminderModel.reminderNote!)' AND reminder_time = '\(objReminderModel.reminderTime!)' AND reminder_with_notification = '\(objReminderModel.reminderWithNotification!)' AND reminder_date = '\(objReminderModel.reminderDate!)' AND  reminder_end_date = '\(objReminderModel.reminderEndDate!)' AND reminder_weakly_day = '\(objReminderModel.reminderWeaklyDay!)' AND reminder_monthly_day = '\(objReminderModel.reminderMonthlyDay!)' AND reminder_money_goal_amount = '\(objReminderModel.reminderMoneyGoalAmount!)' AND reminder_money_goal_title = '\(objReminderModel.reminderMoneyGoalTitle!)'"
        
        let aMutArrReminderlist : [[String : AnyObject]] = DatabaseEdkhar().selectAllfromTable(query: aStrGetQuery) { (status) in
        }
        
        if aMutArrReminderlist.count > 0 {
            reminderId = Int((aMutArrReminderlist[0]["reminder_id"] as? String)!)!
        }
        return reminderId
    }
}
