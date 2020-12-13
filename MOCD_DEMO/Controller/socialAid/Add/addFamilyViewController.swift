//
//  addFamilyViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 7/2/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit

struct FamilyMember{
    var gender: String = ""
    var genderId: String = ""
    var education: String = ""
    var educationId: String = ""
    
    
    var relation: String = ""
    var relationId: String = ""
    
    var disease: String = ""
    var diseaseId: String = ""
    
    
    var memberName: String = ""
    var memberNameEn: String = ""
    var motherName: String = ""
    var dateOfBirth: String = ""
    var nationalId: String = ""
    var mobile: String = ""
    var email: String = ""
}
class addFamilyViewController: UIViewController {
    
    @IBOutlet var genderPicker: UIPickerView!
    @IBOutlet var educationPicker: UIPickerView!
    @IBOutlet var relationshipPicker: UIPickerView!
    @IBOutlet var diseasePicker: UIPickerView!
    
    var gendersArray: [MOCDGenderSocial] = []
    var diseaseArray: [MOCDDiseaseSocial] = []
    var relationArray: [MOCDRelationshipSocial] = []
    var educationArray: [MOCDEducationSocial] = []
    
    var delegate: addIncomeDelegate!
    var familyItem: FamilyMember = FamilyMember()
    var toolBar = UIToolbar()
    
    @IBOutlet var memberNameView: textFieldMandatory!
    @IBOutlet var memberNameEnView: textFieldMandatory!
    @IBOutlet var dateOfBirthView: dateTexteField!
    @IBOutlet var genderView: selectTextField!
    @IBOutlet var educationView: selectTextField!
    @IBOutlet var relationshipView: selectTextField!
    @IBOutlet var motherNameView: textFieldMandatory!
    @IBOutlet var diseaseView: selectTextField!
    @IBOutlet var nationalIdView: textFieldMandatory!
    @IBOutlet var mobileNoView: textFieldMandatory!
    @IBOutlet var emailView: textFieldMandatory!
    
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupField()
        
