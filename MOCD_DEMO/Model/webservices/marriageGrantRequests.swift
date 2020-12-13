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


class marriageGrantRequests {
    
    static func SubmitGrantRequest(HusbandNationalId:String ,WifeNationalId: String ,MarriageContractDate: String ,Court:String ,EmployerCategory:String ,HusbandFullNameArabic:String ,HusbandFullNameEnglish:String ,HusbandBirthDate:String ,HusbandEducationLevel:String ,HusbandMobile1:String
        ,HusbandMobile2:String ,HusbandEmail:String ,WifeFullNameArabic:String
        ,WifeFullNameEnglish:String,WifeBirthDate:String ,WifeEducationLevel:String ,WifeMobile1:String,WifeEmail:String,FamilyBookNumber:String,TownNumber:String,FamilyNumber:String,FamilyBookIssueDate:String,FamilyBookIssuePlace:String,Employer:String,WorkPlace:String,Totalmonthlyincome:String,BankName:String,IBAN:String,item:Gallery?,view: UIView ,completation: @escaping ([String:Any] , NSMutableArray ,_ error: Error?)->Void ){
           
           
        let apiString = "Services/SubmitGrantRequest"
           
           
        let uploadURL = AppConstants.WEB_SERVER_MOCD_SERVICES_SOCIAL_DEV + apiString
        
        var result = [String:Any]()
        
        let mocd_user = MOCDUser.getMOCDUser()
           
           
    
           
        var parametersArray: [String:Any]? = [:]
           
          
        
        parametersArray?["HusbandNationalId"] = HusbandNationalId
        
        parametersArray?["WifeNationalId"] = WifeNationalId
        
        parametersArray?["MarriageContractDate"] = MarriageContractDate
        
        parametersArray?["Court"] = Court
        
        parametersArray?["EmployerCategory"] = EmployerCategory
        
        parametersArray?["HusbandFullNameArabic"] = HusbandFullNameArabic
        
        parametersArray?["HusbandFullNameEnglish"] = HusbandFullNameEnglish
        
        parametersArray?["HusbandBirthDate"] = HusbandBirthDate
        
        parametersArray?["HusbandEducationLevel"] = HusbandEducationLevel
         
        parametersArray?["HusbandMobile1"] = HusbandMobile1
        
        parametersArray?["HusbandMobile2"] = HusbandMobile2
        
        parametersArray?["HusbandEmail"] = HusbandEmail
        
        parametersArray?["WifeFullNameArabic"] = WifeFullNameArabic
    
        
        parametersArray?["WifeFullNameEnglish"] = WifeFullNameEnglish
        
        parametersArray?["WifeBirthDate"] = WifeBirthDate
        
        parametersArray?["WifeEducationLevel"] = WifeEducationLevel
        
        parametersArray?["WifeMobile1"] = WifeMobile1
        
        parametersArray?["WifeEmail"] = WifeEmail
        
        parametersArray?["FamilyBookNumber"] = FamilyBookNumber
         
        parametersArray?["TownNumber"] = TownNumber
        
        parametersArray?["FamilyNumber"] = FamilyNumber
        
        parametersArray?["HusbandEmail"] = HusbandEmail
        
        parametersArray?["FamilyBookIssueDate"] = FamilyBookIssueDate
        
        parametersArray?["FamilyBookIssuePlace"] = FamilyBookIssuePlace
        
        parametersArray?["Employer"] = Employer
        
        parametersArray?["WorkPlace"] = WorkPlace
        
        parametersArray?["Totalmonthlyincome"] = Totalmonthlyincome
        
        parametersArray?["BankName"] = BankName
        
        parametersArray?["IBAN"] = IBAN
         
        parametersArray?["TypeOfRequest"] = AppConstants.TypeOfRequestGrantRequestDEV
        
        parametersArray?["RequestingService"] = AppConstants.RequestingServiceGrantRequestDEV
           
        parametersArray?["ChannelType"] = AppConstants.ChannelType
        
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
         
             
            
            formData.appendPart(withForm: HusbandNationalId.data(using: String.Encoding.utf8)!, name: "HusbandNationalId")
            
            formData.appendPart(withForm: WifeNationalId.data(using: String.Encoding.utf8)!, name: "WifeNationalId")
            
            formData.appendPart(withForm: MarriageContractDate.data(using: String.Encoding.utf8)!, name: "MarriageContractDate")
            
            formData.appendPart(withForm: Court.data(using: String.Encoding.utf8)!, name: "Court")
            
            formData.appendPart(withForm: EmployerCategory.data(using: String.Encoding.utf8)!, name: "EmployerCategory")
            
            formData.appendPart(withForm: HusbandFullNameArabic.data(using: String.Encoding.utf8)!, name: "HusbandFullNameArabic")
            
            formData.appendPart(withForm: HusbandFullNameEnglish.data(using: String.Encoding.utf8)!, name: "HusbandFullNameEnglish")
            
            formData.appendPart(withForm: HusbandBirthDate.data(using: String.Encoding.utf8)!, name: "HusbandBirthDate")
            
            formData.appendPart(withForm: HusbandEducationLevel.data(using: String.Encoding.utf8)!, name: "HusbandEducationLevel")
               
            formData.appendPart(withForm: HusbandMobile1.data(using: String.Encoding.utf8)!, name: "HusbandMobile1")
            
            formData.appendPart(withForm: HusbandMobile2.data(using: String.Encoding.utf8)!, name: "HusbandMobile2")
            
            formData.appendPart(withForm: HusbandEmail.data(using: String.Encoding.utf8)!, name: "HusbandEmail")
            
            formData.appendPart(withForm: WifeFullNameArabic.data(using: String.Encoding.utf8)!, name: "WifeFullNameArabic")
            
            formData.appendPart(withForm: WifeFullNameEnglish.data(using: String.Encoding.utf8)!, name: "WifeFullNameEnglish")
            
            formData.appendPart(withForm: WifeBirthDate.data(using: String.Encoding.utf8)!, name: "WifeBirthDate")
            
            formData.appendPart(withForm: WifeEducationLevel.data(using: String.Encoding.utf8)!, name: "WifeEducationLevel")
               
            formData.appendPart(withForm: WifeMobile1.data(using: String.Encoding.utf8)!, name: "WifeMobile1")
            
            formData.appendPart(withForm: WifeEmail.data(using: String.Encoding.utf8)!, name: "WifeEmail")
            
            formData.appendPart(withForm: FamilyBookNumber.data(using: String.Encoding.utf8)!, name: "FamilyBookNumber")
            
            formData.appendPart(withForm: TownNumber.data(using: String.Encoding.utf8)!, name: "TownNumber")
            
            formData.appendPart(withForm: FamilyNumber.data(using: String.Encoding.utf8)!, name: "FamilyNumber")
            
            formData.appendPart(withForm: FamilyBookIssueDate.data(using: String.Encoding.utf8)!, name: "FamilyBookIssueDate")
            
            formData.appendPart(withForm: FamilyBookIssuePlace.data(using: String.Encoding.utf8)!, name: "FamilyBookIssuePlace")
            
            formData.appendPart(withForm: Employer.data(using: String.Encoding.utf8)!, name: "Employer")
               
            formData.appendPart(withForm: WorkPlace.data(using: String.Encoding.utf8)!, name: "WorkPlace")
            
            formData.appendPart(withForm: Totalmonthlyincome.data(using: String.Encoding.utf8)!, name: "Totalmonthlyincome")
            
            formData.appendPart(withForm: BankName.data(using: String.Encoding.utf8)!, name: "BankName")
            
            formData.appendPart(withForm: IBAN.data(using: String.Encoding.utf8)!, name: "IBAN")
            
            formData.appendPart(withForm: AppConstants.TypeOfRequestGrantRequestDEV.data(using: String.Encoding.utf8)!, name: "TypeOfRequest")
            
            formData.appendPart(withForm: AppConstants.RequestingServiceGrantRequestDEV.data(using: String.Encoding.utf8)!, name: "RequestingService")
            
            formData.appendPart(withForm: AppConstants.ChannelType.data(using: String.Encoding.utf8)!, name: "ChannelType")
            
            
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
    
    
    static func SubmitMassWeddingRequest(HusbandNationalId:String ,WifeNationalId: String ,MarriageContractDate: String ,Court:String,HusbandFullNameArabic:String,HusbandFullNameEnglish:String,HusbandBirthDate:String,HusbandEducationLevel:String,HusbandMobile1:String,HusbandMobile2:String,HusbandEmail:String,WifeFullNameArabic:String,WifeFullNameEnglish:String,WifeBirthDate:String,WifeEducationLevel:String,WifeMobile1:String,WifeEmail:String,FamilyBookIssuePlace:String ,ReasonForNotRecievinggrant:String ,item: Gallery? ,view: UIView ,completation: @escaping ([String:Any] , NSMutableArray ,_ error: Error?)->Void ){
          
        let apiString = "Services/SubmitMassWeddingRequest"
           
           
        let uploadURL = AppConstants.WEB_SERVER_MOCD_MARRIAGE_GRANT_DEV_SERVICE + apiString
        
        var result = [String:Any]()
        
        let mocd_user = MOCDUser.getMOCDUser()
        
           
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
            
            var parametersArray: [String:Any]? = [:]
 
                parametersArray?["HusbandNationalId"] = HusbandNationalId
                
                parametersArray?["WifeNationalId"] = WifeNationalId
                
                parametersArray?["MarriageContractDate"] = MarriageContractDate
                
                parametersArray?["Court"] = Court
                
                parametersArray?["HusbandFullNameArabic"] = HusbandFullNameArabic
                
                parametersArray?["HusbandFullNameEnglish"] = HusbandFullNameEnglish
                
                parametersArray?["HusbandBirthDate"] = HusbandBirthDate
                
                parametersArray?["HusbandEducationLevel"] = HusbandEducationLevel
                
                parametersArray?["HusbandMobile1"] = HusbandMobile1
                 
                parametersArray?["HusbandMobile2"] = HusbandMobile2
                
                parametersArray?["HusbandEmail"] = HusbandEmail
                
                parametersArray?["WifeFullNameArabic"] = WifeFullNameArabic
                
                parametersArray?["WifeFullNameEnglish"] = WifeFullNameEnglish
            
                
                parametersArray?["WifeBirthDate"] = WifeBirthDate
                
                parametersArray?["WifeEducationLevel"] = WifeEducationLevel
                
                parametersArray?["WifeMobile1"] = WifeMobile1
                
                parametersArray?["WifeEmail"] = WifeEmail
                
                parametersArray?["FamilyBookIssuePlace"] = FamilyBookIssuePlace
            
                parametersArray?["ReasonForNotRecievinggrant"] = ReasonForNotRecievinggrant
                 
                parametersArray?["TypeOfRequest"] = AppConstants.TypeOfRequestMassWeddingDEV
                
                parametersArray?["RequestingService"] = AppConstants.RequestingServiceMassWeddingDEV
                   
                parametersArray?["ChannelType"] = AppConstants.ChannelType
         
            formData.appendPart(withForm: HusbandNationalId.data(using: String.Encoding.utf8)!, name: "HusbandNationalId")
            
            formData.appendPart(withForm: WifeNationalId.data(using: String.Encoding.utf8)!, name: "WifeNationalId")
            
            formData.appendPart(withForm: MarriageContractDate.data(using: String.Encoding.utf8)!, name: "MarriageContractDate")
            
            formData.appendPart(withForm: Court.data(using: String.Encoding.utf8)!, name: "Court")
            
            formData.appendPart(withForm: HusbandFullNameArabic.data(using: String.Encoding.utf8)!, name: "HusbandFullNameArabic")
            
            
            formData.appendPart(withForm: HusbandFullNameEnglish.data(using: String.Encoding.utf8)!, name: "HusbandFullNameEnglish")
            
            formData.appendPart(withForm: HusbandBirthDate.data(using: String.Encoding.utf8)!, name: "HusbandBirthDate")
            
            formData.appendPart(withForm: HusbandEducationLevel.data(using: String.Encoding.utf8)!, name: "HusbandEducationLevel")
            
            formData.appendPart(withForm: HusbandMobile1.data(using: String.Encoding.utf8)!, name: "HusbandMobile1")
            
            formData.appendPart(withForm: HusbandMobile2.data(using: String.Encoding.utf8)!, name: "HusbandMobile2")
            formData.appendPart(withForm: HusbandEmail.data(using: String.Encoding.utf8)!, name: "HusbandEmail")
            
            formData.appendPart(withForm: WifeFullNameArabic.data(using: String.Encoding.utf8)!, name: "WifeFullNameArabic")
            
            formData.appendPart(withForm: WifeFullNameEnglish.data(using: String.Encoding.utf8)!, name: "WifeFullNameEnglish")
            
            formData.appendPart(withForm: WifeBirthDate.data(using: String.Encoding.utf8)!, name: "WifeBirthDate")
            
            formData.appendPart(withForm: WifeEducationLevel.data(using: String.Encoding.utf8)!, name: "WifeEducationLevel")
            formData.appendPart(withForm: WifeMobile1.data(using: String.Encoding.utf8)!, name: "WifeMobile1")
            
            formData.appendPart(withForm: WifeEmail.data(using: String.Encoding.utf8)!, name: "WifeEmail")
            
            formData.appendPart(withForm: FamilyBookIssuePlace.data(using: String.Encoding.utf8)!, name: "FamilyBookIssuePlace")
                        
            formData.appendPart(withForm: ReasonForNotRecievinggrant.data(using: String.Encoding.utf8)!, name: "ReasonForNotRecievinggrant")
            
            formData.appendPart(withForm: AppConstants.TypeOfRequestMassWeddingDEV.data(using: String.Encoding.utf8)!, name: "TypeOfRequest")
            
            formData.appendPart(withForm: AppConstants.RequestingServiceMassWeddingDEV.data(using: String.Encoding.utf8)!, name: "RequestingService")
            
            formData.appendPart(withForm: AppConstants.ChannelType.data(using: String.Encoding.utf8)!, name: "ChannelType")
            
            
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
                "Authorization":"Bearer 91931889-3db3-4694-a07b-61f5a4dea865"
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
    
    static func SubmitEdaadRequest(HusbandNationalId:String ,WifeNationalId: String ,MarriageContractDate: String ,Court:String,HusbandFullNameArabic:String,HusbandFullNameEnglish:String,HusbandBirthDate:String,HusbandEducationLevel:String,HusbandMobile1:String,HusbandMobile2:String,HusbandEmail:String,WifeFullNameArabic:String,WifeFullNameEnglish:String,WifeBirthDate:String,WifeEducationLevel:String,WifeMobile1:String,WifeEmail:String,FamilyBookIssuePlace:String ,item: Gallery? ,view: UIView ,completation: @escaping ([String:Any] , NSMutableArray ,_ error: Error?)->Void ){
          
        let apiString = "Services/SubmitEdaadRequest"
           
           
        let uploadURL = AppConstants.WEB_SERVER_MOCD_MARRIAGE_GRANT_DEV_SERVICE + apiString
        
        var result = [String:Any]()
        
        let mocd_user = MOCDUser.getMOCDUser()
        
           
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
            
            var parametersArray: [String:Any]? = [:]
            
                           parametersArray?["HusbandNationalId"] = HusbandNationalId
                           
                           parametersArray?["WifeNationalId"] = WifeNationalId
                           
                           parametersArray?["MarriageContractDate"] = MarriageContractDate
                           
                           parametersArray?["Court"] = Court
                           
                           parametersArray?["HusbandFullNameArabic"] = HusbandFullNameArabic
                           
                           parametersArray?["HusbandFullNameEnglish"] = HusbandFullNameEnglish
                           
                           parametersArray?["HusbandBirthDate"] = HusbandBirthDate
                           
                           parametersArray?["HusbandEducationLevel"] = HusbandEducationLevel
                           
                           parametersArray?["HusbandMobile1"] = HusbandMobile1
                            
                           parametersArray?["HusbandMobile2"] = HusbandMobile2
                           
                           parametersArray?["HusbandEmail"] = HusbandEmail
                           
                           parametersArray?["WifeFullNameArabic"] = WifeFullNameArabic
                           
                           parametersArray?["WifeFullNameEnglish"] = WifeFullNameEnglish
                       
                           
                           parametersArray?["WifeBirthDate"] = WifeBirthDate
                           
                           parametersArray?["WifeEducationLevel"] = WifeEducationLevel
                           
                           parametersArray?["WifeMobile1"] = WifeMobile1
                           
                           parametersArray?["WifeEmail"] = WifeEmail
                           
                           parametersArray?["FamilyBookIssuePlace"] = FamilyBookIssuePlace
                                                   
                           parametersArray?["TypeOfRequest"] = AppConstants.TypeOfRequestMassWeddingDEV
                           
                           parametersArray?["RequestingService"] = AppConstants.RequestingServiceMassWeddingDEV
                              
                           parametersArray?["ChannelType"] = AppConstants.ChannelType
         
            formData.appendPart(withForm: HusbandNationalId.data(using: String.Encoding.utf8)!, name: "HusbandNationalId")
            
            formData.appendPart(withForm: WifeNationalId.data(using: String.Encoding.utf8)!, name: "WifeNationalId")
            
            formData.appendPart(withForm: MarriageContractDate.data(using: String.Encoding.utf8)!, name: "MarriageContractDate")
            
            formData.appendPart(withForm: Court.data(using: String.Encoding.utf8)!, name: "Court")
            
            formData.appendPart(withForm: HusbandFullNameArabic.data(using: String.Encoding.utf8)!, name: "HusbandFullNameArabic")
            
            
            formData.appendPart(withForm: HusbandFullNameEnglish.data(using: String.Encoding.utf8)!, name: "HusbandFullNameEnglish")
            
            formData.appendPart(withForm: HusbandBirthDate.data(using: String.Encoding.utf8)!, name: "HusbandBirthDate")
            
            formData.appendPart(withForm: HusbandEducationLevel.data(using: String.Encoding.utf8)!, name: "HusbandEducationLevel")
            
            formData.appendPart(withForm: HusbandMobile1.data(using: String.Encoding.utf8)!, name: "HusbandMobile1")
            
            formData.appendPart(withForm: HusbandMobile2.data(using: String.Encoding.utf8)!, name: "HusbandMobile2")
            formData.appendPart(withForm: HusbandEmail.data(using: String.Encoding.utf8)!, name: "HusbandEmail")
            
            formData.appendPart(withForm: WifeFullNameArabic.data(using: String.Encoding.utf8)!, name: "WifeFullNameArabic")
            
            formData.appendPart(withForm: WifeFullNameEnglish.data(using: String.Encoding.utf8)!, name: "WifeFullNameEnglish")
            
            formData.appendPart(withForm: WifeBirthDate.data(using: String.Encoding.utf8)!, name: "WifeBirthDate")
            
            formData.appendPart(withForm: WifeEducationLevel.data(using: String.Encoding.utf8)!, name: "WifeEducationLevel")
            formData.appendPart(withForm: WifeMobile1.data(using: String.Encoding.utf8)!, name: "WifeMobile1")
            
            formData.appendPart(withForm: WifeEmail.data(using: String.Encoding.utf8)!, name: "WifeEmail")
            
            formData.appendPart(withForm: FamilyBookIssuePlace.data(using: String.Encoding.utf8)!, name: "FamilyBookIssuePlace")
            
            formData.appendPart(withForm: AppConstants.TypeOfRequestMassWeddingDEV.data(using: String.Encoding.utf8)!, name: "TypeOfRequest")
            
            formData.appendPart(withForm: AppConstants.RequestingServiceMassWeddingDEV.data(using: String.Encoding.utf8)!, name: "RequestingService")
            
            formData.appendPart(withForm: AppConstants.ChannelType.data(using: String.Encoding.utf8)!, name: "ChannelType")
            
            
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


