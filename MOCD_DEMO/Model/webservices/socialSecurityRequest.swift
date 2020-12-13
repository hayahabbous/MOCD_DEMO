//
//  socialSecurityRequest.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 8/17/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation


import AFNetworking
 import JGProgressHUD
import NotificationBannerSwift
import Alamofire


class socialSecurityRequest {
    
    
    static func CreateFinancialAssistanceRequest(AccommodationTypeId:String ,
                                                 EmirateId: String ,
                                                 Area: String ,
                                                 CenterId:String ,
                                                 CaseReason:String ,
                                                 NationalId:String ,
                                                 NationalIdIssueDate:String ,
                                                 NationalIdExpiryDate:String ,
                                                 ApplicantNameAR:String ,
                                                 ApplicantNameEN:String ,
                                                 FamilyNo:String ,
                                                 TownNo:String ,
                                                 DateOfBirth:String ,
                                                 GenderId:String ,
                                                 MaritalStatusId:String ,
                                                 EducationId:String ,
                                                 NationalityId2:String ,
                                                 Occupation:String ,
                                                 EmailAddress:String ,
                                                 MotherNameAR:String ,
                                                 PhoneNo:String ,
                                                 MobileNo:String ,
                                                 PassportNo:String ,
                                                 PassportIssueDate:String ,
                                                 PassportIssuePlace:String ,
                                                 PassportIssuePlaceId:String ,
                                                 PassportExpiryDate:String ,
                                                 ImmigrationNo:String ,
                                                 OwnershipTypeId:String ,
                                                 NoOfRooms:String ,
                                                 NoOfPersons:String ,
                                                 PersonsAccommodatedId:String ,
                                                 ConditionId:String ,
                                                 Latitude:String,
                                                 Longitude:String ,
                                                 MakaniNo:String ,
                                                 membersObject:NSMutableArray ,
                                                 incomesObject:NSMutableArray ,
                                                 userId: String ,
                                                 ServiceDocTypeIds:String ,
                                                 filesArray: [URL],
                                                 item: Gallery? ,
                                                 view: UIView ,
                                                 completation: @escaping ([String:Any] , NSMutableArray ,_ error: Error?)->Void ){
          
           
           
        let apiString = "CreateFinancialAssistanceRequest"
           
           
        let uploadURL = AppConstants.WEB_SERVER_MOCD_SERVICES_SOCIAL_DEV + apiString
        
        var result = [String:Any]()
        
        let mocd_user = MOCDUser.getMOCDUser()
           
           
    
        
        guard let incomeJson = try? JSONSerialization.data(withJSONObject: incomesObject, options: []) else {return }
        
        guard let incomeString = String(data: incomeJson, encoding: String.Encoding.utf8) else {return}
        
        
        guard let memberJson = try? JSONSerialization.data(withJSONObject: membersObject, options: []) else {return }
        
        guard let memberString = String(data: memberJson, encoding: String.Encoding.utf8) else {return}
        
        
           
        var parametersArray: [String:Any]? = [:]
           
          
        
        parametersArray?["AccommodationTypeId"] = AccommodationTypeId
        parametersArray?["EmirateId"] = EmirateId
        parametersArray?["Area"] = Area
        parametersArray?["CenterId"] = CenterId
        parametersArray?["CaseReason"] = CaseReason
        parametersArray?["NationalId"] = NationalId
        parametersArray?["NationalIdIssueDate"] = NationalIdIssueDate
        parametersArray?["NationalIdExpiryDate"] = NationalIdExpiryDate
        parametersArray?["ApplicantNameAR"] = ApplicantNameAR
        parametersArray?["ApplicantNameEN"] = ApplicantNameEN
        parametersArray?["FamilyNo"] = FamilyNo
        parametersArray?["TownNo"] = TownNo
        parametersArray?["DateOfBirth"] = DateOfBirth
        parametersArray?["GenderId"] = GenderId
        parametersArray?["MaritalStatusId"] = MaritalStatusId
        parametersArray?["EducationId"] = EducationId
        parametersArray?["NationalityId"] = NationalityId2
        parametersArray?["Occupation"] = Occupation
        parametersArray?["EmailAddress"] = EmailAddress
        parametersArray?["MotherNameAR"] = MotherNameAR
        parametersArray?["PhoneNo"] = PhoneNo
        parametersArray?["MobileNo"] = MobileNo
        parametersArray?["PassportNo"] = PassportNo
        parametersArray?["PassportIssueDate"] = PassportIssueDate
        parametersArray?["PassportIssuePlace"] = PassportIssuePlace
        parametersArray?["PassportIssuePlaceId"] = PassportIssuePlaceId
        parametersArray?["PassportExpiryDate"] = PassportExpiryDate
        parametersArray?["ImmigrationNo"] = ImmigrationNo
        parametersArray?["OwnershipTypeId"] = OwnershipTypeId
        parametersArray?["NoOfRooms"] = NoOfRooms
        parametersArray?["NoOfPersons"] = NoOfPersons
        parametersArray?["PersonsAccommodatedId"] = PersonsAccommodatedId
        parametersArray?["ConditionId"] = ConditionId
        parametersArray?["Latitude"] = Latitude
        parametersArray?["Longitude"] = Longitude
        parametersArray?["MakaniNo"] = MakaniNo
        parametersArray?["membersObject"] = memberString
        
        parametersArray?["incomesObject"] = incomeString
        parametersArray?["userId"] = userId
        parametersArray?["ServiceDocTypeIds"] = ServiceDocTypeIds

 
        
           print(parametersArray)
        let request = AFHTTPRequestSerializer().multipartFormRequest(withMethod: "POST", urlString: uploadURL, parameters: nil, constructingBodyWith: { (formData) in
             
            do {
               
                
                for url in filesArray {
                    try formData.appendPart(withFileURL: url, name: "", fileName: url.lastPathComponent, mimeType: "")
                }
                  /*
                if item?.path.count >  0 {
                
                    var theURL = URL(string: item?.path)
                    
                    if !theURL!.isFileURL {
                    
                        theURL = URL(fileURLWithPath: item.path)
                       
                    }
                       //let uploadURL = AppConstants.FILE_UPLOAD_BASE_URL + WebServiceRequests.uploadRequest.rawValue
                   
                    
                       
                    
                    let data = FileManager.default.contents(atPath: item?.path)
                       
                       
                    
                    if(data == nil)
                    
                    {
                    
                        print("data not found to upload")
                     
                    }
                       
                       
                    
                    try formData.appendPart(withFileURL: theURL!, name: "file", fileName: item.name.lowercased(), mimeType: item.type)
                 
                }else{
                
                    //formData.appendPart(withForm: "".data(using: String.Encoding.utf8)!, name: "file")
                  
                }
                  */
                   
              
            }
            
            catch {
            
                print("error appending file data: \(error)")
               
            }
         
         

          
      
        
      
           
   
            formData.appendPart(withForm: AccommodationTypeId.data(using: String.Encoding.utf8)!, name: "AccommodationTypeId")
            
            formData.appendPart(withForm: EmirateId.data(using: String.Encoding.utf8)!, name: "EmirateId")
            
            formData.appendPart(withForm: Area.data(using: String.Encoding.utf8)!, name: "Area")
            
            formData.appendPart(withForm: CenterId.data(using: String.Encoding.utf8)!, name: "CenterId")
            
            formData.appendPart(withForm: CaseReason.data(using: String.Encoding.utf8)!, name: "CaseReason")
            
            formData.appendPart(withForm: NationalId.data(using: String.Encoding.utf8)!, name: "NationalId")
            
            formData.appendPart(withForm: NationalIdIssueDate.data(using: String.Encoding.utf8)!, name: "NationalIdIssueDate")
            
            formData.appendPart(withForm: NationalIdExpiryDate.data(using: String.Encoding.utf8)!, name: "NationalIdExpiryDate")
            
            formData.appendPart(withForm: ApplicantNameAR.data(using: String.Encoding.utf8)!, name: "ApplicantNameAR")
               
            formData.appendPart(withForm: ApplicantNameEN.data(using: String.Encoding.utf8)!, name: "ApplicantNameEN")
            
            formData.appendPart(withForm: FamilyNo.data(using: String.Encoding.utf8)!, name: "FamilyNo")
            
            formData.appendPart(withForm: TownNo.data(using: String.Encoding.utf8)!, name: "TownNo")
            
            formData.appendPart(withForm: DateOfBirth.data(using: String.Encoding.utf8)!, name: "DateOfBirth")
            
            formData.appendPart(withForm: GenderId.data(using: String.Encoding.utf8)!, name: "GenderId")
            formData.appendPart(withForm: MaritalStatusId.data(using: String.Encoding.utf8)!, name: "MaritalStatusId")
            formData.appendPart(withForm: EducationId.data(using: String.Encoding.utf8)!, name: "EducationId")
            formData.appendPart(withForm: NationalityId2.data(using: String.Encoding.utf8)!, name: "NationalityId")
            formData.appendPart(withForm: Occupation.data(using: String.Encoding.utf8)!, name: "Occupation")
            formData.appendPart(withForm: EmailAddress.data(using: String.Encoding.utf8)!, name: "EmailAddress")
            
            
            formData.appendPart(withForm: MotherNameAR.data(using: String.Encoding.utf8)!, name: "MotherNameAR")
            formData.appendPart(withForm: PhoneNo.data(using: String.Encoding.utf8)!, name: "PhoneNo")
            formData.appendPart(withForm: MobileNo.data(using: String.Encoding.utf8)!, name: "MobileNo")
            formData.appendPart(withForm: PassportNo.data(using: String.Encoding.utf8)!, name: "PassportNo")
            formData.appendPart(withForm: PassportIssueDate.data(using: String.Encoding.utf8)!, name: "PassportIssueDate")
            formData.appendPart(withForm: PassportIssuePlace.data(using: String.Encoding.utf8)!, name: "PassportIssuePlace")
            formData.appendPart(withForm: PassportIssuePlaceId.data(using: String.Encoding.utf8)!, name: "PassportIssuePlaceId")
            formData.appendPart(withForm: PassportExpiryDate.data(using: String.Encoding.utf8)!, name: "PassportExpiryDate")
            
            formData.appendPart(withForm: ImmigrationNo.data(using: String.Encoding.utf8)!, name: "ImmigrationNo")
            formData.appendPart(withForm: OwnershipTypeId.data(using: String.Encoding.utf8)!, name: "OwnershipTypeId")
            formData.appendPart(withForm: NoOfRooms.data(using: String.Encoding.utf8)!, name: "NoOfRooms")
            formData.appendPart(withForm: NoOfPersons.data(using: String.Encoding.utf8)!, name: "NoOfPersons")
            formData.appendPart(withForm: PersonsAccommodatedId.data(using: String.Encoding.utf8)!, name: "PersonsAccommodatedId")
            
            formData.appendPart(withForm: ConditionId.data(using: String.Encoding.utf8)!, name: "ConditionId")
            
            formData.appendPart(withForm: Latitude.data(using: String.Encoding.utf8)!, name: "Latitude")
            
            
            formData.appendPart(withForm: Longitude.data(using: String.Encoding.utf8)!, name: "Longitude")
            
            formData.appendPart(withForm: MakaniNo.data(using: String.Encoding.utf8)!, name: "MakaniNo")
            
            formData.appendPart(withForm: memberString.data(using: String.Encoding.utf8)!, name: "membersObject")
            
            formData.appendPart(withForm: incomeString.data(using: String.Encoding.utf8)!, name: "incomesObject")
            
            formData.appendPart(withForm: userId.data(using: String.Encoding.utf8)!, name: "userId")
            
            
            
            
            formData.appendPart(withForm: ServiceDocTypeIds.data(using: String.Encoding.utf8)!, name: "ServiceDocTypeIds")
            
            
            
               
               
              
            
            print(formData)
           
        }, error: nil)
        
        let sessionManager = AFURLSessionManager(sessionConfiguration: URLSessionConfiguration.default)
           
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let reachable = appDelegate.reach
        
        if reachable!.connection == .wifi || reachable!.connection == .cellular {
            let hud = JGProgressHUD(style: .light)
                         
            hud.indicatorView = JGProgressHUDPieIndicatorView()
            
            hud.detailTextLabel.text = "0% Complete"
            
            hud.textLabel.text = "Uploading"
                          
            
            DispatchQueue.main.async {
            
                hud.show(in: view)
                
                // banner.show(queuePosition: QueuePosition.front, bannerPosition: BannerPosition.top)
                              
                
            }
               
              
              
            var mocd_user = MOCDUser.getMOCDUser()
            
            request.allHTTPHeaderFields = ["DToken":"6RGT36D10Q637059759964359851B1I1" ,"UserToken":"\(mocd_user?.userToken ?? "")" ,
            ]
              
            
            let task = sessionManager.uploadTask(withStreamedRequest: request as URLRequest, progress: { (progress) in
                 
                DispatchQueue.main.async {
                
                    ProgressHelper.incrementHUD(hud, progress: (Int(progress.fractionCompleted * 100)), withView: view)
                    
                    //customeView.progressView.progress = Float(CGFloat(progress.fractionCompleted) )
                    
                    //customeView.label.text = "\((Int(progress.fractionCompleted * 100)))% Completed"
                    
                    //customeView.imageView.image = #imageLiteral(resourceName: "male_profile_picture.png")
                   
                
                }
                   
                
                print(progress.fractionCompleted)
                   
             
            }) { (response, data, error) in
                   
            
                if error != nil {
                
                    DispatchQueue.main.async {
                           
                           //banner.dismiss()
                   
                        hud.dismiss(afterDelay: 1.0)
                        
                        
                        
                        completation([String:Any](),NSMutableArray() ,error)
                       
                    }
                  
                }else{
                       
                       /*
                       print("responce: \(data)")
                       
                       
                       let res = data as? [String:Any]
                       let code = res!["code"] as? String
                       
                   
                       let datares = res!["data"] as! [Any]
                       let photosArray = NSMutableArray()
                       
                       let message = res!["message"] as? String*/
                       
                    print("responce: \(data)")
                    
                    let photosArray = NSMutableArray()
                     
                    
                    DispatchQueue.main.async {
                           
                           //banner.dismiss()
                    
                        hud.dismiss(afterDelay: 1.0)
                           
                        
                        completation(data as! [String:Any],photosArray,error)
                       
                    }
                   
                }
               
            }
             
               
            task.resume()
            
            //semaphore.wait()
            
            print(result)
            
            //completation(result)
           
        }else{
        
            DispatchQueue.main.async {
                   
            
                //banner.dismiss()
                
                ProgressHelper.showSimpleHUD(withView: view, text: "no internet connection")
               
            }
               
             
            print("no internet connection")
          
            completation([String:Any](),NSMutableArray() , nil )
           
        }
           
           
       
    }
}
