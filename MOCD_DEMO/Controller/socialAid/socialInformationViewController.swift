//
//  socialInformationViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 6/26/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit


class socialInformationViewController: UIViewController {
    
    @IBOutlet var materialStatusPicker: UIPickerView!
    @IBOutlet var educationPicker: UIPickerView!
    @IBOutlet var nationalityPicker: UIPickerView!
    var toolBar = UIToolbar()
    
    var socialAidItem: socialAid = socialAid()
    var materialsArray: [MOCDMaterialStatusSocial] = []
    var eduactaionsArray: [MOCDEducationSocial] = []
    var nationalitiesArray: [MOCDNationalitySocial] = []
    
    
    @IBOutlet var nameArView: textFieldMandatory!
    @IBOutlet var nameEnView: textFieldMandatory!
    @IBOutlet var familyNoView: textFieldMandatory!
    @IBOutlet var townNoView: textFieldMandatory!
    @IBOutlet var dateOfBirthView: dateTexteField!
    @IBOutlet var genderView: multipleTextField!
    @IBOutlet var materialStatusView: selectTextField!
    @IBOutlet var educationView: selectTextField!
    @IBOutlet var nationalityView: selectTextField!
    @IBOutlet var occupationView: textFieldMandatory!
    @IBOutlet var emailView: textFieldMandatory!
    @IBOutlet var motherNameView: textFieldMandatory!
    @IBOutlet var telephoneView: textFieldMandatory!
    @IBOutlet var mobileNoView: textFieldMandatory!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var previousButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupField()
        setupToolbar()
        
