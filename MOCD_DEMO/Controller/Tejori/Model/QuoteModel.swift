//
//  AppointmentModel.swift
//  Edkhar
//
//  Created by indianic on 31/12/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit

class QuoteModel: NSObject {

    var identifier : Int!
    var quote_en : String!
    var quote_ar : String!
    
    var aQueryExcutionStatus : Bool!
    var mutArrQuoteList = [QuoteModel]()
    
    func GetWeeklyQuote() -> [QuoteModel] {
        
        let calender = NSCalendar.current
        let aIntWeekOfYear = Int(calender.component(.weekOfYear, from: Date()))
    
        let aStrGetAllQuery = String(format: "select * from quote where quote_id = %@","\(aIntWeekOfYear)")
        
        let aMutArrQuotelist : [[String : AnyObject]] = DatabaseEdkhar().selectAllfromTable(query: aStrGetAllQuery) { (status) in
        }
        
        if self.mutArrQuoteList.count > 0 {
            self.mutArrQuoteList.removeAll()
        }
        
        if aMutArrQuotelist.count > 0 {
            
            for aDictQuoteInfo in aMutArrQuotelist {
                
                let objQuoteModel = QuoteModel()
                objQuoteModel.identifier = NSInteger((aDictQuoteInfo["quote_id"] as! String))
                objQuoteModel.quote_en = aDictQuoteInfo["quote_en"] as? String
                objQuoteModel.quote_ar = aDictQuoteInfo["quote_ar"] as? String
                self.mutArrQuoteList.append(objQuoteModel)
            }
        }
        return self.mutArrQuoteList
    }
}

