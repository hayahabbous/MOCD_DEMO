//
//  UserInfoModel.swift
//  Edkhar
//
//  Created by indianic on 27/12/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit

class userInfoModelT: NSObject {
    
    var identifier : Int!
    var name : String!
    var dob : String!
    var state : String!
    var gender : Int!
    var nationality : String!
    var requiredPin : Int!
    var pinForSecurity : String!
    var phoneNumber : String!
    var yourSalary : String!
    var salaryDay : String!
    var profilePicture : String!
    
    
    var aQueryExcutionStatus : Bool!
    var mutArrUserInfoList = [userInfoModelT]()
    
    func GetAllUserList() -> [userInfoModelT] {
        
        let aStrGetAllQuery = "select * from user_info"
        
        let aMutArrUserlist : [[String : AnyObject]] = DatabaseEdkhar.sharedInstance.selectAllfromTable(query: aStrGetAllQuery) { (status) in
            
        }
        
        if self.mutArrUserInfoList.count > 0 {
            self.mutArrUserInfoList.removeAll()
        }
        
        if aMutArrUserlist.count > 0 {
            for aDictUserInfo in aMutArrUserlist {
                
                let objUserModel = userInfoModelT()
                
                let aStrUserID = aDictUserInfo["user_id"] as? String
                objUserModel.identifier = NSInteger(aStrUserID!)
                objUserModel.name = aDictUserInfo["user_name"] as? String
                objUserModel.dob = aDictUserInfo["user_dob"] as? String
                objUserModel.state = aDictUserInfo["user_state"] as? String
                let aStrUserGender = aDictUserInfo["user_gender"] as? String
                objUserModel.gender = NSInteger(aStrUserGender!)
                objUserModel.nationality = aDictUserInfo["user_nationality"] as? String
                let aStrUserRequired_pin = aDictUserInfo["user_required_pin"] as? String
                objUserModel.requiredPin = NSInteger(aStrUserRequired_pin!)
                objUserModel.pinForSecurity = aDictUserInfo["user_pin_for_security"] as? String
                objUserModel.phoneNumber = aDictUserInfo["user_phone_number"] as? String
                objUserModel.yourSalary = aDictUserInfo["user_your_salary"] as? String
                objUserModel.salaryDay = aDictUserInfo["user_salary_day"] as? String
                objUserModel.profilePicture = aDictUserInfo["user_profile_picture"] as? String
                
                self.mutArrUserInfoList.append(objUserModel)
            }
        }
        return self.mutArrUserInfoList
    }
    
    func InsertUserInfo(objUserInfo : userInfoModelT) -> Bool {
        
        let insertSQL = "INSERT INTO user_info (user_name,user_dob,user_profile_picture, user_state,user_gender, user_nationality,user_required_pin, user_phone_number,user_your_salary,user_pin_for_security,user_salary_day) VALUES ('\(objUserInfo.name!)', '\(objUserInfo.dob!)','\(objUserInfo.profilePicture!)','\(objUserInfo.state!)','\(objUserInfo.gender!)','\(objUserInfo.nationality!)','\(objUserInfo.requiredPin!)','\(objUserInfo.phoneNumber!)','\(objUserInfo.yourSalary!)','\(objUserInfo.pinForSecurity!)','\(objUserInfo.salaryDay!)')"
        
        DatabaseEdkhar.sharedInstance.insert(query: insertSQL, success: {
            // Success.
            aQueryExcutionStatus = true
        }, failure: {
            // failure.
            aQueryExcutionStatus = false
        })
        
        return aQueryExcutionStatus
    }
    
    func UpdateUserInfo(objUserInfo : userInfoModelT) -> Bool {
        
        let UpdateSQL = "Update user_info Set user_name = '\(objUserInfo.name!)', user_dob = '\(objUserInfo.dob!)', user_profile_picture = '\(objUserInfo.profilePicture!)', user_state = '\(objUserInfo.state!)', user_gender = '\(objUserInfo.gender!)', user_nationality = '\(objUserInfo.nationality!)', user_required_pin = '\(objUserInfo.requiredPin!)', user_phone_number = '\(objUserInfo.phoneNumber!)', user_your_salary = '\(objUserInfo.yourSalary!)', user_pin_for_security = '\(objUserInfo.pinForSecurity!)', user_salary_day = '\(objUserInfo.salaryDay!)'"
        
        DatabaseEdkhar.sharedInstance.update(query: UpdateSQL, success: {
            // Success.
            aQueryExcutionStatus = true
        }, failure: {
            // failure.
            aQueryExcutionStatus = false
        })
        
        return aQueryExcutionStatus
    }
    
    func DeleteUserInfo(objUserInfo : userInfoModelT) -> Bool {
        
        let aStrDeleteQuery = "delete from user_info where user_id = '\(objUserInfo.identifier!)'"
        DatabaseEdkhar().delete(query: aStrDeleteQuery, success: { (aStatus) in
            if aStatus == true{
                aQueryExcutionStatus = true
            }
        }) { (aStatus) in
            aQueryExcutionStatus = false
        }
        
        return aQueryExcutionStatus
    }
}


