//
//  DisabledCardDetailsVC.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 2/26/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit


class DisabledCardDetailsVC: UIViewController  ,serviceProtocol{
    func checkboxChnaged(value: Int) {
        
    }
    var countriesArray: [MOCDCountry] = []
    var mStatusArray: [MOCDMaterialStatus] = []
    var qualificationArray: [MOCDQualification] = []
    var accommodationArray: [MOCDAccommodation] = []
    
    @IBOutlet var nationalitiesPickerView: UIPickerView!
    @IBOutlet var materialStatusPickerView: UIPickerView!
    @IBOutlet var qualificationPickerView: UIPickerView!
    @IBOutlet var accomodationPickerView: UIPickerView!
    var toolBar = UIToolbar()
    
    
    @IBOutlet var nationalityView: selectTextField!
    @IBOutlet var identificationNoView: textFieldMandatory!
    @IBOutlet var UIDView: textFieldMandatory!
    @IBOutlet var firstNameEnView: textFieldMandatory!
    @IBOutlet var fatherNameEnView: textFieldMandatory!
    @IBOutlet var grandFatherView: textFieldMandatory!
    @IBOutlet var familyNameEnView: textFieldMandatory!
    
    
    @IBOutlet var FirstNameArView: textFieldMandatory!
    @IBOutlet var FatherNameArView: textFieldMandatory!
    @IBOutlet var grandFatherArView: textFieldMandatory!
    @IBOutlet var FamilyNameArView: textFieldMandatory!
    
    @IBOutlet var birthDateView: dateTexteField!
    @IBOutlet var genderView: multipleTextField!
    
    @IBOutlet var studentView: multipleTextField!
    @IBOutlet var materialStatusView: selectTextField!
    @IBOutlet var qualificationView: selectTextField!
    @IBOutlet var accomidationTypeView: selectTextField!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var previousButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFields()
        
