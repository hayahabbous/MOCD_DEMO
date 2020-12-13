//
//  ApplicantCardDetailsVC.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 2/26/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView


struct newCardStruct {
    
    var ApplicantTypeId: String = "1"
    var NationalityId:String = "1"
    var IdentificationNo: String  = "7842543222223477232342"
    var expireVisaDate: String = ""
    var UID: String  = "123"
    var FirstNameAR:String  = "test"
    var FatherNameAR:String = "test"
    var GrandfatherNameAR:String = "test"
    var FamilyNameAR:String = "test"
    var FirstNameEN:String = "test"
    var FatherNameEN:String = "test"
    var GrandfatherNameEN:String = "test"
    var FamilyNameEN:String = "test"
    var GenderId:String = "1"
    var DateOfBirth:String = "09/02/2020"
    var IsStudent:String = "true"
    var MaritalStatusId:String = "1"
    var AccommodationTypeId:String = "1"
    var Address:String = "test"
    var EmirateId:String = "1"
    var POBox:String = "1234"
    var MobileNo:String = "1234"
    var OtherMobileNo:String = "1234"
    var PhoneNo:String = "1234"
    var Email:String = "h@g.com"
    var MakaniNo:String = "12345"
    var XCoord:String = "1234"
    var YCoord:String = "1234"
    var DiagnosisAuthorityId:String = "1"
    var DiagnosisInformation:String = "test"
    var DisabilityTypeId:String = "1"
    var DisabilityLevelId:String = "1"
    var SupportingEquipment:String = "1|2|"
    var NeedSupporter:String = "false"
    var CanLiveAlone:String = "false"
    var ReportIssuedBy:String = "test"
    var Speciality:String = "test"
    var ReportDate:String = "09/02/2020"
    var SecurityToken:String = "672382249327378423"
    var UserId:String = ""
    var OrganizationId: String = ""
    var ResidenceExpiryDate: String = ""
    var WorkingStatusId: String = ""
    var WorkFieldId: String = ""
    var Company: String = ""
    var InstitutionId: String = ""
    var CenterId: String = ""

    var disabledCardNumber: String = ""
    var cardIssueDate: String = ""
    var cardExpiryDate: String = ""
    
    
    
    
    var ServiceDocTypeIds:String = ""
    var allFiles: [MOCDReceivedDocumen] = []
}
class ApplicantCardDetailsVC: UIViewController ,serviceProtocol ,NVActivityIndicatorViewable ,refreshDelegate{
    func refreshDateView() {
        
    }
    
    func refreshMultipleView() {
        
    }
    
    func checkboxChnaged(value: Int) {
        if value == 1 {
            organizationHeightConstraint.constant = 0
             organizationView.isHidden = true
            self.view.endEditing(true)
        }else{
            organizationHeightConstraint.constant = 60
            
        
            organizationView.isHidden = false
            self.view.endEditing(true)
        }
    }
    
    
    var isRenewal: Bool = false
    var newCardItem: newCardStruct!
    @IBOutlet var organizationHeightConstraint: NSLayoutConstraint!
    var organizationsArray: [MOCDOrganization] = []
    @IBOutlet var organizationPickerView: UIPickerView!
    @IBOutlet var typeView: multipleTextField!
    @IBOutlet var organizationView: selectTextField!
    @IBOutlet var issueDae: dateTexteField!
    @IBOutlet var issueDateHeight: NSLayoutConstraint!
    @IBOutlet var expiryDate: dateTexteField!
    @IBOutlet var expiryDateHeight: NSLayoutConstraint!
    @IBOutlet var submitButton: UIButton!
    let nvactivity = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    var toolBar = UIToolbar()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isRenewal {
            
        }else{
            newCardItem = newCardStruct()
        }
        setupView()
        
        setupPickerView()
        
