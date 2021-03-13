//
//  PreviousMonthSavingListModel.swift
//  Edkhar
//
//  Created by indianic on 18/02/17.
//  Copyright © 2017 demo. All rights reserved.
//

import UIKit

class PreviousMonthSavingListModel: NSObject {
    
    var target_id : String!
    var target_name : String!
    var target_final_amount : String!
    var target_saved_amount : String!
    var target_final_date : String!
    var target_monthly_installment : String!
    var target_total_saving_value : Float!
    
    var aQueryExcutionStatus : Bool!
    var mutArrPreviousMonthSavingListModel = [PreviousMonthSavingListModel]()
    
    func GetSavingListForMonth(aMonth: String, aYear: String) -> [PreviousMonthSavingListModel] {
        
        let aStrGetAllQuery = String(format: "SELECT target_id,target_name,target_final_amount,target_saved_amount,target_final_date,target_monthly_installment,(select total(saving_value) from saving  where target_id=t.target_id and (saving_date BETWEEN '\(aYear)-\(aMonth)-01' AND '\(aYear)-\(aMonth)-31')) target_total_saving_value  FROM target t order by target_total_saving_value desc")
        
        
//        let aStrGetAllQuery = String(format: "SELECT target_id,target_name,target_final_amount,target_saved_amount,target_final_date,target_monthly_installment,(select total(saving_value) + t.target_saved_amount from saving  where target_id=t.target_id and strftime('m', saving_date)='\(aMonth)' and strftime('Y', saving_date)='\(aYear)') target_total_saving_value  FROM target t order by target_total_saving_value desc")
        
//        SELECT target_id,target_name,target_final_amount,target_saved_amount,target_final_date,target_monthly_installment,(select total(saving_value) + t.target_saved_amount from saving  where target_id=t.target_id and strftime('m', saving_date)='02' and strftime('Y', saving_date)='2017') target_total_saving_value  FROM target t order by target_total_saving_value desc

        
        print(aStrGetAllQuery)
        
        let aMutArrSavingList : [[String : AnyObject]] = DatabaseEdkhar().selectAllfromTable(query: aStrGetAllQuery) { (status) in
        }
        
        if self.mutArrPreviousMonthSavingListModel.count > 0 {
            self.mutArrPreviousMonthSavingListModel.removeAll()
        }
        
        if aMutArrSavingList.count > 0 {
            
            for aDictSavingListInfo in aMutArrSavingList {
                
                let objPreviousYearSavingListModel = PreviousMonthSavingListModel()
                objPreviousYearSavingListModel.target_id = aDictSavingListInfo["target_id"] as? String
                objPreviousYearSavingListModel.target_name = aDictSavingListInfo["target_name"] as? String
                objPreviousYearSavingListModel.target_final_amount = aDictSavingListInfo["target_final_amount"] as? String
                objPreviousYearSavingListModel.target_saved_amount = aDictSavingListInfo["target_saved_amount"] as? String
                objPreviousYearSavingListModel.target_final_date = aDictSavingListInfo["target_final_date"] as? String
                objPreviousYearSavingListModel.target_monthly_installment = aDictSavingListInfo["target_monthly_installment"] as? String
                objPreviousYearSavingListModel.target_total_saving_value = aDictSavingListInfo["target_total_saving_value"] as? Float
                
                self.mutArrPreviousMonthSavingListModel.append(objPreviousYearSavingListModel)
            }
        }
        
        print(self.mutArrPreviousMonthSavingListModel)
        return self.mutArrPreviousMonthSavingListModel
    }
    
    
}

