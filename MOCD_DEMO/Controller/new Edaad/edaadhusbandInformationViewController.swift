//
//  edaadhusbandInformationViewController.swift
//  MOCD_DEMO
//
//  Created by haya habbous on 24/05/2021.
//  Copyright © 2021 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView
import CryptoSwift



class edaadhusbandInformationViewController: UIViewController ,NVActivityIndicatorViewable{
    
    
    @IBOutlet var courtPicker: UIPickerView!
    var courtsArray: [MOCDEducationLevelMaster] = []
    
    @IBOutlet var dateOfMarriageContractView: dateTexteField!
    @IBOutlet var shariaCourtView: selectTextField!
    
    
    var marriageItem: marriageService = marriageService()
    @IBOutlet var educationPicker: UIPickerView!
    var educationsArray: [MOCDEducationLevelMaster] = []
    var toolBar = UIToolbar()
    let nvactivity = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    @IBOutlet var husbandNameView: textFieldMandatory!
    @IBOutlet var husbandNameEnView: textFieldMandatory!
    @IBOutlet var dateOfBirthView: dateTexteField!
    @IBOutlet var nationalNumberView: textFieldMandatory!
    @IBOutlet var educationalLevelView: selectTextField!
    @IBOutlet var emailView: textFieldMandatory!
    @IBOutlet var mobileoneView: textFieldMandatory!
    @IBOutlet var mobiletowView: textFieldMandatory!
    @IBOutlet var nextButton: UIButton!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupField()
        getToken()
        setupToolbar()
        
