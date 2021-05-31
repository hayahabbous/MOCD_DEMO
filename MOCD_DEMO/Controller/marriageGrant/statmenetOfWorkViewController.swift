//
//  statmenetOfWorkViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 7/1/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView


class statmenetOfWorkViewController: UIViewController ,NVActivityIndicatorViewable{
    var marriageItem: marriageService = marriageService()
    @IBOutlet var emiratePicker: UIPickerView!
    @IBOutlet var employerPicker: UIPickerView!
    var emiratesArray: [MOCDEducationLevelMaster] = []
    var employerArray: [MOCDEducationLevelMaster] = []
    var toolBar = UIToolbar()
    let nvactivity = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    
    
    
    @IBOutlet var employerCategoryView: selectTextField!
    @IBOutlet var emplyerView: textFieldMandatory!
    @IBOutlet var placeOfWorkView: selectTextField!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var previousButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupField()
        setupToolbar()
        getEmployerMaster()
        getEmiratesMaster()
    }
    
    func setupField()
    {
        
        employerCategoryView.textLabel.text = "The Employee Category".localize
        employerCategoryView.textField.placeholder = "Please Select".localize
        
        
        emplyerView.textLabel.text = "Employer".localize
        emplyerView.textField.placeholder = "Employer".localize
        
        placeOfWorkView.textLabel.text = "Place of Work".localize
        placeOfWorkView.textField.placeholder = "Please Select".localize
        
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
        
        placeOfWorkView.textField.inputAccessoryView = toolBar
        

        placeOfWorkView.textField.isUserInteractionEnabled = true
        placeOfWorkView.textField.inputView = emiratePicker
      
        
      
        emiratePicker.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        
        employerCategoryView.textField.inputAccessoryView = toolBar
          

          employerCategoryView.textField.isUserInteractionEnabled = true
          employerCategoryView.textField.inputView = employerPicker
        
          
        
          employerPicker.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        
    }
    
    @objc func onClickedToolbeltButton(_ sender: Any){
        self.view.endEditing(true)
    }
    func getEmiratesMaster() {
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
                
                
                for r in list {
                let item: MOCDEducationLevelMaster = MOCDEducationLevelMaster()
                    
                    item.Id = String(describing: r["Id"] ?? "")
                    item.Name = String(describing: r["Name"] ?? "")
                    item.NameinArabic = String(describing: r["NameinArabic"] ?? "")
                    //item.ICA_ID = String(describing: r["ICA_ID"] ?? "")
                    
                  
                    
                    self.emiratesArray.append(item)
                    
                    
                }
                
                DispatchQueue.main.async {
                    
                    
                    self.emiratePicker.reloadAllComponents()
                }
            }else{
                
                
                DispatchQueue.main.async {
                                   
                    Utils.showAlertWith(title: "Error", message: message, viewController: self)
                    
                }
            }

        }
    }
    
    
    func getEmployerMaster() {
        let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        
        
        WebService.GetEmployerTypeMaster { (json) in
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
                    //item.ICA_ID = String(describing: r["ICA_ID"] ?? "")
                    
                  
                    
                    self.employerArray.append(item)
                    
                    
                }
                
                DispatchQueue.main.async {
                    
                    
                    self.employerPicker.reloadAllComponents()
                }
            }else{
                
                
                DispatchQueue.main.async {
                                   
                    Utils.showAlertWith(title: "Error", message: message, viewController: self)
                    
                }
            }

        }
    }
    
    func validateFields() -> Bool{
        
     
        //marriageItem.EmployerCategory = employerCategoryView.textField.text ?? ""
        marriageItem.Employer = emplyerView.textField.text ?? ""
        //marriageItem.WorkPlace = placeOfWorkView.textField.text ?? ""
        
        
        if employerCategoryView.textField.text == "" ||
            emplyerView.textField.text == "" ||
            placeOfWorkView.textField.text == "" {
            
            Utils.showAlertWith(title: "Error".localize, message: "Please Fill All Fields".localize, viewController: self)
            return false
            
            
        }
        
        
        
        return true
        
    }
    @IBAction func nextAction(_ sender: Any) {
        if !validateFields() {
            return
        }
        self.performSegue(withIdentifier: "toIncomeStatment", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toIncomeStatment" {
            let dest = segue.destination as! incomeStatmentViewController
            dest.marriageItem = self.marriageItem
        }
    }
}
extension statmenetOfWorkViewController: UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == emiratePicker {
            return emiratesArray.count
        }else if pickerView == employerPicker {
            return employerArray.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == emiratePicker {
           
            let item = emiratesArray[row]
            
            return AppConstants.isArabic() ? item.NameinArabic : item.Name
        }else if pickerView == employerPicker {
            let item = employerArray[row]
            
            return AppConstants.isArabic() ? item.NameinArabic : item.Name
        }
    
        
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == emiratePicker {
           
            if emiratesArray.count > 0 {
                let item = emiratesArray[row]
                   let title = item.NameinArabic
                   placeOfWorkView.textField.text = title
                
                marriageItem.WorkPlace = item.Id
            }
            
        }else if pickerView == employerPicker {
            
            if employerArray.count > 0 {
                let item = employerArray[row]
                let title = AppConstants.isArabic() ? item.NameinArabic : item.Name
                employerCategoryView.textField.text = title
                marriageItem.EmployerCategory = item.Id
            }
            
        }
        
        
    }

   
}