        setupToolbar()
        getGenders()
        getDisease()
        getEducation()
        getRelations()
    }
    func setupField() {
        memberNameView.textLabel.text = "Member Name [AR]".localize
        memberNameView.textField.placeholder = "Member Name [AR]".localize
        
        
        memberNameEnView.textLabel.text = "Member Name [En]".localize
        memberNameEnView.textField.placeholder = "Member Name [En]".localize
        
        
        dateOfBirthView.textLabel.text = "Date of Birth".localize
        dateOfBirthView.textField.placeholder = "Date of Birth".localize
        dateOfBirthView.viewController = self
        
        
        genderView.textLabel.text = "Gender".localize
        genderView.textField.placeholder = "Please Select".localize
        
        
        educationView.textLabel.text = "Education".localize
        educationView.textField.placeholder = "Please Select".localize
        
        
        relationshipView.textLabel.text = "Relationship".localize
        relationshipView.textField.placeholder = "Please Select".localize
        
        
        motherNameView.textLabel.text = "Mother Name [AR]".localize
        motherNameView.textField.placeholder = "Mother Name [AR]".localize
        
        
        diseaseView.textLabel.text = "Disease".localize
        diseaseView.textField.placeholder = "Please Select".localize
        
        
        diseaseView.textLabel.text = "Disease".localize
        diseaseView.textField.placeholder = "Please Select".localize
        
        
        nationalIdView.textLabel.text = "National Id".localize
        nationalIdView.textField.placeholder = "National Id".localize
        
        
        mobileNoView.textLabel.text = "Mobile No".localize
        mobileNoView.textField.placeholder = "Mobile No".localize
        
        
        emailView.textLabel.text = "Email".localize
        emailView.textField.placeholder = "Email".localize
        
        
        let gradient = CAGradientLayer()
        gradient.frame = self.saveButton.bounds
        gradient.colors = [UIColor.green]
        
        self.saveButton.applyGradient(colours: [AppConstants.firstBrownColor, AppConstants.secondBrownColor])
        //self.loginButton.backgroundColor = .green
        self.saveButton.layer.cornerRadius = 20
        self.saveButton.layer.masksToBounds = true
        
        
        gradient.frame = self.cancelButton.bounds
        gradient.colors = [UIColor.green]
        
        self.cancelButton.applyGradient(colours: [AppConstants.firstBrownColor, AppConstants.secondBrownColor])
        //self.loginButton.backgroundColor = .green
        self.cancelButton.layer.cornerRadius = 20
        self.cancelButton.layer.masksToBounds = true
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
             
          
        genderView.textField.inputAccessoryView = toolBar
           
        genderView.textField.inputView = genderPicker
       
        genderPicker.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        educationView.textField.inputAccessoryView = toolBar
            
        educationView.textField.inputView = educationPicker
        
         educationPicker.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        diseaseView.textField.inputAccessoryView = toolBar
            
        diseaseView.textField.inputView = diseasePicker
        
        diseasePicker.translatesAutoresizingMaskIntoConstraints = false
        
        
        relationshipView.textField.inputAccessoryView = toolBar
            
        relationshipView.textField.inputView = relationshipPicker
        
        relationshipPicker.translatesAutoresizingMaskIntoConstraints = false

          
          
      }
      
      
    @objc func onClickedToolbeltButton(_ sender: Any){
    
        self.view.endEditing(true)
      
    }
    func getGenders() {
        WebService.RetrieveGenderSocial { (json) in
            print(json)
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
                guard let data = json["data"] as? [String:Any] else {return}
                guard let results = data["result"] as? [String:Any] else {return}
                guard let list = results["list"] as? [[String:Any]] else {return}
                var emiratesA: [String: String] = [:]
                for r in list {
                    
                    
                    let item = MOCDGenderSocial()
                    item.GenderId = String(describing: r["GenderId"]  ?? "" )
                    item.GenderTitleAR = String(describing: r["GenderTitleAR"] ?? "" )
                    item.GenderTitleEN = String(describing: r["GenderTitleEN"] ?? "")
                    
                    self.gendersArray.append(item)
                    
                }
                
                
                DispatchQueue.main.async {
                    
                    self.genderPicker.reloadAllComponents()
                }
            }
            
        }
    }
    
    
    func getRelations() {
        WebService.RetrieveFamilyMemberRelationship { (json) in
            print(json)
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
                guard let data = json["data"] as? [String:Any] else {return}
                guard let results = data["result"] as? [String:Any] else {return}
                guard let list = results["list"] as? [[String:Any]] else {return}
                var emiratesA: [String: String] = [:]
                for r in list {
                    
                    
                    let item = MOCDRelationshipSocial()
                    item.RelationshipTypeId = String(describing: r["RelationshipTypeId"]  ?? "" )
                    item.RelationshipTypeAR = String(describing: r["RelationshipTypeAR"] ?? "" )
                    item.RelationshipTypeEN = String(describing: r["RelationshipTypeEN"] ?? "")
                    
                    self.relationArray.append(item)
                    
                }
                
                
                DispatchQueue.main.async {
                    
                    self.relationshipPicker.reloadAllComponents()
                }
            }
            
        }
    }
    
    func getDisease() {
        WebService.RetrieveDiseaseTypeSocial { (json) in
            print(json)
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
                guard let data = json["data"] as? [String:Any] else {return}
                guard let results = data["result"] as? [String:Any] else {return}
                guard let list = results["list"] as? [[String:Any]] else {return}
                var emiratesA: [String: String] = [:]
                for r in list {
                    
                    
                    let item = MOCDDiseaseSocial()
                    item.DiseaseTypeId = String(describing: r["DiseaseTypeId"]  ?? "" )
                    item.DiseaseTypeAR = String(describing: r["DiseaseTypeAR"] ?? "" )
                    item.DiseaseTypeEN = String(describing: r["DiseaseTypeEN"] ?? "")
                    
                    self.diseaseArray.append(item)
                    
                }
                
                
                DispatchQueue.main.async {
                    
                    self.diseasePicker.reloadAllComponents()
                }
            }
            
        }
    }
    func getEducation() {
        WebService.RetrieveEducationLevelSocial { (json) in
            print(json)
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
                guard let data = json["data"] as? [String:Any] else {return}
                guard let results = data["result"] as? [String:Any] else {return}
                guard let list = results["list"] as? [[String:Any]] else {return}
                var emiratesA: [String: String] = [:]
                for r in list {
                    
                    
                    let item = MOCDEducationSocial()
                    item.EducationId = String(describing: r["EducationId"]  ?? "" )
                    item.EducationTitleAR = String(describing: r["EducationTitleAR"] ?? "" )
                    item.EducationTitleEN = String(describing: r["EducationTitleEN"] ?? "")
                    
                    self.educationArray.append(item)
                    
                }
                
                
                DispatchQueue.main.async {
                    
                    self.educationPicker.reloadAllComponents()
                }
            }
            
        }
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
        familyItem.gender = genderView.textField.text ?? ""
        familyItem.relation = relationshipView.textField.text ?? ""
        familyItem.disease = diseaseView.textField.text ?? ""
        familyItem.education = educationView.textField.text ?? ""
        familyItem.memberName = memberNameView.textField.text ?? ""
        familyItem.memberNameEn = memberNameEnView.textField.text ?? ""
        familyItem.motherName = motherNameView.textField.text ?? ""
        familyItem.dateOfBirth = dateOfBirthView.textField.text ?? ""
        familyItem.mobile = mobileNoView.textField.text ?? ""
        familyItem.email = emailView.textField.text ?? ""
        familyItem.nationalId = nationalIdView.textField.text ?? ""
        if  familyItem.gender == "" ||
            familyItem.relation == "" ||
            familyItem.disease == "" ||
            familyItem.education == "" ||
            familyItem.memberName == "" ||
            familyItem.memberNameEn == "" ||
            familyItem.motherName == "" ||
            familyItem.dateOfBirth == "" ||
            familyItem.nationalId == ""{
            
            
            Utils.showAlertWith(title: "Error".localize, message: "Please Fill All Fields".localize, viewController: self)
            return
        }
        
        delegate.addFamily(familyItem: self.familyItem)
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelAction(_ sender: Any) {
    }
}
extension addFamilyViewController: UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == genderPicker{
            return gendersArray.count
        }else if pickerView == educationPicker{
            return educationArray.count
        }else if pickerView == diseasePicker{
            return diseaseArray.count
        }else if pickerView == relationshipPicker{
            return relationArray.count
        }
        
        return 0
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == genderPicker{
            let item = gendersArray[row]
            let title = AppConstants.isArabic() ?  item.GenderTitleAR : item.GenderTitleEN
            
            return title
        }else if pickerView == educationPicker{
            let item = educationArray[row]
            let title = AppConstants.isArabic() ?  item.EducationTitleAR : item.EducationTitleEN
            
            return title
        }else if pickerView == diseasePicker{
            let item = diseaseArray[row]
            let title = AppConstants.isArabic() ?  item.DiseaseTypeAR : item.DiseaseTypeEN
            
            return title
        }else if pickerView == relationshipPicker{
            let item = relationArray[row]
            let title = AppConstants.isArabic() ?  item.RelationshipTypeAR : item.RelationshipTypeEN
            
            return title
        }
        return ""
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == genderPicker{
            let item = gendersArray[row]
          
            familyItem.genderId = item.GenderId
            
            self.genderView.textField.text = AppConstants.isArabic() ?  item.GenderTitleAR : item.GenderTitleEN
           
        }else if pickerView == educationPicker{
            let item = educationArray[row]
            
            familyItem.educationId = item.EducationId
              self.educationView.textField.text = AppConstants.isArabic() ?  item.EducationTitleAR : item.EducationTitleEN
             
        }else if pickerView == diseasePicker{
            let item = diseaseArray[row]
            familyItem.diseaseId = item.DiseaseTypeId
              self.diseaseView.textField.text = AppConstants.isArabic() ?  item.DiseaseTypeAR : item.DiseaseTypeEN
             
        }else if pickerView == relationshipPicker{
            let item = relationArray[row]
            familyItem.relationId = item.RelationshipTypeId
              self.relationshipView.textField.text = AppConstants.isArabic() ?  item.RelationshipTypeAR : item.RelationshipTypeEN
             
        }
        
    }
    
}
