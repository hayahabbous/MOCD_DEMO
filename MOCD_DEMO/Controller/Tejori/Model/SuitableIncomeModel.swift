//
//  SuitableIncomeModel.swift
//  Edkhar
//
//  Created by indianic on 20/02/17.
//  Copyright © 2017 demo. All rights reserved.
//

import UIKit

class SuitableIncomeModel: NSObject {
    var spending_value : Float!
    
    var aQueryExcutionStatus : Bool!
    var mutArrSuitableIncomeModel = [SuitableIncomeModel]()
    
    func GetSuitableIncome(aYear: String, aMonth: String) -> [SuitableIncomeModel] {
        
        let aStrGetAllQuery = String(format: "select total(spending_value) spending_value from spending where ((strftime('%%Y-%%m', spending_date) <='\(aYear)-\(aMonth)' and spending_type_isrecurring = 1)) or (strftime('%%Y-%%m',spending_date) ='\(aYear)-\(aMonth)'  and  spending_type_isrecurring =0)")
        
        
        
        
        
//        select total(spending_value) spending_value from spending where ((strftime('%Y', spending_date) <='2017' and spending_type_isrecurring = 1)) or (strftime('%Y',spending_date) ='2017'  and  spending_type_isrecurring =0)
        
        print(aStrGetAllQuery)
        
        let aMutArrSuitableIncomeList : [[String : AnyObject]] = DatabaseEdkhar().selectAllfromTable(query: aStrGetAllQuery) { (status) in
        }
        
        if self.mutArrSuitableIncomeModel.count > 0 {
            self.mutArrSuitableIncomeModel.removeAll()
        }
        
        if aMutArrSuitableIncomeList.count > 0 {
            
            for aDictSuitableIncomeInfo in aMutArrSuitableIncomeList {
                
                let objSuitableIncomeModel = SuitableIncomeModel()
                objSuitableIncomeModel.spending_value = aDictSuitableIncomeInfo["spending_value"] as? Float
                self.mutArrSuitableIncomeModel.append(objSuitableIncomeModel)
            }
        }
        
        print(self.mutArrSuitableIncomeModel)
        return self.mutArrSuitableIncomeModel
    }

}
