//
//  PreviousMonthExpenseModel.swift
//  Edkhar
//
//  Created by indianic on 18/02/17.
//  Copyright © 2017 demo. All rights reserved.
//PreviousMonthExpenseModel


import UIKit

class PreviousMonthExpenseModel: NSObject {
    var income_value : Float!
    var spending_value : Float!
    var remainingIncome : Float!
    var saving_value : Float!
    
    var aQueryExcutionStatus : Bool!
    var mutArrPreviousMonthExpenseModel = [PreviousMonthExpenseModel]()
    
    func GetAllPreviousMonthExpenseList(aMonth: String, aYear: String) -> [PreviousMonthExpenseModel] {
        

        let aStrGetAllQuery = String(format: "SELECT total(income_value) income_value,(SELECT total(spending_value) from spending where (spending_date <='\(aYear)-\(aMonth)-31' and spending_type_isrecurring = 1) or ((spending_date >= '\(aYear)-\(aMonth)-01' and spending_date <= '\(aYear)-\(aMonth)-31')  and  spending_type_isrecurring = 0)) spending_value,(total(income_value)-(SELECT total(spending_value) from spending where (spending_date <='\(aYear)-\(aMonth)-31' and spending_type_isrecurring = 1) or ((spending_date >= '2017-\(aMonth)-01' and spending_date <='\(aYear)-\(aMonth)-31')  and  spending_type_isrecurring =0))) remainingIncome,(SELECT total(saving_value) from saving where strftime('%%m-%%Y', saving_date)='\(aMonth)-\(aYear)') saving_value from income where (income_date <='\(aYear)-\(aMonth)-31' and income_type_isrecurring = 1) or ((income_date >='\(aYear)-\(aMonth)-01' and income_date <='\(aYear)-\(aMonth)-31')  and  income_type_isrecurring = 0)")
        
        print("aStrGetAllQuery = \(aStrGetAllQuery)")
        
        let aMutArrPreviousMonthlist : [[String : AnyObject]] = DatabaseEdkhar().selectAllfromTable(query: aStrGetAllQuery) { (status) in
        }
        
        if self.mutArrPreviousMonthExpenseModel.count > 0 {
            self.mutArrPreviousMonthExpenseModel.removeAll()
        }
        
        if aMutArrPreviousMonthlist.count > 0 {
            
            for aDictPreviousMonthInfo in aMutArrPreviousMonthlist {
                let objPreviousMonthModel = PreviousMonthExpenseModel()
                objPreviousMonthModel.income_value = aDictPreviousMonthInfo["income_value"] as? Float
                objPreviousMonthModel.spending_value = aDictPreviousMonthInfo["spending_value"] as? Float
                objPreviousMonthModel.saving_value = aDictPreviousMonthInfo["saving_value"]  as? Float
                objPreviousMonthModel.remainingIncome = aDictPreviousMonthInfo["remainingIncome"]  as? Float
                
                self.mutArrPreviousMonthExpenseModel.append(objPreviousMonthModel)
            }
        }
        return self.mutArrPreviousMonthExpenseModel
        
    }
}
