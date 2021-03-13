//
//  UserInfoModel.swift
//  Edkhar
//
//  Created by indianic on 27/12/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit

class StateListModel: NSObject {
    
    var identifier : Int!
    var state_en : String!
    var state_ar : String!
    
    var aQueryExcutionStatus : Bool!
    var mutArrStateList = [StateListModel]()
    
    func GetAllStateList() -> [StateListModel] {
        
        let aStrGetAllQuery = "select * from states"
        
        let aMutArrStatelist : [[String : AnyObject]] = DatabaseEdkhar.sharedInstance.selectAllfromTable(query: aStrGetAllQuery) { (status) in
            
        }
       
        if self.mutArrStateList.count > 0 {
            self.mutArrStateList.removeAll()
        }
        
        if aMutArrStatelist.count > 0 {
            for aDictStateInfo in aMutArrStatelist {
                
                let objStateModel = StateListModel()
                
                let aStrStateID = aDictStateInfo["state_id"] as? String
                objStateModel.identifier = NSInteger(aStrStateID!)
                objStateModel.state_en = aDictStateInfo["state_en"] as? String
                objStateModel.state_ar = aDictStateInfo["state_ar"] as? String
                
                self.mutArrStateList.append(objStateModel)
            }
        }
        return self.mutArrStateList
    }
    
}


