//
//  AppointmentModel.swift
//  Edkhar
//
//  Created by indianic on 31/12/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit

class SpendingTypeModel: NSObject {

    var spending_type_id : Int!
    var spending_type_title : String!
    var spending_type_title_ar : String!
    var spending_type_super : Int!
    var spending_type_isbyuser : Int!
    
    var aQueryExcutionStatus : Bool!
    var mutArrSpendingTypeList = [SpendingTypeModel]()
    
    func GetAllSpendingTypeList() -> [SpendingTypeModel] {
        
        let aStrGetAllQuery = "select * from spending_type"
        
        let aMutArrSpendingTypelist : [[String : AnyObject]] = DatabaseEdkhar().selectAllfromTable(query: aStrGetAllQuery) { (status) in
        }
        
        if self.mutArrSpendingTypeList.count > 0 {
            self.mutArrSpendingTypeList.removeAll()
        }
        
        if aMutArrSpendingTypelist.count > 0 {
            
            for aDictSpendingTypeInfo in aMutArrSpendingTypelist {
                
                let objSpendingTypeModel = SpendingTypeModel()
                objSpendingTypeModel.spending_type_id = Int((aDictSpendingTypeInfo["spending_type_id"] as? String)!)
                objSpendingTypeModel.spending_type_title = aDictSpendingTypeInfo["spending_type_title"] as? String
                objSpendingTypeModel.spending_type_title_ar = aDictSpendingTypeInfo["spending_type_title_ar"] as? String
                objSpendingTypeModel.spending_type_super = Int((aDictSpendingTypeInfo["spending_type_super"] as? String)!)
                objSpendingTypeModel.spending_type_isbyuser = Int((aDictSpendingTypeInfo["spending_type_isbyuser"] as? String)!)
                
                self.mutArrSpendingTypeList.append(objSpendingTypeModel)
            }
        }
        return self.mutArrSpendingTypeList
    }
    
    func InsertSpendingTypeInfo(objSpendingTypeModel : SpendingTypeModel) -> Bool {
        
        let insertSQL = "INSERT INTO spending_type (spending_type_title,spending_type_title_ar,spending_type_super,spending_type_isbyuser) VALUES ('\(objSpendingTypeModel.spending_type_title!)','\(objSpendingTypeModel.spending_type_title_ar!)','\(objSpendingTypeModel.spending_type_super!)','\(objSpendingTypeModel.spending_type_isbyuser!)')"
        
        DatabaseEdkhar.sharedInstance.insert(query: insertSQL, success: {
            // Success.
            aQueryExcutionStatus = true
        }, failure: {
            // failure.
            aQueryExcutionStatus = false
        })
        
        return aQueryExcutionStatus
    }
    
    
    func isCategoryExist(objSpendingTypeModel : SpendingTypeModel) -> Bool {
        var status: Bool = false
        let aStrCaterogy = "select * from spending_type where upper(spending_type_title) = '\(objSpendingTypeModel.spending_type_title.uppercased())' OR upper(spending_type_title_ar) = '\(objSpendingTypeModel.spending_type_title_ar.uppercased())'"
        DatabaseEdkhar.sharedInstance.getRecordCount(query: aStrCaterogy, success: { (count) in
            if count > 0{
                status = true
            }
            else{
                status = false
            }
        }, failure: {
            status = false
        })
        return status
    }
    
}

