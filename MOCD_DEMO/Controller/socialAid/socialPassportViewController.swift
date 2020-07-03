//
//  socialPassportViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 6/26/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit


class socialPassportViewController: UIViewController {
    
    
    var toolBar = UIToolbar()
    
    @IBOutlet var emiratePicker: UIPickerView!
    var emiratesArray: [MOCDEmirate] = []
    
    
    @IBOutlet var passportNoView: textFieldMandatory!
    @IBOutlet var passportIssuePlaceView: selectTextField!
    @IBOutlet var issueDateView: dateTexteField!
    @IBOutlet var immigrationNoView: textFieldMandatory!
    
    @IBOutlet var expiryDateView: dateTexteField!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var previousButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setupField()
        setupToolbar()
        getEmirates()
    }
    
    func setupField() {
        passportNoView.textLabel.text = "Passport No"
        passportNoView.textField.placeholder = "Passport No"
        
        
        passportIssuePlaceView.textLabel.text = "Passport Issue Place"
        passportIssuePlaceView.textField.placeholder = "Please Select"
        
        
        issueDateView.textLabel.text = "Issue Date"
        issueDateView.viewController = self
        
        expiryDateView.textLabel.text = "Expiry Date"
        expiryDateView.viewController = self
        
        immigrationNoView.textLabel.text = "Immigration No"
        immigrationNoView.textField.placeholder = "Immigration No"
        
        
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
    func getEmirates() {
        WebService.getEmirates { (json) in
            print(json)
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
           
        passportIssuePlaceView.textField.inputAccessoryView = toolBar
           
       
        
        passportIssuePlaceView.textField.inputView = emiratePicker
      
        
        emiratePicker.translatesAutoresizingMaskIntoConstraints = false
  
        
        
    }
    
    @objc func onClickedToolbeltButton(_ sender: Any){
        self.view.endEditing(true)
    }
    @IBAction func nextButton(_ sender: Any) {
        self.performSegue(withIdentifier: "toAccomodation", sender: self)
    }
}
extension socialPassportViewController: UIPickerViewDelegate , UIPickerViewDataSource {
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
            let title = AppConstants.isArabic() ?  item.emirate_ar : item.emirate_en
            
            return title
        }
        return ""
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == emiratePicker{
            let item = emiratesArray[row]
          
            
           
            //self.nationality_id = item.CountryId
            self.passportIssuePlaceView.textField.text = AppConstants.isArabic() ?  item.emirate_ar : item.emirate_en
            
            
            
        } 
        
    }
    
}
