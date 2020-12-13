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

class MOCDInstitute: NSObject {
    
    
    var InstituteId: String = ""
    var InstituteNameEn: String = ""
    var InstituteNameAr: String = ""
    
    
}

class MOCDWorkField: NSObject {
    
    
    var WorkFieldId: String = ""
    var DisplayOrder: String = ""
    var WorkFieldNameEn: String = ""
    var WorkFieldNameAr: String = ""
    
    
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

class MOCDRelationshipSocial: NSObject {
    
    var RelationshipTypeId: String = ""
    var RelationshipTypeAR: String = ""
    var RelationshipTypeEN: String = ""
   
}

class MOCDGenderSocial: NSObject {
    
    var GenderId: String = ""
    var GenderTitleAR: String = ""
    var GenderTitleEN: String = ""
   
}

class MOCDNationalitySocial: NSObject {
    var NationalityId: String = ""
    var NationalityTitleAR: String = ""
    var NationalityTitleEN: String = ""
    
}

class MOCDIncomeSource: NSObject {
    var IncomeSourceTypeId: String = ""
    var IncomeSourceTypeAR: String = ""
    var IncomeSourceTypeEN: String = ""
    
   
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


class MOCDDiseaseSocial: NSObject {
    var DiseaseTypeId: String = ""
    
    var DiseaseTypeAR: String = ""
    var DiseaseTypeEN: String = ""
   

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
class MOCDLetterType: NSObject {
 
    var ID: String = ""
    var OFFICIAL_LETTER_TYPE_AR: String = ""
    var OFFICIAL_LETTER_TYPE_EN: String = ""
    
}
class MOCDLostRequestType: NSObject {
    
    var RequestTypeId: String = ""
    var RequestTypeNameEN: String = ""
    var RequestTypeNameAR: String = ""
 
   
}
class MOCDEducationLevelMaster: NSObject {
    
    var Id: String  = ""
    var Name: String  = ""
    var NameinArabic: String  = ""
    var ICA_ID: String  = ""
    
    
}
class MOCDReceivedDocumen: NSObject {
    var ServiceDocTypeId: String = ""
    var DocumentName: String = ""
    var DocumentLength: String = ""
    var DocumentContents: String = ""
    var DocumentContentType: String = ""
    var documentURL: URL?
    
    
}
