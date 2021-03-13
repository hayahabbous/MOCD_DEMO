//
//  MedicinePlan_Model.swift
//  SwiftDatabase
//
//  Created by indianic on 31/12/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit

class medicinePlanReminderModel: NSObject {
    
    var identifier : Int!
    var identifier2 : Int!
    var identifier3 : Int!
    var identifier4 : Int!
    var identifier5 : Int!
    var identifier6 : Int!
    
    var name : String!
    var dose : String!
    var time : String!
    var dailyFrequency: Int!
    
    
    var reminderID : Int!
    var type : Int!
    var typeID : Int!
    var reminderTxt : String!
    var reminderTime : String!
    var reminderFrequency : String?
    var reminderDayFrequency : String?
    var reminderWithNotification : Int!
    var reminderDate : String!
    var reminderEndDate : String!
    var reminderWeaklyDay : String!
    var reminderMonthlyDay : String!
    
    var time2: String?
    var time3: String?
    var time4: String?
    var time5: String?
    var time6: String?
}



class medicinePlan: NSObject {
    
    
    var identifier : Int!
    var name : String!
    var dose : String!
    var time : String!
    var dailyFrequency: Int!
    
    var mutArrMedicineList = [medicinePlanReminderModel]()
    var mutArrOnlyMedicineList = [medicinePlan]()
    
