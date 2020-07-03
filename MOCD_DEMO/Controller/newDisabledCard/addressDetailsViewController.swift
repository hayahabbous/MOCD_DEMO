//
//  addressDetailsViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 5/31/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit




class addressDetailsViewController: UIViewController {
    
    
    var toolBar = UIToolbar()
    
    var emiratesArray: [MOCDEmirate] = []
    @IBOutlet var emiratePicker: UIPickerView!
    @IBOutlet var adressView: textFieldMandatory!
    @IBOutlet var emirateView: selectTextField!
    @IBOutlet var poBoxView: textFieldMandatory!
    @IBOutlet var mobileNoView: textFieldMandatory!
    @IBOutlet var otherMobileNoView: textFieldMandatory!
    @IBOutlet var telephoneView: textFieldMandatory!
    @IBOutlet var emailView: textFieldMandatory!
    @IBOutlet var makaniView: textFieldMandatory!
    @IBOutlet var xCordinateView: textFieldMandatory!
    @IBOutlet var yCordinateView: textFieldMandatory!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var previousButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupFields()
        
        setupToolbar()
        getEmirates()
    }
    
    func setupFields() {
        
        adressView.textLabel.text = "Address"
        adressView.textField.placeholder = "Address"
        
        
        emirateView.textLabel.text = "Emirate"
        emirateView.textField.placeholder = "Emirate"
        
        
        poBoxView.textLabel.text = "PO Box"
        poBoxView.textField.placeholder = "PO Box"
        poBoxView.starImage.isHidden = true
        
        mobileNoView.textLabel.text = "Mobile No"
        mobileNoView.textField.placeholder = "Mobile No"
        mobileNoView.textField.keyboardType = .numberPad
        
        
        
        
        otherMobileNoView.textLabel.text = "Other Mobile No"
        otherMobileNoView.textField.placeholder = "Other Mobile No"
        otherMobileNoView.starImage.isHidden = true
         otherMobileNoView.textField.keyboardType = .numberPad
        
        
        telephoneView.textLabel.text = "Telephone"
        telephoneView.textField.placeholder = "Telephone"
        telephoneView.starImage.isHidden = true
        telephoneView.textField.keyboardType = .numberPad
        
        
        
        emailView.textLabel.text = "Email"
        emailView.textField.placeholder = "Email"
        
        
        makaniView.textLabel.text = "Makani No"
        makaniView.textField.placeholder = "Makani No"
        makaniView.starImage.isHidden = true
        
        xCordinateView.textLabel.text = "X Cordinate"
        xCordinateView.textField.placeholder = "X Cordinate"
        xCordinateView.starImage.isHidden = true
        
        yCordinateView.textLabel.text = "Y Cordinate"
        yCordinateView.textField.placeholder = "Y Cordinate"
        yCordinateView.starImage.isHidden = true
        
        
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
        
        emirateView.textField.inputAccessoryView = toolBar
        

        emirateView.textField.isUserInteractionEnabled = true
        emirateView.textField.inputView = emiratePicker
      
        
      
        emiratePicker.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        
    }
    
    @objc func onClickedToolbeltButton(_ sender: Any){
        self.view.endEditing(true)
    }
    
    
    func getEmirates() {
           WebService.getEmirates { (json) in
               
               guard let code = json["code"] as? Int else {return}
               guard let message = json["message"] as? String else {return}
               
               if code == 200 {
                   guard let data = json["data"] as? [String:Any] else {return}
                   guard let results = data["result"] as? [[String:Any]] else {return}
                   
                   var emiratesA: [String: String] = [:]
                   for r in results {
                       
                       
                       let emirateItem = MOCDEmirate()
                       emirateItem.id = r["id"] as! String
                       emirateItem.emirate_en = r["emirate_en"] as! String
                       emirateItem.emirate_ar = r["emirate_ar"] as! String
                       
                       self.emiratesArray.append(emirateItem)
                       
                   }
                   
                   
                   DispatchQueue.main.async {
                       
                       self.emiratePicker.reloadAllComponents()
                   }
               }
               
           }
       }
    @IBAction func nextButtonAction(_ sender: Any) {
        
        self.performSegue(withIdentifier: "toDiagnosisInfo", sender: self)
    }
}
extension addressDetailsViewController: UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == emiratePicker{
            return emiratesArray.count
        }
        
        
        return 0
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == emiratePicker{
            let item = emiratesArray[row]
            let title = AppConstants.isArabic() ? item.emirate_ar :  item.emirate_en
            
            return title
        }
        
        return ""
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == emiratePicker{
            let item = emiratesArray[row]
            
              //self.emirate = item.id
           
            //childItem.emirateID = item.id
            self.emirateView.textField.text = AppConstants.isArabic() ? item.emirate_ar :  item.emirate_en
        }
        
    }
    
}
