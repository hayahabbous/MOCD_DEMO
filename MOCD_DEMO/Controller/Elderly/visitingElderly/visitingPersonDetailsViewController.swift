//
//  visitingPersonDetailsViewController.swift
//  MOCD_DEMO
//
//  Created by haya habbous on 15/04/2021.
//  Copyright © 2021 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView


class visitingPersonDetailsViewController: UIViewController ,NVActivityIndicatorViewable{
    
    var requestId: String = ""
    var appReference: String = ""
    var contentString: String = ""
    var nationalitiesList: [MOCDNationalitiesMaster] = []
    var emiratesList: [MOCDNationalitiesMaster] = []
    var hobbyList: [MOCDNationalitiesMaster] = []
    var activityList: [MOCDNationalitiesMaster] = []
    var genderList: [MOCDNationalitiesMaster] = []
    var toolBar = UIToolbar()
    
    
    @IBOutlet var nationalityPicker: UIPickerView!
    @IBOutlet var emiratePicker: UIPickerView!
    @IBOutlet var hobbyPicker: UIPickerView!
    @IBOutlet var appointmentPicker: UIPickerView!
    
    
    @IBOutlet weak var emiratesIDView: textFieldMandatory!
    @IBOutlet weak var firstnameView: textFieldMandatory!
    @IBOutlet weak var fatherNameEnView: textFieldMandatory!
    @IBOutlet weak var grandfatherEnView: textFieldMandatory!
    @IBOutlet weak var familyNameEnView: textFieldMandatory!
    @IBOutlet weak var firstNameArView: textFieldMandatory!
    @IBOutlet weak var fatherNameArView: textFieldMandatory!
    @IBOutlet weak var grandfatherArView: textFieldMandatory!
    @IBOutlet weak var familyNameArView: textFieldMandatory!
    @IBOutlet weak var nationalitiesView: selectTextField!
    @IBOutlet weak var emirateView: selectTextField!
    @IBOutlet weak var genderView: multipleTextField!
    @IBOutlet weak var dateOfBirthView: dateTexteField!
    @IBOutlet weak var residenceAddress: textFieldMandatory!
    @IBOutlet weak var telephoneView: textFieldMandatory!
    @IBOutlet weak var otherTelephoneView: textFieldMandatory!
    @IBOutlet weak var mobileNumberView: textFieldMandatory!
    @IBOutlet weak var emailView: textFieldMandatory!
    @IBOutlet weak var hobbyView: selectTextField!
    @IBOutlet weak var activityView: selectTextField!
    
    @IBOutlet weak var appointmentDateView: dateTexteField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    
    
    var  visitElderlyItemItem: visitingElderly = visitingElderly()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupField()
        setupToolbar()
        
