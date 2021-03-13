//
//  AppointmentModel.swift
//  Edkhar
//
//  Created by indianic on 31/12/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit

class SpendingModel: NSObject {

    var identifier : Int!
    var spending_type_id : Int!
    var spending_note : String!
    var spending_value : String!
    var spending_date : String!
    var spending_type_isrecurring : Int!
    var spending_option : Int!
    
    var aQueryExcutionStatus : Bool!
    var mutArrSpendingList = [SpendingModel]()
    
    
    
    func GetAllSpendingListByMonth(aMonthNumber : String, aYearNumber : String) -> [SpendingModel] {
        

        let astrlastDate = String.init(format: "%@-%@-%@", aYearNumber,aMonthNumber,"31")
        
//        select * from spending where spending_date <= "2017-02-31" OR spending_type_isrecurring = 1
        
        let aStrGetAllQuery = String(format: "select * from spending where (spending_date <= \"%@\" OR spending_type_isrecurring = 1) ORDER BY spending_id DESC","\(astrlastDate)")
        
        let aMutArrSpendinglist : [[String : AnyObject]] = DatabaseEdkhar().selectAllfromTable(query: aStrGetAllQuery) { (status) in
        }
        
        if self.mutArrSpendingList.count > 0 {
            self.mutArrSpendingList.removeAll()
        }
        
        if aMutArrSpendinglist.count > 0 {
            
            for aDictSpendingInfo in aMutArrSpendinglist {
                
                let objSpendingModel = SpendingModel()
                objSpendingModel.identifier = NSInteger((aDictSpendingInfo["spending_id"] as! String))
                objSpendingModel.spending_type_id = NSInteger((aDictSpendingInfo["spending_type_id"] as! String))
                objSpendingModel.spending_note = aDictSpendingInfo["spending_note"] as? String
                objSpendingModel.spending_value = aDictSpendingInfo["spending_value"] as? String
                objSpendingModel.spending_date = aDictSpendingInfo["spending_date"] as? String
                objSpendingModel.spending_type_isrecurring = NSInteger((aDictSpendingInfo["spending_type_isrecurring"] as! String))
                objSpendingModel.spending_option = NSInteger((aDictSpendingInfo["spending_option"] as! String))
                
                self.mutArrSpendingList.append(objSpendingModel)
            }
        }
        return self.mutArrSpendingList
    }
    
    func GetAllSpendingList() -> [SpendingModel] {
        
        let astrStartDate = String.init(format: "%@-%@-%@", aStrSelectedYear,aStrSelectedMonth,"01")
        let astrlastDate = String.init(format: "%@-%@-%@", aStrSelectedYear,aStrSelectedMonth,"31")
        
        let aStrGetAllQuery = String(format: "select * from spending where (spending_date BETWEEN \"%@\" AND \"%@\") OR (spending_date <= \"%@\" AND spending_type_isrecurring = 1) ORDER BY spending_id DESC","\(astrStartDate)","\(astrlastDate)","\(astrStartDate)")
        
        let aMutArrSpendinglist : [[String : AnyObject]] = DatabaseEdkhar().selectAllfromTable(query: aStrGetAllQuery) { (status) in
        }
        
        if self.mutArrSpendingList.count > 0 {
            self.mutArrSpendingList.removeAll()
        }
        
        if aMutArrSpendinglist.count > 0 {
            
            for aDictSpendingInfo in aMutArrSpendinglist {
                
                let objSpendingModel = SpendingModel()
                objSpendingModel.identifier = NSInteger((aDictSpendingInfo["spending_id"] as! String))
                objSpendingModel.spending_type_id = NSInteger((aDictSpendingInfo["spending_type_id"] as! String))
                objSpendingModel.spending_note = aDictSpendingInfo["spending_note"] as? String
                objSpendingModel.spending_value = aDictSpendingInfo["spending_value"] as? String
                objSpendingModel.spending_date = aDictSpendingInfo["spending_date"] as? String
                objSpendingModel.spending_type_isrecurring = NSInteger((aDictSpendingInfo["spending_type_isrecurring"] as! String))
                objSpendingModel.spending_option = NSInteger((aDictSpendingInfo["spending_option"] as! String))
                
                self.mutArrSpendingList.append(objSpendingModel)
            }
        }
        return self.mutArrSpendingList
    }
    
