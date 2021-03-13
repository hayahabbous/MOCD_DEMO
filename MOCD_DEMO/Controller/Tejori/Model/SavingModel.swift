//
//  Social_Activities_Model.swift
//  Edkhar
//
//  Created by indianic on 31/12/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit

class SavingModel: NSObject {

    var identifier : Int!
    var target_id : Int!
    var saving_note : String!
    var saving_value : String!
    var saving_date : String!
    
    var aQueryExcutionStatus : Bool!
    var mutArrSavingList = [SavingModel]()
    
    func GetAllSavingList() -> [SavingModel] {
        
        let astrStartDate = String.init(format: "%@-%@-%@", aStrSelectedYear,aStrSelectedMonth,"01")
        let astrlastDate = String.init(format: "%@-%@-%@", aStrSelectedYear,aStrSelectedMonth,"31")
        
        let aStrGetAllQuery = String(format: "select * from saving where (saving_date BETWEEN \"%@\" AND \"%@\") ORDER BY saving_id DESC","\(astrStartDate)","\(astrlastDate)")
        
        let aMutArrSavinglist : [[String : AnyObject]] = DatabaseEdkhar().selectAllfromTable(query: aStrGetAllQuery) { (status) in
        }
        
        if self.mutArrSavingList.count > 0 {
            self.mutArrSavingList.removeAll()
        }
        
        if aMutArrSavinglist.count > 0 {
            
            for aDictSavingInfo in aMutArrSavinglist {
                
                let objSavingModel = SavingModel()
                objSavingModel.identifier = Int((aDictSavingInfo["saving_id"] as? String)!)
                objSavingModel.target_id = Int((aDictSavingInfo["target_id"] as? String)!)
                objSavingModel.saving_note = aDictSavingInfo["saving_note"] as? String
                objSavingModel.saving_value = (aDictSavingInfo["saving_value"] as? String)!
                objSavingModel.saving_date = (aDictSavingInfo["saving_date"] as? String)!
                
                self.mutArrSavingList.append(objSavingModel)
            }
        }
        return self.mutArrSavingList
    }
    
    func GetSavingValueByTarget(objSavingModel : SavingModel) -> [SavingModel] {
        
        var aStrGetAllQuery = ""
        if objSavingModel.saving_value != nil{
            aStrGetAllQuery = String.init(format: "select * from saving where target_id = %d and saving_value = %@", objSavingModel.target_id, objSavingModel.saving_value)
        }else{
            aStrGetAllQuery = String.init(format: "select * from saving where target_id = %d", objSavingModel.target_id)
        }
 
        let aMutArrSavinglist : [[String : AnyObject]] = DatabaseEdkhar().selectAllfromTable(query: aStrGetAllQuery) { (status) in
        }
        
        if self.mutArrSavingList.count > 0 {
            self.mutArrSavingList.removeAll()
        }
        
        if aMutArrSavinglist.count > 0 {
            
            for aDictSavingInfo in aMutArrSavinglist {
                
                let objSavingModel = SavingModel()
                objSavingModel.identifier = Int((aDictSavingInfo["saving_id"] as? String)!)
                objSavingModel.target_id = Int((aDictSavingInfo["target_id"] as? String)!)
                objSavingModel.saving_note = aDictSavingInfo["saving_note"] as? String
                objSavingModel.saving_value = (aDictSavingInfo["saving_value"] as? String)!
                objSavingModel.saving_date = (aDictSavingInfo["saving_date"] as? String)!
                
                self.mutArrSavingList.append(objSavingModel)
            }
        }
        return self.mutArrSavingList
    }
    
    func InsertSavingInfo(objSavingModel : SavingModel) -> Bool {
        
        let insertSQL = "INSERT INTO saving (target_id,saving_note,saving_value,saving_date) VALUES ('\(objSavingModel.target_id!)','\(objSavingModel.saving_note!)','\(objSavingModel.saving_value!)','\(objSavingModel.saving_date!)')"
        
        DatabaseEdkhar.sharedInstance.insert(query: insertSQL, success: {
            // Success.
            aQueryExcutionStatus = true
        }, failure: {
            // failure.
            aQueryExcutionStatus = false
        })
        
        return aQueryExcutionStatus
    }
    
    func UpdateSavingInfo(objSavingModel : SavingModel) -> Bool {
        
        let UpdateSQL = "Update saving Set target_id = '\(objSavingModel.target_id!)', saving_note = '\(objSavingModel.saving_note!)', saving_value = '\(objSavingModel.saving_value!)', saving_date = '\(objSavingModel.saving_date!)'where saving_id = '\(objSavingModel.identifier!)'"
        
        DatabaseEdkhar.sharedInstance.update(query: UpdateSQL, success: {
            // Success.
            aQueryExcutionStatus = true
        }, failure: {
            // failure.
            aQueryExcutionStatus = false
        })
        
        return aQueryExcutionStatus
    }
    
    func DeleteSavingInfo(objSavingModel : SavingModel) -> Bool {
        
        let DeleteSQL = String.init(format: "delete FROM saving where saving_id = %d", objSavingModel.identifier)
        
        DatabaseEdkhar.sharedInstance.delete(query: DeleteSQL, success: { (status) in
            // Success.
            aQueryExcutionStatus = true
        }) { (status) in
            aQueryExcutionStatus = false
        }
        return aQueryExcutionStatus
    }
    
}
