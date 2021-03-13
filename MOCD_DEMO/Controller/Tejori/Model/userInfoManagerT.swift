//
//  UserInfoManager.swift
//  Edkhar
//
//  Created by indianic on 29/12/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit

class userInfoManagerT: NSObject {
    
    // MARK: Shared UserInfoManager
    class var sharedInstance: userInfoManagerT {
        struct Static {
            static var instance = userInfoManagerT()
        }
        return Static.instance
    }
    
    // MARK: GetAllUserInfoList
    func GetAllUserInfoList() -> [userInfoModelT] {
        let aMutArrUserList : [userInfoModelT] = userInfoModelT().GetAllUserList()
        return aMutArrUserList
    }
    
    // MARK: GetAllCountryList
    func GetAllCountryList() -> [CountryListModel] {
        let aMutArrCountryList : [CountryListModel] = CountryListModel().GetAllCountryList()
        return aMutArrCountryList
    }
    
    // MARK: GetAllStateList
    func GetAllStateList() -> [StateListModel] {
        let aMutArrStateList : [StateListModel] = StateListModel().GetAllStateList()
        return aMutArrStateList
    }
    
    // MARK: DeleteUserDetailInfo
    func DeleteUserDetailInfo(objUserInfo : userInfoModelT) -> Bool {
        let aBoolDeleteStatus : Bool = userInfoModelT().DeleteUserInfo(objUserInfo: objUserInfo)
        return aBoolDeleteStatus
    }
    
    // MARK: InsertUserInfoDetail
    func InsertUserInfoDetail(objUserInfo : userInfoModelT) -> Bool {
        let aInsertStatus : Bool = userInfoModelT().InsertUserInfo(objUserInfo: objUserInfo)
        return aInsertStatus
    }
    
    // MARK: UpdateUserInfoDetail
    func UpdateUserInfoDetail(objUserInfo : userInfoModelT) -> Bool {
        let aUpdateStatus : Bool = userInfoModelT().UpdateUserInfo(objUserInfo: objUserInfo)
        return aUpdateStatus
    }
    
    // MARK: GetAllIncomeTypeListDetail
    func GetAllIncomeTypeListDetail() -> [IncomeTypeModel] {
        let aMutArrIncomeTypeList : [IncomeTypeModel] = IncomeTypeModel().GetAllIncomeTypeList()
        return aMutArrIncomeTypeList
    }
    
    // MARK: GetAllIncomeList
    func GetAllIncomeList() -> [IncomeModel] {
        let aMutArrIncomeList : [IncomeModel] = IncomeModel().GetAllIncomeList()
        return aMutArrIncomeList
    }
    
    // MARK: GetTotalIncomeList
    func GetTotalIncomeList() -> [IncomeModel] {
        let aMutArrIncomeList : [IncomeModel] = IncomeModel().GetTotalIncomeList()
        return aMutArrIncomeList
    }
    
    // MARK: Insert - InsertIncomeDetail
    func InsertIncomeDetail(objIncomeModel : IncomeModel) -> Bool {
        let aInsertStatus : Bool = IncomeModel().InsertIncomeInfo(objIncomeModel: objIncomeModel)
        return aInsertStatus
    }
    
    
    // MARK: Update - UpdateIncomeDetail
    func UpdateIncomeDetail(objIncomeModel : IncomeModel) -> Bool {
        let aInsertStatus : Bool = IncomeModel().UpdateIncomeInfo(objIncomeModel: objIncomeModel)
        return aInsertStatus
    }
    
    // MARK: Update - DeleteIncomeDetail
    func DeleteIncomeDetail(objIncomeModel : IncomeModel) -> Bool {
        let aDeleteStatus : Bool = IncomeModel().DeleteIncomeInfo(objIncomeModel: objIncomeModel)
        return aDeleteStatus
    }
    
    // MARK: GetAllSpendingTypeListDetail
    func GetAllSpendingTypeListDetail() -> [SpendingTypeModel] {
        let aMutArrSpendingTypeList : [SpendingTypeModel] = SpendingTypeModel().GetAllSpendingTypeList()
        return aMutArrSpendingTypeList
    }
    
    // MARK: GetAllSpendingList
    func GetAllSpendingList() -> [SpendingModel] {
        let aMutArrSpendingList : [SpendingModel] = SpendingModel().GetAllSpendingList()
        return aMutArrSpendingList
    }
    
