//
//  familyDetailsViewController.swift
//  MOCD_DEMO
//
//  Created by haya habbous on 11/04/2021.
//  Copyright © 2021 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView


class familyDetailsViewController: UIViewController , NVActivityIndicatorViewable {
    
    var toolBar = UIToolbar()
    var maritalList: [MOCDNationalitiesMaster] = []
    @IBOutlet var maritalStatusPicker: UIPickerView!
    @IBOutlet weak var maritalStatusView: selectTextField!
    @IBOutlet weak var noOfMarriageView: textFieldMandatory!
    @IBOutlet weak var noOfDivorcedView: textFieldMandatory!
    @IBOutlet weak var noOfWidownessView: textFieldMandatory!
    @IBOutlet weak var noOfSonsView: textFieldMandatory!
    @IBOutlet weak var noOfDaughtersView: textFieldMandatory!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupField()
        setupToolbar()
        getMaritalStatus()
    }
    
    func setupField() {
        
        maritalStatusView.textLabel.text = "Marital Status".localize
        maritalStatusView.textField.placeholder = "Please Select".localize
        
        noOfMarriageView.textLabel.text = "No. Of Marriages".localize
        noOfMarriageView.textField.placeholder = "No. Of Marriages".localize
        
        noOfDivorcedView.textLabel.text = "No. Of Divorced".localize
        noOfDivorcedView.textField.placeholder = "No. Of Divorced".localize
        
        
        noOfWidownessView.textLabel.text = "No. Of Widowness".localize
        noOfWidownessView.textField.placeholder = "No. Of Widowness".localize
        
        noOfSonsView.textLabel.text = "No. Of Sons".localize
        noOfSonsView.textField.placeholder = "No. Of Sons".localize
        
        noOfDaughtersView.textLabel.text = "No. Of Daughters".localize
        noOfDaughtersView.textField.placeholder = "No. Of Daughters".localize
        
        
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
        
       
        
        
        if maritalStatusView.textField.text == "" ||
            noOfMarriageView.textField.text == "" ||
            noOfDivorcedView.textField.text == "" ||
           
            noOfWidownessView.textField.text == "" ||
            noOfSonsView.textField.text == "" ||
            noOfDaughtersView.textField.text == ""
            
            {
            
            Utils.showAlertWith(title: "Error".localize, message: "Please Fill All Fields".localize, viewController: self)
            return false
            
            
        }
        
        
        return true
    }
    
    
    @IBAction func nextButton(_ sender: Any) {
        
        if validateFields() {
            self.performSegue(withIdentifier: "toResponsiblePerson", sender: self)
        }
        
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
           
        maritalStatusView.textField.inputAccessoryView = toolBar
        
 
        maritalStatusView.textField.inputView = maritalStatusPicker
        maritalStatusPicker.translatesAutoresizingMaskIntoConstraints = false
    }
    @objc func onClickedToolbeltButton(_ sender: Any){
        self.view.endEditing(true)
    }
    
    func getMaritalStatus() {
        let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        
        
        WebService.GetMaritalStatus { (json) in
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
                    
                    self.maritalList.append(item)
                }
                
                DispatchQueue.main.async {
                    
                    
                    self.maritalStatusPicker.reloadAllComponents()
                }
            }else{
                
                
                DispatchQueue.main.async {
                                   
                    Utils.showAlertWith(title: "Error".localize, message: message, viewController: self)
                    
                }
            }

        }
    }
}
extension familyDetailsViewController: UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == maritalStatusPicker{
            return maritalList.count
        }
        
        return 0
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == maritalStatusPicker{
            let item = maritalList[row]
            let title = AppConstants.isArabic() ?  item.NameinArabic : item.Name
            
            return title
        }
        return ""
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == maritalStatusPicker{
            let item = maritalList[row]
          
            
           
            //self.nationality_id = item.CountryId
            self.maritalStatusView.textField.text = AppConstants.isArabic() ?  item.NameinArabic : item.Name
           
            
        }
        
    }
    
}
