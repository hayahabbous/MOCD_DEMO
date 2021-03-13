
//
//  MostSpendingMonthModel.swift
//  Edkhar
//
//  Created by indianic on 20/02/17.
//  Copyright © 2017 demo. All rights reserved.
//

import UIKit

class MostSpendingMonthModel: NSObject {
    
    var monthYear : String!
    var spending_value : Float!
    
    var aQueryExcutionStatus : Bool!
    var mutArrMostSpendingMonthModel = [MostSpendingMonthModel]()
    
    func GetMostSpendingMonth(aMonth: String , aYear: String) -> [MostSpendingMonthModel] {
        
//        let aStrGetAllQuery = String(format: "select strftime('%%Y-%%m',spending_date) monthYear,MAX((Select Total(spending_value) from spending where ((strftime('%%m', spending_date) <=strftime('%%m', s.spending_date) and strftime('%%Y', spending_date) <='\(aYear)' and spending_type_isrecurring = 1)) or (strftime('%%m',spending_date) =strftime('%%m', s.spending_date) and strftime('%%Y',spending_date) ='\(aYear)'  and  spending_type_isrecurring =0))) spending_value from spending s")
        
//        let aStrGetAllQuery = String(format: "select max(TotalSpensing.spending_value)spending_value, TotalSpensing .monthYear from (select '\(aYear)'||'-'||strftime('%%m',spending_date) monthYear, (total(s.spending_value))spending_value, (select (case when st.spending_type_super !=0 then st.spending_type_super else s.spending_type_id end) id from spending_type where spending_type_id=s.spending_id) id  from spending s, spending_type st where (s.spending_type_id=st.spending_type_id) and (((strftime('%%Y-%%m', s.spending_date) <='\(aYear)'||'-'||strftime('%%m',spending_date) and spending_type_isrecurring = 1)) or (strftime('%%Y-%%m',s.spending_date) ='\(aYear)'||'-'||strftime('%%m',spending_date)  and  spending_type_isrecurring =0)) group by id) TotalSpensing")
        
        let aStrGetAllQuery = String(format: "Select Total(spending_value) spending_value from spending where ((strftime('%%Y-%%m-%%d', spending_date) <='\(aYear)-\(aMonth)-31' and spending_type_isrecurring = 1)) or (strftime('%%Y-%%m',spending_date) ='\(aYear)-\(aMonth)' and  spending_type_isrecurring =0)")
        
        
        
        print(aStrGetAllQuery)
        
        let aMutArrMostSpendingMonthList : [[String : AnyObject]] = DatabaseEdkhar().selectAllfromTable(query: aStrGetAllQuery) { (status) in
        }
        
        if self.mutArrMostSpendingMonthModel.count > 0 {
            self.mutArrMostSpendingMonthModel.removeAll()
        }
        
        if aMutArrMostSpendingMonthList.count > 0 {
            
            for aDictMostSpendingMonthListInfo in aMutArrMostSpendingMonthList {
                
                let objMostSpendingMonthModel = MostSpendingMonthModel()
//                objMostSpendingMonthModel.monthYear = aDictMostSpendingMonthListInfo["monthYear"] as? String
                objMostSpendingMonthModel.monthYear = String.init(format: "%@-%@", aYear,aMonth)
                objMostSpendingMonthModel.spending_value = aDictMostSpendingMonthListInfo["spending_value"] as? Float
                
                self.mutArrMostSpendingMonthModel.append(objMostSpendingMonthModel)
            }
        }
        
        print(self.mutArrMostSpendingMonthModel)
        return self.mutArrMostSpendingMonthModel
    }

}
