//
//  nursingPersonDetailsViewController.swift
//  MOCD_DEMO
//
//  Created by haya habbous on 15/04/2021.
//  Copyright © 2021 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView


class nursingPersonDetailsViewController: UIViewController ,NVActivityIndicatorViewable {
    
    
    var requestId: String = ""
    var appReference: String = ""
    
    
    var contentString: String = ""
    var nationalitiesList: [MOCDNationalitiesMaster] = []
    var emiratesList: [MOCDNationalitiesMaster] = []
    var toolBar = UIToolbar()
    
    
    @IBOutlet var nationalitiesPicke: UIPickerView!
    @IBOutlet var emiratesPicker: UIPickerView!
    @IBOutlet weak var emiratesIDView: textFieldMandatory!
    @IBOutlet weak var firstnameView: textFieldMandatory!
    @IBOutlet weak var fatherNameEnView: textFieldMandatory!
    @IBOutlet weak var grandfatherEnView: textFieldMandatory!
    @IBOutlet weak var familyNameEnView: textFieldMandatory!
    @IBOutlet weak var firstNameArView: textFieldMandatory!
    @IBOutlet weak var fatherNameArView: textFieldMandatory!
    @IBOutlet weak var grandfatherArView: textFieldMandatory!
    @IBOutlet weak var familyNameArView: textFieldMandatory!
    @IBOutlet weak var dateOfBirthView: dateTexteField!
    @IBOutlet weak var mobileNoView: textFieldMandatory!
    @IBOutlet weak var phoneNumberView: textFieldMandatory!
    @IBOutlet weak var genderView: multipleTextField!
    @IBOutlet weak var emailView: textFieldMandatory!
    @IBOutlet weak var nationalityView: selectTextField!
    @IBOutlet weak var emiratesView: selectTextField!
    @IBOutlet weak var placeOfShelterView: textFieldMandatory!
    @IBOutlet weak var addressView: textFieldMandatory!
    @IBOutlet weak var hasChildrenView: multipleTextField!
    @IBOutlet weak var describeChildrenView: textFieldMandatory!
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
        
        mobileNoView.textLabel.text = "Mobile Number".localize
        mobileNoView.textField.placeholder = "Mobile Number".localize
        
        
        phoneNumberView.textLabel.text = "Phone Number".localize
        phoneNumberView.textField.placeholder = "Phone Number".localize
        
        genderView.textLabel.text = "Gender".localize
        genderView.firstLabel.text = "Female".localize
        genderView.secondLabel.text = "Male".localize
        
        
        emailView.textLabel.text = "Email".localize
        emailView.textField.placeholder = "Email".localize
        
        
        
        nationalityView.textLabel.text = "Nationality".localize
        nationalityView.textField.placeholder = "Please Select".localize
        
        emiratesView.textLabel.text = "Emirate".localize
        emiratesView.textField.placeholder = "Please Select".localize
        
        
        placeOfShelterView.textLabel.text = "Place of Shelter".localize
        placeOfShelterView.textField.placeholder = "Place of Shelter".localize
        
        
        hasChildrenView.textLabel.text = "Has Children".localize
        hasChildrenView.firstLabel.text = "Yes".localize
        hasChildrenView.secondLabel.text = "No".localize
        
        
        
        describeChildrenView.textLabel.text = "Describe Children".localize
        describeChildrenView.textField.placeholder = "Describe Children".localize
        
        
        
        
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
           
        nationalityView.textField.inputAccessoryView = toolBar
        nationalityView.textField.inputView = nationalitiesPicke
        
        
        emiratesView.textField.inputAccessoryView = toolBar
        emiratesView.textField.inputView = emiratesPicker
        
        
        
        nationalitiesPicke.translatesAutoresizingMaskIntoConstraints = false
        emiratesPicker.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    @objc func onClickedToolbeltButton(_ sender: Any){
        self.view.endEditing(true)
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
                    
                    
                    self.nationalitiesPicke.reloadAllComponents()
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
                    
                    
                    self.emiratesPicker.reloadAllComponents()
                }
            }else{
                
                
                DispatchQueue.main.async {
                                   
                    Utils.showAlertWith(title: "Error".localize, message: message, viewController: self)
                    
                }
            }

        }
    }
    @IBAction func nextAction(_ sender: Any) {
        
        
        if !validateFields(){
            return
        }
        WebService.SaveElderlyRegistrationInNursingHome { (json) in
            
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
    func validateFields() -> Bool{
        
        
        
        
        if emiratesIDView.textField.text == "" ||
            firstnameView.textField.text == "" ||
            fatherNameEnView.textField.text == "" ||
            grandfatherEnView.textField.text == "" ||
            familyNameEnView.textField.text == "" ||
            firstNameArView.textField.text == "" ||
            fatherNameArView.textField.text == "" ||
            grandfatherArView.textField.text == "" ||
            familyNameArView.textField.text == "" ||
            dateOfBirthView.textField.text == "" ||
            mobileNoView.textField.text == "" ||
            phoneNumberView.textField.text == "" ||
            emailView.textField.text == "" ||
            nationalityView.textField.text == "" ||
            emiratesView.textField.text == "" ||
            placeOfShelterView.textField.text == "" ||
            addressView.textField.text == "" ||
            describeChildrenView.textField.text == ""
            
            {
            
            Utils.showAlertWith(title: "Error".localize, message: "Please Fill All Fields".localize, viewController: self)
            return false
            
            
        }
        
        
        return true
    }
       
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDoc" {
            let dest = segue.destination as! masterDocViewController
            dest.requestType = "4"
            dest.contentString = self.contentString
            dest.requestId = self.requestId
            dest.appReference = self.appReference
            dest.isElderly = true
        }
    }
}
extension nursingPersonDetailsViewController: UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == nationalitiesPicke{
            return nationalitiesList.count
        }else if pickerView == emiratesPicker{
            return emiratesList.count
        }
        
        
        
        return 0
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == nationalitiesPicke{
            let item = nationalitiesList[row]
            let title = AppConstants.isArabic() ?  item.NameinArabic : item.Name
            
            return title
        }else if pickerView == emiratesPicker{
             let item = emiratesList[row]
            let title = AppConstants.isArabic() ?  item.NameinArabic : item.Name
            
            return title
        }
        return ""
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == nationalitiesPicke{
            let item = nationalitiesList[row]
          
            
           
            //self.nationality_id = item.CountryId
            self.nationalityView.textField.text = AppConstants.isArabic() ?  item.NameinArabic : item.Name
           
            
        } else if pickerView == emiratesPicker{
            let item = emiratesList[row]
            self.emiratesView.textField.text = AppConstants.isArabic() ?  item.NameinArabic : item.Name
       
        }
        
    }
    
}
