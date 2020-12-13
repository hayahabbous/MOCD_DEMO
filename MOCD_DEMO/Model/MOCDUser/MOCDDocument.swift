//
//  MOCDDocument.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 6/16/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit


class MOCDDocument: NSObject {
    
    var DocTypeTitleEn: String = ""
    var DocTypeTitleAr: String = ""
    var ValidExtension: String = ""
    var StatusTitleEN: String = ""
    var StatusTitleAR: String = ""
    var ServiceDocTypeId: String = ""
    var ServiceId: String = ""
    var DocTypeId: String = ""
    var StatusId: String = ""
    var IsMandatory: String = ""
    var IsMany: String = ""
   
    var filesArray: [URL] = []
   
}


class MOCDMasterDocument: NSObject {
    
    var Id: String = ""
    var Name: String = ""
    var NameinArabic: String = ""
    var Typedoc: String = ""
    var FileExtension: String = ""
    var IsMandatory: String = ""
    var IsMany: String = ""
    
   
    var filesArray: [URL] = []
    
    
  
   
}
