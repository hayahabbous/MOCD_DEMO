//
//  certificateInformationViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 7/5/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit


class certificateInformationViewController: UIViewController {
    
    
    
    var officialItem: officialLetter = officialLetter()
    var countriesArray: [MOCDCountry] = []
    @IBOutlet var countryPicker: UIPickerView!
    var toolBar = UIToolbar()
    
    
    @IBOutlet var applicantNameView: textFieldMandatory!
    @IBOutlet var nationalIdView: textFieldMandatory!
    @IBOutlet var nationalityView: selectTextField!
    @IBOutlet var genderView: multipleTextField!
    @IBOutlet var familyNo: textFieldMandatory!
    @IBOutlet var townNo: textFieldMandatory!
    @IBOutlet var entityView: textFieldMandatory!
    @IBOutlet var passportNo: textFieldMandatory!
    @IBOutlet var reasonView: textFieldMandatory!
    @IBOutlet var mobileView: textFieldMandatory!
    @IBOutlet var emailView: textFieldMandatory!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var previousButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupFields()
        setupToolbar()
        getNationalities()
    }
    
    func setupFields() {
        applicantNameView.textLabel.text = "Applicant Name".localize
        applicantNameView.textField.placeholder = "Applicant Name".localize
        
        
        nationalIdView.textLabel.text = "National Id".localize
        nationalIdView.textField.placeholder = "National Id".localize
        
        nationalityView.textLabel.text = "Nationality".localize
        nationalityView.textField.placeholder = "Please Select".localize
        
        
        genderView.textLabel.text = "Gender".localize
        genderView.firstLabel.text = "Male".localize
        genderView.secondLabel.text = "Female".localize
        
        
        
        familyNo.textLabel.text = "Family No".localize
        familyNo.textField.placeholder = "Family No".localize
        familyNo.textField.keyboardType = .numberPad
        
        
        
        townNo.textLabel.text = "Town No".localize
        townNo.textField.placeholder = "Town No".localize
        townNo.textField.keyboardType = .numberPad
        
        townNo.textLabel.text = "Town No".localize
        townNo.textField.placeholder = "Town No".localize
        
        
        entityView.textLabel.text = "Entity ".localize
        entityView.textField.placeholder = "Entity".localize
        
        
        passportNo.textLabel.text = "Passport No ".localize
        passportNo.textField.placeholder = "Passport No".localize
        
        
        
        
        reasonView.textLabel.text = "Reason".localize
        reasonView.textField.placeholder = "Reason".localize
        
        
        mobileView.textLabel.text = "Mobile No".localize
        mobileView.textField.placeholder = "Mobile No".localize
        mobileView.textField.keyboardType = .numberPad
        
        
        emailView.textLabel.text = "Email".localize
        emailView.textField.placeholder = "Email".localize
     
        
        
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
           
        //nationalIdView.textField.inputView = countryPicker
        
        
        
        
        countryPicker.translatesAutoresizingMaskIntoConstraints = false
       
        
        nationalityView.textField.inputView = countryPicker
        
        
        
        
    }
    @objc func onClickedToolbeltButton(_ sender: Any){
        self.view.endEditing(true)
    }
    func getNationalities() {
        WebService.getCountries { (json) in
            
            print(json)
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
                  
                    self.countryPicker.reloadAllComponents()
                }
            }
        }
    }
    
    func validateFields() -> Bool{
        
        
        officialItem.ApplicantNameAR = applicantNameView.textField.text ?? ""
        officialItem.nationalId = nationalIdView.textField.text ?? ""
        self.officialItem.genderId = self.genderView.firstCheckBox.checkState == .checked ? "1" : "2"
        officialItem.familyNo = familyNo.textField.text ?? ""
        officialItem.townNo = townNo.textField.text ?? ""
        officialItem.entityAddressed = entityView.textField.text ?? ""
        officialItem.passportNo = passportNo.textField.text ?? ""
        officialItem.mobile = mobileView.textField.text ?? ""
        officialItem.email = emailView.textField.text ?? ""
        
        if((!officialItem.nationalId.isEmpty) || (!officialItem.passportNo.isEmpty) ||
            ((!officialItem.townNo.isEmpty) && (!officialItem.familyNo.isEmpty))) ||
            (!officialItem.entityAddressed.isEmpty) || (!officialItem.reason.isEmpty) || (!officialItem.email.isEmpty){
           
        } else {
            Utils.showAlertWith(title: "Error".localize, message: "Please Fill All Fields".localize, viewController: self)
            return false
        }
        
        
        return true
    }
    @IBAction func saveAction(_ sender: Any) {
        
        if !validateFields() {
            return
        }
        self.performSegue(withIdentifier: "toAttachment", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAttachment" {
            let dest = segue.destination as! certificateAttachemntViewController
            dest.officialItem = self.officialItem
        }
    }
}
extension certificateInformationViewController: UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == countryPicker{
            return countriesArray.count
        }
        
        
        return 0
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == countryPicker{
            let item = countriesArray[row]
            let title = item.CountryNameEn
            
            return title
        }
        return ""
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == countryPicker{
            let item = countriesArray[row]
          
            
           
            //self.nationality_id = item.CountryId
            self.nationalityView.textField.text = item.CountryNameEn
            self.officialItem.nationalityId = item.CountryId
            
            
        }
    }
    
}