        getEducationLevelMaster()
        getCourtMaster()
        let user = MOCDUser.getMOCDUser()
        //getPersonProfile(id: "784199365717091")
        /*
        do {
            let string  = try "0568266100".aesEncrypt(key: "", iv: "")
            print(string)
            let base16 = string.data(using: .utf8)?.toHexString()
            print(base16)
            
            self.generateOTP(mobile: base16 ?? "")
            let decrypt = try string.aesDecrypt()
            print(decrypt)
            
        }catch{
            
        }
        */
        //cipherText()
        
    }
    
    func setupField()
    {
        
        husbandNameView.textLabel.text = "Husband Name".localize
        husbandNameView.textField.placeholder = "Husband Name".localize
        husbandNameView.textField.text = AppConstants.personalUser?.fullArabicName ?? ""
        
        husbandNameEnView.textLabel.text = "Husband Name [EN]".localize
        husbandNameEnView.textField.placeholder = "Husband Name [EN]".localize
        husbandNameEnView.textField.text = AppConstants.personalUser?.fullEnglishName ?? ""
        
        dateOfBirthView.textLabel.text = "Date of Birth of Husband".localize
        dateOfBirthView.viewController = self
        
        nationalNumberView.textLabel.text = "National Number For The Husband".localize
        nationalNumberView.textField.placeholder = "National Number For The Husband".localize
        nationalNumberView.textField.text = AppConstants.personalUser?.emiratesID ?? ""
        
        
        
        educationalLevelView.textLabel.text = "Educational Level"
        educationalLevelView.textField.placeholder = "Please Select"
        
        
        emailView.textLabel.text = "Email".localize
        emailView.textField.placeholder = "Email".localize
        emailView.textField.text = AppConstants.personalUser?.email ?? ""
        
        mobileoneView.textLabel.text = "Mobile 1".localize
        mobileoneView.textField.placeholder = "Mobile 1".localize
        mobileoneView.textField.text = AppConstants.personalUser?.mobileNumber ?? ""
        
        mobiletowView.textLabel.text = "Mobile 2".localize
        mobiletowView.textField.placeholder = "Mobile 2".localize
        mobiletowView.textField.text = AppConstants.personalUser?.workPhone ?? ""
        
        
        dateOfMarriageContractView.textLabel.text = "Date of the Marriage Contract".localize
        dateOfMarriageContractView.viewController = self
        
        shariaCourtView.textLabel.text = "Sharia Court Name".localize
        shariaCourtView.textField.placeholder = "Please Select".localize
        
        
        let gradient = CAGradientLayer()
        gradient.frame = self.nextButton.bounds
        gradient.colors = [UIColor.green]
        
        self.nextButton.applyGradient(colours: [AppConstants.firstBrownColor, AppConstants.secondBrownColor])
        //self.loginButton.backgroundColor = .green
        self.nextButton.layer.cornerRadius = 20
        self.nextButton.layer.masksToBounds = true
        
        
        
        
        
        
    }
    func setupToolbar() {
        toolBar.tintColor = AppConstants.BROWN_COLOR
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        
        toolBar.sizeToFit()
        
        
        var items = [UIBarButtonItem]()
        
        /*
        items.append(
            UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(onClickedToolbeltButton(_:)))
        )
        items.append(
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace , target: self, action: nil))*/
        items.append(
            UIBarButtonItem(barButtonSystemItem: .done , target: self, action: #selector(onClickedToolbeltButton(_:)))
        )
        
        toolBar.items = items
        toolBar.backgroundColor = AppConstants.GREEN_COLOR
        
        educationalLevelView.textField.inputAccessoryView = toolBar
        

        educationalLevelView.textField.isUserInteractionEnabled = true
        educationalLevelView.textField.inputView = educationPicker
      
        
      
        educationPicker.translatesAutoresizingMaskIntoConstraints = false
        
        
        shariaCourtView.textField.inputAccessoryView = toolBar
        

        shariaCourtView.textField.isUserInteractionEnabled = true
        shariaCourtView.textField.inputView = courtPicker
      
        
      
        courtPicker.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    @objc func onClickedToolbeltButton(_ sender: Any){
        self.view.endEditing(true)
    }
    func getToken() {
        let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        
        
        WebService.getToken { (json) in
            print(json)
            DispatchQueue.main.async {
                self.stopAnimating(nil)
            }
            

        }
    }
    
    func getPersonProfile(id: String) {
        let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        
        
        WebService.getPersonalProfile(id: id) { (json) in
            print(json)
            DispatchQueue.main.async {
                self.stopAnimating(nil)
            }
            

        }
    }
    func getCourtMaster() {
        let size = CGSize(width: 30, height: 30)
         
         
         self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        
        
        WebService.GetCourtMaster { (json) in
            print(json)
            DispatchQueue.main.async {
                self.stopAnimating(nil)
            }
            
            guard let code = json["Code"] as? Int else {return}
            guard let message = json["ResponseTitle"] as? String else {return}
            
            if code == 200 {
                
                guard let list = json["Content"] as? [[String: Any]] else{return}
                
                
                for r in list {
                let item: MOCDEducationLevelMaster = MOCDEducationLevelMaster()
                    
                    item.Id = String(describing: r["Id"] ?? "")
                    item.Name = String(describing: r["Name"] ?? "")
                    item.NameinArabic = String(describing: r["NameinArabic"] ?? "")
                    //item.ICA_ID = String(describing: r["ICA_ID"] ?? "")
                    
                  
                    
                    self.courtsArray.append(item)
                    
                    
                }
                
                DispatchQueue.main.async {
                    
                    
                    self.courtPicker.reloadAllComponents()
                }
            }else{
                
                
                DispatchQueue.main.async {
                                   
                    Utils.showAlertWith(title: "Error".localize, message: message, viewController: self)
                    
                }
            }

        }
    }
    /*
    func generateOTP(mobile: String) {
        let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        
        
        WebService.generateOTP(mobileNumber: mobile) { (json) in
            print(json)
            DispatchQueue.main.async {
                self.stopAnimating(nil)
            }
            

            guard let sendsmsresult = json["sendsmsresult"] as? String else {return}
            
            if sendsmsresult == "true" {
                guard let mobilenumber = json["mobilenumber"] as? String else {return}
                 
            }else{
                Utils.showAlertWith(title: "Error".localize, message: "No user found", viewController: self)
            }
            
            
            
            
            
            
        }
    }
    */
    func getEducationLevelMaster() {
        let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        
        
        WebService.GetEducationLevelMaster { (json) in
            print(json)
            DispatchQueue.main.async {
                self.stopAnimating(nil)
            }
            
            guard let code = json["Code"] as? Int else {return}
            guard let message = json["ResponseTitle"] as? String else {return}
            
            if code == 200 {
                
                guard let list = json["Content"] as? [[String: Any]] else{return}
                
                
                for r in list {
                let item: MOCDEducationLevelMaster = MOCDEducationLevelMaster()
                    
                    item.Id = String(describing: r["Id"] ?? "")
                    item.Name = String(describing: r["Name"] ?? "")
                    item.NameinArabic = String(describing: r["NameinArabic"] ?? "")
                    item.ICA_ID = String(describing: r["ICA_ID"] ?? "")
                    
                  
                    
                    self.educationsArray.append(item)
                    
                    
                }
                
                DispatchQueue.main.async {
                    
                    
                    self.educationPicker.reloadAllComponents()
                }
            }else{
                
                
                DispatchQueue.main.async {
                                   
                    Utils.showAlertWith(title: "Error", message: message, viewController: self)
                    
                }
            }

        }
    }
    
    func validateFields() -> Bool{
        
        
        
        
        marriageItem.HusbandFullNameArabic = husbandNameView.textField.text ?? ""
        marriageItem.HusbandFullNameEnglish = husbandNameEnView.textField.text ?? ""
        marriageItem.HusbandBirthDate = dateOfBirthView.textField.text ?? ""
        marriageItem.HusbandNationalId = nationalNumberView.textField.text ?? ""
        //marriageItem.HusbandEducationLevel = educationalLevelView.textField.text ?? ""
        marriageItem.HusbandEmail = emailView.textField.text ?? ""
        marriageItem.HusbandMobile1 = mobileoneView.textField.text ?? ""
        marriageItem.HusbandMobile2 = mobiletowView.textField.text ?? ""

        marriageItem.MarriageContractDate = dateOfMarriageContractView.textField.text ?? ""
        //marriageItem.Court = shariaCourtView.textField.text ?? ""
        marriageItem.marriageContractDate = dateOfMarriageContractView.date
        
        let age = self.dateOfBirthView.date.calculateAge() ?? 0
        print(age ?? 0)
        
        if husbandNameView.textField.text == "" ||
            husbandNameEnView.textField.text == "" ||
            dateOfBirthView.textField.text == "" ||
            nationalNumberView.textField.text == "" ||
            educationalLevelView.textField.text == "" ||
        emailView.textField.text == "" ||
        mobileoneView.textField.text == "" ||
        mobiletowView.textField.text == "" ||
        dateOfMarriageContractView.textField.text == "" ||
        shariaCourtView.textField.text == "" {
            
            Utils.showAlertWith(title: "Error".localize, message: "Please Fill All Fields".localize, viewController: self)
            return false
            
            
        }
        
        if marriageItem.marriageContractDate.calculateMonths() > 6 {
            Utils.showAlertWith(title: "Error".localize, message: "Marriage Contract date should not be older than six months".localize, viewController: self)
            return false
        }
        if age < 21 {
            Utils.showAlertWith(title: "Error".localize, message: "Date of Birth of Husband is requird (should be more than 21 years)".localize, viewController: self)
            return false
        }
        
        
        return true
        
    }
    @IBAction func nextAction(_ sender: Any) {
        
        if !validateFields() {
            return
        }
        self.performSegue(withIdentifier: "toWifeInformation", sender: self)
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWifeInformation" {
            let dest = segue.destination as! eddadwifeInformationViewController
            dest.marriageItem = self.marriageItem
            dest.myString = "MMMMMMM"
            print(dest.marriageItem)
        }
    }
}
extension edaadhusbandInformationViewController: UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == self.educationPicker {
            return educationsArray.count
        }else {
            return courtsArray.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == self.educationPicker {
            
            let item = educationsArray[row]
            
            return AppConstants.isArabic() ? item.NameinArabic : item.Name
        }else{
            let item = courtsArray[row]
            
            return AppConstants.isArabic() ? item.NameinArabic : item.Name
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        if pickerView == self.educationPicker {
            if educationsArray.count > 0 {
                
                let item = educationsArray[row]
                   let title = AppConstants.isArabic() ? item.NameinArabic : item.Name
                   educationalLevelView.textField.text = title
                
                   marriageItem.HusbandEducationLevel = item.Id
            }
        }else{
            if courtsArray.count > 0 {
                let item = courtsArray[row]
                   let title = AppConstants.isArabic() ? item.NameinArabic : item.Name
                   shariaCourtView.textField.text = title
                
                   marriageItem.Court = item.Id
            }
        }
        
        
    }

   
}
