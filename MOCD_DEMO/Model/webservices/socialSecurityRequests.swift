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


class socialSecurityRequests {
    
    
    static func applyForOfficialLetter(userId:String ,ApplicantNameAR: String ,nationalityId: String ,NationalId:String ,familyNo:String ,townNo:String ,genderId:String ,entityAddressed:String ,passportNo:String ,reason:String ,mobileNo:String ,email:String ,ServiceDocTypeIds:String ,filesArray: [URL],sitem: Gallery? ,view: UIView ,completation: @escaping ([String:Any] , NSMutableArray ,_ error: Error?)->Void ){
          
           
           
        let apiString = "applyForOfficialLetter"
           
           
        let uploadURL = AppConstants.WEB_SERVER_MOCD_SERVICES_SOCIAL_DEV + apiString
        
        var result = [String:Any]()
        
        let mocd_user = MOCDUser.getMOCDUser()
           
           
    
           
        var parametersArray: [String:Any]? = [:]
           
          
        
        parametersArray?["userId"] = userId
        
        parametersArray?["ApplicantNameAR"] = ApplicantNameAR
        
        parametersArray?["nationalityId"] = nationalityId
        
        parametersArray?["NationalId"] = NationalId
        
        parametersArray?["familyNo"] = familyNo
        
        parametersArray?["townNo"] = townNo
        
        parametersArray?["genderId"] = genderId
        
        parametersArray?["entityAddressed"] = entityAddressed
        
        parametersArray?["passportNo"] = passportNo
         
        parametersArray?["reason"] = reason
        
        parametersArray?["mobileNo"] = mobileNo
        
        parametersArray?["email"] = email
        
        parametersArray?["ServiceDocTypeIds"] = ServiceDocTypeIds
    
           
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
         
             
            
            formData.appendPart(withForm: userId.data(using: String.Encoding.utf8)!, name: "userId")
            
            formData.appendPart(withForm: ApplicantNameAR.data(using: String.Encoding.utf8)!, name: "ApplicantNameAR")
            
            formData.appendPart(withForm: nationalityId.data(using: String.Encoding.utf8)!, name: "nationalityId")
            
            formData.appendPart(withForm: NationalId.data(using: String.Encoding.utf8)!, name: "NationalId")
            
            formData.appendPart(withForm: familyNo.data(using: String.Encoding.utf8)!, name: "familyNo")
            
            formData.appendPart(withForm: townNo.data(using: String.Encoding.utf8)!, name: "townNo")
            
            formData.appendPart(withForm: genderId.data(using: String.Encoding.utf8)!, name: "genderId")
            
            formData.appendPart(withForm: entityAddressed.data(using: String.Encoding.utf8)!, name: "entityAddressed")
            
            formData.appendPart(withForm: passportNo.data(using: String.Encoding.utf8)!, name: "passportNo")
               
            formData.appendPart(withForm: reason.data(using: String.Encoding.utf8)!, name: "reason")
            
            formData.appendPart(withForm: mobileNo.data(using: String.Encoding.utf8)!, name: "mobileNo")
            
            formData.appendPart(withForm: email.data(using: String.Encoding.utf8)!, name: "email")
            
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
    
    
    static func applyForOfficialLetterWithCaseID(userId:String ,mobileNo: String ,caseID: String ,email:String ,entityAddressed:String ,item: Gallery? ,view: UIView ,completation: @escaping ([String:Any] , NSMutableArray ,_ error: Error?)->Void ){
          
           
           
        let apiString = "applyForOfficialLetterWithCaseID"
           
           
        let uploadURL = AppConstants.WEB_SERVER_MOCD_SERVICES_SOCIAL_DEV + apiString
        
        var result = [String:Any]()
        
        let mocd_user = MOCDUser.getMOCDUser()
           
           
    
           
        var parametersArray: [String:Any]? = [:]
           
          
        
        parametersArray?["userId"] = userId
        
        parametersArray?["mobileNo"] = mobileNo
        
        parametersArray?["caseID"] = caseID
        
        parametersArray?["email"] = email
                
        parametersArray?["entityAddressed"] = entityAddressed
           
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
         
             
            
            formData.appendPart(withForm: userId.data(using: String.Encoding.utf8)!, name: "userId")
            
            formData.appendPart(withForm: mobileNo.data(using: String.Encoding.utf8)!, name: "mobileNo")
            
            formData.appendPart(withForm: caseID.data(using: String.Encoding.utf8)!, name: "caseID")
            
            formData.appendPart(withForm: email.data(using: String.Encoding.utf8)!, name: "email")
            
            formData.appendPart(withForm: entityAddressed.data(using: String.Encoding.utf8)!, name: "entityAddressed")
            
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