    // MARK: GetAllSpendingList
    func GetAllSpendingListByProvidedMonthYear(aSelectedMonth: String , aSelectedYear: String) -> [SpendingModel] {
        let aMutArrSpendingList : [SpendingModel] = SpendingModel().GetAllSpendingListByProvidedMonthYear(aSelectedMonth: aSelectedMonth, aSelectedYear: aSelectedYear)
        return aMutArrSpendingList
    }
    
    
    func GetAllSpendingListByMonth(aMonthNumber : String, aYearNumber : String) -> [SpendingModel] {
        let aMutArrSpendingList : [SpendingModel] = SpendingModel().GetAllSpendingListByMonth(aMonthNumber: aMonthNumber, aYearNumber: aYearNumber)
        return aMutArrSpendingList
    }
    
    // MARK: GetAllSpendingListTitle
    func GetAllSpendingListTitle() -> [SpendingTypeModel] {
        let aMutArrSpendingListTitle : [SpendingTypeModel] = SpendingModel().GetAllSpendingListTitle()
        return aMutArrSpendingListTitle
    }
    
    // MARK: Insert - InsertSpendingDetail
    func InsertSpendingDetail(objSpendingModel : SpendingModel) -> Bool {
        let aInsertStatus : Bool = SpendingModel().InsertSpendingInfo(objSpendingModel: objSpendingModel)
        return aInsertStatus
    }
    
    // MARK: Insert - InsertSpendingTypeDetail
    func InsertSpendingTypeDetail(objSpendingTypeModel : SpendingTypeModel) -> Bool {
        let aInsertStatus : Bool = SpendingTypeModel().InsertSpendingTypeInfo(objSpendingTypeModel: objSpendingTypeModel)
        return aInsertStatus
    }
    
    // MARK: Delete - DeleteSpendingDetail
    func DeleteSpendingDetail(objSpendingModel : SpendingModel) -> Bool {
        let aDeleteStatus : Bool = SpendingModel().DeleteSpendingInfo(objSpendingModel: objSpendingModel)
        return aDeleteStatus
    }
    
    // MARK: Update - UpdateSpendingDetail
    func UpdateSpendingDetail(objSpendingModel : SpendingModel) -> Bool {
        let aUpdateStatus : Bool = SpendingModel().UpdateSpendingInfo(objSpendingModel: objSpendingModel)
        return aUpdateStatus
    }
    
    // MARK: Insert - InsertTargetDetail
    func InsertTargetDetail(objTargetModel : TargetModel) -> Bool {
        let aInsertStatus : Bool = TargetModel().InsertTargetInfo(objTargetModel: objTargetModel)
        return aInsertStatus
    }
    
    func getTargetId(objTargetModel : TargetModel) -> Int{
        let targetId = TargetModel().getTargetId(objTargetModel: objTargetModel)
        return targetId
    }
    
    // MARK: GetAllTargetListTitle
    func GetAllTargetListTitle() -> [TargetModel] {
        let aMutArrTargetListTitle : [TargetModel] = TargetModel().GetAllTargetList()
        return aMutArrTargetListTitle
    }
    
    // MARK: Delete - DeleteTargetDetail
    func DeleteTargetDetail(objTargetModel : TargetModel) -> Bool {
        let aDeleteStatus : Bool = TargetModel().DeleteTargetInfo(objTargetModel: objTargetModel)
        return aDeleteStatus
    }
    
    // MARK: Update - UpdateTargetDetail
    func UpdateTargetDetail(objTargetModel : TargetModel) -> Bool {
        let aUpdateStatus : Bool = TargetModel().UpdateTargetInfo(objTargetModel: objTargetModel)
        return aUpdateStatus
    }
    
    // MARK: Insert - InsertTargetDetail
    func InsertSavingDetail(objSavingModel : SavingModel) -> Bool {
        let aInsertStatus : Bool = SavingModel().InsertSavingInfo(objSavingModel: objSavingModel)
        return aInsertStatus
    }
    
    // MARK: GetAllTargetListTitle
    func GetAllSavingListTitle() -> [SavingModel] {
        let aMutArrSavingList : [SavingModel] = SavingModel().GetAllSavingList()
        return aMutArrSavingList
    }
    
    // MARK: GetSavingValByTarget
    func GetSavingValByTarget(objSavingModel : SavingModel) -> [SavingModel] {
        let aMutArrSavingList : [SavingModel] = SavingModel().GetSavingValueByTarget(objSavingModel: objSavingModel)
        return aMutArrSavingList
    }
    
