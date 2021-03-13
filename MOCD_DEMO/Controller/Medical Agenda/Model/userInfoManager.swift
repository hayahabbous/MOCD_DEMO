//
//  UserInfoManager.swift
//  SwiftDatabase
//
//  Created by indianic on 29/12/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit

class userInfoManager: NSObject {
    
    // MARK: Shared UserInfoManager
    class var sharedInstance: userInfoManager {
        struct Static {
            static var instance = userInfoManager()
        }
        return Static.instance
    }
    
    // MARK: GetAllUserInfoList
    func GetAllUserInfoList() -> [userInfoModel] {
        let aMutArrUserList : [userInfoModel] = userInfoModel().GetAllUserList()
        return aMutArrUserList
    }
    
    // MARK: GetAllCountryList
    func GetAllCountryList() -> [CountryListModel] {
        let aMutArrCountryList : [CountryListModel] = CountryListModel().GetAllCountryList()
        return aMutArrCountryList
    }
    
    // MARK: DeleteUserDetailInfo
    func DeleteUserDetailInfo(objUserInfo : userInfoModel) -> Bool {
        let aBoolDeleteStatus : Bool = userInfoModel().DeleteUserInfo(objUserInfo: objUserInfo)
        return aBoolDeleteStatus
    }
    
    // MARK: InsertUserInfoDetail
    func InsertUserInfoDetail(objUserInfo : userInfoModel) -> Bool {
        let aInsertStatus : Bool = userInfoModel().InsertUserInfo(objUserInfo: objUserInfo)
        return aInsertStatus
    }

    // MARK: SignUp User
    func SignUpUser(objUserInfo : userInfoModel, complition: ((Bool) -> Void))  {
        userInfoModel().SignUpUser(objUserInfo: objUserInfo) { (result: (Bool)) in
            
            complition(result)
        }
        
    }
    
    
    // MARK: UpdateUserInfoDetail
    func UpdateUserInfoDetail(objUserInfo : userInfoModel) -> Bool {
        let aUpdateStatus : Bool = userInfoModel().UpdateUserInfo(objUserInfo: objUserInfo)
        return aUpdateStatus
    }
    

    // MARK: GetAllCalenderAppointmentList
    func GetAllCalenderAppointmentList(_ aStrStartDateOfMonth : String, aStrEndDateOfMonth : String , aReminderType : Int, completion: ([ReminderModel]) -> Void)  {
        
        ReminderModel().GetAllReminderListForCalender(aStrStartDateOfMonth, aStrEndDateOfMonth: aStrEndDateOfMonth, aReminderType: aReminderType) { (obj: [ReminderModel]) in
            completion(obj)
        }

    }
    
    
    // MARK: GetAllCalenderAppointmentList
    func GetAllReminderCheckList(_ aDateOfEvent : Date, strStartEndDateOfMonth : [String], complete: (([ReminderModel])-> Void)){
        ReminderModel().GetAllReminderListForChecklist(aDateOfEvent, strStartEndDateOfMonth: strStartEndDateOfMonth) { (obj: [ReminderModel]) in
            complete(obj)
        }
        
    }
    
    // MARK: GetAllCalenderAppointmentList
    func getAllFromReminderIDByDiseaseIDList(_ typrID : String, complete: (([ReminderModel])-> Void)){
        ReminderModel().getAllFromReminderIDByDiseaseID(typrID: typrID) { (obj: [ReminderModel]) in
            complete(obj)
        }
        
    }
    
    
}
