//
//  DisabledCardDetailsVC.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 2/26/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class DisabledCardDetailsVC: UIViewController  ,serviceProtocol , refreshDelegate ,NVActivityIndicatorViewable{
    func checkboxChnaged(value: Int) {
        
    }
    var organizationsArray: [MOCDOrganization] = []
    var newCardItem: newCardStruct!
    var countriesArray: [MOCDCountry] = []
    var mStatusArray: [MOCDMaterialStatus] = []
    var qualificationArray: [MOCDQualification] = []
    var accommodationArray: [MOCDAccommodation] = []
    var instituteArray: [MOCDInstitute] = []
    var workArray: [MOCDWorkField] = []
    
    var isRenewal: Bool = false
    
    let nvactivity = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
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
    
    
    
    
    @IBOutlet var workingStatusView: multipleTextField!
    @IBOutlet var workingTypeView: selectTextField!
    @IBOutlet var workingCompanyView: textFieldMandatory!
    @IBOutlet var instituteView: selectTextField!
    @IBOutlet var centerView: selectTextField!
    
    
    @IBOutlet var expireVisaDateView: dateTexteField!
    @IBOutlet var expireVisaHeight: NSLayoutConstraint!
    @IBOutlet var expireVisaVHeight: NSLayoutConstraint!
    
    
    @IBOutlet var wStatusHeight: NSLayoutConstraint!
    @IBOutlet var wTypeHeigh: NSLayoutConstraint!
    @IBOutlet var wCompanyHeight: NSLayoutConstraint!
    @IBOutlet var instituteHeight: NSLayoutConstraint!
    @IBOutlet var centerHeight: NSLayoutConstraint!
    
    @IBOutlet var wStatusVHeight: NSLayoutConstraint!
    
    @IBOutlet var wTypeVHeight: NSLayoutConstraint!
    @IBOutlet var wCompanyVHeight: NSLayoutConstraint!
    @IBOutlet var instituteVHeight: NSLayoutConstraint!
    @IBOutlet var centerVHeight: NSLayoutConstraint!
    
    
    @IBOutlet var workTypePicker: UIPickerView!
    @IBOutlet var institutePicker: UIPickerView!
    @IBOutlet var centerPicker: UIPickerView!
    
    
    
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var previousButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        hideViews()
        setupFields()
        
        setupToolbar()
        getNationalities()
        getMaterialStatus()
        getQualification()
        getAccommodation()
        
        
        getOrganization()
        getWorkField()
        getInstitute()
        if isRenewal {
            fillField()
        }
        
        
    }
    func hideViews() {
        wStatusHeight.constant = 0
        wTypeHeigh.constant = 0
        wCompanyHeight.constant = 0
        instituteHeight.constant = 0
        centerHeight.constant = 0
        expireVisaHeight.constant = 0
        
        
        
        wStatusVHeight.constant = 0
        wTypeVHeight.constant = 0
        wCompanyVHeight.constant = 0
        instituteVHeight.constant = 0
        centerVHeight.constant = 0
        expireVisaVHeight.constant = 0
        
        
        
        workingStatusView.isHidden = true
        workingTypeView.isHidden = true
        workingCompanyView.isHidden = true
        instituteView.isHidden = true
        centerView.isHidden = true
        expireVisaDateView.isHidden = true
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
                    
                    if self.isRenewal{
                        guard let mItem = self.countriesArray.filter({ (item) -> Bool in
                            item.CountryId == self.newCardItem.NationalityId
                        }).first else {
                            return
                        }
                        let title = AppConstants.isArabic() ? mItem.CountryNameAr : mItem.CountryNameEn
                        self.nationalityView.textField.text = title
                    }
                    
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
                    
                    if self.isRenewal{
                        guard let mItem = self.mStatusArray.filter({ (item) -> Bool in
                            item.MaritalStatusId == self.newCardItem.MaritalStatusId
                        }).first else {
                            return
                        }
                        let title = AppConstants.isArabic() ? mItem.MStatusAr : mItem.MStatusEn
                        self.materialStatusView.textField.text = title
                    }
                    
                    
                    
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
                    if self.isRenewal{
                        
                        guard let mItem = self.accommodationArray.filter({ (item) -> Bool in
                            item.AccommodationTypeId == self.newCardItem.AccommodationTypeId
                        }).first else {
                            return
                        }
                        let title = AppConstants.isArabic() ? mItem.AccommodationTypeAr : mItem.AccommodationTypeEn
                        self.accomidationTypeView.textField.text = title
                    }
                    
                }
            }
        }
    }
    
    func getInstitute() {
        WebService.RetrieveStudentInstituteType { (json) in
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
            
                guard let data = json["data"] as? [String:Any] else {return}
                guard let results = data["result"] as? [String:Any] else {return}
                guard let list = results["list"] as? [[String:Any]] else {return}
               
                for r in list {
                    
                    
                    let item = MOCDInstitute()
                   
                    item.InstituteId = String (describing: r["InstituteId"] ?? "" )
                    item.InstituteNameEn = String (describing: r["InstituteNameEn"] ?? "")
                    item.InstituteNameAr  = String (describing: r["InstituteNameAr"] ?? "")
                    
                   
                    self.instituteArray.append(item)
                }
                
                DispatchQueue.main.async {
                  
                    self.institutePicker.reloadAllComponents()
                }
            }
        }
    }
    
    func getWorkField() {
        WebService.RetrieveWorkField { (json) in
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
            
                guard let data = json["data"] as? [String:Any] else {return}
                guard let results = data["result"] as? [String:Any] else {return}
                guard let list = results["list"] as? [[String:Any]] else {return}
               
                for r in list {
                    
                    
                    let item = MOCDWorkField()
                   
                    item.WorkFieldId = String (describing: r["WorkFieldId"] ?? "" )
                    item.WorkFieldNameEn = String (describing: r["WorkFieldNameEn"] ?? "")
                    item.WorkFieldNameAr  = String (describing: r["WorkFieldNameAr"] ?? "")
                    
                   
                    self.workArray.append(item)
                }
                
                DispatchQueue.main.async {
                  
                    self.workTypePicker.reloadAllComponents()
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
    
    func getOrganization() {
        let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        
        
        WebService.RetrieveOrganizations { (json) in
            print(json)
            DispatchQueue.main.async {
                self.stopAnimating(nil)
            }
            
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
                
                guard let data = json["data"] as? [String: Any] else{return}
                guard let result = data["result"] as? [String: Any] else {return}
                guard let list = result["list"] as? [[String: Any]] else {return}
                
                for r in list {
                let routine: MOCDOrganization = MOCDOrganization()
                    
                    routine.OrgId = r["OrgId"] as? String  ?? ""
                    routine.OrgTitleAr = r["OrgTitleAr"] as? String  ?? ""
                    routine.OrgTitleEn = r["OrgTitleEn"] as? String  ?? ""
                  
                    
                    self.organizationsArray.append(routine)
                    
                    
                }
                
                DispatchQueue.main.async {
                    
                    
                    self.centerPicker.reloadAllComponents()
                }
            }else{
                
                
                DispatchQueue.main.async {
                                   
                    Utils.showAlertWith(title: "Error".localize, message: message, viewController: self)
                    
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
        
        workingTypeView.textField.inputAccessoryView = toolBar
        instituteView.textField.inputAccessoryView = toolBar
        centerView.textField.inputAccessoryView = toolBar
        
        
        
        
        nationalitiesPickerView.translatesAutoresizingMaskIntoConstraints = false
        materialStatusPickerView.translatesAutoresizingMaskIntoConstraints = false
        qualificationPickerView.translatesAutoresizingMaskIntoConstraints = false
        accomodationPickerView.translatesAutoresizingMaskIntoConstraints = false
        
        workTypePicker.translatesAutoresizingMaskIntoConstraints = false
        institutePicker.translatesAutoresizingMaskIntoConstraints = false
        centerPicker.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        workingTypeView.textField.inputView = workTypePicker
        instituteView.textField.inputView = institutePicker
        centerView.textField.inputView = centerPicker
        
        
        
    }
    @objc func onClickedToolbeltButton(_ sender: Any){
        self.view.endEditing(true)
    }
    func setupFields() {
        nationalityView.textField.placeholder = "Please Select".localize
        nationalityView.textLabel.text = "Nationality".localize
        nationalityView.textField.inputView = nationalitiesPickerView
        
        identificationNoView.textField.placeholder = "Identification No".localize
        identificationNoView.textLabel.text = "Identification No".localize
        identificationNoView.textField.keyboardType = .numberPad
        
        
        UIDView.textField.placeholder = "U.ID".localize
        UIDView.textLabel.text = "U.ID".localize
        UIDView.starImage.isHidden = true
        
        firstNameEnView.textField.placeholder = "First Name [EN]".localize
        firstNameEnView.textLabel.text = "First Name [EN]".localize
        
        
        fatherNameEnView.textField.placeholder = "Father Name [EN]".localize
        fatherNameEnView.textLabel.text = "Father Name [EN]".localize
        
        
        familyNameEnView.textField.placeholder = "Family Name [EN]".localize
        familyNameEnView.textLabel.text = "Family Name [EN]".localize
        familyNameEnView.starImage.isHidden = true
        
        grandFatherView.textField.placeholder = "Grandfather [EN]".localize
        grandFatherView.textLabel.text = "Grandfather [EN]".localize
        grandFatherView.starImage.isHidden = true
        
        
        
        FirstNameArView.textField.placeholder = "First Name [AR]".localize
        FirstNameArView.textLabel.text = "First Name [AR]".localize
        
        
        FatherNameArView.textField.placeholder = "Father Name [AR]".localize
        FatherNameArView.textLabel.text = "Father Name [AR]".localize
        
        
        FamilyNameArView.textField.placeholder = "Family Name [AR]".localize
        FamilyNameArView.textLabel.text = "Family Name [AR]".localize
        FamilyNameArView.starImage.isHidden = true
        
        grandFatherArView.textField.placeholder = "Grandfather [AR]".localize
        grandFatherArView.textLabel.text = "Grandfather [AR]".localize
        grandFatherArView.starImage.isHidden = true
        
        
        
        
        birthDateView.textLabel.text = "Date of Birth".localize
        //birthDateView.textField.placeholder = "Date of Birth"
        birthDateView.viewController = self
        birthDateView.delegate = self
        
        
        expireVisaDateView.textLabel.text = "Residence Expiry Date".localize
        //birthDateView.textField.placeholder = "Date of Birth"
        expireVisaDateView.viewController = self
        expireVisaDateView.delegate = self
        
        
        genderView.textLabel.text = "Gender".localize
        genderView.firstLabel.text = "Female".localize
        genderView.secondLabel.text = "Male".localize
        genderView.delegate = self
        
        
        studentView.textLabel.text = "Student".localize
        studentView.firstLabel.text = "No".localize
        studentView.secondLabel.text = "Yes".localize
        studentView.delegate = self
        studentView.refreshDelegate = self
        
        
        materialStatusView.textLabel.text = "Material Status".localize
        materialStatusView.textField.inputView = materialStatusPickerView
        materialStatusView.textField.placeholder = "Please Select".localize
        
        
        qualificationView.textLabel.text = "Qulaification".localize
        qualificationView.textField.inputView = qualificationPickerView
        qualificationView.textField.placeholder = "Please Select".localize
        
        accomidationTypeView.textLabel.text = "Accommodation Type".localize
        accomidationTypeView.textField.inputView = accomodationPickerView
        accomidationTypeView.textField.placeholder = "Please Select".localize
        
        
        
        workingStatusView.textLabel.text = "Working Status".localize
        workingStatusView.firstLabel.text = "Not Working".localize
        workingStatusView.secondLabel.text = "Working".localize
        workingStatusView.delegate = self
        workingStatusView.refreshDelegate = self
        
        workingTypeView.textLabel.text = "Working Type".localize
        //workingTypeView.textField.inputView = accomodationPickerView
        workingTypeView.textField.placeholder = "Please Select".localize
        
        
        
        instituteView.textField.placeholder = "Please Select".localize
        instituteView.textLabel.text = "Institute".localize
        //instituteView.starImage.isHidden = true
        
        
        centerView.textField.placeholder = "Please Select".localize
            
        centerView.textLabel.text = "Center".localize
        
        //centerView.starImage.isHidden = true
        
        
        
        
        workingTypeView.textLabel.text = "Working Type".localize
        workingTypeView.textField.inputView = accomodationPickerView
        workingTypeView.textField.placeholder = "Please Select".localize
        
        workingCompanyView.textField.placeholder = "Company".localize
        workingCompanyView.textLabel.text = "Company".localize
        workingCompanyView.starImage.isHidden = true
        
        
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
    
    func refreshDateView() {
        if birthDateView.date.calculateAge() > 18 {
            
            
            wStatusHeight.constant = 60
            
            wStatusVHeight.constant = 30
            
            workingStatusView.isHidden = false
            
        }
    }
    
    
    func refreshMultipleView() {
        if workingStatusView.firstCheckBox.checkState == .checked {
            wTypeHeigh.constant = 0
            wCompanyHeight.constant = 0
            
            
            wTypeVHeight.constant = 0
            wCompanyVHeight.constant = 0
            
            
            workingTypeView.isHidden = true
            workingCompanyView.isHidden = true
        }else{
            
            wTypeHeigh.constant = 60
            wCompanyHeight.constant = 60
            
            
            wTypeVHeight.constant = 30
            wCompanyVHeight.constant = 30
            
            
            workingTypeView.isHidden = false
            workingCompanyView.isHidden = false
        }
        
        if studentView.firstCheckBox.checkState == .checked {
            instituteHeight.constant = 0
            //centerHeight.constant = 0
            
            
            instituteVHeight.constant = 0
            //centerVHeight.constant = 0
            
            
            instituteView.isHidden = true
            //centerView.isHidden = true
        }else{
            
            instituteHeight.constant = 60
            //centerHeight.constant = 60
            
            
            instituteVHeight.constant = 30
            //centerVHeight.constant = 30
            
            
            instituteView.isHidden = false
            //centerView.isHidden = false
        }
        
    }
    func fillField() {
        //self.nationalityView.textField.text = self.newCardItem.NationalityId != "" ? self.countriesArray[Int(self.newCardItem.NationalityId) ?? 0].CountryNameEn : ""
        
        self.identificationNoView.textField.text = self.newCardItem.IdentificationNo
        self.firstNameEnView.textField.text = self.newCardItem.FirstNameEN
         
        self.fatherNameEnView.textField.text = self.newCardItem.FatherNameEN
        self.grandFatherView.textField.text = self.newCardItem.GrandfatherNameEN
        self.familyNameEnView.textField.text = self.newCardItem.FamilyNameEN
        self.FirstNameArView.textField.text = self.newCardItem.FirstNameAR
        self.FatherNameArView.textField.text = self.newCardItem.FatherNameAR
        self.grandFatherArView.textField.text = self.newCardItem.GrandfatherNameAR
        self.FamilyNameArView.textField.text = self.newCardItem.FamilyNameAR
        self.birthDateView.textField.text = self.newCardItem.DateOfBirth
        
        //self.materialStatusView.textField.text = self.newCardItem.MaritalStatusId != "" ? self.mStatusArray[Int(self.newCardItem.MaritalStatusId) ?? 0].MStatusEn : ""
        //self.accomidationTypeView.textField.text = self.newCardItem.AccommodationTypeId != "" ? self.accommodationArray[Int(self.newCardItem.AccommodationTypeId) ?? 0].AccommodationTypeEn : ""
        
        
        if self.newCardItem.NationalityId != "1" && self.newCardItem.NationalityId != "0" {
            self.expireVisaDateView.textField.text = self.newCardItem.expireVisaDate
            expireVisaHeight.constant = 60
                                       
            expireVisaVHeight.constant = 30
                                       
            expireVisaDateView.isHidden = false
        }
        
        
    }
    func validateFields() -> Bool {
        
        self.newCardItem.IdentificationNo = self.identificationNoView.textField.text ?? ""
        self.newCardItem.UID = self.UIDView.textField.text ?? ""
        self.newCardItem.FirstNameEN = self.firstNameEnView.textField.text ?? ""
        self.newCardItem.FatherNameEN = self.fatherNameEnView.textField.text ?? ""
        self.newCardItem.GrandfatherNameEN = self.grandFatherView.textField.text ?? ""
        self.newCardItem.FamilyNameEN = self.familyNameEnView.textField.text ?? ""
        self.newCardItem.FirstNameAR = self.FirstNameArView.textField.text ?? ""
        self.newCardItem.FatherNameAR = self.FatherNameArView.textField.text ?? ""
        self.newCardItem.GrandfatherNameAR = self.grandFatherArView.textField.text ?? ""
        self.newCardItem.FamilyNameAR = self.FamilyNameArView.textField.text ?? ""
        self.newCardItem.DateOfBirth = self.birthDateView.textField.text ?? ""
        self.newCardItem.GenderId = self.genderView.firstCheckBox.checkState == .checked ? "2" : "1"
        self.newCardItem.IsStudent = self.studentView.firstCheckBox.checkState == .checked ? "true" : "false"
        self.newCardItem.WorkFieldId = self.workingStatusView.firstCheckBox.checkState == .checked ? "true" : "false"
        self.newCardItem.Company = self.workingCompanyView.textField.text ?? ""
        self.newCardItem.ResidenceExpiryDate = self.expireVisaDateView.textField.text ?? ""
        
        
        if self.newCardItem.NationalityId == "" ||
        self.newCardItem.IdentificationNo == "" ||
        self.newCardItem.FirstNameEN == "" ||
        self.newCardItem.FatherNameEN == "" ||
        self.newCardItem.FirstNameAR == "" ||
        self.newCardItem.FatherNameAR == "" ||
        self.newCardItem.DateOfBirth == "" ||
        self.newCardItem.GenderId == "" ||
        self.newCardItem.IsStudent == "" ||
        self.newCardItem.MaritalStatusId == "" ||
        self.newCardItem.AccommodationTypeId == "" {
            
            
            Utils.showAlertWith(title: "Error", message: "Please Fill All Fields".localize, viewController: self)
            return false
        }
        
        
        if self.newCardItem.NationalityId != "1" && self.newCardItem.NationalityId != "0" {
            
            
            self.newCardItem.expireVisaDate = self.expireVisaDateView.textField.text ?? ""
            if self.newCardItem.expireVisaDate == "" {
                Utils.showAlertWith(title: "Error", message: "Please Fill All Fields".localize, viewController: self)
                return false
            }
            
        }
        
        
        
        
        if !self.newCardItem.IdentificationNo.hasPrefix("784") {
            Utils.showAlertWith(title: "Error", message: "Identification No should start with 784".localize, viewController: self)
            return false
        }
        
        
        if self.newCardItem.IdentificationNo.count != 15 {
            Utils.showAlertWith(title: "Error", message: "Identification No should be 15 characters".localize, viewController: self)
            return false
        }
        return true
    }
    @IBAction func nextButtonAction(_ sender: Any) {
        
        if validateFields() {
            self.performSegue(withIdentifier: "toAddressDetails", sender: self)
        }
        
    }
    @IBAction func previousButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddressDetails" {
            let dest = segue.destination as! addressDetailsViewController
            dest.newCardItem = self.newCardItem
            dest.isRenewal = isRenewal
        }
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
        }else if pickerView == centerPicker{
            return organizationsArray.count
        }else if pickerView == institutePicker{
            return instituteArray.count
        }else if pickerView == workTypePicker{
            return workArray.count
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
        }else if pickerView == centerPicker{
            let item = organizationsArray[row]
            let title = item.OrgTitleEn
            return title
        }else if pickerView == institutePicker{
            let item = instituteArray[row]
            let title = item.InstituteNameEn
            return title
        }else if pickerView == workTypePicker{
            let item = workArray[row]
            let title = item.WorkFieldNameEn
            return title
        }
        return ""
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == nationalitiesPickerView{
            let item = countriesArray[row]
          
            
           
            //self.nationality_id = item.CountryId
            self.nationalityView.textField.text = item.CountryNameEn
            self.newCardItem.NationalityId = item.CountryId
            
            
            
            if self.newCardItem.NationalityId != "1" {
                
                
                expireVisaHeight.constant = 60
                                           
                expireVisaVHeight.constant = 30
                                           
                expireVisaDateView.isHidden = false
            }else{
                expireVisaHeight.constant = 0
                                           
                expireVisaVHeight.constant = 0
                                           
                expireVisaDateView.isHidden = true
            }
            
        } else if pickerView == materialStatusPickerView{
            let item = mStatusArray[row]
            self.materialStatusView.textField.text = item.MStatusEn
       
            self.newCardItem.MaritalStatusId = item.MaritalStatusId
        }else if pickerView == accomodationPickerView{
            let item = accommodationArray[row]
            
            self.accomidationTypeView.textField.text = item.AccommodationTypeEn
            self.newCardItem.AccommodationTypeId = item.AccommodationTypeId
        }else if pickerView == qualificationPickerView{
            let item = qualificationArray[row]
            self.qualificationView.textField.text = item.QualificationNameEn
        }else if pickerView == centerPicker{
            let item = organizationsArray[row]
            self.centerView.textField.text = item.OrgTitleEn
            
            
           
        }else if pickerView == institutePicker{
            let item = instituteArray[row]
            self.instituteView.textField.text = item.InstituteNameEn
            self.newCardItem.InstitutionId = item.InstituteId
            if item.InstituteNameEn == "Center" {
                
                
                centerHeight.constant = 60
                            
                centerVHeight.constant = 30
                            
                centerView.isHidden = false
            }else{
                centerHeight.constant = 0
                            
                centerVHeight.constant = 0
                
                centerView.isHidden = true
                
            }
        }else if pickerView == workTypePicker{
            let item = workArray[row]
            self.newCardItem.WorkFieldId = item.WorkFieldId
            self.workingTypeView.textField.text = item.WorkFieldNameEn
        }
        
    }
    
}
