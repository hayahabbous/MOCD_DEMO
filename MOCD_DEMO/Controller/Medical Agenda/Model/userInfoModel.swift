//
//  UserInfoModel.swift
//  SwiftDatabase
//
//  Created by indianic on 27/12/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit

class userInfoModel: NSObject {
    
    var identifier : Int!
    var name : String!
    var dob : String!
    var profilePicture : String!
    var state : String!
    var nationality : String!
    var gender : Int!
    var bloodType : String!
    var smoker : Int!
    var phoneNumber : String!
    var emergencyPhoneNumber : String!
    var idNumber : String!
    var healthCardNumber : String!
    var weight : String!
    var height : String!
    var notes : String!
    
    
    var aQueryExcutionStatus : Bool!
    var mutArrUserInfoList = [userInfoModel]()
    
    func GetAllUserList() -> [userInfoModel] {
        let aStrGetAllQuery = "select * from user_info"
        let aMutArrUserlist : [[String : AnyObject]] = Database.sharedInstance.selectAllfromTable(query: aStrGetAllQuery) { (status) in
            
        }
        
        if self.mutArrUserInfoList.count > 0 {
            self.mutArrUserInfoList.removeAll()
        }
        
        if aMutArrUserlist.count > 0 {
            for aDictUserInfo in aMutArrUserlist {
                let objUserModel = userInfoModel()
                
                let aStrUserID = aDictUserInfo["user_id"]!
                objUserModel.identifier = NSInteger(aStrUserID as! Int)
                objUserModel.name = aDictUserInfo["user_name"] as? String
                objUserModel.dob = aDictUserInfo["user_dob"] as? String
                objUserModel.state = aDictUserInfo["user_state"] as? String
                objUserModel.nationality = aDictUserInfo["user_nationality"] as? String
                objUserModel.gender = aDictUserInfo["user_gender"] as? Int
                objUserModel.bloodType = aDictUserInfo["user_blood_type"] as? String
                objUserModel.smoker = aDictUserInfo["user_smoker"] as? Int
                objUserModel.phoneNumber = aDictUserInfo["user_phone_number"] as? String
                objUserModel.emergencyPhoneNumber = aDictUserInfo["user_emergency_phone_number"] as? String
                objUserModel.healthCardNumber = aDictUserInfo["user_health_card_number"] as? String
                objUserModel.idNumber = aDictUserInfo["user_id_number"] as? String
                objUserModel.weight = aDictUserInfo["user_weight"] as? String
                objUserModel.height = aDictUserInfo["user_length"] as? String
                objUserModel.notes = aDictUserInfo["user_special_notes"] as? String
                
                
                self.mutArrUserInfoList.append(objUserModel)
            }
        }
        return self.mutArrUserInfoList
    }
    
    func InsertUserInfo(objUserInfo : userInfoModel) -> Bool {
        
        let insertSQL = "INSERT INTO user_info (user_name, user_dob) VALUES ('\(objUserInfo.name!)', '\(objUserInfo.dob!)')"
        Database.sharedInstance.insert(query: insertSQL, success: {
            // Success.
            aQueryExcutionStatus = true
        }, failure: {
            // failure.
            aQueryExcutionStatus = false
        })
        
        return aQueryExcutionStatus
    }
    
    func SignUpUser(objUserInfo : userInfoModel, complition: ((Bool)) -> Void) {
        
        let name = objUserInfo.name!
        let dob =  objUserInfo.dob!
        let state = objUserInfo.state!
        let nationality = objUserInfo.nationality!
        let gender = objUserInfo.gender!
        let bloodType = objUserInfo.bloodType!
        let smoker = objUserInfo.smoker!
        let phone = objUserInfo.phoneNumber!
        let emer = objUserInfo.emergencyPhoneNumber!
        let health = objUserInfo.healthCardNumber!
        let idnum = objUserInfo.idNumber!
        let weight = objUserInfo.weight!
        let height = objUserInfo.height!
        let note = objUserInfo.notes!
        
//        let deleteAllRegistedUsers = "delete from user_info"
//        
//        Database.sharedInstance.delete(query: deleteAllRegistedUsers, success: { (status) in
//            
//        }) { (status) in
//            
//        }
        
        let insertSQL = "INSERT INTO user_info (user_name, user_dob, user_state, user_nationality, user_gender, user_blood_type, user_smoker, user_phone_number, user_emergency_phone_number, user_health_card_number, user_id_number, user_weight, user_length, user_special_notes) VALUES ('\(name)', '\(dob)', '\(state)', '\(nationality)', \(gender), '\(bloodType)', \(smoker), '\(phone)', '\(emer)', '\(health)', '\(idnum)', '\(weight)', '\(height)', '\(note)')"
        
        let string2 = insertSQL.replacingOccurrences(of: "\\", with: "")
        
        
        //        var insertSQL = "INSERT INTO user_info (user_name, user_dob, user_state, user_gender, user_blood_type, user_smoker, user_phone_number, user_emergency_phone_number, user_health_card_number, user_id_number) VALUES ('\(name)', '\(dob)', '\(state)', \(gender), '\(bloodType)', \(smoker), '\(phone)', '\(emer)', '\(health)', '\(idnum)')"
        
        
        print(string2)
        
        Database.sharedInstance.insert(query: string2, success: {
            // Success.
            complition(true)
        }, failure: {
            // failure.
            complition(false)
        })
        
    }
    
    func UpdateUserInfo(objUserInfo : userInfoModel) -> Bool {
        
        let UpdateSQL = "Update user_info Set user_name = '\(objUserInfo.name!)', user_dob = '\(objUserInfo.dob!)', user_blood_type = '\(objUserInfo.bloodType!)', user_state = '\(objUserInfo.state!)', user_nationality = '\(objUserInfo.nationality!)', user_gender = '\(objUserInfo.gender!)', user_smoker = '\(objUserInfo.smoker!)', user_phone_number = '\(objUserInfo.phoneNumber!)', user_emergency_phone_number = '\(objUserInfo.emergencyPhoneNumber!)', user_health_card_number = '\(objUserInfo.healthCardNumber!)', user_id_number = '\(objUserInfo.idNumber!)', user_weight = '\(objUserInfo.weight!)', user_length = '\(objUserInfo.height!)', user_special_notes = '\(objUserInfo.notes!)'"
        Database.sharedInstance.update(query: UpdateSQL, success: {
            // Success.
            aQueryExcutionStatus = true
        }, failure: {
            // failure.
            aQueryExcutionStatus = false
        })
        
        return aQueryExcutionStatus
    }
    
    func DeleteUserInfo(objUserInfo : userInfoModel) -> Bool {
        
        let aStrDeleteQuery = "delete from UserInfo where user_id = '\(objUserInfo.identifier!)'"
        Database().delete(query: aStrDeleteQuery, success: { (aStatus) in
            if aStatus == true{
                aQueryExcutionStatus = true
            }
        }) { (aStatus) in
            aQueryExcutionStatus = false
        }
        
        return aQueryExcutionStatus
    }
}


