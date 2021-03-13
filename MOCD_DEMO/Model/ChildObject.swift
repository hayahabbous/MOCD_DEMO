//
//  ChildObject.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 6/19/19.
//  Copyright © 2019 Datacellme. All rights reserved.
//

import Foundation
import UIKit

class ChildObject: NSObject {
    
    var firstName: String = ""
    var lastName: String = ""
    var birthdate: String = ""
    var address: String = ""
    var nationalityAr: String = ""
    var nationalityEn: String = ""
    
    var age: String = ""
    var parentObject: String?
    var status: CHILD_STATUS = .NEED_TEST
    var picture: String?
    var objectID = ""
    var mobile = ""
    var email = ""
    var child_age: CHILD_AGES = .none
    var emiratesId = ""
    
    var child_picture = ""
    var emirateStringAr = ""
    var emirateStringEn = ""
    
    
    
    
    var genderStringAr = ""
    var genderStringEn = ""
    
    var emirateID = ""
    var genderID = ""
    var countryCode = ""
    
    
    var overallStatus: String = ""
    var overallProgress:String = ""
    
    
    
}


class AssesmentObject: NSObject {
    var name: String = ""
    var objectId: String = ""
    
    
}