    //MARK: Category Exist
    func isSpendingCategoryExist(objSpendingTypeModel : SpendingTypeModel) -> Bool {
        let aCategoryStatus : Bool = SpendingTypeModel().isCategoryExist(objSpendingTypeModel: objSpendingTypeModel)
        return aCategoryStatus
        
    }
    
    // MARK: Delete - DeleteSavingDetail
    func DeleteSavingDetail(objSavingModel : SavingModel) -> Bool {
        let aDeleteStatus : Bool = SavingModel().DeleteSavingInfo(objSavingModel: objSavingModel)
        return aDeleteStatus
    }
    
    
    
    // MARK: Update - UpdateTargetDetail
    func UpdateSavingDetail(objSavingModel : SavingModel) -> Bool {
        let aUpdateStatus : Bool = SavingModel().UpdateSavingInfo(objSavingModel: objSavingModel)
        return aUpdateStatus
    }
    
    // MARK: GetQuoteOfWeek
    func GetQuoteOfWeek() -> [QuoteModel] {
        let aMutArrQuoteList : [QuoteModel] = QuoteModel().GetWeeklyQuote()
        return aMutArrQuoteList
    }
    
    //MARK:- Insert - ReminderDetails
    func InsertReminderDetail(objReminderModel : ReminderModelT) -> Bool {
        let aInsertStatus : Bool = ReminderModelT().InsertReminderInfo(objReminderModel: objReminderModel)
        return aInsertStatus
    }
    
    //MARK:- UpdateReminderDetail
    func UpdateReminderDetail(objReminderModel : ReminderModelT) -> Bool {
        let aUpdateStatus : Bool = ReminderModelT().UpdateReminderInfo(objReminderModel: objReminderModel)
        return aUpdateStatus
    }
    
    //MARK:- DeleteReminderDetails
    func DeleteReminderDetail(objReminderModel : ReminderModelT) -> Bool {
        let aDeleteStatus : Bool = ReminderModelT().DeleteReminderInfo(objReminderModel: objReminderModel)
        return aDeleteStatus
    }
    
    //MARK:- GetReminderId
    
    func GetReminderId(objReminderModel: ReminderModelT) -> Int {
        let reminderId: Int = ReminderModelT().getReminderId(objReminderModel: objReminderModel)
        return reminderId
    }
    
    //MARK:- Get All Reminder List
    func GetAllReminderList() -> [ReminderModelT] {
        let aMutArrReminderList : [ReminderModelT] = ReminderModelT().GetAllReminderList()
        return aMutArrReminderList
    }
    
    //MARK:- Get All GetAllPreviousMonth List
    func GetAllPreviousMonthList(aMonth: String, aYear: String) -> [PreviousMonthModel] {
        let aMutArrPreviousMonthList : [PreviousMonthModel] = PreviousMonthModel().GetAllPreviousMonthList(aMonth: aMonth, aYear: aYear)
        return aMutArrPreviousMonthList
    }

    //MARK:- Get All Previous Year List
    
    func GetAllPreviousYearList(aYearNumber: String) -> [PreviousYearModel] {
        let aMutArrPreviousYearList: [PreviousYearModel] = PreviousYearModel().GetAllPreviousYearList(aYearNumber: aYearNumber)
        return aMutArrPreviousYearList
    }
    
    //MARK:- Get All Previous Year List Titel
    
    func GetAllPreviousYearTitelList(aYearNumber: String) -> [PreviousYearModel] {
        let aMutArrPreviousYearList: [PreviousYearModel] = PreviousYearModel().GetAllPreviousYearTitelList(aYearNumber: aYearNumber)
        return aMutArrPreviousYearList
    }
    
    //MARK:- Get SavingList For Year
    
    func GetSavingListForYear(aYearNumber: String) -> [PreviousYearSavingListModel] {
        let aMutArrPreviousYearSavingList: [PreviousYearSavingListModel] = PreviousYearSavingListModel().GetSavingListForYear(aYearNumber: aYearNumber)
        return aMutArrPreviousYearSavingList
    }
    
