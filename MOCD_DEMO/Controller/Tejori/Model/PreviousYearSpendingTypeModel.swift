//
//  PreviousYearSpendingTypeModel.swift
//  Edkhar
//
//  Created by indianic on 18/02/17.
//  Copyright © 2017 demo. All rights reserved.
//PreviousYearSpendingTypeModel

import UIKit

class PreviousYearSpendingTypeModel: NSObject {
    
    var totalluxury : Float!
    var totalnecessary : Float!
    var totalnotdefined : Float!
    var totalspending : Float!
    
    var aQueryExcutionStatus : Bool!
    var mutArrPreviousYearSpendingTypeModel = [PreviousYearSpendingTypeModel]()
    
    func GetPreviousYearSpendingTypeForYear(aYearNumber: String) -> [PreviousYearSpendingTypeModel] {
        
        let aStrGetAllQuery = String(format: "select total(spending_value) totalluxury ,(select total(spending_value) from spending where ((strftime('%%Y', spending_date) <='\(aYearNumber)' and spending_type_isrecurring = 1 and spending_option='2')) or (strftime('%%Y',spending_date) ='\(aYearNumber)'  and  spending_type_isrecurring =0 and spending_option='2')) totalnecessary,(select total(spending_value) from spending where ((strftime('%%Y', spending_date) <='\(aYearNumber)' and spending_type_isrecurring = 1 and (spending_option='3' or spending_option='0'))) or (strftime('%%Y',spending_date) ='\(aYearNumber)'  and  spending_type_isrecurring =0 and (spending_option='3' or spending_option='0'))) totalnotdefined,(select total(spending_value) from spending where ((strftime('%%Y', spending_date) <='\(aYearNumber)' and spending_type_isrecurring = 1)) or (strftime('%%Y',spending_date) ='\(aYearNumber)'  and  spending_type_isrecurring =0)) totalspending from spending where ((strftime('%%Y', spending_date) <='\(aYearNumber)' and spending_type_isrecurring = 1 and spending_option='1')) or (strftime('%%Y',spending_date) ='\(aYearNumber)'  and  spending_type_isrecurring =0 and spending_option='1')")

        
        print(aStrGetAllQuery)
        
        let aMutArrSpendingTypeList : [[String : AnyObject]] = DatabaseEdkhar().selectAllfromTable(query: aStrGetAllQuery) { (status) in
        }
        
        if self.mutArrPreviousYearSpendingTypeModel.count > 0 {
            self.mutArrPreviousYearSpendingTypeModel.removeAll()
        }
        
        if aMutArrSpendingTypeList.count > 0 {
            
            for aDictSpendingTypeListInfo in aMutArrSpendingTypeList {
                
                let objPreviousYearSpendingTypeModel = PreviousYearSpendingTypeModel()
                objPreviousYearSpendingTypeModel.totalluxury = aDictSpendingTypeListInfo["totalluxury"] as? Float
                objPreviousYearSpendingTypeModel.totalnecessary = aDictSpendingTypeListInfo["totalnecessary"] as? Float
                objPreviousYearSpendingTypeModel.totalnotdefined = aDictSpendingTypeListInfo["totalnotdefined"] as? Float
                objPreviousYearSpendingTypeModel.totalspending = aDictSpendingTypeListInfo["totalspending"] as? Float
                
                self.mutArrPreviousYearSpendingTypeModel.append(objPreviousYearSpendingTypeModel)
            }
        }
        
        print(self.mutArrPreviousYearSpendingTypeModel)
        return self.mutArrPreviousYearSpendingTypeModel
    }
    
    
}
