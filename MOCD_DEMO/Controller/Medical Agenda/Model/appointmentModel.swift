//
//  AppointmentModel.swift
//  SwiftDatabase
//
//  Created by indianic on 31/12/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit


class getAppointmentReminder: NSObject {
    var identifier : Int!
    var title : String!
    var date : String!
    var doctorName : String!
    var clinicName : String!
    var note : String!

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


class appointmentModel: NSObject {

    var identifier : Int!
    var title : String!
    var date : String!
    var doctorName : String!
    var clinicName : String!
    var note : String!

    
    var aQueryExcutionStatus : Bool!
    var mutArrAppointmentList = [getAppointmentReminder]()
    
    func GetAllAppointmentList() -> [getAppointmentReminder] {
        

        let aStrGetAllQuery = "SELECT * FROM appointments INNER JOIN reminder ON appointments.appointment_id=reminder.type_id AND reminder.type='4' order by  appointments.appointment_id"
        //        select * from reminder where type = 2 AND reminder_date >= '01/01/2017' AND reminder_end_date <= '31/01/2017'
//        let aStrGetAllQuery = "select * from reminder where type = 2 AND reminder_date >= '01/01/2017' AND reminder_end_date <= '31/01/2017'"

        
        let aMutArrAppointmentlist : [[String : AnyObject]] = Database().selectAllfromTable(query: aStrGetAllQuery) { (status) in
        }
        
        if self.mutArrAppointmentList.count > 0 {
            self.mutArrAppointmentList.removeAll()
        }
        
        if aMutArrAppointmentlist.count > 0 {
            
            for aDictAppointmentInfo in aMutArrAppointmentlist {
                
                let objGetAppointmentReminder = getAppointmentReminder()
                objGetAppointmentReminder.identifier = aDictAppointmentInfo["appointment_id"] as? Int
                objGetAppointmentReminder.title = aDictAppointmentInfo["appointment_title"] as? String
                objGetAppointmentReminder.date = aDictAppointmentInfo["appointment_date"] as? String
                objGetAppointmentReminder.doctorName = aDictAppointmentInfo["appointment_doctor_name"] as? String
                objGetAppointmentReminder.clinicName = aDictAppointmentInfo["appointment_clinic_name"] as? String
                objGetAppointmentReminder.note = aDictAppointmentInfo["appointment_note"] as? String

                objGetAppointmentReminder.reminderID = aDictAppointmentInfo["reminder_id"] as? Int
                objGetAppointmentReminder.type = aDictAppointmentInfo["type"] as? Int
                objGetAppointmentReminder.typeID = aDictAppointmentInfo["type_id"] as? Int
                objGetAppointmentReminder.reminderTxt = aDictAppointmentInfo["reminder_txt"] as? String
                objGetAppointmentReminder.reminderTime = aDictAppointmentInfo["reminder_time"] as? String
                objGetAppointmentReminder.reminderFrequency = aDictAppointmentInfo["reminder_frequency"] as? String
                objGetAppointmentReminder.reminderWithNotification = aDictAppointmentInfo["reminder_with_notification"] as? Int
                objGetAppointmentReminder.reminderDate = aDictAppointmentInfo["reminder_date"] as? String
                objGetAppointmentReminder.reminderEndDate = aDictAppointmentInfo["reminder_end_date"] as? String
                objGetAppointmentReminder.reminderWeaklyDay = aDictAppointmentInfo["reminder_weakly_day"] as? String
                objGetAppointmentReminder.reminderMonthlyDay = aDictAppointmentInfo["reminder_monthly_day"] as? String
                
                self.mutArrAppointmentList.append(objGetAppointmentReminder)
            }
        }
        return self.mutArrAppointmentList
    }

    
    func insertAppointment(objAppointment: appointmentModel, aObjReminder: ReminderModel, flageUpdate: Bool, complition: ((_ success: Bool)  -> Void)){
        
        if flageUpdate {
            // Update
            
            let updateSQLInappointMent = "UPDATE appointments SET appointment_title='\(objAppointment.title!)', appointment_date='\(objAppointment.date!)', appointment_doctor_name='\(objAppointment.doctorName!)', appointment_clinic_name='\(objAppointment.clinicName!)', appointment_note='\(objAppointment.note!)' WHERE appointment_id='\(objAppointment.identifier!)'"
            
            print(updateSQLInappointMent)
            
            Database.sharedInstance.update(query: updateSQLInappointMent, success: {
                
                // Success.
                let aResult = ReminderModel().updateInReminder(aObjReminder: aObjReminder, typeid: objAppointment.identifier!)
                
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
        let insertSQLInappointMent = "INSERT INTO appointments (appointment_title, appointment_date, appointment_doctor_name, appointment_clinic_name, appointment_note) VALUES ('\(objAppointment.title!)', '\(objAppointment.date!)','\(objAppointment.doctorName!)', '\(objAppointment.clinicName!)', '\(objAppointment.note!)')"
        
        print(insertSQLInappointMent)
        
        Database.sharedInstance.insert(query: insertSQLInappointMent, success: {
            
            // Success.
            aQueryExcutionStatus = true
            // Get count from appointment table
            Database.sharedInstance.getRecordCount(query: "select MAX(appointment_id) from appointments", success: { (count: Int) in
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

    
    func getMaxCount(complitionCount: ((String)-> Void)) {
        // Get count from appointment table
//        "select MAX(appointment_id) from appointments"
        Database.sharedInstance.getRecordCount(query: "select MAX(reminder_id) from reminder", success: { (count: Int) in
            print(count)
            complitionCount("\(count)")
        }, failure: {
            // failure.
        })
    }
    
    func deleteAppointment(deleteID: Int, complition: ((Bool)  -> Void)) {
        
        let sqlDeleteAppointment =  "DELETE FROM appointments WHERE appointment_id='\(deleteID)'"
        let sqlDeleteReminder =  "DELETE FROM reminder WHERE type_id='\(deleteID)' AND type='4'"
        
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

