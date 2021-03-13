//
//  UserInfoModel.swift
//
//
//  Created by indianic on 27/12/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit

class CountryListModel: NSObject {
    
    var identifier : Int!
    var country_en : String!
    var country_ar : String!
    
    var aQueryExcutionStatus : Bool!
    var mutArrCountryList = [CountryListModel]()
    
    func GetAllCountryList() -> [CountryListModel] {
        
        let aStrGetAllQuery = "select * from countries"
        
        let aMutArrCountrylist : [[String : AnyObject]] = Database.sharedInstance.selectAllfromTable(query: aStrGetAllQuery) { (status) in
            
        }
       
        if self.mutArrCountryList.count > 0 {
            self.mutArrCountryList.removeAll()
        }
        
        if aMutArrCountrylist.count > 0 {
            for aDictCountryInfo in aMutArrCountrylist {
                
                let objCountryModel = CountryListModel()
                
                let aStrCountryID = aDictCountryInfo["country_id"] as? String
                objCountryModel.identifier = aDictCountryInfo["country_id"] as? Int
                objCountryModel.country_en = aDictCountryInfo["country_en"] as? String
                objCountryModel.country_ar = aDictCountryInfo["country_ar"] as? String
                
                self.mutArrCountryList.append(objCountryModel)
            }
        }
        return self.mutArrCountryList
    }
    
}


