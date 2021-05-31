//
//  elderlyPersonDetailsViewController.swift
//  MOCD_DEMO
//
//  Created by haya habbous on 11/04/2021.
//  Copyright © 2021 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class elderlyPersonDetailsViewController: UIViewController ,NVActivityIndicatorViewable{
    
    var nationalitiesList: [MOCDNationalitiesMaster] = []
    var emiratesList: [MOCDNationalitiesMaster] = []
    
    @IBOutlet var nationalitiesPickerView: UIPickerView!
    @IBOutlet var emiratesPickerView: UIPickerView!
    var toolBar = UIToolbar()
    
    
    @IBOutlet weak var emiratesIDView: textFieldMandatory!
    @IBOutlet weak var firstNameEnView: textFieldMandatory!
    @IBOutlet weak var fatherNameEnView: textFieldMandatory!
    @IBOutlet weak var familyNameEnView: textFieldMandatory!
    @IBOutlet weak var firstNameArView: textFieldMandatory!
    @IBOutlet weak var fatherNameArView: textFieldMandatory!
    @IBOutlet weak var grandFatherArView: textFieldMandatory!
    @IBOutlet weak var familyNameArView: textFieldMandatory!
    @IBOutlet weak var grandFatherEnView: textFieldMandatory!
    @IBOutlet weak var nationalityView: selectTextField!
    @IBOutlet weak var genderView: multipleTextField!
    @IBOutlet weak var dateOfBirthView: dateTexteField!
    @IBOutlet weak var placeOfBirthView: textFieldMandatory!
    @IBOutlet weak var residenceEmirateView: selectTextField!
    @IBOutlet weak var residenceAddressView: textFieldMandatory!
    @IBOutlet weak var telephoneNumberView: textFieldMandatory!
    @IBOutlet weak var mobileNumberView: textFieldMandatory!
    @IBOutlet weak var POBoxView: textFieldMandatory!
    @IBOutlet weak var emailView: textFieldMandatory!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupField()
        setupToolbar()
     
        getNationalities()
        getEmirates()
    }
    
    func setupField() {
        
        emiratesIDView.textLabel.text = "Emirates ID".localize
        emiratesIDView.textField.placeholder = "Emirates ID".localize
        
        
        firstNameEnView.textLabel.text = "First Name [EN]".localize
        firstNameEnView.textField.placeholder = "First Name [EN]".localize
        
        
        fatherNameEnView.textLabel.text = "Father Name [EN]".localize
        fatherNameEnView.textField.placeholder = "Father Name [EN]".localize
        
        grandFatherEnView.textLabel.text = "Grandfather [EN]".localize
        grandFatherEnView.textField.placeholder = "Grandfather [EN]".localize
        
        
        familyNameEnView.textLabel.text = "Family Name [EN]".localize
        familyNameEnView.textField.placeholder = "Family Name [EN]".localize
        
        
        
        firstNameArView.textLabel.text = "First Name [AR]".localize
        firstNameArView.textField.placeholder = "First Name [AR]".localize
        
        
        fatherNameArView.textLabel.text = "Father Name [AR]".localize
        fatherNameArView.textField.placeholder = "Father Name [AR]".localize
        
        grandFatherArView.textLabel.text = "Grandfather [AR]".localize
        grandFatherArView.textField.placeholder = "Grandfather [AR]".localize
        
        
        familyNameArView.textLabel.text = "Family Name [AR]".localize
        familyNameArView.textField.placeholder = "Family Name [AR]".localize
        
        nationalityView.textLabel.text = "Nationality".localize
        nationalityView.textField.placeholder = "Please select".localize
     
        
        genderView.textLabel.text = "Gender".localize
        genderView.firstLabel.text = "Female".localize
        genderView.secondLabel.text = "Male".localize
        
        
        dateOfBirthView.textLabel.text = "Date of Birth".localize
        dateOfBirthView.textField.placeholder = "Date of Birth".localize
        dateOfBirthView.viewController  = self
        
        
        
        placeOfBirthView.textLabel.text = "Place of Birth".localize
        placeOfBirthView.textField.placeholder = "Place of Birth".localize
        
        
        residenceEmirateView.textLabel.text = "Residence Emirate".localize
        residenceEmirateView.textField.placeholder = "Please select".localize
        
        
        residenceAddressView.textLabel.text = "Residence Address".localize
        residenceAddressView.textField.placeholder = "Residence Address".localize
        
        
        telephoneNumberView.textLabel.text = "Telephone Number".localize
        telephoneNumberView.textField.placeholder = "Telephone Number".localize
        
        
        mobileNumberView.textLabel.text = "Mobile Number".localize
        mobileNumberView.textField.placeholder = "Mobile Number".localize
        
        POBoxView.textLabel.text = "PO Box".localize
        POBoxView.textField.placeholder = "PO Box".localize
        
        
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
    
    
    func validateFields() -> Bool{
        
        
        
        
        if emiratesIDView.textField.text == "" ||
            firstNameEnView.textField.text == "" ||
            fatherNameEnView.textField.text == "" ||
            grandFatherEnView.textField.text == "" ||
            familyNameEnView.textField.text == "" ||
            firstNameArView.textField.text == "" ||
            fatherNameArView.textField.text == "" ||
            grandFatherArView.textField.text == "" ||
            familyNameArView.textField.text == "" ||
            dateOfBirthView.textField.text == "" ||
            nationalityView.textField.text == "" ||
            dateOfBirthView.textField.text == "" ||
            placeOfBirthView.textField.text == "" ||
            residenceEmirateView.textField.text == "" ||
            residenceAddressView.textField.text == "" ||
            residenceAddressView.textField.text == "" ||
            telephoneNumberView.textField.text == "" ||
            POBoxView.textField.text == "" ||
            emailView.textField.text == "" ||
            mobileNumberView.textField.text == ""
            
            {
            
            Utils.showAlertWith(title: "Error".localize, message: "Please Fill All Fields".localize, viewController: self)
            return false
            
            
        }
        
        
      
        return true
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
        nationalityView.textField.inputView = nationalitiesPickerView
        
        
        residenceEmirateView.textField.inputAccessoryView = toolBar
        residenceEmirateView.textField.inputView = emiratesPickerView
        
        
        
        nationalitiesPickerView.translatesAutoresizingMaskIntoConstraints = false
        emiratesPickerView.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    @objc func onClickedToolbeltButton(_ sender: Any){
        self.view.endEditing(true)
    }
    @IBAction func nextAction(_ sender: Any) {
        if validateFields(){
            self.performSegue(withIdentifier: "toFamilyDetails", sender: self)
        }
        
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
                    
                    
                    self.nationalitiesPickerView.reloadAllComponents()
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
                    
                    
                    self.emiratesPickerView.reloadAllComponents()
                }
            }else{
                
                
                DispatchQueue.main.async {
                                   
                    Utils.showAlertWith(title: "Error".localize, message: message, viewController: self)
                    
                }
            }

        }
    }
    
}
extension elderlyPersonDetailsViewController: UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == nationalitiesPickerView{
            return nationalitiesList.count
        }else if pickerView == emiratesPickerView{
            return emiratesList.count
        }
        
        
        
        return 0
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == nationalitiesPickerView{
            let item = nationalitiesList[row]
            let title = AppConstants.isArabic() ?  item.NameinArabic : item.Name
            
            return title
        }else if pickerView == emiratesPickerView{
             let item = emiratesList[row]
            let title = AppConstants.isArabic() ?  item.NameinArabic : item.Name
            
            return title
        }
        return ""
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == nationalitiesPickerView{
            let item = nationalitiesList[row]
          
            
           
            //self.nationality_id = item.CountryId
            self.nationalityView.textField.text = AppConstants.isArabic() ?  item.NameinArabic : item.Name
           
            
        } else if pickerView == emiratesPickerView{
            let item = emiratesList[row]
            self.residenceEmirateView.textField.text = AppConstants.isArabic() ?  item.NameinArabic : item.Name
       
        }
        
    }
    
}