        getMaterialStatus()
        getEducationalLevel()
        getNationalities()
    }
    
    func setupField(){
        
        nameArView.textLabel.text = "Name [AR]".localize
        nameArView.textField.placeholder = "Name [AR]".localize
        
        
        nameEnView.textLabel.text = "Name [En]".localize
        nameEnView.textField.placeholder = "Name [En]".localize
        
        
        familyNoView.textLabel.text = "Family No".localize
        familyNoView.textField.placeholder = "Family No".localize
        
        townNoView.textLabel.text = "Town No".localize
        townNoView.textField.placeholder = "Town No".localize
        
        dateOfBirthView.textLabel.text = "Date Of Birth".localize
        dateOfBirthView.viewController = self
        genderView.textLabel.text = "Gender".localize
        genderView.firstLabel.text = "Female".localize
        genderView.secondLabel.text = "Male".localize
        
        
        
        materialStatusView.textLabel.text = "Material Status".localize
        materialStatusView.textField.placeholder = "Please Select".localize
        
        
        educationView.textLabel.text = "Education".localize
        educationView.textField.placeholder = "Please Select".localize
        
        
        nationalityView.textLabel.text = "Nationality".localize
        nationalityView.textField.placeholder = "Please Select".localize
        
        
        
        occupationView.textLabel.text = "Occupation".localize
        occupationView.textField.placeholder = "Occupation".localize
        
        emailView.textLabel.text = "Email".localize
        emailView.textField.placeholder = "Email".localize
        
        
        motherNameView.textLabel.text = "Mother Name [AR]".localize
        motherNameView.textField.placeholder = "Mother Name [AR]".localize
        
        telephoneView.textLabel.text = "Telephone".localize
        telephoneView.textField.placeholder = "Telephone".localize
        
        
        mobileNoView.textLabel.text = "Mobile No".localize
        mobileNoView.textField.placeholder = "Mobile No".localize
        
        
        let gradient = CAGradientLayer()
        gradient.frame = self.nextButton.bounds
        gradient.colors = [UIColor.green]
        
        self.nextButton.applyGradient(colours: [AppConstants.firstBrownColor, AppConstants.secondBrownColor])
        //self.loginButton.backgroundColor = .green
        self.nextButton.layer.cornerRadius = 20
        self.nextButton.layer.masksToBounds = true
        
        
        gradient.frame = self.previousButton.bounds
        gradient.colors = [UIColor.green]
        
        self.previousButton.applyGradient(colours: [AppConstants.firstBrownColor, AppConstants.secondBrownColor])
        //self.loginButton.backgroundColor = .green
        self.previousButton.layer.cornerRadius = 20
        self.previousButton.layer.masksToBounds = true
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
        
        materialStatusView.textField.inputAccessoryView = toolBar
        

        materialStatusView.textField.isUserInteractionEnabled = true
        materialStatusView.textField.inputView = materialStatusPicker
      
        
      
        materialStatusPicker.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        
        
        educationView.textField.inputAccessoryView = toolBar
          

          
        educationView.textField.isUserInteractionEnabled = true
        
        educationView.textField.inputView = educationPicker
        
        educationPicker.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        nationalityView.textField.inputAccessoryView = toolBar
          

          
        nationalityView.textField.isUserInteractionEnabled = true
        
        nationalityView.textField.inputView = nationalityPicker
        nationalityPicker.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    @objc func onClickedToolbeltButton(_ sender: Any){
        self.view.endEditing(true)
    }
    
    func getMaterialStatus() {
        WebService.RetrieveMaritalStatusSocial { (json) in
            print(json)
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
                guard let data = json["data"] as? [String:Any] else {return}
                guard let results = data["result"] as? [String:Any] else {return}
                guard let list = results["list"] as? [[String:Any]] else {return}
                
                
                for r in list {
                    
                    
                    let item = MOCDMaterialStatusSocial()
                    item.MaritalStatusId = String(describing: r["MaritalStatusId"] ?? "" )
                    item.MaritalStatusAR = String(describing: r["MaritalStatusAR"] ?? "" )
                    item.MaritalStatusEN = String(describing: r["MaritalStatusEN"] ?? "" )
                    
                    self.materialsArray.append(item)
                    
                }
                
                
                DispatchQueue.main.async {
                    
                    self.materialStatusPicker.reloadAllComponents()
                }
            }
            
      
        }
    }
    
    func getEducationalLevel() {
        WebService.RetrieveEducationLevelSocial { (json) in
            
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
                guard let data = json["data"] as? [String:Any] else {return}
                guard let results = data["result"] as? [String:Any] else {return}
                guard let list = results["list"] as? [[String:Any]] else {return}
                
                
                for r in list {
                    
                    
                    let item = MOCDEducationSocial()
                    item.EducationId = String(describing: r["EducationId"] ?? "" )
                    item.EducationTitleAR = String(describing: r["EducationTitleAR"] ?? "" )
                    item.EducationTitleEN = String(describing: r["EducationTitleEN"] ?? "" )
                    
                    self.eduactaionsArray.append(item)
                    
                }
                
                
                DispatchQueue.main.async {
                    
                    self.educationPicker.reloadAllComponents()
                }
            }
            
        }
    }
    
    
    func getNationalities() {
        WebService.RetrieveNationalitySocial { (json) in
            
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
                guard let data = json["data"] as? [String:Any] else {return}
                guard let results = data["result"] as? [String:Any] else {return}
                guard let list = results["list"] as? [[String:Any]] else {return}
                
                
                for r in list {
                    
                    
                    let item = MOCDNationalitySocial()
                    item.NationalityId = String(describing: r["NationalityId"] ?? "" )
                    item.NationalityTitleAR = String(describing: r["NationalityTitleAR"] ?? "" )
                    item.NationalityTitleEN = String(describing: r["NationalityTitleEN"] ?? "" )
                    
                    self.nationalitiesArray.append(item)
                    
                }
                
                
                DispatchQueue.main.async {
                    
                    self.nationalityPicker.reloadAllComponents()
                }
            }
            
        }
    }
    
    func validateFields() -> Bool{
        
        //return true
        
        
        socialAidItem.ApplicantNameAR = nameArView.textField.text ?? ""
        socialAidItem.ApplicantNameEN = nameEnView.textField.text ?? ""
        socialAidItem.FamilyNo = familyNoView.textField.text ?? ""
        socialAidItem.TownNo = townNoView.textField.text ?? ""
        socialAidItem.DateOfBirth = dateOfBirthView.textField.text ?? ""
        socialAidItem.GenderId = self.genderView.firstCheckBox.checkState == .checked ? "2" : "1"
        socialAidItem.Occupation = occupationView.textField.text ?? ""
        socialAidItem.EmailAddress = emailView.textField.text ?? ""
        socialAidItem.MotherNameAR = motherNameView.textField.text ?? ""
        socialAidItem.PhoneNo = telephoneView.textField.text ?? ""
        socialAidItem.MobileNo = mobileNoView.textField.text ?? ""
        
        
        
        
        let df = DateFormatter()
        df.dateFormat = "MM/dd/yyyy"
        socialAidItem.DateOfBirth  = df.string(from: dateOfBirthView.date )
        
        
        if socialAidItem.ApplicantNameAR == "" ||
            socialAidItem.ApplicantNameEN == "" ||
            socialAidItem.FamilyNo == "" ||
            socialAidItem.TownNo == "" ||
            socialAidItem.DateOfBirth == "" ||
            socialAidItem.GenderId == "" ||
            socialAidItem.Occupation == "" ||
            socialAidItem.EmailAddress == "" ||
            socialAidItem.MotherNameAR == "" ||
            socialAidItem.PhoneNo == "" ||
            socialAidItem.MobileNo == "" ||
            socialAidItem.MaritalStatusId == "" ||
            socialAidItem.NationalityId == "" ||
            socialAidItem.EducationId == "" 
            {
            
            Utils.showAlertWith(title: "Error".localize, message: "Please Fill All Fields".localize, viewController: self)
            return false
            
            
        }
        
        
        return true
        
    }
    @IBAction func nextButtonAction(_ sender: Any) {
        if !validateFields() {
            return
        }
        self.performSegue(withIdentifier: "toPassportInfo", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPassportInfo" {
            let dest = segue.destination as! socialPassportViewController
            dest.socialAidItem = self.socialAidItem
        }
    }
}
extension socialInformationViewController: UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == materialStatusPicker{
            return materialsArray.count
        }else if pickerView == educationPicker{
            return eduactaionsArray.count
        }else if pickerView == nationalityPicker{
            return nationalitiesArray.count
        }
        
        
        return 0
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == materialStatusPicker{
            let item = materialsArray[row]
            let title = AppConstants.isArabic() ? item.MaritalStatusAR :  item.MaritalStatusEN
            
            return title
        }else if pickerView == educationPicker{
            let item = eduactaionsArray[row]
            let title = AppConstants.isArabic() ? item.EducationTitleAR :  item.EducationTitleAR
            
            return title
        }else if pickerView == nationalityPicker{
            let item = nationalitiesArray[row]
            let title = AppConstants.isArabic() ? item.NationalityTitleAR :  item.NationalityTitleEN
            
            return title
        }
        
        return ""
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == materialStatusPicker{
            let item = materialsArray[row]
            
              //self.emirate = item.id
           
            //childItem.emirateID = item.id
            socialAidItem.MaritalStatusId = item.MaritalStatusId
            self.materialStatusView.textField.text = AppConstants.isArabic() ? item.MaritalStatusAR :  item.MaritalStatusEN
        }else if pickerView == educationPicker{
            let item = eduactaionsArray[row]
            
           
            socialAidItem.EducationId = item.EducationId
            self.educationView.textField.text = AppConstants.isArabic() ? item.EducationTitleAR :  item.EducationTitleEN
        }else if pickerView == nationalityPicker{
            let item = nationalitiesArray[row]
            
              //self.emirate = item.id
           
            //childItem.emirateID = item.id
            socialAidItem.NationalityId = item.NationalityId
            self.nationalityView.textField.text = AppConstants.isArabic() ? item.NationalityTitleAR :  item.NationalityTitleEN
        }
        
    }
    
}
