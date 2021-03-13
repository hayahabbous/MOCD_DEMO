//
//  QuoteOfTheDayModel.swift
//  SmartAgenda
//
//  Created by indianic on 07/02/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit

class QuoteOfTheMonthModel: NSObject {

    
    var QuoteID: Int!
    var QuoteText: String!
    var QuoteTextAR: String!
    var QuoteDate: String!
    
    var aDictMain = [QuoteOfTheMonthModel]()
    func getQuoteOfTheDay() -> [QuoteOfTheMonthModel]{
       
        let aStrQuery = "SELECT * FROM quote_of_the_month"
        
        let aDictTemp: [[String: AnyObject]] = Database().selectAllfromTable(query: aStrQuery) { (result: String) in }
        
        if aDictTemp.count > 0 {
           aDictMain.removeAll()
        }
        
        
        for obj in aDictTemp
        {
            
            let aObjTempQuote = QuoteOfTheMonthModel()
            
            aObjTempQuote.QuoteID = obj["id"] as? Int
            aObjTempQuote.QuoteText = obj["text"] as? String
            aObjTempQuote.QuoteTextAR = obj["text_ar"] as? String
            aObjTempQuote.QuoteDate = obj["date"] as? String
            
            self.aDictMain.append(aObjTempQuote)
        }
        
        return aDictMain
        
    }
}
