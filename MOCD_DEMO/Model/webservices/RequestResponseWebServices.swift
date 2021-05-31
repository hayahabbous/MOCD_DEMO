 //
//  RequestResponseWebServices.swift
//  JSON
//
//  Created by haya habbous on 2/25/18.
//  Copyright © 2018 haya habbous. All rights reserved.
//

import Foundation
import AFNetworking
 import JGProgressHUD
import NotificationBannerSwift
import Alamofire
 
 class RequestResponseWebServices{
    
    enum SerializationError: Error {
        case missing(String)
        case invalid(String,Any)
    }
    
    
 
    
    static func requestByPOST(WebServiceUrl: String ,params:inout [[String:Any]] ,endpoint:String ,completion: @escaping ([String:Any]) -> Void){
        
        var urlString: String = ""
        if endpoint == "masterService" {
            urlString = AppConstants.WEB_SERVER_MOCD_MARRIAGE_GRANT_DEV_SERVICE + WebServiceUrl
        }else if endpoint == "social" {
            urlString = AppConstants.WEB_SERVER_MOCD_SERVICES_SOCIAL_DEV + WebServiceUrl
        }else if endpoint == "otp" {
            urlString = AppConstants.WEB_SERVER_MOCD_MARRIAGE_GRANT_OTP + WebServiceUrl
        }else{
            urlString = AppConstants.WEB_SERVER_MOCD_URL + endpoint + "/" + WebServiceUrl
        }
        
        
        
        
        //set headesr
        
        
        var postString: String = ""
        
        var mocd_user = MOCDUser.getMOCDUser()
        
        //we need to check internet connection
        for parameter in params {
            for (key,value) in parameter {
                
                if WebServiceUrl == "xmpp-users/set-contact-list"{
                    postString = postString + "\"\(key)\" : \(value),"
                    
                }else{
                    if let v = value as? [String] {
                        postString = postString + "\"\(key)\" : \(v),"
                    }else if key == "answers" {
                        postString = postString + "\"\(key)\" : \(value),"
                    }else {
                    
                        postString = postString + "\"\(key)\" : \"\(value)\","
                    }
                    
                }
                
            }
        }
        
        if postString.count > 0{
            postString = postString.substring(to: postString.index(before: postString.endIndex))
            postString = "{\(postString)}"
        }
        
        print(urlString)
        if WebServiceUrl != "Services/UploadDocumentByServiceRequest" {
            print(postString)
        }
        
        var jsonResponse:[String:Any] = [:]
        
        
        urlString = replaceCharacter(InString: urlString)
        var request = URLRequest(url: URL(string: urlString)!)
        let postData = postString.data(using: .utf8)
        
        
        let langStr = Locale.current.languageCode
        request.addValue(langStr ?? "en", forHTTPHeaderField: "language");
        request.addValue(AppConstants.DToken, forHTTPHeaderField: "DToken");
        request.addValue("application/json", forHTTPHeaderField: "Content-Type");
        request.addValue(mocd_user?.userToken ?? "", forHTTPHeaderField: "UserToken")
        request.addValue("Bearer \(AppConstants.MASTER_TOKEN)", forHTTPHeaderField: "Authorization")
        
        
        request.timeoutInterval = 30
        request.httpMethod = "POST"
        request.httpBody = postData!
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let reachable = appDelegate.reach
         if reachable!.connection == .wifi || reachable!.connection == .cellular {
            
            let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error? ) in
                //var forecastArray:[String] = []
                if let data = data {
                    do{
                        if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]{
                            
                            jsonResponse = json
                            
                            completion(jsonResponse)
                            
                        }
                    }catch{
                        
                        jsonResponse["code"] = "-2222"
                        jsonResponse["message"] = "Unable to connect to the server\n Please try again later"
                        completion(jsonResponse)
                        
                        print(error.localizedDescription)
                    }
                }else{
                    jsonResponse["code"] = "-2222"
                    jsonResponse["message"] = "Unable to connect to the server\n Please try again later"
                    completion(jsonResponse)
                }
                
                
            }
            
            task.resume()
        }else{
            jsonResponse["code"] = "-222"
            jsonResponse["message"] = "no internet connection"
            completion(jsonResponse)
        }
        
        
        
        
        
    }
    
    static func requestByGET(WebServiceUrl: String ,params:inout [[String:Any]] ,endpoint:String ,serviceType: String = "",completion: @escaping ([String:Any]) -> Void){
        
        
        var urlString: String = ""
        if endpoint == "GetDocumentListByService" {
            urlString = AppConstants.WEB_SERVER_MOCD_MARRIAGE_GRANT_DEV_SERVICE + WebServiceUrl + "?"
        }else if serviceType == "newCard" {
         
            urlString  = AppConstants.WEB_SERVER_MOCD_SERVICES_CARD_DEV + WebServiceUrl + "/"
        }else if endpoint == "otp" {
            urlString = AppConstants.WEB_SERVER_MOCD_MARRIAGE_GRANT_OTP + WebServiceUrl + "?"
        }else if serviceType == "social"{
            urlString  = AppConstants.WEB_SERVER_MOCD_SERVICES_SOCIAL_DEV + WebServiceUrl + "/"
        }else if serviceType == "master"{
            urlString  = AppConstants.WEB_SERVER_MOCD_MARRIAGE_GRANT_DEV + WebServiceUrl + "/"
        }else{
            urlString = AppConstants.WEB_SERVER_MOCD_URL + endpoint + "/" + WebServiceUrl + "/"
        }
      
        
        if endpoint == "GetDocumentListByService" || endpoint == "otp" {
            
            if params.count > 0 {
                for parameter in params {
                    for (key,value) in parameter {
                        
                        urlString = urlString + "\(key)=" + "\(value)&"
                    }
                }
            }
        }else{
            if params.count > 0 {
                for parameter in params {
                    for (key,value) in parameter {
                        
                        urlString = urlString + "\(value)/"
                    }
                }
            }
        }
        
        
        
        
        //set headesr
        

        var mocd_user = MOCDUser.getMOCDUser()
        
        urlString = urlString.substring(to: urlString.index(before: urlString.endIndex))
        
        print(urlString)
 
        var jsonResponse:[String:Any] = [:]
        
        
        urlString = replaceCharacter(InString: urlString)
        var request = URLRequest(url: URL(string: urlString)!)
        
        
        
        let langStr = Locale.current.languageCode
        request.addValue(langStr ?? "en", forHTTPHeaderField: "language");
        request.addValue(AppConstants.DToken, forHTTPHeaderField: "DToken");
        request.addValue("application/json", forHTTPHeaderField: "Content-Type");
        request.addValue(mocd_user?.userToken ?? "", forHTTPHeaderField: "UserToken")
        request.addValue("Bearer \(AppConstants.MASTER_TOKEN)", forHTTPHeaderField: "Authorization")
        
        
        print("user token is \(mocd_user?.userToken ?? "not set"))")
        
        
        request.timeoutInterval = 30
        request.httpMethod = "GET"
     
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let reachable = appDelegate.reach
        if reachable!.connection == .wifi || reachable!.connection == .cellular {
            
            let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error? ) in
                //var forecastArray:[String] = []
                if let data = data {
                    do{
                        if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]{
                            
                            jsonResponse = json
                            
                            completion(jsonResponse)
                            
                        }
                    }catch{
                        
                        jsonResponse["code"] = "-2222"
                        jsonResponse["message"] = "Unable to connect to the server\n Please try again later"
                        completion(jsonResponse)
                        
                        print(error.localizedDescription)
                    }
                }else{
                    jsonResponse["code"] = "-2222"
                    jsonResponse["message"] = "Unable to connect to the server\n Please try again later"
                    completion(jsonResponse)
                }
                
                
            }
            
            task.resume()
        }else{
            jsonResponse["code"] = "-222"
            jsonResponse["message"] = "no internet connection"
            completion(jsonResponse)
        }
        
        
        
        
        
    }
    static func requestByDelete(WebServiceUrl: String ,params:inout [[String:Any]] ,endpoint:String ,completion: @escaping ([String:Any]) -> Void){
           
           
           var urlString: String = AppConstants.WEB_SERVER_MOCD_URL + endpoint + "/" + WebServiceUrl + "/"
           
           if params.count > 0 {
               for parameter in params {
                   for (key,value) in parameter {
                       
                       urlString = urlString + "\(value)/"
                   }
               }
           }
           
           
           //set headesr
           

           var mocd_user = MOCDUser.getMOCDUser()
           
           urlString = urlString.substring(to: urlString.index(before: urlString.endIndex))
           
           print(urlString)
    
           var jsonResponse:[String:Any] = [:]
           
           
           urlString = replaceCharacter(InString: urlString)
           var request = URLRequest(url: URL(string: urlString)!)
           
           
           
           let langStr = Locale.current.languageCode
           request.addValue(langStr ?? "en", forHTTPHeaderField: "language");
           request.addValue(AppConstants.DToken, forHTTPHeaderField: "DToken");
           request.addValue("application/json", forHTTPHeaderField: "Content-Type");
           request.addValue(mocd_user?.userToken ?? "", forHTTPHeaderField: "UserToken")
           
           
           print("user token is \(mocd_user?.userToken ?? "not set"))")
           
           
           request.timeoutInterval = 30
           request.httpMethod = "Delete"
        
           
           
           let appDelegate = UIApplication.shared.delegate as! AppDelegate
           let reachable = appDelegate.reach
           if reachable!.connection == .wifi || reachable!.connection == .cellular {
               
               let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error? ) in
                   //var forecastArray:[String] = []
                   if let data = data {
                       do{
                           if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any]{
                               
                               jsonResponse = json
                               
                               completion(jsonResponse)
                               
                           }
                       }catch{
                           
                           jsonResponse["code"] = "-2222"
                           jsonResponse["message"] = "Unable to connect to the server\n Please try again later"
                           completion(jsonResponse)
                           
                           print(error.localizedDescription)
                       }
                   }else{
                       jsonResponse["code"] = "-2222"
                       jsonResponse["message"] = "Unable to connect to the server\n Please try again later"
                       completion(jsonResponse)
                   }
                   
                   
               }
               
               task.resume()
           }else{
               jsonResponse["code"] = "-222"
               jsonResponse["message"] = "no internet connection"
               completion(jsonResponse)
           }
           
           
           
           
           
       }
       
    static func uploadUsingAFNetworkingFromUrl(isEdit: Bool ,childId: String?,  parent_id: String ,first_name: String ,
    last_name: String ,nationality: String ,
    gender: String ,mobile: String ,
    email: String ,emirates_id: String ,
    emirate: String ,address: String ,
    data_of_birth: String ,view: UIView ,type: String,item: Gallery ,completation: @escaping ([String:Any] , NSMutableArray)->Void){
       
        
        
        var apiString = ""
        if isEdit {
            apiString = "updateChild"
        }else {
            apiString = "createChild"
        }
        let uploadURL = AppConstants.WEB_SERVER_MOCD_URL + "child/" + apiString
        var result = [String:Any]()
        let mocd_user = MOCDUser.getMOCDUser()
        
        
        //let customeView  = ProgressBannerView(view: view)
        
        //let banner = NotificationBanner(customView: customeView)
        //banner.delegate = self
        //banner.duration = 3000
        
        
        //banner.isUserInteractionEnabled = false
        
        var parametersArray: [String:Any]? = [:]
        
        if isEdit {
            parametersArray?["child_id"] = childId
        }
        parametersArray?["first_name"] = first_name
        parametersArray?["last_name"] = last_name
        parametersArray?["nationality"] = nationality
        parametersArray?["gender"] = gender
        parametersArray?["mobile"] = mobile
        parametersArray?["email"] = email
        parametersArray?["emirates_id"] = emirates_id
        parametersArray?["emirate"] = emirate
        parametersArray?["address"] = address
        parametersArray?["data_of_birth"] = data_of_birth
        
        
    
        let request = AFHTTPRequestSerializer().multipartFormRequest(withMethod: "POST", urlString: uploadURL, parameters: nil, constructingBodyWith: { (formData) in
            do {
            
                if item.path.count >  0 {
                    var theURL = URL(string: item.path)
                    if !theURL!.isFileURL {
                        theURL = URL(fileURLWithPath: item.path)
                    }
                    //let uploadURL = AppConstants.FILE_UPLOAD_BASE_URL + WebServiceRequests.uploadRequest.rawValue
                    
                    
                    let data = FileManager.default.contents(atPath: item.path)
                    
                    
                    if(data == nil)
                    {
                        print("data not found to upload")
                    }
                    
                    
                    try formData.appendPart(withFileURL: theURL!, name: "file", fileName: item.name.lowercased(), mimeType: item.type)
                }else{
                    //formData.appendPart(withForm: "".data(using: String.Encoding.utf8)!, name: "file")
                }
                
                
            }
            catch {
                print("error appending file data: \(error)")
            }
      
          
            if isEdit {
            
                let childId = childId!
                formData.appendPart(withForm: childId.data(using: String.Encoding.utf8)!, name: "child_id")
                
         
            }
            formData.appendPart(withForm: first_name.data(using: String.Encoding.utf8)!, name: "first_name")
            formData.appendPart(withForm: last_name.data(using: String.Encoding.utf8)!, name: "last_name")
            formData.appendPart(withForm: nationality.data(using: String.Encoding.utf8)!, name: "nationality")
            formData.appendPart(withForm: gender.data(using: String.Encoding.utf8)!, name: "gender")
            formData.appendPart(withForm: mobile.data(using: String.Encoding.utf8)!, name: "mobile")
            formData.appendPart(withForm: email.data(using: String.Encoding.utf8)!, name: "email")
            formData.appendPart(withForm: emirates_id.data(using: String.Encoding.utf8)!, name: "emirates_id")
            formData.appendPart(withForm: emirate.data(using: String.Encoding.utf8)!, name: "emirate")
            formData.appendPart(withForm: address.data(using: String.Encoding.utf8)!, name: "address")
            formData.appendPart(withForm: data_of_birth.data(using: String.Encoding.utf8)!, name: "data_of_birth")
            
            
           
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
                        
                        completation(data as! [String:Any],NSMutableArray())
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
                        
                        completation(data as! [String:Any],photosArray)
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
            completation([String:Any](),NSMutableArray())
        }
        
        
    }
    
    
    static func addUser(first_name:String ,last_name: String ,password: String ,username:String ,nationality_id:String ,gender_id:String ,user_email:String ,user_mobile:String ,emirates_id:String ,question_id:String ,question_answer:String ,enable_tow_factor_auth:String ,item: Gallery ,view: UIView ,completation: @escaping ([String:Any] , NSMutableArray ,_ error: Error?)->Void ){
          
           
           
        let apiString = "createUser"
           
           
        let uploadURL = AppConstants.WEB_SERVER_MOCD_URL + "user/" + apiString
        
        var result = [String:Any]()
        
        let mocd_user = MOCDUser.getMOCDUser()
           
           
    
           
        var parametersArray: [String:Any]? = [:]
           
          
        
        parametersArray?["first_name"] = first_name
        
        parametersArray?["last_name"] = last_name
        
        parametersArray?["password"] = password
        
        parametersArray?["username"] = username
        
        parametersArray?["nationality_id"] = nationality_id
        
        parametersArray?["gender_id"] = gender_id
        
        parametersArray?["user_email"] = user_email
        
        parametersArray?["user_mobile"] = user_mobile
        
        parametersArray?["emirates_id"] = emirates_id
         
        parametersArray?["question_id"] = question_id
        
        parametersArray?["question_answer"] = question_answer
        parametersArray?["enable_two_factor_authentication"] = enable_tow_factor_auth
           
           
       
           
        let request = AFHTTPRequestSerializer().multipartFormRequest(withMethod: "POST", urlString: uploadURL, parameters: nil, constructingBodyWith: { (formData) in
             
            do {
               
                  
                if item.path.count >  0 {
                
                    var theURL = URL(string: item.path)
                    
                    if !theURL!.isFileURL {
                    
                        theURL = URL(fileURLWithPath: item.path)
                       
                    }
                       //let uploadURL = AppConstants.FILE_UPLOAD_BASE_URL + WebServiceRequests.uploadRequest.rawValue
                   
                    
                       
                    
                    let data = FileManager.default.contents(atPath: item.path)
                       
                       
                    
                    if(data == nil)
                    
                    {
                    
                        print("data not found to upload")
                     
                    }
                       
                       
                    
                    try formData.appendPart(withFileURL: theURL!, name: "file", fileName: item.name.lowercased(), mimeType: item.type)
                  
                }else{
                
                    //formData.appendPart(withForm: "".data(using: String.Encoding.utf8)!, name: "file")
                  
                }
                   
                   
              
            }
            
            catch {
            
                print("error appending file data: \(error)")
               
            }
         
             
            
            formData.appendPart(withForm: first_name.data(using: String.Encoding.utf8)!, name: "first_name")
            
            formData.appendPart(withForm: last_name.data(using: String.Encoding.utf8)!, name: "last_name")
            
            formData.appendPart(withForm: password.data(using: String.Encoding.utf8)!, name: "password")
            
            formData.appendPart(withForm: username.data(using: String.Encoding.utf8)!, name: "username")
            
            formData.appendPart(withForm: nationality_id.data(using: String.Encoding.utf8)!, name: "nationality_id")
            
            formData.appendPart(withForm: gender_id.data(using: String.Encoding.utf8)!, name: "gender_id")
            
            formData.appendPart(withForm: user_email.data(using: String.Encoding.utf8)!, name: "user_email")
            
            formData.appendPart(withForm: user_mobile.data(using: String.Encoding.utf8)!, name: "user_mobile")
            
            formData.appendPart(withForm: emirates_id.data(using: String.Encoding.utf8)!, name: "emirates_id")
               
            formData.appendPart(withForm: question_id.data(using: String.Encoding.utf8)!, name: "question_id")
            formData.appendPart(withForm: question_answer.data(using: String.Encoding.utf8)!, name: "question_answer")
            formData.appendPart(withForm: enable_tow_factor_auth.data(using: String.Encoding.utf8)!, name: "enable_two_factor_authentication")
               
               
              
            
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
    /*
    
    func requestWith(parent_id: String ,first_name: String ,
    
                     last_name: String ,nationality: String ,
                     gender: String ,mobile: String ,
                     email: String ,emirates_id: String ,
                     emirate: String ,address: String ,
                     data_of_birth: String ,view: UIView ,type: String,item: Gallery ,endUrl: String, imageData: Data?, parameters: [String : Any], completation: @escaping ([String:Any] , NSMutableArray)->Void){
        
        let url = "http://google.com" /* your API url */
        
        let headers: HTTPHeaders = [
            /* "Authorization": "your_access_token",  in case you need authorization header */
            "Content-type": "multipart/form-data"
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            if let data = imageData{
                multipartFormData.append(data, withName: "file", fileName: "", mimeType: "image/png")
            }
            
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    print("Succesfully uploaded")
                    if let err = response.error{
                        onError?(err)
                        return
                    }
                    onCompletion?(nil)
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                onError?(error)
            }
        }
    }*/
    static func replaceCharacter(InString: String) ->String{
        let newString = InString.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        
        return newString
    }
    
    //---------------------------------------------------------------------------------------------------------------------
    static func urlencode(_ enteredString: String?) -> String? {
        var output = ""
        let source = enteredString?.utf8CString
        let sourceLen = source?.count
        for i in 0 ..< sourceLen! {
            let thisChar = source![i]
            if thisChar == " ".utf8CString.first!  {
                output += "+"
            }
            else if thisChar == ".".utf8CString.first! || thisChar == "-".utf8CString.first! || thisChar == "_".utf8CString.first! || thisChar == "~".utf8CString.first! || (thisChar >= "a".utf8CString.first! && thisChar <= "z".utf8CString.first!) || (thisChar >= "A".utf8CString.first! && thisChar <= "Z".utf8CString.first!) || (thisChar >= "0".utf8CString.first! && thisChar <= "9".utf8CString.first!) {
                output += "\(thisChar)"
            }
            else {
                output += String(format: "%%%02X", thisChar)
            }
        }
        return output
    }
    /*
    static func getHash(forText text: String?) -> String? {
        var hash = (text?.sha256())!
        hash = hash.replacingOccurrences(of: " ", with: "")
        hash = hash.replacingOccurrences(of: "<", with: "")
        hash = hash.replacingOccurrences(of: ">", with: "")
        print(hash)
        return hash
    }*/
    //---------------------------------------------------------------------------------------------------------------------
    
    /*
    static func uploadUsingAFNetworkingFromUrl(view: UIView ,type: String ,galleryItems:[Gallery],completation: @escaping ([String:Any] , NSMutableArray)->Void){
       
        
        
        
        let uploadURL = AppConstants.WEB_ENGILINK_UPLOAD_URL
        var result = [String:Any]()
        let linkuser = EngiLinkUser.getEngiLinkUser()
        
        
        let customeView  = ProgressBannerView(view: view)
        
        let banner = NotificationBanner(customView: customeView)
        //banner.delegate = self
        banner.duration = 3000
        
        
        banner.isUserInteractionEnabled = false
        let request = AFHTTPRequestSerializer().multipartFormRequest(withMethod: "POST", urlString: uploadURL, parameters: nil, constructingBodyWith: { (formData) in
            do {
                
                for item in galleryItems {
                    
                    
                    var theURL = URL(string: item.path)
                    if !theURL!.isFileURL {
                        theURL = URL(fileURLWithPath: item.path)
                    }
                    //let uploadURL = AppConstants.FILE_UPLOAD_BASE_URL + WebServiceRequests.uploadRequest.rawValue
                    
                    
                    let data = FileManager.default.contents(atPath: item.path)
                    
                    
                    if(data == nil)
                    {
                        print("data not found to upload")
                    }
                    
                    
                    try formData.appendPart(withFileURL: theURL!, name: "files[]", fileName: item.name.lowercased(), mimeType: item.type)
                }
                
            }
            catch {
                print("error appending file data: \(error)")
            }
            
            
            formData.appendPart(withForm: type.data(using: String.Encoding.utf8)!, name: "type")
            
            
           
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
                //hud.show(in: view)
                banner.show(queuePosition: QueuePosition.front, bannerPosition: BannerPosition.top)
                
            }
            
            
            
            let task = sessionManager.uploadTask(withStreamedRequest: request as URLRequest, progress: { (progress) in
                DispatchQueue.main.async {
                    ProgressHelper.incrementHUD(hud, progress: (Int(progress.fractionCompleted * 100)), withView: view)
                    customeView.progressView.progress = Float(CGFloat(progress.fractionCompleted) )
                    customeView.label.text = "\((Int(progress.fractionCompleted * 100)))% Completed"
                    customeView.imageView.image = #imageLiteral(resourceName: "male_profile_picture.png")
                }
                
                print(progress.fractionCompleted)
                
            }) { (response, data, error) in
                
                if error != nil {
                    DispatchQueue.main.async {
                        
                        banner.dismiss()
                        hud.dismiss(afterDelay: 1.0)
                        
                        completation([String:Any](),NSMutableArray())
                    }
                }else{
                    
                    
                    print("responce: \(data)")
                    let res = data as? [String:Any]
                    let code = res!["code"] as? String
                    
                
                    let datares = res!["data"] as! [Any]
                    let photosArray = NSMutableArray()
                    for item in datares {
                        let item = item as! [String: Any]
                        let newPhoto = Gallery()
                        newPhoto.name = String(describing: item["name"] ?? "")
                        newPhoto.type = String(describing: item["mime"] ?? "")
                        newPhoto.size = String(describing: item["size"] ?? "")
                        newPhoto.type = String(describing: item["type"] ?? "")
                        
                        photosArray.add(newPhoto)
                        
                        
                    }
                    let message = res!["message"] as? String
                    print(message)
                    DispatchQueue.main.async {
                        
                        banner.dismiss()
                        hud.dismiss(afterDelay: 1.0)
                        
                        completation([String:Any](),photosArray)
                    }
                }
            }
          
            task.resume()
            //semaphore.wait()
            print(result)
            //completation(result)
        }else{
            DispatchQueue.main.async {
                
                banner.dismiss()
                ProgressHelper.showSimpleHUD(withView: view, text: "no internet connection")
            }
            
            print("no internet connection")
            completation([String:Any](),NSMutableArray())
        }
        
        
    }*/
    static func sha256(data : Data) -> Data {
        var hash = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA256($0, CC_LONG(data.count), &hash)
        }
        return Data(bytes: hash)
    }

    static func isInternetConnetcionEnabled() -> Bool{
        
        var is_internet_con = true
        let reachability = AFNetworkReachabilityManager.shared().networkReachabilityStatus
        switch reachability {
        case .reachableViaWWAN:
            print("wan status ")
        case .reachableViaWiFi:
            print("wifi status ")
        case .unknown:
            print("other connection status")
        case .notReachable:
            is_internet_con = false
            print("no internet connection")
            
        default:
            print("error")
        }
        
        return is_internet_con
    }
}
