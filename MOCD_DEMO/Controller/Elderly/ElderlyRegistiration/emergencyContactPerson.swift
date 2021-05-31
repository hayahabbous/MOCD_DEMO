//
//  emergencyContactPerson.swift
//  MOCD_DEMO
//
//  Created by haya habbous on 11/04/2021.
//  Copyright © 2021 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView


class emergencyContactPerson: UIViewController , NVActivityIndicatorViewable{
    
    var requestId: String = ""
    var appReference: String = ""
    
    var relationsList: [MOCDNationalitiesMaster] = []
    var professioList: [MOCDNationalitiesMaster] = []
    
    var toolBar = UIToolbar()
    
    @IBOutlet var realtionsPicker: UIPickerView!
    @IBOutlet var professionPicker: UIPickerView!
    
    @IBOutlet weak var emiratesIDView: textFieldMandatory!
    @IBOutlet weak var personNameView: textFieldMandatory!
    @IBOutlet weak var mobileNumberView: textFieldMandatory!
    @IBOutlet weak var personRelationshipView: selectTextField!
    @IBOutlet weak var professionView: selectTextField!
    @IBOutlet weak var personAddressView: textFieldMandatory!
    @IBOutlet weak var transferPartyView: textFieldMandatory!
    @IBOutlet weak var transferReasonView: textFieldMandatory!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupField()
        setupToolbar()
        
        
        getRelations()
        getProfession()
    }
    
    func setupField() {
        
        emiratesIDView.textLabel.text = "Emirates ID".localize
        emiratesIDView.textField.placeholder = "Emirates ID".localize
        
        
        personNameView.textLabel.text = "Person Name".localize
        personNameView.textField.placeholder = "Person Name".localize
        
        
        mobileNumberView.textLabel.text = "Mobile Numebr".localize
        mobileNumberView.textField.placeholder = "Mobile Numebr".localize
        
        
        personRelationshipView.textLabel.text = "Person Relationship".localize
        personRelationshipView.textField.placeholder = "Please Select".localize
        
        professionView.textLabel.text = "Profession".localize
        professionView.textField.placeholder = "Please Select".localize
        
        
        personAddressView.textLabel.text = "Person Address".localize
        personAddressView.textField.placeholder = "Person Address".localize
        
        
        transferPartyView.textLabel.text = "Transfer Party".localize
        transferPartyView.textField.placeholder = "Transfer Party".localize
        
        
        transferReasonView.textLabel.text = "Transfer Reason".localize
        transferReasonView.textField.placeholder = "Transfer Reason".localize
        
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
    @IBAction func saveAction(_ sender: Any) {
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
           
        personRelationshipView.textField.inputAccessoryView = toolBar
        personRelationshipView.textField.inputView = realtionsPicker
        
        
        professionView.textField.inputAccessoryView = toolBar
        professionView.textField.inputView = professionPicker
        
        
        
        realtionsPicker.translatesAutoresizingMaskIntoConstraints = false
        professionPicker.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    @objc func onClickedToolbeltButton(_ sender: Any){
        self.view.endEditing(true)
    }
    func getRelations() {
        let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        
        
        WebService.GetRelationsMaster { (json) in
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
                    item.Id = a["Id"] as? String ?? ""
                    item.Name = a["Name"] as? String ?? ""
                    item.NameinArabic = a["NameinArabic"] as? String ?? ""
                    
                    self.relationsList.append(item)
                }
                
                DispatchQueue.main.async {
                    
                    
                    self.realtionsPicker.reloadAllComponents()
                }
            }else{
                
                
                DispatchQueue.main.async {
                                   
                    Utils.showAlertWith(title: "Error".localize, message: message, viewController: self)
                    
                }
            }

        }
    }
    func getProfession() {
        let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        
        
        WebService.GetElderlyProfession { (json) in
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
                    item.Id = a["Id"] as? String ?? ""
                    item.Name = a["Name"] as? String ?? ""
                    item.NameinArabic = a["NameinArabic"] as? String ?? ""
                    
                    self.professioList.append(item)
                }
                
                DispatchQueue.main.async {
                    
                    
                    self.professionPicker.reloadAllComponents()
                }
            }else{
                
                
                DispatchQueue.main.async {
                                   
                    Utils.showAlertWith(title: "Error".localize, message: message, viewController: self)
                    
                }
            }

        }
    }
    
    func validateFields() -> Bool{
        
        
        
        if emiratesIDView.textField.text == "" ||
            personNameView.textField.text == "" ||
            mobileNumberView.textField.text == "" ||
            personRelationshipView.textField.text == "" ||
            professionView.textField.text == "" ||
            personAddressView.textField.text == "" ||
            transferPartyView.textField.text == "" ||
            transferReasonView.textField.text == ""
            {
            
            Utils.showAlertWith(title: "Error".localize, message: "Please Fill All Fields".localize, viewController: self)
            return false
            
            
        }
        
        
        return true
    }
    @IBAction func nextAction(_ sender: Any) {
        
        if !validateFields() {
            return 
        }
        WebService.SaveElderlyRegistartionInMobileUnit { (json) in
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
            dest.requestType = "3"
            dest.contentString = ""
            dest.requestId = self.requestId
            dest.appReference = self.appReference
            dest.isElderly = true
        }
    }
}
extension emergencyContactPerson: UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == realtionsPicker{
            return relationsList.count
        }else if pickerView == professionPicker{
            return professioList.count
        }
        
        
        
        return 0
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == realtionsPicker{
            let item = relationsList[row]
            let title = AppConstants.isArabic() ?  item.NameinArabic : item.Name
            
            return title
        }else if pickerView == professionPicker{
             let item = professioList[row]
            let title = AppConstants.isArabic() ?  item.NameinArabic : item.Name
            
            return title
        }
        return ""
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == realtionsPicker{
            let item = relationsList[row]
          
            
           
            //self.nationality_id = item.CountryId
            self.personRelationshipView.textField.text = AppConstants.isArabic() ?  item.NameinArabic : item.Name
           
            
        } else if pickerView == professionPicker{
            let item = professioList[row]
            self.professionView.textField.text = AppConstants.isArabic() ?  item.NameinArabic : item.Name
       
        }
        
    }
    
}
