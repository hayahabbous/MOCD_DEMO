//
//  MOCDSecurityQuestions.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 4/10/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit



class MOCDSecurityQuestions: NSObject {
    
    
    var QuestionId: String = ""
    var QuestionEn: String = ""
    
    var QuestionAr: String = ""
}
class MOCDCountry: NSObject {
    
    
    var CountryId: String = ""
    var CountryNameEn: String = ""
    
    var CountryNameAr: String = ""
    var CountryCode: String = ""
}

class MOCDCenter: NSObject {
    
    
    
    var center_address: String = ""
    var center_name: String = ""
    var email: String = ""
    var id: String = ""
    var latitude: String = ""
    var longitude: String = ""
    var telephone: String = ""
    var working_hours: String = ""
    
    
    

}
class MOCDEmirate: NSObject {
    var id: String = ""
    var emirate_ar: String = ""
    var emirate_en: String = ""
    
    
  
}
class MOCDEmirateService: NSObject {
    var EmirateId: String = ""
    var EmirateTitleAr: String = ""
    var EmirateTitleEn: String = ""
    
    
  
}

class MOCDCenterService: NSObject {
    var EmirateId: String = ""
    var CenterId: String = ""
    var OfficeNameAR: String = ""
    var OfficeNameEN: String = ""
    
   
  
}
