//
//  emiratesIDViewController.swift
//  MOCD_DEMO
//
//  Created by haya habbous on 17/03/2021.
//  Copyright © 2021 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView


class emiratesIDViewController: UIViewController ,NVActivityIndicatorViewable {
    
    var mobileNumber: String = ""
    var mobileNumberBase16: String = ""
    @IBOutlet var emiratesIDView: textFieldMandatory!
    @IBOutlet var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        emiratesIDView.textLabel.text = "Emirates ID".localize
        emiratesIDView.textField.placeholder = "Emirates ID".localize
        
        let gradient = CAGradientLayer()
        gradient.frame = self.nextButton.bounds
        gradient.colors = [UIColor.green]
        
        self.nextButton.applyGradient(colours: [AppConstants.FIRST_GREEN_COLOR, AppConstants.SECOND_GREEN_COLOR])
        //self.loginButton.backgroundColor = .green
        self.nextButton.layer.cornerRadius = 20
        self.nextButton.layer.masksToBounds = true
        
        
        //getPersonProfile(id: "784199365717091")
    }
    
    
    
    @IBAction func dismissAxction(_ sender: Any) {
        
        self.view.endEditing(true)
    }
    @IBAction func doneaction(_ sender: Any) {
        let emiratesID = self.emiratesIDView.textField.text ?? ""
        
        
        getPersonProfile(id: emiratesID)
        
    }
    func getPersonProfile(id: String) {
        let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        
        
        WebService.getPersonalProfile(id: id) { (json) in
            print(json)
            DispatchQueue.main.async {
                self.stopAnimating(nil)
            }
            guard let code = json["code"] as? Int else {return}
        
            
            AppConstants.personalUser = personalInfo()
            
            let data = json["data"] as? [String:Any]
            let result = data?["result"] as? [String:Any]
            let addresses = result?["addresses"] as? [[String:Any]]
            let item = addresses?[0]["Item"] as? [String:Any]
           
            
            
            AppConstants.personalUser?.emiratesID = id
            //area
            let area = item?["area"] as? [String:Any]
            let arDesc = area?["arDesc"] as? String
            let enDesc = area?["enDesc"] as? String

            
            
            let email = item?["email"] as? String
            
            //city
            let city = item?["city"] as? [String:Any]
            let cityarDesc = city?["arDesc"] as? String
            let cityenDesc = city?["enDesc"] as? String
            
            
            //emirates
            let emirate = item?["emirate"] as? [String:Any]
            let emiratearDesc = emirate?["arDesc"] as? String
            let emirateenDesc = emirate?["enDesc"] as? String
            
            
            let mobileNumber = item?["mobileNumber"] as? String ?? ""
            let workPhone = item?["workPhone"] as? String
            
            
            
            
            
            let dateofbirth = result?["dateOfBirth"] as? String
            
            
            //person
            let personName = result?["personName"] as? [String:Any]
            let firstNameArabic = personName?["firstNameArabic"] as? String
            let firstNameEnglish = personName?["firstNameEnglish"] as? String
            
            let secondNameArabic = personName?["secondNameArabic"] as? String
            let secondNameEnglish = personName?["secondNameEnglish"] as? String
            
            let fullArabicName = personName?["fullArabicName"] as? String
            let fullEnglishName = personName?["fullEnglishName"] as? String
            
            
            AppConstants.personalUser?.mobileNumber = mobileNumber
            AppConstants.personalUser?.workPhone = workPhone ?? ""
            AppConstants.personalUser?.firstNameArabic = firstNameArabic ?? ""
            AppConstants.personalUser?.firstNameEnglish = firstNameEnglish ?? ""
            AppConstants.personalUser?.secondNameArabic = secondNameArabic ?? ""
            AppConstants.personalUser?.secondNameEnglish = secondNameEnglish ?? ""
            AppConstants.personalUser?.fullArabicName = fullArabicName ?? ""
            AppConstants.personalUser?.fullEnglishName = fullEnglishName ?? ""
            AppConstants.personalUser?.email = email ?? ""
            if code > 0 {
                
                do {
                    let string  = try mobileNumber.aesEncrypt(key: "", iv: "")
                    print(string)
                    self.mobileNumberBase16 = string.data(using: .utf8)?.toHexString() ?? ""
                    print(self.mobileNumberBase16)
                    
                    self.generateOTP(mobile: self.mobileNumberBase16 )
                    let decrypt = try string.aesDecrypt()
                    print(decrypt)
                    
                    //self.generateOTP(mobile: self.mobileNumberBase16 ?? "")
                    
                }catch{
                    
                }
                
            }
        }
    }
    
    
    func generateOTP(mobile: String) {
        let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        
        
        WebService.generateOTP(mobileNumber: mobile) { (json) in
            print(json)
            DispatchQueue.main.async {
                self.stopAnimating(nil)
            }
            

            guard let sendsmsresult = json["sendsmsresult"] as? String else {
                guard let errcode = json["err.code"] as? Int else {return}
                if errcode == 400 {
                    DispatchQueue.main.async {
                        Utils.showAlertWith(title: "Error".localize, message: "An error has occured", viewController: self)
                    }
                    
                }
                
                return
                
            }
            
            if sendsmsresult == "true" {
                guard let mobilenumber = json["mobilenumber"] as? String else {return}
                self.mobileNumber = mobilenumber
                
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "toValidate", sender: self)
                }
            }else{
                Utils.showAlertWith(title: "Error".localize, message: "No user found", viewController: self)
            }
            
            
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toValidate" {
            let dest = segue.destination as! validateOTPViewController
            dest.mobileNumberBase16 = mobileNumberBase16
        }
    }
}
