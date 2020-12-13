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
    
    var socialAidItem: socialAid = socialAid()
    var toolBar = UIToolbar()
    var centersArray: [MOCDCenterService] = []
    var emiratesArray: [MOCDEmirateService] = []
    var filiteredCenters: [MOCDCenterService] = []
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
        
        emirateView.textLabel.text = "Emirate".localize
        emirateView.textField.placeholder = "Please Select".localize
        
        
        centerView.textLabel.text = "Center".localize
        centerView.textField.placeholder = "Please Select".localize
        
        
        
        areaView.textLabel.text = "Area".localize
        areaView.textField.placeholder = "Area".localize
        
        
        caseReasonView.textLabel.text = "Case Reason".localize
        caseReasonView.textField.placeholder = "Case Reason".localize
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
        WebService.RetrieveEmirateSocial { (json) in
            print(json)
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
                guard let data = json["data"] as? [String:Any] else {return}
                guard let results = data["result"] as? [String:Any] else {return}
                guard let list = results["list"] as? [[String:Any]] else {return}
                
                
                for r in list {
                    
                    
                    let emirateItem = MOCDEmirateService()
                    emirateItem.EmirateId = String(describing: r["EmirateId"] ?? "" )
                    emirateItem.EmirateTitleAr = String(describing: r["EmirateTitleAR"] ?? "")
                    emirateItem.EmirateTitleEn = String(describing: r["EmirateTitleEN"] ?? "")
                    
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
    
    func validateFields() -> Bool{
        
        //return true
        
        
        socialAidItem.Area = areaView.textField.text ?? ""
        socialAidItem.CaseReason = caseReasonView.textField.text ?? ""
        
        if emirateView.textField.text == "" ||
            centerView.textField.text == "" ||
            areaView.textField.text == ""
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
        self.performSegue(withIdentifier: "toNational", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "toNational" {
            let dest = segue.destination as! socialNationalViewController
            dest.socialAidItem = self.socialAidItem
        }
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
            if filiteredCenters.count > 0 {
                return filiteredCenters.count
            }
            return 0
        }
        
        
        return 0
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == emiratePicker{
            let item = emiratesArray[row]
            let title = AppConstants.isArabic() ?  item.EmirateTitleAr : item.EmirateTitleEn
            
            return title
        }else if pickerView == centerPicker{
             let item = filiteredCenters[row]
            let title = AppConstants.isArabic() ?  item.OfficeNameAR : item.OfficeNameEN
            
            return title
        }
        return ""
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == emiratePicker{
            let item = emiratesArray[row]
          
            
           
            //self.nationality_id = item.CountryId
            self.emirateView.textField.text = AppConstants.isArabic() ?  item.EmirateTitleAr : item.EmirateTitleEn
            
            self.filiteredCenters = centersArray.filter({ (center) -> Bool in
                center.EmirateId == item.EmirateId
            })
            
            
            socialAidItem.EmirateId = item.EmirateId
            
            self.centerPicker.reloadAllComponents()
            
        } else if pickerView == centerPicker{
            
            
            if filiteredCenters.count == 0 {
                return
            }
            let item = filiteredCenters[row]
            self.centerView.textField.text = AppConstants.isArabic() ?  item.OfficeNameAR : item.OfficeNameEN
            socialAidItem.CenterId = item.CenterId
        }
        
    }
    
}
