//
//  ApplicantCardDetailsVC.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 2/26/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class ApplicantCardDetailsVC: UIViewController ,serviceProtocol{
    func checkboxChnaged(value: Int) {
        if value == 1 {
            organizationHeightConstraint.constant = 0
             organizationView.isHidden = true
            self.view.endEditing(true)
        }else{
            organizationHeightConstraint.constant = 60
            
        
            organizationView.isHidden = false
            self.view.endEditing(true)
        }
    }
    
    
    @IBOutlet var organizationHeightConstraint: NSLayoutConstraint!
    var organizationsArray: [MOCDOrganization] = []
    @IBOutlet var organizationPickerView: UIPickerView!
    @IBOutlet var typeView: multipleTextField!
    @IBOutlet var organizationView: selectTextField!
    @IBOutlet var submitButton: UIButton!
    let activityData = ActivityData()
    var toolBar = UIToolbar()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        setupPickerView()
        
        self.getOrganization()
    }
    
    func setupView() {
        let gradient = CAGradientLayer()
        gradient.frame = self.submitButton.bounds
        gradient.colors = [UIColor.green]
        
        self.submitButton.applyGradient(colours: [AppConstants.firstBrownColor, AppConstants.secondBrownColor])
        //self.loginButton.backgroundColor = .green
        self.submitButton.layer.cornerRadius = 20
        self.submitButton.layer.masksToBounds = true
        
        
        organizationHeightConstraint.constant = 0
        
        setupFields()
    }
     
    func setupPickerView() {
        
        
        organizationPickerView.delegate = self
        organizationPickerView.dataSource = self
        setupToolbar()
        
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
        
        organizationView.textField.inputAccessoryView = toolBar
        

        organizationView.textField.isUserInteractionEnabled = true
        organizationView.textField.inputView = organizationPickerView
      
        
      
        organizationPickerView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        
    }
    
    @objc func onClickedToolbeltButton(_ sender: Any){
        self.view.endEditing(true)
    }
    func setupFields() {
        typeView.textLabel.text = "Type"
        typeView.firstLabel.text = "Personal"
        typeView.secondLabel.text = "Establishment"
        
        typeView.delegate = self
        
        
        organizationView.textLabel.text = "Organization"
        organizationView.textField.placeholder = "Please Select"
        
        organizationView.isHidden = true
        
    }
    
    
    func getOrganization() {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
        
        WebService.RetrieveOrganizations { (json) in
            print(json)
            DispatchQueue.main.async {
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            }
            
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
                
                guard let data = json["data"] as? [String: Any] else{return}
                guard let result = data["result"] as? [String: Any] else {return}
                guard let list = result["list"] as? [[String: Any]] else {return}
                
                for r in list {
                let routine: MOCDOrganization = MOCDOrganization()
                    
                    routine.OrgId = r["OrgId"] as? String  ?? ""
                    routine.OrgTitleAr = r["OrgTitleAr"] as? String  ?? ""
                    routine.OrgTitleEn = r["OrgTitleEn"] as? String  ?? ""
                  
                    
                    self.organizationsArray.append(routine)
                    
                    
                }
                
                DispatchQueue.main.async {
                    
                    
                    self.organizationPickerView.reloadAllComponents()
                }
            }else{
                
                
                DispatchQueue.main.async {
                                   
                    Utils.showAlertWith(title: "Error", message: message, viewController: self)
                    
                }
            }

        }
    }
    @IBAction func nextButtonAction(_ sender: Any) {
        
        self.performSegue(withIdentifier: "toDisabledDetails", sender: self)
    }
}
extension ApplicantCardDetailsVC: UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return organizationsArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let item = organizationsArray[row]
        
        return AppConstants.isArabic() ? item.OrgTitleAr : item.OrgTitleEn
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let item = organizationsArray[row]
        let title = AppConstants.isArabic() ? item.OrgTitleAr : item.OrgTitleEn
        organizationView.textField.text = title
        
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.adjustsFontSizeToFitWidth = true
        
        let item = organizationsArray[row]
        let titleData = AppConstants.isArabic() ? item.OrgTitleAr : item.OrgTitleEn
        
        let myTitle = NSMutableAttributedString(string: titleData , attributes: [NSAttributedString.Key.font:UIFont(name: "Georgia", size: 20.0)!,NSAttributedString.Key.foregroundColor:UIColor.black])
        
        pickerLabel.attributedText = myTitle
  
        
        return pickerLabel
    }
}
