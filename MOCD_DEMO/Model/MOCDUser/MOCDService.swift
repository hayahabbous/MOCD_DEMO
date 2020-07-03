//
//  MOCDService.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 6/16/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation


class MOCDMaterialStatus: NSObject {
    
    var MaritalStatusId: String = ""
    var MStatusEn: String = ""
    var MStatusAr: String = ""
    
   
}
class MOCDQualification: NSObject {
    
    
    var QualificationId: String = ""
    var QualificationNameEn: String = ""
    var QualificationNameAr: String = ""
    
    
}
class MOCDAccommodation: NSObject {
    var AccommodationTypeId: String = ""
    var DisplayOrder: String = ""
    var AccommodationTypeAr: String = ""
    var AccommodationTypeEn: String = ""
    
}

class MOCDDisabilityAuthority: NSObject {
    
    var AuthId: String = ""
    var AuthTitleAr: String = ""
    var AuthTitleEn: String = ""
}
class MOCDDisabilityLevel: NSObject {
    var LevelId: String = ""
    var DisplayOrder: String = ""
    var LevelTitleEn: String = ""
    var LevelTitleAr: String = ""
    
  
}
class MOCDDisabilityType: NSObject {
    
    var TypeId: String = ""
    var TypeTitleAr: String = ""
    var TypeTitleEn: String = ""
    
}
class MOCDEquipment: NSObject {
   
    var EquipId: String = ""
    var EquipTitleAr: String = ""
    var EquipTitleEn: String = ""
  
}

class MOCDMaterialStatusSocial: NSObject {
    
    var MaritalStatusId: String = ""
    var MaritalStatusAR: String = ""
    var MaritalStatusEN: String = ""
   
}
class MOCDEducationSocial: NSObject {
    
    var EducationId: String = ""
    var EducationTitleAR: String = ""
    var EducationTitleEN: String = ""
   
}

class MOCDNationalitySocial: NSObject {
    var NationalityId: String = ""
    var NationalityTitleAR: String = ""
    var NationalityTitleEN: String = ""
    
}
class MOCDAccommodationSocial: NSObject {
    
    var AccommodationTypeId: String = ""
    var AccommodationTypeAR: String = ""
    var AccommodationTypeEN: String = ""
    
}
class MOCDOwnershipSocial: NSObject {
    var OwnershipTypeId: String = ""
    
    var DisplayOrder: String = ""
    var OwnershipTypeTitleAr: String = ""
    var OwnershipTypeTitleEn: String = ""

}

class MOCDPersonAccommodatedSocial: NSObject {
    
    var PersonsAccommodatedId: String = ""
    var DisplayOrder: String = ""
    var PersonsAccommodatedTitleEn: String = ""
    var PersonsAccommodatedTitleAr: String = ""
    
    
}
class MOCDHouseConditionSocial: NSObject {
    var ConditionId: String = ""
    var DisplayOrder: String = ""
    var ConditionTitleAr: String = ""
    var ConditionTitleEn: String = ""

}
