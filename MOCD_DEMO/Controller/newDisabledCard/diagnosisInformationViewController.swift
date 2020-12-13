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
import Alamofire
class diagnosisInformationViewController: UIViewController ,NVActivityIndicatorViewable{
    
    
    var newCardItem: newCardStruct!
    var toolBar = UIToolbar()
    let nvactivity = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    var isRenewal: Bool = false
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
   
    
    @IBOutlet var multipleDisabilityView: supportingField!
    @IBOutlet var mDisabilityVHeight: NSLayoutConstraint!
    @IBOutlet var mDisabilityHeight: NSLayoutConstraint!
    
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var previousButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        hideView()
        setupFields()
        
    
        setupToolbar()
        
        getAuthority()
        getDisabilityType()
        getDisabilityLevel()
        getSupportingEquipment()
        
        
        if isRenewal {
            fillFields()
        }
        
    }
    func hideView() {
        mDisabilityHeight.constant = 0
           
        mDisabilityVHeight.constant = 0
       
        
        multipleDisabilityView.isHidden = true
                  
    }
    func setupFields(){
        
        diagnosisAuthorityView.textLabel.text = "Diagnosis Authority".localize
        diagnosisAuthorityView.textField.placeholder = "Please Select".localize
        
        
        
        diagnosisInformationView.textLabel.text = "Diagnosis Information".localize
        diagnosisInformationView.textField.placeholder = "Diagnosis Information".localize
        
        
        disabilityTypeView.textLabel.text = "Disabilities type".localize
        disabilityTypeView.textField.placeholder = "Please Select".localize
        
        
        disabilityLevelView.textLabel.text = "Disability Level".localize
        disabilityLevelView.textField.placeholder = "Please Select".localize
        disabilityLevelView.starImage.isHidden = true
      
        needSupporterView.textLabel.text = "Need Supporter".localize
        needSupporterView.firstLabel.text = "No".localize
        needSupporterView.secondLabel.text = "Yes".localize
        
        
        canLiveAloneView.textLabel.text = "Can Live Alone?".localize
        canLiveAloneView.firstLabel.text = "No".localize
        canLiveAloneView.secondLabel.text = "Yes".localize
        
        
        reportIssuedView.textField.placeholder = "Report Issued By".localize
        reportIssuedView.textLabel.text = "Report Issued By".localize
        reportIssuedView.starImage.isHidden = true
        
        
        specialityView.textField.placeholder = "Speciality".localize
        specialityView.textLabel.text = "Speciality".localize
        specialityView.starImage.isHidden = true
        
        
        reportDateView.textLabel.text = "Report Date".localize
        reportDateView.textField.placeholder = "DD/MM/YYYY".localize
        reportDateView.starImage.isHidden = true
        reportDateView.viewController = self
        
        
        
        multipleDisabilityView.textLabel.text = "Multiple Disability".localize
        multipleDisabilityView.firstlabel.text = "Intellectual".localize
        multipleDisabilityView.secondLabel.text = "Physical".localize
        multipleDisabilityView.thirdLabel.text = "ADHD".localize
        multipleDisabilityView.fourthLabel.text = "Hearing".localize
        multipleDisabilityView.fifthLabel.text = "Autism".localize
        multipleDisabilityView.sixthLabel.text = "Hearing- Visual".localize
        multipleDisabilityView.seventhLabel.text = "Visual".localize

        
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
    
    
    func fillFields() {
        self.diagnosisInformationView.textField.text = self.newCardItem.DiagnosisInformation
        self.reportIssuedView.textField.text = self.newCardItem.ReportIssuedBy
        self.specialityView.textField.text = self.newCardItem.Speciality
        self.reportDateView.textField.text = self.newCardItem.ReportDate
        
        
        
        
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
        let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        
        
        WebService.RetrieveSupportingEquipment { (json) in
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
                    
                    
                    if self.isRenewal {
                        guard let mItem = self.authorityArray.filter({ (item) -> Bool in
                            item.AuthId == self.newCardItem.DiagnosisAuthorityId
                        }).first else {
                            return
                        }
                        let title = AppConstants.isArabic() ? mItem.AuthTitleAr : mItem.AuthTitleEn
                        self.diagnosisAuthorityView.textField.text = title
                    }
                    
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
                    
               
                    if self.isRenewal {
                        guard let mItem = self.disabilityTypeArray.filter({ (item) -> Bool in
                            item.TypeId == self.newCardItem.DisabilityTypeId
                        }).first else {
                            return
                        }
                        let title = AppConstants.isArabic() ? mItem.TypeTitleAr : mItem.TypeTitleEn
                        self.disabilityTypeView.textField.text = title
                    }
                    
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
                    
                    
                    if self.isRenewal {
                        guard let mItem = self.disabilityLevelArray.filter({ (item) -> Bool in
                            item.LevelId == self.newCardItem.DisabilityLevelId
                        }).first else {
                            return
                        }
                        let title = AppConstants.isArabic() ? mItem.LevelTitleAr : mItem.LevelTitleEn
                        self.disabilityLevelView.textField.text = title
                    }
                    
                }
            }
            
        }
    }
    
    func validateFields() -> Bool{
        
        self.newCardItem.DiagnosisInformation = self.diagnosisInformationView.textField.text ?? ""
        
        var supportingString = ""
        if supportingView.firstCheckBox.checkState == .checked {
            supportingString += equipmentsArray[0].EquipId + "|"
        }
        if supportingView.secondCheckBox.checkState == .checked {
            supportingString += equipmentsArray[1].EquipId + "|"
        }
        if supportingView.thirdCheckBox.checkState == .checked {
            supportingString += equipmentsArray[2].EquipId + "|"
        }
        if supportingView.fourthCheckBox.checkState == .checked {
            supportingString += equipmentsArray[3].EquipId + "|"
        }
        if supportingView.fifthCheckBox.checkState == .checked {
            supportingString += equipmentsArray[4].EquipId + "|"
        }
        
        if supportingView.sixthCheckBox.checkState == .checked {
            supportingString += equipmentsArray[5].EquipId + "|"
        }
        if supportingView.sevenCheckBox.checkState == .checked {
            supportingString += equipmentsArray[6].EquipId + "|"
        }
        
        
        self.newCardItem.SupportingEquipment = supportingString
        self.newCardItem.NeedSupporter = self.needSupporterView.firstCheckBox.checkState == .checked ? "false" : "true"
        self.newCardItem.CanLiveAlone = self.canLiveAloneView.firstCheckBox.checkState == .checked ? "false" : "true"
        self.newCardItem.ReportIssuedBy = self.reportIssuedView.textField.text ?? ""
        self.newCardItem.Speciality = self.specialityView.textField.text ?? ""
        self.newCardItem.ReportDate = self.reportDateView.textField.text ?? ""
        
        
        
        if self.newCardItem.DiagnosisAuthorityId == "" ||
        self.newCardItem.DisabilityTypeId == "" ||
        self.newCardItem.DiagnosisInformation == "" ||
        self.newCardItem.SupportingEquipment == "" ||
        self.newCardItem.NeedSupporter == "" ||
            self.newCardItem.CanLiveAlone == ""  {
            
            Utils.showAlertWith(title: "Error".localize, message: "Please Fill All Fields".localize, viewController: self)
            return false
        }
        return true 
    }
    @IBAction func nextButtonAction(_ sender: Any) {
        if validateFields() {
            self.performSegue(withIdentifier: "toAttachemnent", sender: self)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAttachemnent" {
            let dest = segue.destination as! newCardAttachemnetViewController
            dest.newCardItem = self.newCardItem
            dest.isRenewal = isRenewal
        }
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
            self.newCardItem.DiagnosisAuthorityId = item.AuthId
        }else if pickerView == disabilityLevelPickerView{
            let item = disabilityLevelArray[row]
            
              //self.emirate = item.id
           
            //childItem.emirateID = item.id
            self.disabilityLevelView.textField.text = AppConstants.isArabic() ? item.LevelTitleAr :  item.LevelTitleEn
            self.newCardItem.DisabilityLevelId = item.LevelId
        }else if pickerView == disabilityTypePickerView{
            let item = disabilityTypeArray[row]
            
              //self.emirate = item.id
           
            //childItem.emirateID = item.id
            self.disabilityTypeView.textField.text = AppConstants.isArabic() ? item.TypeTitleAr :  item.TypeTitleEn
            self.newCardItem.DisabilityTypeId = item.TypeId
            
            
            if item.TypeTitleEn == "Multiple Disability" {
                
                mDisabilityHeight.constant = 250
                    
                 mDisabilityVHeight.constant = 30
                
                 
                 multipleDisabilityView.isHidden = false
            }else{
                mDisabilityHeight.constant = 0
                    
                 mDisabilityVHeight.constant = 0
                
                 
                 multipleDisabilityView.isHidden = true
            }
        }
        
    }
    
}
