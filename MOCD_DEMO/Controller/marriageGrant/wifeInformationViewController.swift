//
//  wifeInformationViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 7/1/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView


class wifeInformationViewController: UIViewController ,NVActivityIndicatorViewable{
    
    var marriageItem: marriageService = marriageService()
    @IBOutlet var educationPicker: UIPickerView!
    var educationsArray: [MOCDEducationLevelMaster] = []
    var toolBar = UIToolbar()
    let nvactivity = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    @IBOutlet var wifeNameView: textFieldMandatory!
    var myString = ""
    @IBOutlet var wifeNameEnView: textFieldMandatory!
    @IBOutlet var dateOfBirthView: dateTexteField!
    @IBOutlet var nationalNumberView: textFieldMandatory!
    @IBOutlet var educationalLevelView: selectTextField!
    @IBOutlet var wifeMobile: textFieldMandatory!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var previousButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(marriageItem.HusbandBirthDate)
        setupField()
        setupToolbar()
        getEducationLevelMaster()
    }
    
    func setupField()
    {
        wifeNameView.textLabel.text = "Wife Name".localize
        wifeNameView.textField.placeholder = "Wife Name".localize
        
        
        wifeNameEnView.textLabel.text = "Wife Name [En]".localize
        wifeNameEnView.textField.placeholder = "Wife Name [En]".localize
        
        
        dateOfBirthView.textLabel.text = "Date of Birth of Wife".localize
        dateOfBirthView.viewController = self
        
        nationalNumberView.textLabel.text = "National Number For The Wife".localize
        nationalNumberView.textField.placeholder = "National Number For The Wife".localize
        
        educationalLevelView.textLabel.text = "Educational Level".localize
        educationalLevelView.textField.placeholder = "Please Select".localize
        
        wifeMobile.textLabel.text = "Wife Mobile".localize
        wifeMobile.textField.placeholder = "Wife Mobile".localize
        
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
        
        educationalLevelView.textField.inputAccessoryView = toolBar
        

        educationalLevelView.textField.isUserInteractionEnabled = true
        educationalLevelView.textField.inputView = educationPicker
      
        
      
        educationPicker.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        
    }
    
    @objc func onClickedToolbeltButton(_ sender: Any){
        self.view.endEditing(true)
    }
    func getEducationLevelMaster() {
        let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        
        
        WebService.GetEducationLevelMaster { (json) in
            print(json)
            DispatchQueue.main.async {
                self.stopAnimating(nil)
            }
            
            guard let code = json["Code"] as? Int else {return}
            guard let message = json["ResponseTitle"] as? String else {return}
            
            if code == 200 {
                
                guard let list = json["Content"] as? [[String: Any]] else{return}
                
                
                for r in list {
                let item: MOCDEducationLevelMaster = MOCDEducationLevelMaster()
                    
                    item.Id = String(describing: r["Id"] ?? "")
                    item.Name = String(describing: r["Name"] ?? "")
                    item.NameinArabic = String(describing: r["NameinArabic"] ?? "")
                    item.ICA_ID = String(describing: r["ICA_ID"] ?? "")
                    
                  
                    
                    self.educationsArray.append(item)
                    
                    
                }
                
                DispatchQueue.main.async {
                    
                    
                    self.educationPicker.reloadAllComponents()
                }
            }else{
                
                
                DispatchQueue.main.async {
                                   
                    Utils.showAlertWith(title: "Error".localize, message: message, viewController: self)
                    
                }
            }

        }
    }
    
    func validateFields() -> Bool{
        //return true
        
        marriageItem.WifeFullNameArabic = wifeNameView.textField.text ?? ""
        marriageItem.WifeFullNameEnglish = wifeNameEnView.textField.text ?? ""
        marriageItem.WifeBirthDate = dateOfBirthView.textField.text ?? ""
        marriageItem.WifeNationalId = nationalNumberView.textField.text ?? ""
        //marriageItem.WifeEducationLevel = educationalLevelView.textField.text ?? ""
        marriageItem.WifeMobile1 = wifeMobile.textField.text ?? ""
        
        let age = self.dateOfBirthView.date.calculateAge() ?? 0
        print(age ?? 0)
        if wifeNameView.textField.text == "" ||
            wifeNameEnView.textField.text == "" ||
            dateOfBirthView.textField.text == "" ||
            nationalNumberView.textField.text == "" ||
            educationalLevelView.textField.text == "" ||
        wifeMobile.textField.text == "" {
            
            Utils.showAlertWith(title: "Error".localize, message: "Please Fill All Fields".localize, viewController: self)
            return false
            
            
        }
        if age < 18 {
            Utils.showAlertWith(title: "Error".localize, message: "Date of birth of Wife is requird (should be more than 18 years)".localize, viewController: self)
            return false
        }
        
        
        return true
        
    }
    @IBAction func nextAction(_ sender: Any) {
        if !validateFields() {
            return
        }
        self.performSegue(withIdentifier: "toContarct", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toContarct" {
            let dest = segue.destination as! marriageContractDataViewController
            dest.marriageItem = self.marriageItem
        }
    }
}
extension wifeInformationViewController: UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return educationsArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let item = educationsArray[row]
        
        return AppConstants.isArabic() ? item.NameinArabic : item.Name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if educationsArray.count > 0 {
            let item = educationsArray[row]
               let title = AppConstants.isArabic() ? item.NameinArabic : item.Name
               educationalLevelView.textField.text = title
            
               marriageItem.WifeEducationLevel = item.Id
        }
        
    }

   
}