    func GetAllSpendingListByProvidedMonthYear(aSelectedMonth: String , aSelectedYear: String) -> [SpendingModel] {
        
        let astrStartDate = String.init(format: "%@-%@-%@", aSelectedYear,aSelectedMonth,"01")
        let astrlastDate = String.init(format: "%@-%@-%@", aSelectedYear,aSelectedMonth,"31")
        
        let aStrGetAllQuery = String(format: "select * from spending where (spending_date BETWEEN \"%@\" AND \"%@\") OR (spending_date <= \"%@\" AND spending_type_isrecurring = 1) ORDER BY spending_id DESC","\(astrStartDate)","\(astrlastDate)","\(astrStartDate)")
        
        let aMutArrSpendinglist : [[String : AnyObject]] = DatabaseEdkhar().selectAllfromTable(query: aStrGetAllQuery) { (status) in
        }
        
        if self.mutArrSpendingList.count > 0 {
            self.mutArrSpendingList.removeAll()
        }
        
        if aMutArrSpendinglist.count > 0 {
            
            for aDictSpendingInfo in aMutArrSpendinglist {
                
                let objSpendingModel = SpendingModel()
                objSpendingModel.identifier = NSInteger((aDictSpendingInfo["spending_id"] as! String))
                objSpendingModel.spending_type_id = NSInteger((aDictSpendingInfo["spending_type_id"] as! String))
                objSpendingModel.spending_note = aDictSpendingInfo["spending_note"] as? String
                objSpendingModel.spending_value = aDictSpendingInfo["spending_value"] as? String
                objSpendingModel.spending_date = aDictSpendingInfo["spending_date"] as? String
                objSpendingModel.spending_type_isrecurring = NSInteger((aDictSpendingInfo["spending_type_isrecurring"] as! String))
                objSpendingModel.spending_option = NSInteger((aDictSpendingInfo["spending_option"] as! String))
                
                self.mutArrSpendingList.append(objSpendingModel)
            }
        }
        return self.mutArrSpendingList
    }
    
    
    func GetAllSpendingListTitle() -> [SpendingTypeModel] {
        
        let aStrGetAllQuery = "SELECT * FROM spending_type INNER JOIN spending ON spending_type.spending_type_id=spending.spending_type_id ORDER BY spending.spending_id DESC"
        
        var aMutArrSpendinglist  = [SpendingTypeModel]()
        let aMutArrSpendinglisttemp : [[String:AnyObject]] = DatabaseEdkhar().selectAllfromTable(query: aStrGetAllQuery) { (status) in
            
        }
        
        for aDictSpendingTypeInfo in aMutArrSpendinglisttemp {
            
            let objSpendingTypeModel = SpendingTypeModel()
            objSpendingTypeModel.spending_type_id = Int((aDictSpendingTypeInfo["spending_type_id"] as? String)!)
            objSpendingTypeModel.spending_type_title = aDictSpendingTypeInfo["spending_type_title"] as? String
            objSpendingTypeModel.spending_type_title_ar = aDictSpendingTypeInfo["spending_type_title_ar"] as? String
            objSpendingTypeModel.spending_type_super = Int((aDictSpendingTypeInfo["spending_type_super"] as? String)!)
            objSpendingTypeModel.spending_type_isbyuser = Int((aDictSpendingTypeInfo["spending_type_isbyuser"] as? String)!)
            
            aMutArrSpendinglist.append(objSpendingTypeModel)
        }
        
        return aMutArrSpendinglist
    }
    
    func InsertSpendingInfo(objSpendingModel : SpendingModel) -> Bool {
        
        let insertSQL = "INSERT INTO spending (spending_type_id,spending_note,spending_value,spending_date,spending_type_isrecurring,spending_option) VALUES ('\(objSpendingModel.spending_type_id!)','\(objSpendingModel.spending_note!)','\(objSpendingModel.spending_value!)','\(objSpendingModel.spending_date!)','\(objSpendingModel.spending_type_isrecurring!)','\(objSpendingModel.spending_option!)')"
        
        DatabaseEdkhar.sharedInstance.insert(query: insertSQL, success: {
            // Success.
            aQueryExcutionStatus = true
        }, failure: {
            // failure.
            aQueryExcutionStatus = false
        })
        
        return aQueryExcutionStatus
    }
    
    func UpdateSpendingInfo(objSpendingModel : SpendingModel) -> Bool {
        
        let UpdateSQL = "Update spending Set spending_type_id = '\(objSpendingModel.spending_type_id!)', spending_note = '\(objSpendingModel.spending_note!)', spending_value = '\(objSpendingModel.spending_value!)', spending_date = '\(objSpendingModel.spending_date!)', spending_type_isrecurring = '\(objSpendingModel.spending_type_isrecurring!)', spending_option = '\(objSpendingModel.spending_option!)' where spending_id = '\(objSpendingModel.identifier!)'"
        
        DatabaseEdkhar.sharedInstance.update(query: UpdateSQL, success: {
            // Success.
            aQueryExcutionStatus = true
        }, failure: {
            // failure.
            aQueryExcutionStatus = false
        })
        
        return aQueryExcutionStatus
    }
    
    func DeleteSpendingInfo(objSpendingModel : SpendingModel) -> Bool {
        
        let DeleteSQL = String.init(format: "delete FROM spending where spending_id = %d", objSpendingModel.identifier)
        
        DatabaseEdkhar.sharedInstance.delete(query: DeleteSQL, success: { (status) in
            // Success.
            aQueryExcutionStatus = true
        }) { (status) in
            aQueryExcutionStatus = false
        }
        return aQueryExcutionStatus
    }
    
}

