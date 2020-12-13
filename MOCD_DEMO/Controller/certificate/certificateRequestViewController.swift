//
//  certificateRequestViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 7/5/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit

struct officialLetter {
    
    var ApplicantNameAR: String = ""
    var nationalityId: String = ""
    var nationalId: String = ""
    var familyNo: String = ""
    var townNo: String = ""
    var genderId: String = ""
    var entityAddressed: String = ""
    var passportNo: String = ""
    var reason: String = ""

    var mobile: String = ""
    var email: String = ""
   
    
    
     
}
class certificateRequestViewController: UIViewController {
    
    var officialItem: officialLetter = officialLetter()
    var isValidate: Bool = false
    var toolBar = UIToolbar()
    var letterArrays: [MOCDLetterType] = []
    @IBOutlet var letterTypeView: selectTextField!
    @IBOutlet var caseId: textFieldMandatory!
    @IBOutlet var caseIdHeight: NSLayoutConstraint!
    @IBOutlet var caseIdSpace: NSLayoutConstraint!
    @IBOutlet var letterPicker: UIPickerView!
    @IBOutlet var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.title = "Application Form".localize
        setupFields()
        setupToolbar()
        getLetterType()
        //nextButton.isHidden = true
        caseId.isHidden = true
        caseIdSpace.constant = 0
        caseIdHeight.constant = 0
        
        nextButton.isEnabled = false
    }
    
    func setupFields() {
        letterTypeView.textField.placeholder = "Please Select".localize
        letterTypeView.textLabel.text = "Letter Type".localize
        
        
        caseId.textLabel.text = "Case ID".localize
        caseId.textField.placeholder = "Case ID".localize
        
        
        
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
        
        letterTypeView.textField.inputAccessoryView = toolBar
        

        letterTypeView.textField.isUserInteractionEnabled = true
        letterTypeView.textField.inputView = letterPicker
      
        
      
        letterPicker.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        
    }
    
    @objc func onClickedToolbeltButton(_ sender: Any){
        self.view.endEditing(true)
    }
    func getLetterType() {
        WebService.loadOfficialLetterType { (json) in
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
            
                guard let data = json["data"] as? [String:Any] else {return}
                guard let results = data["result"] as? [String:Any] else {return}
                guard let list = results["list"] as? [[String:Any]] else {return}
               
                for r in list {
                    
                    
                    let item = MOCDLetterType()
                   
                    item.ID = String (describing: r["ID"] ?? "" )
                    item.OFFICIAL_LETTER_TYPE_AR = String (describing: r["OFFICIAL_LETTER_TYPE_AR"] ?? "")
                    item.OFFICIAL_LETTER_TYPE_EN  = String (describing: r["OFFICIAL_LETTER_TYPE_EN"] ?? "")
                   
                    
                   
                    self.letterArrays.append(item)
                }
                
                DispatchQueue.main.async {
                  
                    self.letterPicker.reloadAllComponents()
                }
            }
        }
    }
    @IBAction func nextAction(_ sender: Any) {
        if isValidate {
            
            
            if caseId.textField.text == "" {
                
                Utils.showAlertWith(title: "Error".localize, message: "Please Fill All Fields".localize, viewController: self)
                return
            }
            self.performSegue(withIdentifier: "toCaseId", sender: self)
            
        }else{
            self.performSegue(withIdentifier: "toInfo", sender: self)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCaseId" {
            let dest = segue.destination as! certificateCaseIdViewController
            dest.caseId = self.caseId.textField.text ?? ""
            
        }else if segue.identifier == "toInfo"{
            
            let dest = segue.destination as! certificateInformationViewController
            dest.officialItem = self.officialItem
        }
    }
}
extension certificateRequestViewController: UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return letterArrays.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let item = letterArrays[row]
        
        return AppConstants.isArabic() ? item.OFFICIAL_LETTER_TYPE_AR : item.OFFICIAL_LETTER_TYPE_EN
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let item = letterArrays[row]
        let title = AppConstants.isArabic() ? item.OFFICIAL_LETTER_TYPE_AR : item.OFFICIAL_LETTER_TYPE_EN
        letterTypeView.textField.text = title
     
        
        if item.ID == "1"{
            caseIdHeight.constant = 60
            caseId.isHidden = false
            caseIdSpace.constant = 30
            
            nextButton.setTitle("Validate Case Id".localize, for: .normal)
            isValidate = true
            nextButton.isEnabled = true
        }else{
            caseIdHeight.constant = 0
            caseId.isHidden = true
            caseIdSpace.constant = 0
            
            nextButton.setTitle("Next".localize, for: .normal)
            isValidate = false
            nextButton.isEnabled = true
        }
    }

    
}
