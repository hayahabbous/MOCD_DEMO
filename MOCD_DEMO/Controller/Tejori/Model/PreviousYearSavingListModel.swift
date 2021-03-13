//
//  PreviousYearSavingListModel.swift
//  Edkhar
//
//  Created by indianic on 18/02/17.
//  Copyright © 2017 demo. All rights reserved.
// PreviousYearSavingListModel

import UIKit

class PreviousYearSavingListModel: NSObject {
    
    var target_id : String!
    var target_name : String!
    var target_final_amount : String!
    var target_saved_amount : String!
    var target_final_date : String!
    var target_monthly_installment : String!
    var target_total_saving_value : Float!

    var aQueryExcutionStatus : Bool!
    var mutArrPreviousYearSavingListModel = [PreviousYearSavingListModel]()
    
    func GetSavingListForYear(aYearNumber: String) -> [PreviousYearSavingListModel] {
        
        let aStrGetAllQuery = String(format: "SELECT target_id,target_name,target_final_amount,target_saved_amount,target_final_date,target_monthly_installment,(select total(saving_value) + t.target_saved_amount from saving  where target_id=t.target_id and strftime('%%Y', saving_date)='\(aYearNumber)') target_total_saving_value  FROM target t order by target_total_saving_value desc")
        
        print(aStrGetAllQuery)
        
        //        let aStrGetAllQuery = String(format: "select * from saving where (saving_date BETWEEN \"%%%%@\" AND \"%%%%@\") ORDER BY saving_id DESC","\(astrStartDate)","\(astrlastDate)")
        
        let aMutArrSavingList : [[String : AnyObject]] = DatabaseEdkhar().selectAllfromTable(query: aStrGetAllQuery) { (status) in
        }
        
        if self.mutArrPreviousYearSavingListModel.count > 0 {
            self.mutArrPreviousYearSavingListModel.removeAll()
        }
        
        if aMutArrSavingList.count > 0 {
            
            for aDictSavingListInfo in aMutArrSavingList {
                
                let objPreviousYearSavingListModel = PreviousYearSavingListModel()
                objPreviousYearSavingListModel.target_id = aDictSavingListInfo["target_id"] as? String
                objPreviousYearSavingListModel.target_name = aDictSavingListInfo["target_name"] as? String
                objPreviousYearSavingListModel.target_final_amount = aDictSavingListInfo["target_final_amount"] as? String
                objPreviousYearSavingListModel.target_saved_amount = aDictSavingListInfo["target_saved_amount"] as? String
                objPreviousYearSavingListModel.target_final_date = aDictSavingListInfo["target_final_date"] as? String
                objPreviousYearSavingListModel.target_monthly_installment = aDictSavingListInfo["target_monthly_installment"] as? String
                objPreviousYearSavingListModel.target_total_saving_value = aDictSavingListInfo["target_total_saving_value"] as? Float
                
                self.mutArrPreviousYearSavingListModel.append(objPreviousYearSavingListModel)
            }
        }
        
        print(self.mutArrPreviousYearSavingListModel)
        return self.mutArrPreviousYearSavingListModel
    }
    
    func GetSavingListForYearBYMonth(aYearNumber: String, aMonthNumber: String) -> [PreviousYearSavingListModel] {
        
        
//        select total(saving_value) saving_value from saving where strftime('%Y-%m', saving_date)='\(aYearNumber) - \(aMonthNumber)'
        
        let aStrGetAllQuery = String(format: "select total(saving_value) saving_value from saving where strftime('%%Y-%%m', saving_date)='\(aYearNumber)-\(aMonthNumber)'")
        
        print(aStrGetAllQuery)
        
        //        let aStrGetAllQuery = String(format: "select * from saving where (saving_date BETWEEN \"%%%%@\" AND \"%%%%@\") ORDER BY saving_id DESC","\(astrStartDate)","\(astrlastDate)")
        
        let aMutArrSavingList : [[String : AnyObject]] = DatabaseEdkhar().selectAllfromTable(query: aStrGetAllQuery) { (status) in
        }
        
        if self.mutArrPreviousYearSavingListModel.count > 0 {
            self.mutArrPreviousYearSavingListModel.removeAll()
        }
        
        if aMutArrSavingList.count > 0 {
            
            for aDictSavingListInfo in aMutArrSavingList {
                
                let objPreviousYearSavingListModel = PreviousYearSavingListModel()
//                objPreviousYearSavingListModel.target_id = aDictSavingListInfo["target_id"] as? String
//                objPreviousYearSavingListModel.target_name = aDictSavingListInfo["target_name"] as? String
//                objPreviousYearSavingListModel.target_final_amount = aDictSavingListInfo["target_final_amount"] as? String
//                objPreviousYearSavingListModel.target_saved_amount = aDictSavingListInfo["target_saved_amount"] as? String
//                objPreviousYearSavingListModel.target_final_date = aDictSavingListInfo["target_final_date"] as? String
//                objPreviousYearSavingListModel.target_monthly_installment = aDictSavingListInfo["target_monthly_installment"] as? String
                objPreviousYearSavingListModel.target_total_saving_value = aDictSavingListInfo["saving_value"] as? Float
//                objPreviousYearSavingListModel.target_total_saving_value = aDictSavingListInfo["saving_value"] as? String
                self.mutArrPreviousYearSavingListModel.append(objPreviousYearSavingListModel)
            }
        }
        
        print(self.mutArrPreviousYearSavingListModel)
        
        return self.mutArrPreviousYearSavingListModel
    }
    
    
}
