//
//  servicesRequest.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 6/30/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation

import AFNetworking
 import JGProgressHUD
import NotificationBannerSwift
import Alamofire


class servicesRequest {
    
    
    static func CreateDisabledCardRequest_ByObject(NationalityId:String ,IdentificationNo: String ,UID: String ,FirstNameAR:String ,FatherNameAR:String ,GrandfatherNameAR:String ,FamilyNameAR:String ,FirstNameEN:String ,FatherNameEN:String ,GrandfatherNameEN:String ,FamilyNameEN:String ,GenderId:String ,DateOfBirth:String ,IsStudent:String ,MaritalStatusId:String ,AccommodationTypeId:String ,Address:String ,EmirateId:String ,POBox:String ,MobileNo:String ,OtherMobileNo:String ,PhoneNo:String ,Email:String ,MakaniNo:String ,XCoord:String ,YCoord:String ,DiagnosisAuthorityId:String ,DiagnosisInformation:String , DisabilityTypeId:String ,DisabilityLevelId:String ,SupportingEquipment:String ,NeedSupporter:String ,CanLiveAlone:String ,ReportIssuedBy:String,Speciality:String ,ReportDate:String ,SecurityToken:String ,UserId:String ,ServiceDocTypeIds:String ,item: Gallery? ,view: UIView ,completation: @escaping ([String:Any] , NSMutableArray ,_ error: Error?)->Void ){
          
           
           
        let apiString = "CreateDisabledCardRequest_ByObject"
           
           
        let uploadURL = AppConstants.WEB_SERVER_MOCD_SERVICES_CARD_DEV + apiString
        
        var result = [String:Any]()
        
        let mocd_user = MOCDUser.getMOCDUser()
           
           
    
           
        var parametersArray: [String:Any]? = [:]
           
          
        
        parametersArray?["NationalityId"] = NationalityId
        
        parametersArray?["IdentificationNo"] = IdentificationNo
        
        parametersArray?["UID"] = UID
        
        parametersArray?["FirstNameAR"] = FirstNameAR
        
        parametersArray?["FatherNameAR"] = FatherNameAR
        
        parametersArray?["GrandfatherNameAR"] = GrandfatherNameAR
        
        parametersArray?["FamilyNameAR"] = FamilyNameAR
        
        parametersArray?["FirstNameEN"] = FirstNameEN
        
        parametersArray?["FatherNameEN"] = FatherNameEN
         
        parametersArray?["GrandfatherNameEN"] = GrandfatherNameEN
        
        parametersArray?["FamilyNameEN"] = FamilyNameEN
        
        parametersArray?["GenderId"] = GenderId
        
        parametersArray?["DateOfBirth"] = DateOfBirth
        
        parametersArray?["IsStudent"] = IsStudent
           
       
        parametersArray?["MaritalStatusId"] = MaritalStatusId
        
        parametersArray?["AccommodationTypeId"] = AccommodationTypeId
        
        parametersArray?["Address"] = Address
        
        parametersArray?["EmirateId"] = EmirateId
        
        parametersArray?["POBox"] = POBox
        
        parametersArray?["MobileNo"] = MobileNo
        
        parametersArray?["OtherMobileNo"] = OtherMobileNo
        
        parametersArray?["PhoneNo"] = PhoneNo
        
        parametersArray?["Email"] = Email
        
        parametersArray?["MakaniNo"] = MakaniNo
        
        parametersArray?["XCoord"] = XCoord
        
        parametersArray?["YCoord"] = YCoord
        
        parametersArray?["DiagnosisAuthorityId"] = DiagnosisAuthorityId
        
        parametersArray?["DiagnosisInformation"] = DiagnosisInformation
        
        parametersArray?["DisabilityTypeId"] = DisabilityTypeId
        
        parametersArray?["DisabilityLevelId"] = DisabilityLevelId
        
        parametersArray?["SupportingEquipment"] = SupportingEquipment
        
        parametersArray?["NeedSupporter"] = NeedSupporter
        
        parametersArray?["CanLiveAlone"] = CanLiveAlone
        
        parametersArray?["ReportIssuedBy"] = ReportIssuedBy
        
        parametersArray?["Speciality"] = Speciality
        
        
        parametersArray?["ReportDate"] = ReportDate
        
        parametersArray?["SecurityToken"] = SecurityToken
        
        parametersArray?["UserId"] = UserId
        
        parametersArray?["ServiceDocTypeIds"] = ServiceDocTypeIds
           
        let request = AFHTTPRequestSerializer().multipartFormRequest(withMethod: "POST", urlString: uploadURL, parameters: nil, constructingBodyWith: { (formData) in
             
            do {
               
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
         
             
            
            formData.appendPart(withForm: NationalityId.data(using: String.Encoding.utf8)!, name: "NationalityId")
            
            formData.appendPart(withForm: IdentificationNo.data(using: String.Encoding.utf8)!, name: "IdentificationNo")
            
            formData.appendPart(withForm: UID.data(using: String.Encoding.utf8)!, name: "UID")
            
            formData.appendPart(withForm: FirstNameAR.data(using: String.Encoding.utf8)!, name: "FirstNameAR")
            
            formData.appendPart(withForm: FatherNameAR.data(using: String.Encoding.utf8)!, name: "FatherNameAR")
            
            formData.appendPart(withForm: GrandfatherNameAR.data(using: String.Encoding.utf8)!, name: "GrandfatherNameAR")
            
            formData.appendPart(withForm: FamilyNameAR.data(using: String.Encoding.utf8)!, name: "FamilyNameAR")
            
            formData.appendPart(withForm: FirstNameEN.data(using: String.Encoding.utf8)!, name: "FirstNameEN")
            
            formData.appendPart(withForm: FatherNameEN.data(using: String.Encoding.utf8)!, name: "FatherNameEN")
               
            formData.appendPart(withForm: GrandfatherNameEN.data(using: String.Encoding.utf8)!, name: "GrandfatherNameEN")
            
            formData.appendPart(withForm: FamilyNameEN.data(using: String.Encoding.utf8)!, name: "FamilyNameEN")
            
            formData.appendPart(withForm: GenderId.data(using: String.Encoding.utf8)!, name: "GenderId")
            
            formData.appendPart(withForm: DateOfBirth.data(using: String.Encoding.utf8)!, name: "DateOfBirth")
            
            
            formData.appendPart(withForm: IsStudent.data(using: String.Encoding.utf8)!, name: "IsStudent")
            
            formData.appendPart(withForm: MaritalStatusId.data(using: String.Encoding.utf8)!, name: "MaritalStatusId")
            
            formData.appendPart(withForm: AccommodationTypeId.data(using: String.Encoding.utf8)!, name: "AccommodationTypeId")
            
            formData.appendPart(withForm: Address.data(using: String.Encoding.utf8)!, name: "Address")
            
            
            formData.appendPart(withForm: EmirateId.data(using: String.Encoding.utf8)!, name: "EmirateId")
            
            formData.appendPart(withForm: POBox.data(using: String.Encoding.utf8)!, name: "POBox")
            
            formData.appendPart(withForm: MobileNo.data(using: String.Encoding.utf8)!, name: "MobileNo")
            
            formData.appendPart(withForm: OtherMobileNo.data(using: String.Encoding.utf8)!, name: "OtherMobileNo")
            
            formData.appendPart(withForm: PhoneNo.data(using: String.Encoding.utf8)!, name: "PhoneNo")
            
            formData.appendPart(withForm: Email.data(using: String.Encoding.utf8)!, name: "Email")
            
            formData.appendPart(withForm: MakaniNo.data(using: String.Encoding.utf8)!, name: "MakaniNo")
            
            formData.appendPart(withForm: XCoord.data(using: String.Encoding.utf8)!, name: "XCoord")
            
            formData.appendPart(withForm: YCoord.data(using: String.Encoding.utf8)!, name: "YCoord")
            formData.appendPart(withForm: DiagnosisAuthorityId.data(using: String.Encoding.utf8)!, name: "DiagnosisAuthorityId")
            
            
            formData.appendPart(withForm: DiagnosisInformation.data(using: String.Encoding.utf8)!, name: "DiagnosisInformation")
            formData.appendPart(withForm: DisabilityTypeId.data(using: String.Encoding.utf8)!, name: "DisabilityTypeId")
            
            formData.appendPart(withForm: DisabilityLevelId.data(using: String.Encoding.utf8)!, name: "DisabilityLevelId")
            formData.appendPart(withForm: SupportingEquipment.data(using: String.Encoding.utf8)!, name: "SupportingEquipment")
            formData.appendPart(withForm: NeedSupporter.data(using: String.Encoding.utf8)!, name: "NeedSupporter")
            formData.appendPart(withForm: CanLiveAlone.data(using: String.Encoding.utf8)!, name: "CanLiveAlone")
            formData.appendPart(withForm: ReportIssuedBy.data(using: String.Encoding.utf8)!, name: "ReportIssuedBy")
            formData.appendPart(withForm: Speciality.data(using: String.Encoding.utf8)!, name: "Speciality")
            formData.appendPart(withForm: ReportDate.data(using: String.Encoding.utf8)!, name: "ReportDate")
            
            formData.appendPart(withForm: SecurityToken.data(using: String.Encoding.utf8)!, name: "SecurityToken")
            formData.appendPart(withForm: UserId.data(using: String.Encoding.utf8)!, name: "UserId")
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
