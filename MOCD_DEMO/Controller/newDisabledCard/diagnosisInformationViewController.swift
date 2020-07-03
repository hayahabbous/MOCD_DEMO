//
//  diagnosisInformationViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 6/14/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class diagnosisInformationViewController: UIViewController {
    
    
    
    var toolBar = UIToolbar()
    let activityData = ActivityData()
    
    var equipmentsArray: [MOCDEquipment] = []
    var authorityArray: [MOCDDisabilityAuthority] = []
    var disabilityTypeArray: [MOCDDisabilityType] = []
    var disabilityLevelArray: [MOCDDisabilityLevel] = []
    
    
    @IBOutlet var disabilityLevelPickerView: UIPickerView!
    @IBOutlet var disabilityTypePickerView: UIPickerView!
    @IBOutlet var authorityPickerView: UIPickerView!
    @IBOutlet var diagnosisAuthorityView: selectTextField!
    @IBOutlet var diagnosisInformationView: textFieldMandatory!
    @IBOutlet var disabilityTypeView: selectTextField!
    @IBOutlet var disabilityLevelView: selectTextField!
    @IBOutlet var supportingView: supportingField!
    @IBOutlet var needSupporterView: multipleTextField!
    @IBOutlet var canLiveAloneView: multipleTextField!
    @IBOutlet var reportIssuedView: textFieldMandatory!
    @IBOutlet var specialityView: textFieldMandatory!
    @IBOutlet var reportDateView: dateTexteField!
    
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var previousButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFields()
        
        
        setupToolbar()
        
        getAuthority()
        getDisabilityType()
        getDisabilityLevel()
        getSupportingEquipment()
    }
    
    func setupFields(){
        
        diagnosisAuthorityView.textLabel.text = "Diagnosis Authority"
        diagnosisAuthorityView.textField.placeholder = "Please Select"
        
        
        
        diagnosisInformationView.textLabel.text = "Diagnosis Information"
        diagnosisInformationView.textField.placeholder = "Diagnosis Information"
        
        
        disabilityTypeView.textLabel.text = "Disabilities type"
        disabilityTypeView.textField.placeholder = "Please Select"
        
        
        disabilityLevelView.textLabel.text = "Disability Level"
        disabilityLevelView.textField.placeholder = "Please Select"
        disabilityLevelView.starImage.isHidden = true
      
        needSupporterView.textLabel.text = "Need Supporter"
        needSupporterView.firstLabel.text = "No"
        needSupporterView.secondLabel.text = "Yes"
        
        
        canLiveAloneView.textLabel.text = "Can Live Alone?"
        canLiveAloneView.firstLabel.text = "No"
        canLiveAloneView.secondLabel.text = "Yes"
        
        
        reportIssuedView.textField.placeholder = "Report Issued By"
        reportIssuedView.textLabel.text = "Report Issued By"
        reportIssuedView.starImage.isHidden = true
        
        
        specialityView.textField.placeholder = "Speciality"
        specialityView.textLabel.text = "Speciality"
        specialityView.starImage.isHidden = true
        
        
        reportDateView.textLabel.text = "Report Date"
        reportDateView.textField.placeholder = "DD/MM/YYYY"
        reportDateView.starImage.isHidden = true
        reportDateView.viewController = self
        
        
        
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
        
        diagnosisAuthorityView.textField.inputAccessoryView = toolBar
        

        diagnosisAuthorityView.textField.isUserInteractionEnabled = true
        diagnosisAuthorityView.textField.inputView = authorityPickerView
      
        
      
        authorityPickerView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        
        
        disabilityTypeView.textField.inputAccessoryView = toolBar
          

          
        disabilityTypeView.textField.isUserInteractionEnabled = true
        
        disabilityTypeView.textField.inputView = disabilityTypePickerView
        
        disabilityTypePickerView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        disabilityLevelView.textField.inputAccessoryView = toolBar
          

          
        disabilityLevelView.textField.isUserInteractionEnabled = true
        
        disabilityLevelView.textField.inputView = disabilityLevelPickerView
        disabilityLevelPickerView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    @objc func onClickedToolbeltButton(_ sender: Any){
        self.view.endEditing(true)
    }
    
    func getSupportingEquipment() {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
        
        WebService.RetrieveSupportingEquipment { (json) in
            print(json)
            DispatchQueue.main.async {
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            }
            
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
                
                guard let data = json["data"] as? [String: Any] else{return}
                guard let result = data["result"] as? [String: Any] else {return}
                guard let list = result["list"] as? [[String: Any]] else {return}
                
                for r in list {
                let routine: MOCDEquipment = MOCDEquipment()
                    
                    routine.EquipId = String(describing: r["EquipId"] ?? "" )
                    routine.EquipTitleAr = String(describing: r["EquipTitleAr"] ?? "" )
                    routine.EquipTitleEn = String(describing: r["EquipTitleEn"] ?? "" )
                  
                    
                    self.equipmentsArray.append(routine)
                    
                    
                }
                
                DispatchQueue.main.async {
                    
                    self.supportingView.firstlabel.text = AppConstants.isArabic() ? self.equipmentsArray[0].EquipTitleAr : self.equipmentsArray[0].EquipTitleEn
                    self.supportingView.secondLabel.text = AppConstants.isArabic() ? self.equipmentsArray[1].EquipTitleAr : self.equipmentsArray[1].EquipTitleEn
                    self.supportingView.thirdLabel.text = AppConstants.isArabic() ? self.equipmentsArray[2].EquipTitleAr : self.equipmentsArray[2].EquipTitleEn
                    self.supportingView.fourthLabel.text = AppConstants.isArabic() ? self.equipmentsArray[3].EquipTitleAr : self.equipmentsArray[3].EquipTitleEn
                    
                    self.supportingView.fifthLabel.text = AppConstants.isArabic() ? self.equipmentsArray[4].EquipTitleAr : self.equipmentsArray[4].EquipTitleEn
                    
                    self.supportingView.sixthLabel.text = AppConstants.isArabic() ? self.equipmentsArray[5].EquipTitleAr : self.equipmentsArray[5].EquipTitleEn
                    
                    self.supportingView.seventhLabel.text = AppConstants.isArabic() ? self.equipmentsArray[6].EquipTitleAr : self.equipmentsArray[6].EquipTitleEn
                    //self.organizationPickerView.reloadAllComponents()
                }
            }else{
                
                
                DispatchQueue.main.async {
                                   
                    Utils.showAlertWith(title: "Error", message: message, viewController: self)
                    
                }
            }

        }
    }
    func getAuthority() {
        WebService.RetrieveDiagnosisAuthority { (json) in
            
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
                guard let data = json["data"] as? [String:Any] else {return}
                guard let results = data["result"] as? [String:Any] else {return}
                guard let list = results["list"] as? [[String:Any]] else {return}
                
                
                for r in list {
                    
                    
                    let authorityItem = MOCDDisabilityAuthority()
                    authorityItem.AuthId = String(describing: r["AuthId"] ?? "" )
                    authorityItem.AuthTitleAr = String(describing: r["AuthTitleAr"] ?? "" )
                    authorityItem.AuthTitleEn = String(describing: r["AuthTitleEn"] ?? "" )
                    
                    self.authorityArray.append(authorityItem)
                    
                }
                
                
                DispatchQueue.main.async {
                    
                    self.authorityPickerView.reloadAllComponents()
                }
            }
            
        }
    }
    
    func getDisabilityType() {
        WebService.RetrieveDisabilityTypes { (json) in
            
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
                guard let data = json["data"] as? [String:Any] else {return}
                guard let results = data["result"] as? [String:Any] else {return}
                guard let list = results["list"] as? [[String:Any]] else {return}
                
                
                for r in list {
                    
                    
                    let disabilityItem = MOCDDisabilityType()
                    disabilityItem.TypeId = String(describing: r["TypeId"] ?? "" )
                    disabilityItem.TypeTitleAr = String(describing: r["TypeTitleAr"] ?? "" )
                    disabilityItem.TypeTitleEn = String(describing: r["TypeTitleEn"] ?? "" )
                    
                    self.disabilityTypeArray.append(disabilityItem)
                    
                }
                
                
                DispatchQueue.main.async {
                    
                    self.disabilityTypePickerView.reloadAllComponents()
                }
            }
            
        }
    }
    
    func getDisabilityLevel() {
        WebService.RetrieveDisabilityLevel{ (json) in
            
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
                guard let data = json["data"] as? [String:Any] else {return}
                guard let results = data["result"] as? [String:Any] else {return}
                guard let list = results["list"] as? [[String:Any]] else {return}
                
                
                for r in list {
                    
                    
                    let disabilityItem = MOCDDisabilityLevel()
                    disabilityItem.LevelId = String(describing: r["LevelId"] ?? "" )
                    disabilityItem.DisplayOrder = String(describing: r["DisplayOrder"] ?? "" )
                    disabilityItem.LevelTitleEn = String(describing: r["LevelTitleEn"] ?? "" )
                    disabilityItem.LevelTitleAr = String(describing: r["LevelTitleAr"] ?? "" )
                    
                    self.disabilityLevelArray.append(disabilityItem)
                    
                }
                
                
                DispatchQueue.main.async {
                    
                    self.disabilityLevelPickerView.reloadAllComponents()
                }
            }
            
        }
    }
    @IBAction func nextButtonAction(_ sender: Any) {
        
        self.performSegue(withIdentifier: "toAttachemnent", sender: self)
    }
}
extension diagnosisInformationViewController: UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == authorityPickerView{
            return authorityArray.count
        }else if pickerView == disabilityLevelPickerView{
            return disabilityLevelArray.count
        }else if pickerView == disabilityTypePickerView{
            return disabilityTypeArray.count
        }
        
        
        return 0
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == authorityPickerView{
            let item = authorityArray[row]
            let title = AppConstants.isArabic() ? item.AuthTitleAr :  item.AuthTitleEn
            
            return title
        }else if pickerView == disabilityLevelPickerView{
            let item = disabilityLevelArray[row]
            let title = AppConstants.isArabic() ? item.LevelTitleAr :  item.LevelTitleEn
            
            return title
        }else if pickerView == disabilityTypePickerView{
            let item = disabilityTypeArray[row]
            let title = AppConstants.isArabic() ? item.TypeTitleAr :  item.TypeTitleEn
            
            return title
        }
        
        return ""
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == authorityPickerView{
            let item = authorityArray[row]
            
              //self.emirate = item.id
           
            //childItem.emirateID = item.id
            self.diagnosisAuthorityView.textField.text = AppConstants.isArabic() ? item.AuthTitleAr :  item.AuthTitleEn
        }else if pickerView == disabilityLevelPickerView{
            let item = disabilityLevelArray[row]
            
              //self.emirate = item.id
           
            //childItem.emirateID = item.id
            self.disabilityLevelView.textField.text = AppConstants.isArabic() ? item.LevelTitleAr :  item.LevelTitleEn
        }else if pickerView == disabilityTypePickerView{
            let item = disabilityTypeArray[row]
            
              //self.emirate = item.id
           
            //childItem.emirateID = item.id
            self.disabilityTypeView.textField.text = AppConstants.isArabic() ? item.TypeTitleAr :  item.TypeTitleEn
        }
        
    }
    
}