    func GetSavingListForYearByMonth(aYearNumber: String , aMonthNumber: String) -> [PreviousYearSavingListModel] {
        let aMutArrPreviousYearSavingList: [PreviousYearSavingListModel] = PreviousYearSavingListModel().GetSavingListForYearBYMonth(aYearNumber: aYearNumber, aMonthNumber: aMonthNumber)
        return aMutArrPreviousYearSavingList
    }
    
    
    //MARK:- Get Most Spending Category For Year
    
    func GetMostSpendingCategoryForYear(aYearNumber: String) -> [PreviousYearMostSpendingCategoryModel] {
        let aMutArrMostSpendingCategoryList: [PreviousYearMostSpendingCategoryModel] = PreviousYearMostSpendingCategoryModel().GetMostSpendingCategoryForYear(aYearNumber: aYearNumber)
        return aMutArrMostSpendingCategoryList
    }
    
    
//    //MARK:- Get SpendingType List
//    
//    func GetSpendingTypeForYear(aYearNumber: String) -> [PreviousYearSpendingTypeModel] {
//        let aMutArrSpendingTypeList: [PreviousYearSpendingTypeModel] = PreviousYearSpendingTypeModel().GetPreviousYearSpendingTypeForYear(aYearNumber: aYearNumber)
//        return aMutArrSpendingTypeList
//    }
    
    
    //MARK:- Month Graph -
    
    
    func GetPreviousMonthExpenseList(aMonth: String, aYear: String) -> [PreviousMonthExpenseModel] {
        let aMutArrPreviousMonthExpenseList: [PreviousMonthExpenseModel] = PreviousMonthExpenseModel().GetAllPreviousMonthExpenseList(aMonth: aMonth, aYear: aYear)
        return aMutArrPreviousMonthExpenseList
    }
    
    
    func GetPreviousMonthSavingList(aMonth: String, aYear: String) -> [PreviousMonthSavingListModel] {
        let aMutArrPreviousMonthSavingList: [PreviousMonthSavingListModel] = PreviousMonthSavingListModel().GetSavingListForMonth(aMonth: aMonth, aYear: aYear)
        return aMutArrPreviousMonthSavingList
    }
    
    func GetPreviousMonthMostSpendingCategoryList(aMonth: String, aYear: String) -> [PreviousMonthMostSpendingCategoryModel] {
        let aMutArrPreviousMonthMostSpendingCategoryModel: [PreviousMonthMostSpendingCategoryModel] = PreviousMonthMostSpendingCategoryModel().GetMostSpendingCategoryListForMonth(aMonth: aMonth, aYear: aYear)
        return aMutArrPreviousMonthMostSpendingCategoryModel
    }
    
    
    
    //MARK:- Most Spending month of year
    
    func MostSpendingMonthOfYear(aYear: String , aMonth: String) -> [MostSpendingMonthModel] {
        let aMutArrMostSpendingMonth: [MostSpendingMonthModel] = MostSpendingMonthModel().GetMostSpendingMonth(aMonth: aMonth, aYear: aYear)
        return aMutArrMostSpendingMonth
        
    }
    //MARK:- Get SpendingType List
    
    func GetSpendingTypeForYear(aYearNumber: String) -> [PreviousYearSpendingTypeModel] {
        let aMutArrSpendingTypeList: [PreviousYearSpendingTypeModel] = PreviousYearSpendingTypeModel().GetPreviousYearSpendingTypeForYear(aYearNumber: aYearNumber)
        return aMutArrSpendingTypeList
    }
    
    //MARK:- Suitable Income
    
    func SuitableIncomeOfYear(aYear: String, aMonth: String) -> [SuitableIncomeModel] {
        let aMutArrSuitableIncome: [SuitableIncomeModel] = SuitableIncomeModel().GetSuitableIncome(aYear: aYear, aMonth: aMonth)
        return aMutArrSuitableIncome
    }
    
    
    //MARK:- Finacial facts - income distibution
    func GetAllFFIncomeDistributionData(aYear: String) -> [FF_IncomeDistribution] {
        let aMutArrSuitableIncome: [FF_IncomeDistribution] = FF_IncomeDistribution().GetAllFFIncomeDistribution(aYearNumber: aYear)
        return aMutArrSuitableIncome
    }

    //MARK:- Most Spending month of year
    
    func PYearMostSpendingCategoryList() -> [PYearMostSpendingCategoryModel] {
        let aMutArrMostSpendingCategory: [PYearMostSpendingCategoryModel] = PYearMostSpendingCategoryModel().GetMostSpendingCategoryForYear()
        return aMutArrMostSpendingCategory
    }

}
