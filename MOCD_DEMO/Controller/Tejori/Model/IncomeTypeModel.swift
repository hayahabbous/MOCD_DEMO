//
//  AppointmentModel.swift
//  Edkhar
//
//  Created by indianic on 31/12/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit

class IncomeTypeModel: NSObject {

    var income_type_id : Int!
    var income_type_title : String!
    var income_type_title_ar : String!
    var income_type_super : Int!
    var income_type_isbyuser : Int!
    
    var aQueryExcutionStatus : Bool!
    var mutArrIncomeTypeList = [IncomeTypeModel]()
    
    func GetAllIncomeTypeList() -> [IncomeTypeModel] {
        
        let aStrGetAllQuery = "select * from income_type"
        
        let aMutArrIncomeTypelist : [[String : AnyObject]] = DatabaseEdkhar().selectAllfromTable(query: aStrGetAllQuery) { (status) in
        }
        
        if self.mutArrIncomeTypeList.count > 0 {
            self.mutArrIncomeTypeList.removeAll()
        }
        
        if aMutArrIncomeTypelist.count > 0 {
            
            for aDictIncomeTypeInfo in aMutArrIncomeTypelist {
                
                let objIncomeTypeModel = IncomeTypeModel()
                objIncomeTypeModel.income_type_id = Int((aDictIncomeTypeInfo["income_type_id"] as? String)!)
                objIncomeTypeModel.income_type_title = aDictIncomeTypeInfo["income_type_title"] as? String
                objIncomeTypeModel.income_type_title_ar = aDictIncomeTypeInfo["income_type_title_ar"] as? String
                objIncomeTypeModel.income_type_super = Int((aDictIncomeTypeInfo["income_type_super"] as? String)!)
                objIncomeTypeModel.income_type_isbyuser = Int((aDictIncomeTypeInfo["income_type_isbyuser"] as? String)!)
                
                self.mutArrIncomeTypeList.append(objIncomeTypeModel)
            }
        }
        return self.mutArrIncomeTypeList
    }
    
}

