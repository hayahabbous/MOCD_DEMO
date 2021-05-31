//
//  responsiblePersonViewController.swift
//  MOCD_DEMO
//
//  Created by haya habbous on 11/04/2021.
//  Copyright © 2021 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class responsiblePersonViewController: UIViewController ,NVActivityIndicatorViewable{
    
    
    var relationsList: [MOCDNationalitiesMaster] = []
    var professioList: [MOCDNationalitiesMaster] = []
    
    var toolBar = UIToolbar()
    
    @IBOutlet var realtionsPicker: UIPickerView!
    @IBOutlet var professionPicker: UIPickerView!
    
    @IBOutlet weak var emiratesIdView: textFieldMandatory!
    @IBOutlet weak var responsibleNameView: textFieldMandatory!
    @IBOutlet weak var mobileNumberView: textFieldMandatory!
    @IBOutlet weak var responsibleRelationshipView: selectTextField!
    @IBOutlet weak var professionView: selectTextField!
    @IBOutlet weak var responsibleAddress: textFieldMandatory!
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
        
        emiratesIdView.textLabel.text = "Emirates ID".localize
        emiratesIdView.textField.placeholder = "Emirates ID".localize
        
        
        
        responsibleNameView.textLabel.text = "Responsible Name".localize
        responsibleNameView.textField.placeholder = "Responsible Name".localize
        
        
        mobileNumberView.textLabel.text = "Mobile Number".localize
        mobileNumberView.textField.placeholder = "Mobile Number".localize
        
        
        responsibleRelationshipView.textLabel.text = "Responsible Relationship".localize
        responsibleRelationshipView.textField.placeholder = "Please Select".localize
        
        
        professionView.textLabel.text = "Profession".localize
        professionView.textField.placeholder = "Please Select".localize
        
        responsibleAddress.textLabel.text = "Responsible Address".localize
        responsibleAddress.textField.placeholder = "Responsible Address".localize
        
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
        
        if emiratesIdView.textField.text == "" ||
            responsibleNameView.textField.text == "" ||
            mobileNumberView.textField.text == "" ||
            responsibleRelationshipView.textField.text == "" ||
            professionView.textField.text == "" ||
            professionView.textField.text == "" ||
            responsibleAddress.textField.text == ""
            
            {
            
            Utils.showAlertWith(title: "Error".localize, message: "Please Fill All Fields".localize, viewController: self)
            return false
            
            
        }
        
        
        return true
    }
    @IBAction func nextAction(_ sender: Any) {
        
        if validateFields() {
            self.performSegue(withIdentifier: "toEmergencyContactPerson", sender: self)
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
           
        responsibleRelationshipView.textField.inputAccessoryView = toolBar
        responsibleRelationshipView.textField.inputView = realtionsPicker
        
        
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
}
extension responsiblePersonViewController: UIPickerViewDelegate , UIPickerViewDataSource {
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
            self.responsibleRelationshipView.textField.text = AppConstants.isArabic() ?  item.NameinArabic : item.Name
           
            
        } else if pickerView == professionPicker{
            let item = professioList[row]
            self.professionView.textField.text = AppConstants.isArabic() ?  item.NameinArabic : item.Name
       
        }
        
    }
    
}
