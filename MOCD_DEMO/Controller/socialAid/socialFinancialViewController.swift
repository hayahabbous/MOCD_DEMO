//
//  socialFinancialViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 6/25/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit


class socialFinancialViewController: UIViewController {
    
    
    var toolBar = UIToolbar()
    var centersArray: [MOCDCenterService] = []
    var emiratesArray: [MOCDEmirate] = []
    @IBOutlet var emiratePicker: UIPickerView!
    @IBOutlet var centerPicker: UIPickerView!
    @IBOutlet var emirateView: selectTextField!
    @IBOutlet var centerView: selectTextField!
    @IBOutlet var areaView: textFieldMandatory!
    @IBOutlet var caseReasonView: textFieldMandatory!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var previousButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupField()
        setupToolbar()
        getEmirates()
        getCenters()
    }
    
    func setupField() {
        
        emirateView.textLabel.text = "Emirate"
        emirateView.textField.placeholder = "Please Select"
        
        
        centerView.textLabel.text = "Center"
        centerView.textField.placeholder = "Please Select"
        
        
        
        areaView.textLabel.text = "Area"
        areaView.textField.placeholder = "Area"
        
        
        caseReasonView.textLabel.text = "Case Reason"
        caseReasonView.textField.placeholder = "Case Reason"
        caseReasonView.starImage.isHidden = true
        
        
        
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
           
        emirateView.textField.inputAccessoryView = toolBar
           
        centerView.textField.inputAccessoryView = toolBar
        
        emirateView.textField.inputView = emiratePicker
        centerView.textField.inputView = centerPicker
        
        emiratePicker.translatesAutoresizingMaskIntoConstraints = false
        centerPicker.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    @objc func onClickedToolbeltButton(_ sender: Any){
        self.view.endEditing(true)
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
    
    func getCenters() {
        WebService.RetrieveCenters { (json) in
            
            
            print(json)
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
                guard let data = json["data"] as? [String: Any] else{return}
                guard let result = data["result"] as? [String: Any] else {return}
                guard let list = result["list"] as? [[String: Any]] else {return}
                
                for r in list {
       
                    
                    
                    let item = MOCDCenterService()
                    item.EmirateId = String(describing: r["EmirateId"] ?? "")
                    item.CenterId = String(describing: r["CenterId"] ?? "")
                    item.OfficeNameAR = String(describing: r["OfficeNameAR"] ?? "")
                    item.OfficeNameEN = String(describing: r["OfficeNameEN"] ?? "")
                    
                    self.centersArray.append(item)
                    
                }
                
                
                DispatchQueue.main.async {
                    
                    self.centerPicker.reloadAllComponents()
                }
            }
            
        }
    }
    @IBAction func nextAction(_ sender: Any) {
        self.performSegue(withIdentifier: "toNational", sender: self)
    }
}
extension socialFinancialViewController: UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == emiratePicker{
            return emiratesArray.count
        }else if pickerView == centerPicker{
            return centersArray.count
        }
        
        
        return 0
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == emiratePicker{
            let item = emiratesArray[row]
            let title = AppConstants.isArabic() ?  item.emirate_ar : item.emirate_en
            
            return title
        }else if pickerView == centerPicker{
             let item = centersArray[row]
            let title = AppConstants.isArabic() ?  item.OfficeNameAR : item.OfficeNameEN
            
            return title
        }
        return ""
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == emiratePicker{
            let item = emiratesArray[row]
          
            
           
            //self.nationality_id = item.CountryId
            self.emirateView.textField.text = AppConstants.isArabic() ?  item.emirate_ar : item.emirate_en
            
            
            
        } else if pickerView == centerPicker{
            let item = centersArray[row]
            self.centerView.textField.text = AppConstants.isArabic() ?  item.OfficeNameAR : item.OfficeNameEN
        }
        
    }
    
}
