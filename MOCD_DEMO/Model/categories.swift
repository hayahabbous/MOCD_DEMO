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

}
