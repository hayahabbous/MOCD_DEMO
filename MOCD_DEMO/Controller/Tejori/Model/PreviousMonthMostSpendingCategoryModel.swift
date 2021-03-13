//
//  PreviousMonthMostSpendingCategoryModel.swift
//  Edkhar
//
//  Created by indianic on 18/02/17.
//  Copyright © 2017 demo. All rights reserved.
//PreviousMonthMostSpendingCategoryModel

import UIKit

class PreviousMonthMostSpendingCategoryModel: NSObject {
    
    var spending_value : Float!
    var spending_date : String!
    var spending_type_title : String!
    var spending_type_title_ar : String!
    
    var aQueryExcutionStatus : Bool!
    var mutArrPreviousMonthMostSpendingCategoryModel = [PreviousMonthMostSpendingCategoryModel]()
    
    func GetMostSpendingCategoryListForMonth(aMonth: String, aYear: String) -> [PreviousMonthMostSpendingCategoryModel] {
        
//        let aStrGetAllQuery = String(format: "SELECT s.spending_id,s.spending_type_id,s.spending_note,SUM(s.spending_value) as spending_value,s.spending_date,s.spending_type_isrecurring,s.spending_option,st.spending_type_title,st.spending_type_title_ar,(select spending_type_id from spending_type where spending_type_id=st.spending_type_super) spending_type_id1,(select spending_type_title from spending_type where spending_type_id=st.spending_type_super) spending_type_title1 ,(select spending_type_title_ar from spending_type where spending_type_id=st.spending_type_super) spending_type_title_ar1 FROM spending s INNER JOIN spending_type st on s.spending_type_id=st.spending_type_id  where ((strftime('%%m', s.spending_date) <='\(aMonth)' and strftime('%%Y', s.spending_date) <='\(aYear)' and s.spending_type_isrecurring = 1)) or (strftime('%%m',s.spending_date) ='\(aMonth)' and strftime('%%Y',s.spending_date) ='\(aYear)'  and  s.spending_type_isrecurring =0)  group by s.spending_type_id order by cast(SUM(s.spending_value) as REAL) desc")
        
        let aStrGetAllQuery = String(format: "select (total(s.spending_value))spending_value, s.spending_id,s.spending_type_id,st.spending_type_super,(select (case when st.spending_type_super !=0 then st.spending_type_super else s.spending_type_id end) id from spending_type where spending_type_id=s.spending_id) id ,(select spending_type_title from spending_type where spending_type_id=(select (case when st.spending_type_super !=0 then st.spending_type_super else s.spending_type_id end) id from spending_type where spending_type_id=s.spending_id))spending_type_title,(select spending_type_title_ar from spending_type where spending_type_id=(select (case when st.spending_type_super !=0 then st.spending_type_super else s.spending_type_id end) id from spending_type where spending_type_id=s.spending_id))spending_type_title_ar from spending s, spending_type st where (s.spending_type_id=st.spending_type_id) and (((strftime('%%Y-%%m', s.spending_date) <='\(aYear)-\(aMonth)' and spending_type_isrecurring = 1)) or (strftime('%%Y-%%m',s.spending_date) ='\(aYear)-\(aMonth)'  and  spending_type_isrecurring =0)) group by id order by spending_value desc LIMIT 4")
        
        
        print(aStrGetAllQuery)
        
        let aMutArrMostSpendingCategoryList : [[String : AnyObject]] = DatabaseEdkhar().selectAllfromTable(query: aStrGetAllQuery) { (status) in
        }
        
        if self.mutArrPreviousMonthMostSpendingCategoryModel.count > 0 {
            self.mutArrPreviousMonthMostSpendingCategoryModel.removeAll()
        }
        
        if aMutArrMostSpendingCategoryList.count > 0 {
            
            for aDictMostSpendingCategoryListInfo in aMutArrMostSpendingCategoryList {
                
                let objPreviousYearMostSpendingCategoryModel = PreviousMonthMostSpendingCategoryModel()
                objPreviousYearMostSpendingCategoryModel.spending_value = aDictMostSpendingCategoryListInfo["spending_value"] as? Float
//                objPreviousYearMostSpendingCategoryModel.spending_date = aDictMostSpendingCategoryListInfo["spending_date"] as? String
                objPreviousYearMostSpendingCategoryModel.spending_type_title = aDictMostSpendingCategoryListInfo["spending_type_title"] as? String
                objPreviousYearMostSpendingCategoryModel.spending_type_title_ar = aDictMostSpendingCategoryListInfo["spending_type_title_ar"] as? String
                
                self.mutArrPreviousMonthMostSpendingCategoryModel.append(objPreviousYearMostSpendingCategoryModel)
            }
        }
        
        print(self.mutArrPreviousMonthMostSpendingCategoryModel)
        return self.mutArrPreviousMonthMostSpendingCategoryModel
    }
    
    
}
