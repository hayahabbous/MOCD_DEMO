//
//  Social_Activities_Model.swift
//  Edkhar
//
//  Created by indianic on 31/12/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit

class PreviousMonthModel: NSObject {

    var monthsYear : String!
    var totalIncome : Float!
    var totalIncomeRecurring : Float!
    var totalSpending : Float!
    var totalSpendingRecurring : Float!
    var totalSaving : Float!
    
    var aQueryExcutionStatus : Bool!
    var mutArrPreviousMonthModel = [PreviousMonthModel]()
    
    func GetAllPreviousMonthList(aMonth : String, aYear : String) -> [PreviousMonthModel] {
        
//        let aaStrSelectedYear = String(Utility.sharedInstance.getYearFromTodayDate())
        
//        let astrSelectedYear = String.init(format: "%@", aaStrSelectedYear)
//        print("aaStrSelectedYear = \(aaStrSelectedYear)")
        
//        select  strftime('%Y-%m',income_date) monthsYear , total(income_value) totalIncome, (select total(income_value) totalIncome from income i1 where strftime('%m', i1.income_date) < strftime('%m',i.income_date) and strftime('%Y', income_date) <='2017' and income_type_isrecurring = 1 and strftime('%m', i1.income_date) <> strftime('%m', i.income_date) group by strftime('%m',income_date)) totalIncome1, (select total(spending_value) from spending s where (strftime('%Y', spending_date) ='2017' and spending_type_isrecurring = 1 and strftime('%m', i.income_date)=strftime('%m', spending_date)) or (strftime('%Y',spending_date) ='2017' and spending_type_isrecurring =0 and strftime('%m', i.income_date)=strftime('%m', spending_date))) totalSpending,(select total(spending_value) from spending s1 where strftime('%m', s1.spending_date) < strftime('%m',i.income_date) and strftime('%Y', spending_date) <='2017' and spending_type_isrecurring = 1 and strftime('%m', s1.spending_date) <> strftime('%m', i.income_date) group by strftime('%m',spending_date)) totalSpending1,(select total(target_saved_amount)+(select total(saving_value) from saving where strftime('%Y',saving_date)='2017' and strftime('%Y-%m',saving_date)=strftime('%Y-%m',i.income_date)) from target) totalSaving from income i where ((strftime('%Y', income_date) ='2017' and income_type_isrecurring = 1)) or (strftime('%Y',income_date) ='2017' and income_type_isrecurring =0 ) group by strftime('%m',income_date) order by strftime('%m',income_date) desc
//        \(aStrSelectedYear)
//        let aStrGetAllQuery = String(format: "select ('\(aaStrSelectedYear)' || '-' || strftime('%%m',income_date)) monthsYear ,total(income_value) totalIncome ,(select total(spending_value) spending_value from spending where (strftime('%%Y-%%m',spending_date)<=('\(aaStrSelectedYear)' || '-' || strftime('%%m',income_date)) and spending_type_isrecurring=1) or (strftime('%%Y-%%m',spending_date)=('\(aaStrSelectedYear)' || '-' || strftime('%%m',income_date)) and spending_type_isrecurring=0)) totalSpending ,(select total(saving_value) from saving where strftime('%%Y-%%m')=('\(aaStrSelectedYear)' || '-' || strftime('%%m',income_date))) totalSaving from income where (strftime('%%Y',income_date)<='\(aaStrSelectedYear)' and income_type_isrecurring=1) or (strftime('%%Y',income_date)='\(aaStrSelectedYear)' and income_type_isrecurring=0) group by monthsYear order by monthsYear desc")
        
        let aStrGetAllQuery = String(format: "SELECT total(income_value) income_value,(SELECT total(spending_value) from spending where ((strftime('%%Y-%%m-%%d', spending_date) <='\(aYear)-\(aMonth)-31' and spending_type_isrecurring = 1)) or (strftime('%%Y-%%m',spending_date) ='\(aYear)-\(aMonth)'  and  spending_type_isrecurring =0)) spending_value,(total(income_value)-(SELECT total(saving_value) from saving where strftime('%%Y-%%m', saving_date)='\(aYear)-\(aMonth)')-(SELECT total(spending_value) from spending where ((strftime('%%Y-%%m-%%d', spending_date) <='\(aYear)-\(aMonth)-31' and spending_type_isrecurring = 1)) or (strftime('%%Y-%%m',spending_date) ='\(aYear)-\(aMonth)'  and  spending_type_isrecurring =0))) remainingIncome,(SELECT total(saving_value) from saving where strftime('%%Y-%%m', saving_date)='\(aYear)-\(aMonth)') saving_value from income where ((strftime('%%Y-%%m-%%d', income_date) <='\(aYear)-\(aMonth)-31' and income_type_isrecurring = 1)) or (strftime('%%Y-%%m',income_date) ='\(aYear)-\(aMonth)'  and  income_type_isrecurring =0)")
        
        print("aStrGetAllQuery = \(aStrGetAllQuery)")
        
        let aMutArrPreviousMonthlist : [[String : AnyObject]] = DatabaseEdkhar().selectAllfromTable(query: aStrGetAllQuery) { (status) in
        }
        
        if self.mutArrPreviousMonthModel.count > 0 {
            self.mutArrPreviousMonthModel.removeAll()
        }
        
        if aMutArrPreviousMonthlist.count > 0 {
            
            for aDictPreviousMonthInfo in aMutArrPreviousMonthlist {
                
                
                let objPreviousMonthModel = PreviousMonthModel()
                objPreviousMonthModel.monthsYear = String.init(format: "%@-%@", aYear,aMonth)
                objPreviousMonthModel.totalIncome = aDictPreviousMonthInfo["income_value"] as? Float
//                objPreviousMonthModel.totalIncomeRecurring = aDictPreviousMonthInfo["totalIncomeRecurring"]  as? Float
                objPreviousMonthModel.totalSpending = aDictPreviousMonthInfo["spending_value"]  as? Float
//                objPreviousMonthModel.totalSpendingRecurring = aDictPreviousMonthInfo["totalSpendingRecurring"]  as? Float
                objPreviousMonthModel.totalSaving = aDictPreviousMonthInfo["saving_value"] as? Float
                
                self.mutArrPreviousMonthModel.append(objPreviousMonthModel)
            }
        }
        return self.mutArrPreviousMonthModel
        
    }
    
    
}
