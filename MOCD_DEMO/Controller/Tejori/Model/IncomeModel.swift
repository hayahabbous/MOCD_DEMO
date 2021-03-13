//
//  AppointmentModel.swift
//  Edkhar
//
//  Created by indianic on 31/12/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit

class IncomeModel: NSObject {

    var identifier : Int!
    var income_type_id : Int!
    var income_note : String!
    var income_value : String!
    var income_date : String!
    var income_type_isrecurring : Int!
    
    var aQueryExcutionStatus : Bool!
    var mutArrIncomeList = [IncomeModel]()
    
    func GetAllIncomeList() -> [IncomeModel] {
        
        let astrStartDate = String.init(format: "%@-%@-%@", aStrSelectedYear,aStrSelectedMonth,"01")
        let astrlastDate = String.init(format: "%@-%@-%@", aStrSelectedYear,aStrSelectedMonth,"31")
        
    
        let aStrGetAllQuery = String(format: "select * from income where (income_date BETWEEN \"%@\" AND \"%@\") OR (income_date <= \"%@\" AND income_type_isrecurring = 1)ORDER BY income_id DESC","\(astrStartDate)","\(astrlastDate)","\(astrStartDate)")
        
        let aMutArrIncomelist : [[String : AnyObject]] = DatabaseEdkhar().selectAllfromTable(query: aStrGetAllQuery) { (status) in
        }
        
        if self.mutArrIncomeList.count > 0 {
            self.mutArrIncomeList.removeAll()
        }
        
        if aMutArrIncomelist.count > 0 {
            
            for aDictIncomeInfo in aMutArrIncomelist {
                
                let objIncomeModel = IncomeModel()
                objIncomeModel.identifier = NSInteger((aDictIncomeInfo["income_id"] as! String))
                objIncomeModel.income_type_id = NSInteger((aDictIncomeInfo["income_type_id"] as! String))
                objIncomeModel.income_note = aDictIncomeInfo["income_note"] as? String
                objIncomeModel.income_value = aDictIncomeInfo["income_value"] as? String
                objIncomeModel.income_date = aDictIncomeInfo["income_date"] as? String
                objIncomeModel.income_type_isrecurring = NSInteger((aDictIncomeInfo["income_type_isrecurring"] as! String))
                self.mutArrIncomeList.append(objIncomeModel)
            }
        }
        return self.mutArrIncomeList
    }
    
    func GetTotalIncomeList() -> [IncomeModel] {
        
        let aStrGetAllQuery = String(format: "select * from income")
        
        let aMutArrIncomelist : [[String : AnyObject]] = DatabaseEdkhar().selectAllfromTable(query: aStrGetAllQuery) { (status) in
        }
        
        if self.mutArrIncomeList.count > 0 {
            self.mutArrIncomeList.removeAll()
        }
        
        if aMutArrIncomelist.count > 0 {
            
            for aDictIncomeInfo in aMutArrIncomelist {
                
                let objIncomeModel = IncomeModel()
                objIncomeModel.identifier = NSInteger((aDictIncomeInfo["income_id"] as! String))
                objIncomeModel.income_type_id = NSInteger((aDictIncomeInfo["income_type_id"] as! String))
                objIncomeModel.income_note = aDictIncomeInfo["income_note"] as? String
                objIncomeModel.income_value = aDictIncomeInfo["income_value"] as? String
                objIncomeModel.income_date = aDictIncomeInfo["income_date"] as? String
                objIncomeModel.income_type_isrecurring = NSInteger((aDictIncomeInfo["income_type_isrecurring"] as! String))
                self.mutArrIncomeList.append(objIncomeModel)
            }
        }
        return self.mutArrIncomeList
    }

    
    
    func InsertIncomeInfo(objIncomeModel : IncomeModel) -> Bool {
        
        let insertSQL = "INSERT INTO income (income_type_id,income_note,income_value,income_date,income_type_isrecurring) VALUES ('\(objIncomeModel.income_type_id!)', '\(objIncomeModel.income_note!)','\(objIncomeModel.income_value!)','\(objIncomeModel.income_date!)','\(objIncomeModel.income_type_isrecurring!)')"
        
        DatabaseEdkhar.sharedInstance.insert(query: insertSQL, success: {
            // Success.
            aQueryExcutionStatus = true
        }, failure: {
            // failure.
            aQueryExcutionStatus = false
        })
        
        return aQueryExcutionStatus
    }
    
    func UpdateIncomeInfo(objIncomeModel : IncomeModel) -> Bool {
        
        let UpdateSQL = "Update income Set income_type_id = '\(objIncomeModel.income_type_id!)', income_note = '\(objIncomeModel.income_note!)', income_value = '\(objIncomeModel.income_value!)', income_date = '\(objIncomeModel.income_date!)', income_type_isrecurring = '\(objIncomeModel.income_type_isrecurring!)' where income_id = '\(objIncomeModel.identifier!)'"
        
        DatabaseEdkhar.sharedInstance.update(query: UpdateSQL, success: {
            // Success.
            aQueryExcutionStatus = true
        }, failure: {
            // failure.
            aQueryExcutionStatus = false
        })
        
        return aQueryExcutionStatus
    }
    
    func DeleteIncomeInfo(objIncomeModel : IncomeModel) -> Bool {
        
        let DeleteSQL = String.init(format: "delete FROM income where income_id = %d", objIncomeModel.identifier)
        
        DatabaseEdkhar.sharedInstance.delete(query: DeleteSQL, success: { (status) in
            // Success.
            aQueryExcutionStatus = true
        }) { (status) in
            aQueryExcutionStatus = false
        }
        return aQueryExcutionStatus
    }
    
}