        getEmirates()
        getNationalities()
        getHobbies()
        getActivities()
        getGenders()
        
    }
    
    func setupField() {
        emiratesIDView.textLabel.text = "Emirates ID".localize
        emiratesIDView.textField.placeholder = "Emirates ID".localize
       
        firstnameView.textLabel.text = "First Name [EN]".localize
        firstnameView.textField.placeholder = "First Name [EN]".localize
        
        
        fatherNameEnView.textLabel.text = "Father Name [EN]".localize
        fatherNameEnView.textField.placeholder = "Father Name [EN]".localize
        
        
        grandfatherEnView.textLabel.text = "Grandfather [EN]".localize
        grandfatherEnView.textField.placeholder = "Grandfather [EN]".localize
        
        
        familyNameEnView.textLabel.text = "Family Name [EN]".localize
        familyNameEnView.textField.placeholder = "Family Name [EN]".localize
        
        
        firstNameArView.textLabel.text = "First Name [AR]".localize
        firstNameArView.textField.placeholder = "First Name [AR]".localize
        
        
        fatherNameArView.textLabel.text = "Father Name [AR]".localize
        fatherNameArView.textField.placeholder = "Father Name [AR]".localize
        
        
        grandfatherArView.textLabel.text = "Grandfather [AR]".localize
        grandfatherArView.textField.placeholder = "Grandfather [AR]".localize
        
        
        familyNameArView.textLabel.text = "Family Name [AR]".localize
        familyNameArView.textField.placeholder = "Family Name [AR]".localize
        
        
        dateOfBirthView.textLabel.text = "Date of Birth".localize
        dateOfBirthView.viewController = self
        
        
        appointmentDateView.textLabel.text = "Appointment Date".localize
        appointmentDateView.viewController = self
        nationalitiesView.textLabel.text = "Nationality".localize
        nationalitiesView.textField.placeholder = "Please Select".localize
        
        
        emirateView.textLabel.text = "Residence Emirate".localize
        emirateView.textField.placeholder = "Please Select".localize
        
        genderView.textLabel.text = "Gender".localize
        genderView.firstLabel.text = "Female".localize
        genderView.secondLabel.text = "Male".localize
        
        residenceAddress.textLabel.text = "Residence Address".localize
        residenceAddress.textField.placeholder = "Residence Address".localize
        
        
        telephoneView.textLabel.text = "Telephone Number".localize
        telephoneView.textField.placeholder = "Telephone Number".localize
        
        otherTelephoneView.textLabel.text = "Other Telephone Number".localize
        otherTelephoneView.textField.placeholder = "Other Telephone Number".localize
        
        
        mobileNumberView.textLabel.text = "Mobile Number".localize
        mobileNumberView.textField.placeholder = "Mobile Number".localize
        
        
        emailView.textLabel.text = "Email".localize
        emailView.textField.placeholder = "Email".localize
        
        
        
        hobbyView.textLabel.text = "Hobby".localize
        hobbyView.textField.placeholder = "Please Select".localize
        
        activityView.textLabel.text = "Activity".localize
        activityView.textField.placeholder = "Please Select".localize
        
        
        
        
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
           
        nationalitiesView.textField.inputAccessoryView = toolBar
        nationalitiesView.textField.inputView = nationalityPicker
        
        
        emirateView.textField.inputAccessoryView = toolBar
        emirateView.textField.inputView = emiratePicker
        
        hobbyView.textField.inputAccessoryView = toolBar
        hobbyView.textField.inputView = hobbyPicker
        
        activityView.textField.inputAccessoryView = toolBar
        activityView.textField.inputView = appointmentPicker
        
        
        
        nationalityPicker.translatesAutoresizingMaskIntoConstraints = false
        emiratePicker.translatesAutoresizingMaskIntoConstraints = false
        hobbyPicker.translatesAutoresizingMaskIntoConstraints = false
        appointmentPicker.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    @objc func onClickedToolbeltButton(_ sender: Any){
        self.view.endEditing(true)
    }
    
    
    func validateFields() -> Bool{
        
        
        visitElderlyItemItem.personEmiratesID = emiratesIDView.textField.text ?? ""
        visitElderlyItemItem.firstNameEn = firstnameView.textField.text ?? ""
        visitElderlyItemItem.fatherNameEn = fatherNameEnView.textField.text ?? ""
        visitElderlyItemItem.grandFatherEn = grandfatherEnView.textField.text ?? ""
        visitElderlyItemItem.familyNameEn = familyNameEnView.textField.text ?? ""
        
        
        visitElderlyItemItem.firstNameAr = firstNameArView.textField.text ?? ""
        visitElderlyItemItem.fatherNameAr = fatherNameArView.textField.text ?? ""
        visitElderlyItemItem.grandFatherAr = grandfatherArView.textField.text ?? ""
        visitElderlyItemItem.familyNameAr = familyNameArView.textField.text ?? ""
        
        visitElderlyItemItem.dateOfBirth = dateOfBirthView.textField.text ?? ""
        
        
        visitElderlyItemItem.gender = self.genderView.firstCheckBox.checkState == .checked ? genderList[0].Id : genderList[1].Id
        
        
        
        
        if emiratesIDView.textField.text == "" ||
            firstnameView.textField.text == "" ||
            fatherNameEnView.textField.text == "" ||
            grandfatherEnView.textField.text == "" ||
            familyNameEnView.textField.text == "" ||
            firstNameArView.textField.text == "" ||
            fatherNameArView.textField.text == "" ||
            grandfatherArView.textField.text == "" ||
            familyNameArView.textField.text == "" ||
        nationalitiesView.textField.text == "" ||
        emirateView.textField.text == "" ||
        dateOfBirthView.textField.text == "" ||
        residenceAddress.textField.text == "" ||
        telephoneView.textField.text == "" ||
        otherTelephoneView.textField.text == "" ||
        mobileNumberView.textField.text == "" ||
        emailView.textField.text == "" ||
        hobbyView.textField.text == "" ||
        activityView.textField.text == "" {
            
            Utils.showAlertWith(title: "Error".localize, message: "Please Fill All Fields".localize, viewController: self)
            return false
            
            
        }
        
        
        
        return true
        
    }
    func getNationalities() {
        let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        
        
        WebService.GetCountryMaster { (json) in
            print(json)
            DispatchQueue.main.async {
                self.stopAnimating(nil)
            }
            
            guard let code = json["Code"] as? Int else {return}
            guard let message = json["ResponseTitle"] as? String else {return}
            
            if code == 200 {
                
                guard let list = json["Content"] as? [[String: Any]] else{return}
                
                
                for a in list {
                    let item = MOCDNationalitiesMaster()
                    item.ICA_ID = a["ICA_ID"] as? String ?? ""
                    item.Id = a["Id"] as? String ?? ""
                    item.Name = a["Name"] as? String ?? ""
                    item.NameinArabic = a["NameinArabic"] as? String ?? ""
                    
                    self.nationalitiesList.append(item)
                }
                
                DispatchQueue.main.async {
                    
                    
                    self.nationalityPicker.reloadAllComponents()
                }
            }else{
                
                
                DispatchQueue.main.async {
                                   
                    Utils.showAlertWith(title: "Error".localize, message: message, viewController: self)
                    
                }
            }

        }
    }
    
    func getEmirates() {
        let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        
        
        WebService.GetEmiratesMaster { (json) in
            print(json)
            DispatchQueue.main.async {
                self.stopAnimating(nil)
            }
            
            guard let code = json["Code"] as? Int else {return}
            guard let message = json["ResponseTitle"] as? String else {return}
            
            if code == 200 {
                
                guard let list = json["Content"] as? [[String: Any]] else{return}
                
                for a in list {
                    let item = MOCDNationalitiesMaster()
                    item.ICA_ID = a["ICA_ID"] as? String ?? ""
                    item.Id = a["Id"] as? String ?? ""
                    item.Name = a["Name"] as? String ?? ""
                    item.NameinArabic = a["NameinArabic"] as? String ?? ""
                    
                    self.emiratesList.append(item)
                }
                
                
                DispatchQueue.main.async {
                    
                    
                    self.emiratePicker.reloadAllComponents()
                }
            }else{
                
                
                DispatchQueue.main.async {
                                   
                    Utils.showAlertWith(title: "Error".localize, message: message, viewController: self)
                    
                }
            }

        }
    }
    
    func getHobbies() {
        let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        
        
        WebService.GetElderlyHobby { (json) in
            print(json)
            DispatchQueue.main.async {
                self.stopAnimating(nil)
            }
            
            guard let code = json["Code"] as? Int else {return}
            guard let message = json["ResponseTitle"] as? String else {return}
            
            if code == 200 {
                
                guard let list = json["Content"] as? [[String: Any]] else{return}
                
                
                for a in list {
                    let item = MOCDNationalitiesMaster()
                    item.ICA_ID = a["ICA_ID"] as? String ?? ""
                    item.Id = a["Id"] as? String ?? ""
                    item.Name = a["Name"] as? String ?? ""
                    item.NameinArabic = a["NameinArabic"] as? String ?? ""
                    
                    self.hobbyList.append(item)
                }
                
                DispatchQueue.main.async {
                    
                    
                    self.hobbyPicker.reloadAllComponents()
                }
            }else{
                
                
                DispatchQueue.main.async {
                                   
                    Utils.showAlertWith(title: "Error".localize, message: message, viewController: self)
                    
                }
            }

        }
    }
    
    func getActivities() {
        let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        
        
        WebService.GetElderlyActivity { (json) in
            print(json)
            DispatchQueue.main.async {
                self.stopAnimating(nil)
            }
            
            guard let code = json["Code"] as? Int else {return}
            guard let message = json["ResponseTitle"] as? String else {return}
            
            if code == 200 {
                
                guard let list = json["Content"] as? [[String: Any]] else{return}
                
                
                for a in list {
                    let item = MOCDNationalitiesMaster()
                    item.ICA_ID = a["ICA_ID"] as? String ?? ""
                    item.Id = a["Id"] as? String ?? ""
                    item.Name = a["Name"] as? String ?? ""
                    item.NameinArabic = a["NameinArabic"] as? String ?? ""
                    
                    self.activityList.append(item)
                }
                
                DispatchQueue.main.async {
                    
                    
                    self.appointmentPicker.reloadAllComponents()
                }
            }else{
                
                
                DispatchQueue.main.async {
                                   
                    Utils.showAlertWith(title: "Error".localize, message: message, viewController: self)
                    
                }
            }

        }
    }
    
    func getGenders() {
        let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        
        
        WebService.GetElderlyGender { (json) in
            print(json)
            DispatchQueue.main.async {
                self.stopAnimating(nil)
            }
            
            guard let code = json["Code"] as? Int else {return}
            guard let message = json["ResponseTitle"] as? String else {return}
            
            if code == 200 {
                
                guard let list = json["Content"] as? [[String: Any]] else{return}
                
                
                for a in list {
                    let item = MOCDNationalitiesMaster()
                    item.ICA_ID = a["ICA_ID"] as? String ?? ""
                    item.Id = a["Id"] as? String ?? ""
                    item.Name = a["Name"] as? String ?? ""
                    item.NameinArabic = a["NameinArabic"] as? String ?? ""
                    
                    self.genderList.append(item)
                }
                
                DispatchQueue.main.async {
                    
                    
                    //self.nationalityPicker.reloadAllComponents()
                }
            }else{
                
                
                DispatchQueue.main.async {
                                   
                    Utils.showAlertWith(title: "Error".localize, message: message, viewController: self)
                    
                }
            }

        }
    }
    @IBAction func nextAction(_ sender: Any) {
        
        
        if !self.validateFields() {
            return
        }
        
        WebService.SaveElderlyAppointment { (json) in
            print(json)
            guard let code = json["Code"] as? Int else {return}
            guard let ResponseTitle = json["ResponseTitle"] as? String else {return}
            guard let ResponseDescriptionEn = json["ResponseDescriptionEn"] as? String else {return}
            guard let ResponseDescriptionAr = json["ResponseDescriptionAr"] as? String else {return}
            if code == 200 {
                
                guard let content = json["Content"] as? [String:Any] else {
                    DispatchQueue.main.async {
                        Utils.showAlertWith(title: ResponseTitle, message: AppConstants.isArabic() ? ResponseDescriptionAr : ResponseDescriptionEn, viewController: self)
                    }
                    
                    return
                    
                }
                
                self.requestId = content["RequestId"] as? String ?? ""
                self.appReference = content["AppReference"] as? String ?? ""
                
                //self.contentString = content
                
                DispatchQueue.main.async {
                    
                    self.performSegue(withIdentifier: "toDoc", sender: self)
                }
            }else{
                
                
                DispatchQueue.main.async {
                                   
                    Utils.showAlertWith(title: ResponseTitle, message: AppConstants.isArabic() ? ResponseDescriptionAr : ResponseDescriptionEn, viewController: self)
                    
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDoc" {
            let dest = segue.destination as! masterDocViewController
            dest.requestType = "5"
            dest.contentString = self.contentString
            dest.requestId = self.requestId
            dest.appReference = self.appReference
            dest.isElderly = true
        }
    }
}
extension visitingPersonDetailsViewController: UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == nationalityPicker{
            return nationalitiesList.count
        }else if pickerView == emiratePicker{
            return emiratesList.count
        }else if pickerView == hobbyPicker{
            return hobbyList.count
        }else if pickerView == appointmentPicker{
            return activityList.count
        }
        
        
        
        return 0
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == nationalityPicker{
            let item = nationalitiesList[row]
            let title = AppConstants.isArabic() ?  item.NameinArabic : item.Name
            
            return title
        }else if pickerView == emiratePicker{
             let item = emiratesList[row]
            let title = AppConstants.isArabic() ?  item.NameinArabic : item.Name
            
            return title
        }else if pickerView == hobbyPicker{
            let item = hobbyList[row]
           let title = AppConstants.isArabic() ?  item.NameinArabic : item.Name
           
           return title
       }else if pickerView == appointmentPicker{
        let item = activityList[row]
       let title = AppConstants.isArabic() ?  item.NameinArabic : item.Name
       
       return title
   }
        
        return ""
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == nationalityPicker{
            let item = nationalitiesList[row]
          
            
           
            //self.nationality_id = item.CountryId
            self.nationalitiesView.textField.text = AppConstants.isArabic() ?  item.NameinArabic : item.Name
            self.visitElderlyItemItem.nationality = item.Id
            
        } else if pickerView == emiratePicker{
            let item = emiratesList[row]
            self.emirateView.textField.text = AppConstants.isArabic() ?  item.NameinArabic : item.Name
       
            self.visitElderlyItemItem.emirate = item.Id
        }else if pickerView == hobbyPicker{
            let item = hobbyList[row]
            self.hobbyView.textField.text = AppConstants.isArabic() ?  item.NameinArabic : item.Name
            self.visitElderlyItemItem.hobby = item.Id
       
        }else if pickerView == appointmentPicker{
            let item = activityList[row]
            self.activityView.textField.text = AppConstants.isArabic() ?  item.NameinArabic : item.Name
       
            self.visitElderlyItemItem.activity = item.Id
        }
        
    }
    
}