        self.getOrganization()
        
        
    }
    
    func setupView() {
        let gradient = CAGradientLayer()
        gradient.frame = self.submitButton.bounds
        gradient.colors = [UIColor.green]
        
        self.submitButton.applyGradient(colours: [AppConstants.firstBrownColor, AppConstants.secondBrownColor])
        //self.loginButton.backgroundColor = .green
        self.submitButton.layer.cornerRadius = 20
        self.submitButton.layer.masksToBounds = true
        
        
        organizationHeightConstraint.constant = 0
        
        setupFields()
    }
     
    func setupPickerView() {
        
        
        organizationPickerView.delegate = self
        organizationPickerView.dataSource = self
        setupToolbar()
        
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
        
        organizationView.textField.inputAccessoryView = toolBar
        

        organizationView.textField.isUserInteractionEnabled = true
        organizationView.textField.inputView = organizationPickerView
      
        
      
        organizationPickerView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        
    }
    
    @objc func onClickedToolbeltButton(_ sender: Any){
        self.view.endEditing(true)
    }
    func setupFields() {
        typeView.textLabel.text = "Type".localize
        typeView.firstLabel.text = "Personal".localize
        typeView.secondLabel.text = "Establishment".localize
        
        typeView.delegate = self
        
        
        organizationView.textLabel.text = "Organization".localize
        organizationView.textField.placeholder = "Please Select".localize
        
        
        
        
        issueDae.textLabel.text = "Issue Date".localize
        //birthDateView.textField.placeholder = "Date of Birth"
        issueDae.viewController = self
        issueDae.delegate = self
        
        
        
        
        expiryDate.textLabel.text = "ExpiryDate".localize
        //birthDateView.textField.placeholder = "Date of Birth"
        expiryDate.viewController = self
        expiryDate.delegate = self
        
        
        
        if isRenewal {
            
            issueDae.isHidden = false
            issueDateHeight.constant = 60
            
            expiryDate.isHidden = false
            expiryDateHeight.constant = 60
            
            
            
            issueDae.textField.text = self.newCardItem.cardIssueDate
            expiryDate.textField.text = self.newCardItem.cardExpiryDate
            
            
        }else{
            issueDae.isHidden = true
            issueDateHeight.constant = 0
            
            expiryDate.isHidden = true
            expiryDateHeight.constant = 0
        }
        
        
        organizationView.isHidden = true
        
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
                    
                    
                    self.organizationPickerView.reloadAllComponents()
                }
            }else{
                
                
                DispatchQueue.main.async {
                                   
                    Utils.showAlertWith(title: "Error".localize, message: message, viewController: self)
                    
                }
            }

        }
    }
    
    func validateFields(){
        
    }
    @IBAction func nextButtonAction(_ sender: Any) {
        
        self.performSegue(withIdentifier: "toDisabledDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDisabledDetails" {
            let dest = segue.destination as! DisabledCardDetailsVC
            dest.newCardItem = self.newCardItem
            dest.isRenewal = isRenewal
        }
    }
}
extension ApplicantCardDetailsVC: UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return organizationsArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let item = organizationsArray[row]
        
        return AppConstants.isArabic() ? item.OrgTitleAr : item.OrgTitleEn
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let item = organizationsArray[row]
        let title = AppConstants.isArabic() ? item.OrgTitleAr : item.OrgTitleEn
        organizationView.textField.text = title
     
        self.newCardItem.OrganizationId = item.OrgId
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.adjustsFontSizeToFitWidth = true
        
        let item = organizationsArray[row]
        let titleData = AppConstants.isArabic() ? item.OrgTitleAr : item.OrgTitleEn
        
        let myTitle = NSMutableAttributedString(string: titleData , attributes: [NSAttributedString.Key.font:UIFont(name: "Georgia", size: 20.0)!,NSAttributedString.Key.foregroundColor:UIColor.black])
        
        pickerLabel.attributedText = myTitle
  
        
        return pickerLabel
    }
}
