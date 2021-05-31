//
//  nursingHomeViewController.swift
//  MOCD_DEMO
//
//  Created by haya habbous on 15/04/2021.
//  Copyright © 2021 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView


class nursingHomeViewController: UIViewController ,NVActivityIndicatorViewable {
    
    var relationsList: [MOCDNationalitiesMaster] = []
    var toolBar = UIToolbar()
    
    @IBOutlet var relationPickerView: UIPickerView!
    @IBOutlet weak var emiratesIDView: textFieldMandatory!
    @IBOutlet weak var nameView: textFieldMandatory!
    @IBOutlet weak var relationshipView: selectTextField!
    @IBOutlet weak var phoneNoView: textFieldMandatory!
    @IBOutlet weak var homeAddressView: textFieldMandatory!
    @IBOutlet weak var workphoneNoView: textFieldMandatory!
    @IBOutlet weak var workAddressView: textFieldMandatory!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupField()
        setupToolbar()
        
        getRelations()
    }
    
    func setupField() {
        emiratesIDView.textLabel.text = "Emirates ID".localize
        emiratesIDView.textField.placeholder = "Emirates ID".localize
       
        nameView.textLabel.text = "Name".localize
        nameView.textField.placeholder = "Name".localize
        
        
        relationshipView.textLabel.text = "Relationship".localize
        relationshipView.textField.placeholder = "Please Select".localize
        
        phoneNoView.textLabel.text = "Phone No".localize
        phoneNoView.textField.placeholder = "Phone No".localize
        
        homeAddressView.textLabel.text = "Home Address".localize
        homeAddressView.textField.placeholder = "Home Address".localize
        
        
        workphoneNoView.textLabel.text = "Work Phone No".localize
        workphoneNoView.textField.placeholder = "Work Phone No".localize
        
        workAddressView.textLabel.text = "Work Address".localize
        workAddressView.textField.placeholder = "Work Address".localize
        
        
        
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
           
        relationshipView.textField.inputAccessoryView = toolBar
        relationshipView.textField.inputView = relationPickerView
        
        
        
        
        
        relationPickerView.translatesAutoresizingMaskIntoConstraints = false

        
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
                    
                    
                    self.relationPickerView.reloadAllComponents()
                }
            }else{
                
                
                DispatchQueue.main.async {
                                   
                    Utils.showAlertWith(title: "Error".localize, message: message, viewController: self)
                    
                }
            }

        }
    }
    
    func validateFields() -> Bool{
        
        
        
        
        if relationshipView.textField.text == "" ||
            emiratesIDView.textField.text == "" ||
            nameView.textField.text == "" ||
            phoneNoView.textField.text == "" ||
            homeAddressView.textField.text == "" ||
            workphoneNoView.textField.text == "" ||
            workAddressView.textField.text == ""
            
            {
            
            Utils.showAlertWith(title: "Error".localize, message: "Please Fill All Fields".localize, viewController: self)
            return false
            
            
        }
        
        return true
        
    }
    @IBAction func nextAction(_ sender: Any) {
        
        if validateFields() {
            self.performSegue(withIdentifier: "toPersonDetails", sender: self)
        }
        
        
    }
    
}
extension nursingHomeViewController: UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == relationPickerView{
            return relationsList.count
        }
        
        return 0
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == relationPickerView{
            let item = relationsList[row]
            let title = AppConstants.isArabic() ?  item.NameinArabic : item.Name
            
            return title
        }
        return ""
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == relationPickerView{
            let item = relationsList[row]
          
            //self.nationality_id = item.CountryId
            self.relationshipView.textField.text = AppConstants.isArabic() ?  item.NameinArabic : item.Name
           
            
        }
        
    }
    
}