        setupToolbar()
        getNationalities()
        getMaterialStatus()
        getQualification()
        getAccommodation()
    }
    
    func getNationalities() {
        WebService.getCountries { (json) in
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
            
                guard let data = json["data"] as? [String:Any] else {return}
                guard let results = data["result"] as? [String:Any] else {return}
                guard let list = results["list"] as? [[String:Any]] else {return}
               
                for r in list {
                    
                    
                    let item = MOCDCountry()
                   
                    item.CountryId = String (describing: r["CountryId"] ?? "" )
                    item.CountryNameAr = r["CountryNameAr"] as! String
                    item.CountryNameEn  = r["CountryNameEn"] as! String
                    
                    item.CountryCode = r["CountryCode"] as! String
                    self.countriesArray.append(item)
                }
                
                DispatchQueue.main.async {
                  
                    self.nationalitiesPickerView.reloadAllComponents()
                }
            }
        }
    }
    func getMaterialStatus() {
        WebService.RetrieveMaritalStatus { (json) in
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
            
                guard let data = json["data"] as? [String:Any] else {return}
                guard let results = data["result"] as? [String:Any] else {return}
                guard let list = results["list"] as? [[String:Any]] else {return}
               
                for r in list {
                    
                    
                    let item = MOCDMaterialStatus()
                   
                    item.MaritalStatusId = String (describing: r["MaritalStatusId"] ?? "" )
                    item.MStatusEn = String (describing: r["MStatusEn"] ?? "")
                    item.MStatusAr  = String (describing: r["MStatusAr"] ?? "")
                    
                   
                    self.mStatusArray.append(item)
                }
                
                DispatchQueue.main.async {
                  
                    self.materialStatusPickerView.reloadAllComponents()
                }
            }
        }
    }
    func getAccommodation() {
        WebService.RetrieveAccommodationType { (json) in
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
            
                guard let data = json["data"] as? [String:Any] else {return}
                guard let results = data["result"] as? [String:Any] else {return}
                guard let list = results["list"] as? [[String:Any]] else {return}
               
                for r in list {
                    
                    
                    let item = MOCDAccommodation()
                   
                    item.AccommodationTypeId = String (describing: r["AccommodationTypeId"] ?? "" )
                    item.DisplayOrder = String (describing: r["DisplayOrder"] ?? "")
                    item.AccommodationTypeAr  = String (describing: r["AccommodationTypeAr"] ?? "")
                    item.AccommodationTypeEn  = String (describing: r["AccommodationTypeEn"] ?? "")
                    
                   
                    self.accommodationArray.append(item)
                }
                
                DispatchQueue.main.async {
                  
                    self.accomodationPickerView.reloadAllComponents()
                }
            }
        }
    }
    func getQualification() {
        WebService.RetrieveQualification { (json) in
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
            
                guard let data = json["data"] as? [String:Any] else {return}
                guard let results = data["result"] as? [String:Any] else {return}
                guard let list = results["list"] as? [[String:Any]] else {return}
               
                for r in list {
                    
                    
                    let item = MOCDQualification()
                   
                    item.QualificationId = String (describing: r["QualificationId"] ?? "" )
                    item.QualificationNameEn = String (describing: r["QualificationNameEn"] ?? "")
                    item.QualificationNameAr  = String (describing: r["QualificationNameAr"] ?? "")
                   
                    
                   
                    self.qualificationArray.append(item)
                }
                
                DispatchQueue.main.async {
                  
                    self.qualificationPickerView.reloadAllComponents()
                }
            }
        }
    }
    func setupToolbar() {
        
        toolBar.tintColor = AppConstants.BROWN_COLOR
        
        toolBar.barStyle = .default
        
        toolBar.isTranslucent = true
           
           
        toolBar.sizeToFit()
           
           
           
        var items = [UIBarButtonItem]()
           
        items.append(
        
            UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(onClickedToolbeltButton(_:)))
        
        )
           
        items.append(
        
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace , target: self, action: nil))
           
        items.append(
        
            UIBarButtonItem(barButtonSystemItem: .done , target: self, action: #selector(onClickedToolbeltButton(_:)))
        
        )
           
        
        toolBar.items = items
        
        
        toolBar.backgroundColor = AppConstants.GREEN_COLOR
           
        nationalityView.textField.inputAccessoryView = toolBar
           
        materialStatusView.textField.inputAccessoryView = toolBar
        
        qualificationView.textField.inputAccessoryView = toolBar
        accomidationTypeView.textField.inputAccessoryView = toolBar
        
        
    }
    @objc func onClickedToolbeltButton(_ sender: Any){
        self.view.endEditing(true)
    }
    func setupFields() {
        nationalityView.textField.placeholder = "Please Select"
        nationalityView.textLabel.text = "Nationality"
        nationalityView.textField.inputView = nationalitiesPickerView
        
        identificationNoView.textField.placeholder = "Identification No"
        identificationNoView.textLabel.text = "Identification No"
        identificationNoView.textField.keyboardType = .numberPad
        
        
        UIDView.textField.placeholder = "U.ID"
        UIDView.textLabel.text = "U.ID"
        UIDView.starImage.isHidden = true
        
        firstNameEnView.textField.placeholder = "First Name [EN]"
        firstNameEnView.textLabel.text = "First Name [EN]"
        
        
        fatherNameEnView.textField.placeholder = "Father Name [EN]"
        fatherNameEnView.textLabel.text = "Father Name [EN]"
        
        
        familyNameEnView.textField.placeholder = "Family Name [EN]"
        familyNameEnView.textLabel.text = "Family Name [EN]"
        familyNameEnView.starImage.isHidden = true
        
        grandFatherView.textField.placeholder = "Grandfather [EN]"
        grandFatherView.textLabel.text = "Grandfather [EN]"
        grandFatherView.starImage.isHidden = true
        
        
        
        FirstNameArView.textField.placeholder = "First Name [AR]"
        FirstNameArView.textLabel.text = "First Name [AR]"
        
        
        FatherNameArView.textField.placeholder = "Father Name [AR]"
        FatherNameArView.textLabel.text = "Father Name [AR]"
        
        
        FamilyNameArView.textField.placeholder = "Family Name [AR]"
        FamilyNameArView.textLabel.text = "Family Name [AR]"
        FamilyNameArView.starImage.isHidden = true
        
        grandFatherArView.textField.placeholder = "Grandfather [AR]"
        grandFatherArView.textLabel.text = "Grandfather [AR]"
        grandFatherArView.starImage.isHidden = true
        
        
        
        
        birthDateView.textLabel.text = "Date of Birth"
        //birthDateView.textField.placeholder = "Date of Birth"
        birthDateView.viewController = self
        
        genderView.textLabel.text = "Gender"
        genderView.firstLabel.text = "Female"
        genderView.secondLabel.text = "Male"
        genderView.delegate = self
        
        
        studentView.textLabel.text = "Student"
        studentView.firstLabel.text = "Yes"
        studentView.secondLabel.text = "No"
        studentView.delegate = self
        
        materialStatusView.textLabel.text = "Material Status"
        materialStatusView.textField.inputView = materialStatusPickerView
        materialStatusView.textField.placeholder = "Please Select"
        
        
        qualificationView.textLabel.text = "Qulaification"
        qualificationView.textField.inputView = qualificationPickerView
        qualificationView.textField.placeholder = "Please Select"
        
        accomidationTypeView.textLabel.text = "Accommodation Type"
        accomidationTypeView.textField.inputView = accomodationPickerView
        accomidationTypeView.textField.placeholder = "Please Select"
        
        
        
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
    @IBAction func nextButtonAction(_ sender: Any) {
        self.performSegue(withIdentifier: "toAddressDetails", sender: self)
    }
    @IBAction func previousButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension DisabledCardDetailsVC: UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == nationalitiesPickerView{
            return countriesArray.count
        }else if pickerView == materialStatusPickerView{
            return mStatusArray.count
        }else if pickerView == accomodationPickerView{
            return accommodationArray.count
        }else if pickerView == qualificationPickerView{
            return qualificationArray.count
        }
        
        
        return 0
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == nationalitiesPickerView{
            let item = countriesArray[row]
            let title = item.CountryNameEn
            
            return title
        }else if pickerView == materialStatusPickerView{
             let item = mStatusArray[row]
            let title = item.MStatusEn
            
            return title
        }else if pickerView == qualificationPickerView{
             let item = qualificationArray[row]
            let title = item.QualificationNameEn
            
            return title
        }else if pickerView == accomodationPickerView{
             let item = accommodationArray[row]
            let title = item.AccommodationTypeEn
            
            return title
        }
        return ""
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == nationalitiesPickerView{
            let item = countriesArray[row]
          
            
           
            //self.nationality_id = item.CountryId
            self.nationalityView.textField.text = item.CountryNameEn
            
            
            
        } else if pickerView == materialStatusPickerView{
            let item = mStatusArray[row]
            self.materialStatusView.textField.text = item.MStatusEn
        }else if pickerView == accomodationPickerView{
            let item = accommodationArray[row]
            self.accomidationTypeView.textField.text = item.AccommodationTypeEn
        }else if pickerView == qualificationPickerView{
            let item = qualificationArray[row]
            self.qualificationView.textField.text = item.QualificationNameEn
        }
        
    }
    
}
