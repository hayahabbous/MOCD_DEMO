//
//  UserActivityModel.swift
//  SmartAgenda
//
//  Created by indianic on 02/02/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit


class UserReminder: NSObject {
    
    var type : Int?
    var typeID : Int?
    var reminderTxt : String?
    var reminderTime: String?
    
    var user_activity_id = Int()
    var reminder_id = Int()
    var user_activity_time = String()
    var user_activity_date = String()
    var user_activity_value = String()
    var user_activity_value_bool = Int()
    
    
}
class UserActivityModel: NSObject {

    
    var user_activity_id = Int()
    var reminder_id = Int()
    var type = Int()
    var type_id = Int()
    var user_activity_time = String()
    var user_activity_date = String()
    var user_activity_value = String()
    var user_activity_value_bool = Int()

    var mutArrUser = [UserActivityModel]()
    func insertIntoUserActivity(obj: UserReminder, objUserActy: UserActivityModel, complition: ((Bool))-> Void) {
    
        let insertQuery = "INSERT INTO user_activity (reminder_id, type, type_id, user_activity_time, user_activity_date, user_activity_value, user_activity_value_bool) VALUES ('\(obj.reminder_id)', '\(obj.type!)', '\(obj.typeID!)', '\(objUserActy.user_activity_time)', '\(objUserActy.user_activity_date)', '', '\(objUserActy.user_activity_value_bool)')"
        print(insertQuery)
        
        Database().insert(query: insertQuery, success: {
            complition(true)
        }) {
            complition(false)
        }
    }

    func deletFromUserActivity(obj: UserReminder, objUserActy: UserActivityModel,  complition: ((Bool))-> Void) {
    
            let deleteQuery = "DELETE FROM user_activity WHERE reminder_id='\(obj.reminder_id)' and type='\(obj.type!)' and type_id='\(obj.typeID!)' and user_activity_date='\(objUserActy.user_activity_date)'"
            print(deleteQuery)

        Database().delete(query: deleteQuery, success: { (result: Bool) in
            complition(true)
        }) { (result: Bool) in
            complition(false)
        }
            
    }
    
    func selectFromUserActivity(todate:String) -> [UserActivityModel] {
        
        let selectQuery = "SELECT * FROM user_activity WHERE user_activity_date == '\(todate)'"
        print(selectQuery)
        var arrMutResult = [UserActivityModel]()
        
      
       let arrMutResultTemp: [[String : AnyObject]] = Database().selectAllfromTable(query: selectQuery) { (status) in
      
        }
        
        if arrMutResult.count > 0 {
            arrMutResult.removeAll()
        }
        
        for obj in arrMutResultTemp {
            
            let objUserActy = UserActivityModel()
            
            objUserActy.user_activity_id = (obj["user_activity_id"] as? Int)!
            objUserActy.reminder_id = (obj["reminder_id"] as? Int)!
            objUserActy.type = (obj["type"] as? Int)!
            objUserActy.type_id = (obj["type_id"] as? Int)!
            objUserActy.user_activity_time = (obj["user_activity_time"] as? String)!
            objUserActy.user_activity_date = (obj["user_activity_date"] as? String)!
            objUserActy.user_activity_value = (obj["user_activity_value"] as? String)!
            objUserActy.user_activity_value_bool = (obj["user_activity_value_bool"] as? Int)!

            arrMutResult.append(objUserActy)
            
        }
        
        return arrMutResult
    }
    
    
    func deleteActivity(type: Int, typeid: Int, userActivityDate: String, reminderID: Int , complition:((Bool)  -> Void)) {

//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        
//        let strDate = dateFormatter.string(from: Date())
        
        let sqlDelete =  "DELETE FROM user_activity WHERE type = '\(type)' AND type_id = '\(typeid)' AND reminder_id = '\(reminderID)'"
        
        print("sqlDelete = \(sqlDelete)")
        
        Database().delete(query: sqlDelete, success: { (success: Bool) in
            complition(true)

        }) { (failure: Bool) in
            complition(false)
        }
    }
    
    func getUserActivityForReport(_ fromDate : String , toDate: String, reimderID: String, complition: (([UserActivityModel])-> Void)) {
        
        //select * from user_activity where reminder_id = 1 and user_activity_date BETWEEN "2017-02-16" AND "2017-03-16"
//        let strQuery = "select * from user_activity where reminder_id = 1 and user_activity_date BETWEEN '\(fromDate)' AND '\(toDate)'"
        let strQuery = "select * from user_activity where reminder_id = '\(reimderID)' and user_activity_date BETWEEN '\(fromDate)' AND '\(toDate)'"
        print(strQuery)
        
        let mutArrUserActivity = Database().selectAllfromTable(query: strQuery) { (result: String) in
            
        }
        
        if self.mutArrUser.count > 0{
            self.mutArrUser.removeAll()
        }
        
        
        for obj in mutArrUserActivity {
            
            let objUserActy = UserActivityModel()
            
            objUserActy.user_activity_id = (obj["user_activity_id"] as? Int)!
            objUserActy.reminder_id = (obj["reminder_id"] as? Int)!
            objUserActy.type = (obj["type"] as? Int)!
            objUserActy.type_id = (obj["type_id"] as? Int)!
            objUserActy.user_activity_time = (obj["user_activity_time"] as? String)!
            objUserActy.user_activity_date = (obj["user_activity_date"] as? String)!
            objUserActy.user_activity_value = (obj["user_activity_value"] as? String)!
            objUserActy.user_activity_value_bool = (obj["user_activity_value_bool"] as? Int)!
            
            mutArrUser.append(objUserActy)
            
        }
        
        complition(mutArrUser)

        }
    
    
        
    
}
