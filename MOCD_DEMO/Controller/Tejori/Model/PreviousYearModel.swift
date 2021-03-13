//
//  Social_Activities_Model.swift
//  Edkhar
//
//  Created by indianic on 31/12/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit

class PreviousYearModel: NSObject {
    
    var years : String!
    var totalSaving : Float!
    var totalSpending : Float!
    var totalIncomes : Float!
    
    var aQueryExcutionStatus : Bool!
    var mutArrPreviousYearModel = [PreviousYearModel]()
    
    func GetAllPreviousYearList(aYearNumber: String) -> [PreviousYearModel] {
        
        var aStrGetAllQuery: String = ""
        
        if aYearNumber.isEmpty || aYearNumber == ""{
            aStrGetAllQuery = String(format: "select strftime('%%Y',income_date) years,(select total(target_saved_amount)+(select total(saving_value) from saving where strftime('%%Y',saving_date)=strftime('%%Y', p.income_date)) from target) totalSaving, (select (select total(totalspending) from (select (total(spending_value)+ case when (select total(spending_value) from spending s1 where strftime('%%m', s1.spending_date) < strftime('%%m',s.spending_date) and strftime('%%Y', spending_date) <=strftime('%%Y', p.income_date) and spending_type_isrecurring = 1 and strftime('%%m', s1.spending_date) <> strftime('%%m', s.spending_date) group by strftime('%%m',spending_date)) is null then 0 else (select total(spending_value) totalspending from spending s1 where strftime('%%m', s1.spending_date) < strftime('%%m',s.spending_date) and strftime('%%Y', spending_date) <=strftime('%%Y', p.income_date) and spending_type_isrecurring = 1 and strftime('%%m', s1.spending_date) <> strftime('%%m', s.spending_date) group by strftime('%%m',spending_date)) end) totalspending from spending s where ((strftime('%%Y', spending_date) =strftime('%%Y', p.income_date) and spending_type_isrecurring = 1)) or (strftime('%%Y',spending_date) =strftime('%%Y', p.income_date) and spending_type_isrecurring =0 ) group by strftime('%%m',spending_date))) totalspending from spending d group by strftime('%%Y',spending_date)) totalSpending ,(select total(totalincome) from (select (total(income_value)+ case when (select total(income_value) totalIncome from income i1 where strftime('%%m', i1.income_date) < strftime('%%m',i.income_date) and strftime('%%Y', income_date) <=strftime('%%Y', p.income_date) and income_type_isrecurring = 1 and strftime('%%m', i1.income_date) <> strftime('%%m', i.income_date) group by strftime('%%m',income_date)) is null then 0 else (select total(income_value) totalIncome from income i1 where strftime('%%m', i1.income_date) < strftime('%%m',i.income_date) and strftime('%%Y', income_date) <=strftime('%%Y', p.income_date) and income_type_isrecurring = 1 and strftime('%%m', i1.income_date) <> strftime('%%m', i.income_date) group by strftime('%%m',income_date)) end) totalincome from income i where ((strftime('%%Y', income_date) =strftime('%%Y', p.income_date) and income_type_isrecurring = 1)) or (strftime('%%Y',income_date) =strftime('%%Y', p.income_date) and income_type_isrecurring =0 ) group by strftime('%%m',income_date))) totalIncomes from income p group by strftime('%%Y',income_date) order by strftime('%%Y',income_date) desc")
        }
        else{
            
            aStrGetAllQuery = String(format: "select strftime('%%Y',income_date) years ,(select total(target_saved_amount)+(select total(saving_value) from saving where strftime('%%Y',saving_date)='\(aYearNumber)') from target) totalSaving,(select (select total(totalspending) from (select (total(spending_value)+ case when (select total(spending_value) from spending i1 where strftime('%%m', i1.spending_date) < strftime('%%m',i.spending_date) and strftime('%%Y', spending_date) <=strftime('%%Y', p.spending_date) and spending_type_isrecurring = 1 and strftime('%%m', i1.spending_date) <> strftime('%%m', i.spending_date) group by strftime('%%m',spending_date)) is null then 0 else (select total(spending_value) totalspending from spending i1 where strftime('%%m', i1.spending_date) < strftime('%%m',i.spending_date) and strftime('%%Y', spending_date) <=strftime('%%Y', p.spending_date) and spending_type_isrecurring = 1 and strftime('%%m', i1.spending_date) <> strftime('%%m', i.spending_date) group by strftime('%%m',spending_date)) end) totalspending from spending i where ((strftime('%%Y', spending_date) =strftime('%%Y', p.spending_date) and spending_type_isrecurring = 1)) or (strftime('%%Y',spending_date) =strftime('%%Y', p.spending_date) and spending_type_isrecurring =0 ) group by strftime('%%m',spending_date))) totalspending from spending p where strftime('%%Y',spending_date)='\(aYearNumber)' group by strftime('%%Y',spending_date) )totalSpending,(select total(totalincome) from (select (total(income_value)+ case when (select total(income_value) totalIncome from income i1 where strftime('%%m', i1.income_date) < strftime('%%m',i.income_date) and strftime('%%Y', income_date) <=strftime('%%Y', p.income_date) and income_type_isrecurring = 1 and strftime('%%m', i1.income_date) <> strftime('%%m', i.income_date) group by strftime('%%m',income_date)) is null then 0 else (select total(income_value) totalIncome from income i1 where strftime('%%m', i1.income_date) < strftime('%%m',i.income_date) and strftime('%%Y', income_date) <=strftime('%%Y', p.income_date) and income_type_isrecurring = 1 and strftime('%%m', i1.income_date) <> strftime('%%m', i.income_date) group by strftime('%%m',income_date)) end) totalincome from income i where ((strftime('%%Y', income_date) =strftime('%%Y', p.income_date) and income_type_isrecurring = 1)) or (strftime('%%Y',income_date) =strftime('%%Y', p.income_date) and income_type_isrecurring =0 ) group by strftime('%%m',income_date))) totalIncomes from income p where strftime('%%Y',income_date)='\(aYearNumber)' group by strftime('%%Y',income_date)")

        }
        
        print(aStrGetAllQuery)
        
        //        let aStrGetAllQuery = String(format: "select * from saving where (saving_date BETWEEN \"%%%%@\" AND \"%%%%@\") ORDER BY saving_id DESC","\(astrStartDate)","\(astrlastDate)")
        
        let aMutArrPreviousYearlist : [[String : AnyObject]] = DatabaseEdkhar().selectAllfromTable(query: aStrGetAllQuery) { (status) in
        }
        
        if self.mutArrPreviousYearModel.count > 0 {
            self.mutArrPreviousYearModel.removeAll()
        }
        
        if aMutArrPreviousYearlist.count > 0 {
            
            for aDictPreviousMonthInfo in aMutArrPreviousYearlist {
                
                let objPreviousYearModel = PreviousYearModel()
                objPreviousYearModel.years = aDictPreviousMonthInfo["years"] as? String
                objPreviousYearModel.totalSaving = aDictPreviousMonthInfo["totalSaving"] as? Float
                objPreviousYearModel.totalSpending = aDictPreviousMonthInfo["totalSpending"] as? Float
                objPreviousYearModel.totalIncomes = aDictPreviousMonthInfo["totalIncomes"] as? Float
                
                self.mutArrPreviousYearModel.append(objPreviousYearModel)
            }
        }
        
        print(self.mutArrPreviousYearModel)
        return self.mutArrPreviousYearModel
    }
    
    
    func GetAllPreviousYearTitelList(aYearNumber: String) -> [PreviousYearModel]{
        
        
      let aStrGetAllQuery = String(format: "SELECT MIN (minimumYear) AS minimumYear FROM (SELECT MIN (strftime('%%Y',income_date)) AS minimumYear FROM income UNION SELECT MIN (strftime('%%Y',spending_date)) FROM spending UNION SELECT MIN (strftime('%%Y',saving_date))  FROM saving)")
        

        
        print(aStrGetAllQuery)
        
        //        let aStrGetAllQuery = String(format: "select * from saving where (saving_date BETWEEN \"%%%%@\" AND \"%%%%@\") ORDER BY saving_id DESC","\(astrStartDate)","\(astrlastDate)")
        
        let aMutArrPreviousYearlist : [[String : AnyObject]] = DatabaseEdkhar().selectAllfromTable(query: aStrGetAllQuery) { (status) in
        }
        
        if self.mutArrPreviousYearModel.count > 0 {
            self.mutArrPreviousYearModel.removeAll()
        }
       
        if aMutArrPreviousYearlist.count > 0 {
            
            for aDictPreviousMonthInfo in aMutArrPreviousYearlist {
                
                let objPreviousYearModel = PreviousYearModel()
                objPreviousYearModel.years = aDictPreviousMonthInfo["minimumYear"] as? String

                if objPreviousYearModel.years != nil {
                    self.mutArrPreviousYearModel.append(objPreviousYearModel)
                }
            }
        }
        
        print(self.mutArrPreviousYearModel)
        return self.mutArrPreviousYearModel
        
        
    }
    
    
}
