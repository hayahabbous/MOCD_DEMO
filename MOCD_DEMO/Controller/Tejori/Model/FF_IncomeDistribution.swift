//
//  Social_Activities_Model.swift
//  Edkhar
//
//  Created by indianic on 31/12/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit

class FF_IncomeDistribution: NSObject {
    
    var years : String!
    var totalSaving : Float!
    var totalSpending : Float!
    var totalIncomes : Float!
    
    var aQueryExcutionStatus : Bool!
    var mutArrPreviousYearModel = [FF_IncomeDistribution]()
    
    func GetAllFFIncomeDistribution(aYearNumber: String) -> [FF_IncomeDistribution] {
        
        
        
        let aStrGetAllQuery = String(format: "SELECT strftime('%%Y',income_date) year, total(income_value) totalIncomes,(SELECT total(spending_value) from spending where ((strftime('%%Y', spending_date) <='\(aYearNumber)' and spending_type_isrecurring = 1))) totalspending ,(total(income_value)-(SELECT total(saving_value) from saving where strftime('%%Y', saving_date)='\(aYearNumber)')-(SELECT total(spending_value) from spending where ((strftime('%%Y', spending_date) <='\(aYearNumber)' and spending_type_isrecurring = 1)))) remainingIncome,(SELECT total(saving_value) from saving where strftime('%%Y', saving_date)='\(aYearNumber)') totalSaving from income where ((strftime('%%Y', income_date) <='\(aYearNumber)' and income_type_isrecurring = 1))")

        
        print(aStrGetAllQuery)
        
        //        let aStrGetAllQuery = String(format: "select * from saving where (saving_date BETWEEN \"%%%%@\" AND \"%%%%@\") ORDER BY saving_id DESC","\(astrStartDate)","\(astrlastDate)")
        
        let aMutArrPreviousYearlist : [[String : AnyObject]] = DatabaseEdkhar().selectAllfromTable(query: aStrGetAllQuery) { (status) in
        }
        
        if self.mutArrPreviousYearModel.count > 0 {
            self.mutArrPreviousYearModel.removeAll()
        }
        
        if aMutArrPreviousYearlist.count > 0 {
            
            for aDictPreviousMonthInfo in aMutArrPreviousYearlist {
                
                let objPreviousYearModel = FF_IncomeDistribution()
                objPreviousYearModel.years = aDictPreviousMonthInfo["years"] as? String
                objPreviousYearModel.totalSaving = aDictPreviousMonthInfo["totalSaving"] as? Float
                objPreviousYearModel.totalSpending = aDictPreviousMonthInfo["totalspending"] as? Float
                objPreviousYearModel.totalIncomes = aDictPreviousMonthInfo["totalIncomes"] as? Float
                
                self.mutArrPreviousYearModel.append(objPreviousYearModel)
            }
        }
        
        print(self.mutArrPreviousYearModel)
        return self.mutArrPreviousYearModel
    }
    
    
}
