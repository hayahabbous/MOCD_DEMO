//
//  PYearMostSpendingCategoryModel.swift
//  Edkhar
//
//  Created by indianic on 03/03/17.
//  Copyright © 2017 demo. All rights reserved.
//PYearMostSpendingCategoryModel

import UIKit

class PYearMostSpendingCategoryModel: NSObject {
    
    var spending_value : Float!
    var spending_type_title : String!
    var spending_type_title_ar : String!
    var spending_id : String!
    
    var aQueryExcutionStatus : Bool!
    var mutArrPYearMostSpendingCategoryModel = [PYearMostSpendingCategoryModel]()
    
    func GetMostSpendingCategoryForYear() -> [PYearMostSpendingCategoryModel] {
        
        
        let aStrGetAllQuery = String(format: "select spending_id,spending_type_title_en,spending_type_title_ar, total(spending_value) spending_value from most_spending_category group by spending_type_id_super order by spending_value desc")
        
        
        print(aStrGetAllQuery)
        
        let aMutArrMostSpendingCategoryList : [[String : AnyObject]] = DatabaseEdkhar().selectAllfromTable(query: aStrGetAllQuery) { (status) in
        }
        
        if self.mutArrPYearMostSpendingCategoryModel.count > 0 {
            self.mutArrPYearMostSpendingCategoryModel.removeAll()
        }
        
        if aMutArrMostSpendingCategoryList.count > 0 {
            
            for aDictMostSpendingCategoryListInfo in aMutArrMostSpendingCategoryList {
                
                let objPreviousYearMostSpendingCategoryModel = PYearMostSpendingCategoryModel()
                
                let aSpendingValue = aDictMostSpendingCategoryListInfo["spending_value"] as? Float
                
                objPreviousYearMostSpendingCategoryModel.spending_value = aSpendingValue
                objPreviousYearMostSpendingCategoryModel.spending_id = aDictMostSpendingCategoryListInfo["spending_id"] as? String
                objPreviousYearMostSpendingCategoryModel.spending_type_title = aDictMostSpendingCategoryListInfo["spending_type_title_en"] as? String
                objPreviousYearMostSpendingCategoryModel.spending_type_title_ar = aDictMostSpendingCategoryListInfo["spending_type_title_ar"] as? String
                
                self.mutArrPYearMostSpendingCategoryModel.append(objPreviousYearMostSpendingCategoryModel)
            }
        }
        
        print(self.mutArrPYearMostSpendingCategoryModel)
        return self.mutArrPYearMostSpendingCategoryModel
    }
    
    
}
