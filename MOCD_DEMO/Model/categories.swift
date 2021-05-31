//
//  categories.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 1/22/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit



class CategoryItem: NSObject {
    
    var id: String = ""
    var category_name_ar: String = ""
    var category_name_en: String = ""
    var servicesArray: [Service] = []
    
}

class Service: NSObject {
    
    var id: String = ""
    var service_name_ar: String = ""
    var service_name_en: String = ""
    var category_id: String = ""
    var service_code: String = ""
    
    var hm: hMeter?
    
    
    func sethmMeter(id: String) -> hMeter?{
        
        switch id {
        case "DC":
            self.hm = hMeter()
            self.hm?.entitySequenceId = "126"
            self.hm?.mainServiceSequenceId = "04"
            self.hm?.subServiceSequenceId = "001"
            self.hm?.subServiceComplimentarySequenceId = "000"
            self.hm?.fullSequenceCode = "126-04-001-000"
        case "RDC":
            self.hm = hMeter()
            self.hm?.entitySequenceId = "126"
            self.hm?.mainServiceSequenceId = "04"
            self.hm?.subServiceSequenceId = "001"
            self.hm?.subServiceComplimentarySequenceId = "001"
            self.hm?.fullSequenceCode = "126-04-001-001"
        case "SS":
            self.hm = hMeter()
            self.hm?.entitySequenceId = "126"
            self.hm?.mainServiceSequenceId = "01"
            self.hm?.subServiceSequenceId = "001"
            self.hm?.subServiceComplimentarySequenceId = "000"
            self.hm?.fullSequenceCode = "126-01-001-000"
            
        case "FL":
            self.hm = hMeter()
            self.hm?.entitySequenceId = "126"
            self.hm?.mainServiceSequenceId = "01"
            self.hm?.subServiceSequenceId = "001"
            self.hm?.subServiceComplimentarySequenceId = "009"
            self.hm?.fullSequenceCode = "126-01-001-009"
            
        case "EGR":
            self.hm = hMeter()
            self.hm?.entitySequenceId = "126"
            self.hm?.mainServiceSequenceId = "19"
            self.hm?.subServiceSequenceId = "001"
            self.hm?.subServiceComplimentarySequenceId = "000"
            self.hm?.fullSequenceCode = "126-19-001-000"
            
        case "MAW":
            self.hm = hMeter()
            self.hm?.entitySequenceId = "126"
            self.hm?.mainServiceSequenceId = "19"
            self.hm?.subServiceSequenceId = "002"
            self.hm?.subServiceComplimentarySequenceId = "000"
            self.hm?.fullSequenceCode = "126-19-002-000"
            
            
        case "EA":
            self.hm = hMeter()
            self.hm?.entitySequenceId = "126"
            self.hm?.mainServiceSequenceId = "09"
            self.hm?.subServiceSequenceId = "002"
            self.hm?.subServiceComplimentarySequenceId = "000"
            self.hm?.fullSequenceCode = "126-09-002-000"
            
        default:
            return nil
        }
        
        return self.hm
    }

}
class hMeter: NSObject {
    var entitySequenceId: String = ""
    var mainServiceSequenceId: String = ""
    var subServiceSequenceId: String = ""
    var subServiceComplimentarySequenceId: String = ""
    var fullSequenceCode: String = ""
    
   
}