    func getAllMedicinPlanList() -> [medicinePlanReminderModel] {
        
        let aStrGetAllQuery = "SELECT * FROM medicine_plans INNER JOIN reminder ON medicine_plans.medicine_plan_id=reminder.type_id AND reminder.type='3' ORDER BY medicine_plans.medicine_plan_id ASC"

        let aMutArrmedicineList : [[String : AnyObject]] = Database().selectAllfromTable(query: aStrGetAllQuery) { (status) in
        }
        
        if self.mutArrMedicineList.count > 0 {
            self.mutArrMedicineList.removeAll()
        }
        
        if aMutArrmedicineList.count > 0 {
            
            for aDictMedicineInfo in aMutArrmedicineList {
                
                let objGetPlan = medicinePlanReminderModel()
                objGetPlan.identifier = aDictMedicineInfo["medicine_plan_id"] as? Int
                objGetPlan.name = aDictMedicineInfo["medicine_plan_name"] as? String
                objGetPlan.dose = aDictMedicineInfo["medicine_plan_dose"] as? String
                objGetPlan.time = aDictMedicineInfo["medicine_plan_time"] as? String
                objGetPlan.dailyFrequency = aDictMedicineInfo["medicine_plan_daily_frequency"] as? Int
                objGetPlan.time2 = ""
                objGetPlan.time3 = ""
                
                objGetPlan.reminderID = aDictMedicineInfo["reminder_id"] as? Int
                objGetPlan.type = aDictMedicineInfo["type"] as? Int
                objGetPlan.typeID = aDictMedicineInfo["type_id"] as? Int
                objGetPlan.reminderTxt = aDictMedicineInfo["reminder_txt"] as? String
                objGetPlan.reminderTime = aDictMedicineInfo["reminder_time"] as? String
                objGetPlan.reminderFrequency = aDictMedicineInfo["reminder_frequency"] as? String
                objGetPlan.reminderWithNotification = aDictMedicineInfo["reminder_with_notification"] as? Int
                objGetPlan.reminderDate = aDictMedicineInfo["reminder_date"] as? String
                objGetPlan.reminderEndDate = aDictMedicineInfo["reminder_end_date"] as? String
                objGetPlan.reminderWeaklyDay = aDictMedicineInfo["reminder_weakly_day"] as? String
                objGetPlan.reminderMonthlyDay = aDictMedicineInfo["reminder_monthly_day"] as? String
                
                self.mutArrMedicineList.append(objGetPlan)
            }
        }
        return self.mutArrMedicineList
        
    }

    

    
    func getOnlyMedicineList(complition: (([medicinePlan])-> Void)) {
        
        let aStrGetAllQuery = "SELECT * FROM medicine_plans"
        
        let aMutArrmedicineList : [[String : AnyObject]] = Database().selectAllfromTable(query: aStrGetAllQuery) { (status) in
        }
        
        if self.mutArrOnlyMedicineList.count > 0 {
            self.mutArrOnlyMedicineList.removeAll()
        }
        
        if aMutArrmedicineList.count > 0 {
            
            for aDictMedicineInfo in aMutArrmedicineList {
                
                let objGetPlan = medicinePlan()
                objGetPlan.identifier = aDictMedicineInfo["medicine_plan_id"] as? Int
                objGetPlan.name = aDictMedicineInfo["medicine_plan_name"] as? String
                objGetPlan.dose = aDictMedicineInfo["medicine_plan_dose"] as? String
                objGetPlan.time = aDictMedicineInfo["medicine_plan_time"] as? String
                objGetPlan.dailyFrequency = aDictMedicineInfo["medicine_plan_daily_frequency"] as? Int
                
                self.mutArrOnlyMedicineList.append(objGetPlan)
            }
        }
        complition(self.mutArrOnlyMedicineList)
        
    }
    
    
    
    
    func getAllMedicinPlanListByDate(_ fromDate : String , toDate: String, complition: (([medicinePlanReminderModel])-> Void)) {
        
        
        let aStrGetAllQuery = String(format: "SELECT * FROM medicine_plans INNER JOIN reminder ON medicine_plans.medicine_plan_id=reminder.type_id AND reminder.type='3' AND (reminder.reminder_date  BETWEEN \"%@\" AND \"%@\")","\(fromDate)","\(toDate) ORDER BY medicine_plans.medicine_plan_id ASC")
        
        print(aStrGetAllQuery)
        
        let aMutArrmedicineList : [[String : AnyObject]] = Database().selectAllfromTable(query: aStrGetAllQuery) { (status) in
        }
        
        if self.mutArrMedicineList.count > 0 {
            self.mutArrMedicineList.removeAll()
        }
        
        if aMutArrmedicineList.count > 0 {
            
            for aDictMedicineInfo in aMutArrmedicineList {
                
                let objGetPlan = medicinePlanReminderModel()
                objGetPlan.identifier = aDictMedicineInfo["medicine_plan_id"] as? Int
                objGetPlan.name = aDictMedicineInfo["medicine_plan_name"] as? String
                objGetPlan.dose = aDictMedicineInfo["medicine_plan_dose"] as? String
                objGetPlan.time = aDictMedicineInfo["medicine_plan_time"] as? String
                objGetPlan.dailyFrequency = aDictMedicineInfo["medicine_plan_daily_frequency"] as? Int
                objGetPlan.time2 = ""
                objGetPlan.time3 = ""
                
                objGetPlan.reminderID = aDictMedicineInfo["reminder_id"] as? Int
                objGetPlan.type = aDictMedicineInfo["type"] as? Int
                objGetPlan.typeID = aDictMedicineInfo["type_id"] as? Int
                objGetPlan.reminderTxt = aDictMedicineInfo["reminder_txt"] as? String
                objGetPlan.reminderTime = aDictMedicineInfo["reminder_time"] as? String
                objGetPlan.reminderFrequency = aDictMedicineInfo["reminder_frequency"] as? String
                objGetPlan.reminderWithNotification = aDictMedicineInfo["reminder_with_notification"] as? Int
                objGetPlan.reminderDate = aDictMedicineInfo["reminder_date"] as? String
                objGetPlan.reminderEndDate = aDictMedicineInfo["reminder_end_date"] as? String
                objGetPlan.reminderWeaklyDay = aDictMedicineInfo["reminder_weakly_day"] as? String
                objGetPlan.reminderMonthlyDay = aDictMedicineInfo["reminder_monthly_day"] as? String
                
                self.mutArrMedicineList.append(objGetPlan)
            }
        }
        complition(self.mutArrMedicineList)
        
    }

    
    func insertMedicine(objMedicine: medicinePlan, aObjReminder: ReminderModel, flageUpdate: Bool, complition: ((_ success: Bool)  -> Void)){
        
        if flageUpdate {
            // Update
            
            let updateSQLUpdate = "UPDATE medicine_plans SET medicine_plan_name='\(objMedicine.name!)', medicine_plan_dose='\(objMedicine.dose!)', medicine_plan_time='\(objMedicine.time!)', medicine_plan_daily_frequency='\(objMedicine.dailyFrequency!)' WHERE medicine_plan_id='\(objMedicine.identifier!)'"
            
            print(updateSQLUpdate)
            
            Database.sharedInstance.update(query: updateSQLUpdate, success: {
                
                // Success.
                let aResult = ReminderModel().updateInReminder(aObjReminder: aObjReminder, typeid: objMedicine.identifier!)
                
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
            let insertSQLMedicine = "INSERT INTO medicine_plans (medicine_plan_name, medicine_plan_dose, medicine_plan_time, medicine_plan_daily_frequency) VALUES ('\(objMedicine.name!)', '\(objMedicine.dose!)','\(objMedicine.time!)', '\(objMedicine.dailyFrequency!)')"
            
            print(insertSQLMedicine)
            
        
            Database.sharedInstance.insert(query: insertSQLMedicine, success: {
                complition(true)

            
            }, failure: {
                // failure.
                complition(false)
            })
        }
    }
    
    
    
    func inertIntoReminder(objMedicine: medicinePlan, aObjReminder: ReminderModel, flageUpdate: Bool, complition: ((_ success: Bool)  -> Void)){
       
            
            // Success.
            // Get count from appointment table
            Database.sharedInstance.getRecordCount(query: "select MAX(medicine_plan_id) from medicine_plans", success: { (count: Int) in
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
        
        //Database.sharedInstance.getRecordCount(query: "select MAX(medicine_plan_id) from medicine_plans", success: { (count: Int) in
        
        // Get count
        Database.sharedInstance.getRecordCount(query: "select MAX(reminder_id) from reminder", success: { (count: Int) in
           
            print(count)
          
            complitionCount("\(count)")
        }, failure: {
            // failure.
        })
    }
    
    func deleteMedicine(deleteID: Int, complition: ((Bool)  -> Void)) {
        //let sqlDeleteAppointment =  "DELETE FROM medicine_plans WHERE medicine_plan_id='\(deleteID)' AND type='3'"
        let sqlDeleteAppointment =  "DELETE FROM medicine_plans WHERE medicine_plan_id='\(deleteID)'"
        
        Database().delete(query: sqlDeleteAppointment, success: { (success: Bool) in
            // Delete from Appointment table
            
            complition(true)
        }) { (failure: Bool) in
            complition(false)
        }
    }
    
    
    func deleteMedicineReminder(deleteID: Int, complition: ((Bool)  -> Void)) {
        
        let sqlDeleteReminder =  "DELETE FROM reminder WHERE type_id='\(deleteID)' AND type='3'"
        
            Database().delete(query: sqlDeleteReminder, success: { (success: Bool) in
                // Delete from reminder table
                
                complition(true)
            }) { (failure: Bool) in
                complition(false)
            }
          
    }
}
    



