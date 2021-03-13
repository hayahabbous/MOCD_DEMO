//
//  Social_Activities_Model.swift
//  Edkhar
//
//  Created by indianic on 31/12/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit

class TargetModel: NSObject {
    
    var identifier : Int!
    var target_name : String!
    var target_final_amount : String!
    var target_saved_amount : String!
    var target_final_date : String!
    var target_monthly_installment : String!
    
    var aQueryExcutionStatus : Bool!
    var mutArrTargetList = [TargetModel]()
    
    func GetAllTargetList() -> [TargetModel] {
        
        let aStrGetAllQuery = "select * from target ORDER BY target_id DESC"
        
        let aMutArrTargetlist : [[String : AnyObject]] = DatabaseEdkhar().selectAllfromTable(query: aStrGetAllQuery) { (status) in
        }
        
        if self.mutArrTargetList.count > 0 {
            self.mutArrTargetList.removeAll()
        }
        
        if aMutArrTargetlist.count > 0 {
            
            for aDictTargetInfo in aMutArrTargetlist {
                
                let objTargetModel = TargetModel()
                objTargetModel.identifier = Int((aDictTargetInfo["target_id"] as? String)!)
                objTargetModel.target_name = aDictTargetInfo["target_name"] as? String
                objTargetModel.target_final_amount = aDictTargetInfo["target_final_amount"] as? String
                objTargetModel.target_saved_amount = (aDictTargetInfo["target_saved_amount"] as? String)!
                objTargetModel.target_final_date = (aDictTargetInfo["target_final_date"] as? String)!
                objTargetModel.target_monthly_installment = (aDictTargetInfo["target_monthly_installment"] as? String)!
                
                self.mutArrTargetList.append(objTargetModel)
            }
        }
        return self.mutArrTargetList
    }
    
    func InsertTargetInfo(objTargetModel : TargetModel) -> Bool {
        
        let insertSQL = "INSERT INTO target (target_name,target_final_amount,target_saved_amount,target_final_date,target_monthly_installment) VALUES ('\(objTargetModel.target_name!)','\(objTargetModel.target_final_amount!)','\(objTargetModel.target_saved_amount!)','\(objTargetModel.target_final_date!)','\(objTargetModel.target_monthly_installment!)')"
        
        DatabaseEdkhar.sharedInstance.insert(query: insertSQL, success: {
            // Success.
            aQueryExcutionStatus = true
        }, failure: {
            // failure.
            aQueryExcutionStatus = false
        })
        
        return aQueryExcutionStatus
    }
    
    func UpdateTargetInfo(objTargetModel : TargetModel) -> Bool {
        
        let UpdateSQL = "Update target Set target_name = '\(objTargetModel.target_name!)', target_final_amount = '\(objTargetModel.target_final_amount!)', target_saved_amount = '\(objTargetModel.target_saved_amount!)', target_final_date = '\(objTargetModel.target_final_date!)', target_monthly_installment = '\(objTargetModel.target_monthly_installment!)' where target_id = '\(objTargetModel.identifier!)'"
        
        DatabaseEdkhar.sharedInstance.update(query: UpdateSQL, success: {
            // Success.
            aQueryExcutionStatus = true
        }, failure: {
            // failure.
            aQueryExcutionStatus = false
        })
        
        return aQueryExcutionStatus
    }
    
    func getTargetId(objTargetModel : TargetModel) -> Int{
        
        var targetId: Int = 0
        let aStrGetQuery = "select * from target where target_name = '\(objTargetModel.target_name!)'"
        
        let aMutArrTargetlist : [[String : AnyObject]] = DatabaseEdkhar().selectAllfromTable(query: aStrGetQuery) { (status) in
        }
        
        if aMutArrTargetlist.count > 0 {
            targetId = Int((aMutArrTargetlist[0]["target_id"] as? String)!)!
        }
        return targetId
    }
    
    func DeleteTargetInfo(objTargetModel : TargetModel) -> Bool {
        
        let DeleteSQL = String.init(format: "delete FROM target where target_id = %d", objTargetModel.identifier)
        
        DatabaseEdkhar.sharedInstance.delete(query: DeleteSQL, success: { (status) in
            // Success.
            aQueryExcutionStatus = true
            
            let DeleteSQL = String.init(format: "delete FROM saving where target_id = %d", objTargetModel.identifier)
            
            DatabaseEdkhar.sharedInstance.delete(query: DeleteSQL, success: { (status) in
                // Success.
                aQueryExcutionStatus = true
                
            }) { (status) in
                aQueryExcutionStatus = false
            }
            
        }) { (status) in
            aQueryExcutionStatus = false
        }
        return aQueryExcutionStatus
    }
    
}
