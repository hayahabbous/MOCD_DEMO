//
//  incomeStatmentViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 7/1/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView



class incomeStatmentViewController: UIViewController ,NVActivityIndicatorViewable{
    
    var marriageItem: marriageService = marriageService()
    @IBOutlet var incomePicker: UIPickerView!
    var incomeArray: [MOCDEducationLevelMaster] = []
    var toolBar = UIToolbar()
    let nvactivity = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    
    var contentString = ""
    
    @IBOutlet var totalMonthlyIncomeView: textFieldMandatory!
    @IBOutlet var bankNameView: selectTextField!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var previousButton: UIButton!
    @IBOutlet var ibanView: textFieldMandatory!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupField()
        setupToolbar()
        getBanktMaster()
    }
    
    func setupField()
    {
        totalMonthlyIncomeView.textLabel.text = "Total monthly income".localize
        totalMonthlyIncomeView.textField.placeholder = "Total monthly income".localize
        totalMonthlyIncomeView.textField.keyboardType = .numberPad
        
        bankNameView.textLabel.text = "Bank Name".localize
        bankNameView.textField.placeholder = "Please Select".localize
        
        
        ibanView.textLabel.text = "International Account Number (IBAN)".localize
        ibanView.textField.placeholder = "International Account Number (IBAN)".localize
        
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
        
        bankNameView.textField.inputAccessoryView = toolBar
        

        bankNameView.textField.isUserInteractionEnabled = true
        bankNameView.textField.inputView = incomePicker
      
        
      
        incomePicker.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        
    }
    
    @objc func onClickedToolbeltButton(_ sender: Any){
        self.view.endEditing(true)
    }
    func getBanktMaster() {
        let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        
        
        WebService.GetBankListMaster { (json) in
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
                    
                  
                    
                    self.incomeArray.append(item)
                    
                    
                }
                
                DispatchQueue.main.async {
                    
                    
                    self.incomePicker.reloadAllComponents()
                }
            }else{
                
                
                DispatchQueue.main.async {
                                   
                    Utils.showAlertWith(title: "Error".localize, message: message, viewController: self)
                    
                }
            }

        }
    }
    
    func validateFields() -> Bool{
        
     
        marriageItem.Totalmonthlyincome = totalMonthlyIncomeView.textField.text ?? ""
        //marriageItem.BankName = bankNameView.textField.text ?? ""
        marriageItem.IBAN = ibanView.textField.text ?? ""
        
        
        
        if totalMonthlyIncomeView.textField.text == "" ||
            bankNameView.textField.text == "" ||
            ibanView.textField.text == "" {
            
            Utils.showAlertWith(title: "Error".localize, message: "Please Fill All Fields".localize, viewController: self)
            return false
            
            
        }
        if Int(marriageItem.Totalmonthlyincome) ?? 60000000 > 40000 {
            Utils.showAlertWith(title: "Error".localize, message: "Your total monthly income exceeds 40000. and you cannot submit this application.".localize, viewController: self)
            return false
        }
        
        if Int(marriageItem.Totalmonthlyincome) ?? 60000000 < 40000  &&
            Int(marriageItem.Totalmonthlyincome) ?? 60000000 > 25000{
            //Utils.showAlertWith(title: "Error".localize, message: "Your total monthly income exceeds the conditions and controls. Hence, you will be added to the Kun family initiative.".localize, viewController: self)
          
        }
        return true
        
    }
    @IBAction func nextAction(_ sender: Any) {
        if !validateFields() {
            return
        }
        saveAction(sender)
        //self.performSegue(withIdentifier: "toDoc", sender: self)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
        if !validateFields() {
            return
        }
        //self.performSegue(withIdentifier: "toDoc", sender: self)
        
        let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
               
               
        WebService.SubmitGrantRequest(HusbandNationalId: marriageItem.HusbandNationalId, WifeNationalId: marriageItem.WifeNationalId, MarriageContractDate: marriageItem.MarriageContractDate, Court: marriageItem.Court, EmployerCategory: marriageItem.EmployerCategory, HusbandFullNameArabic: marriageItem.HusbandFullNameArabic, HusbandFullNameEnglish: marriageItem.HusbandFullNameEnglish, HusbandBirthDate: marriageItem.HusbandBirthDate, HusbandEducationLevel: marriageItem.HusbandEducationLevel, HusbandMobile1: marriageItem.HusbandMobile1, HusbandMobile2: marriageItem.HusbandMobile2, HusbandEmail: marriageItem.HusbandEmail, WifeFullNameArabic: marriageItem.HusbandFullNameArabic, WifeFullNameEnglish: marriageItem.WifeFullNameEnglish, WifeBirthDate: marriageItem.WifeBirthDate, WifeEducationLevel: marriageItem.WifeEducationLevel, WifeMobile1: marriageItem.WifeMobile1, WifeEmail: marriageItem.WifeEmail, FamilyBookNumber: marriageItem.FamilyBookNumber, TownNumber: marriageItem.TownNumber, FamilyNumber: marriageItem.FamilyNumber, FamilyBookIssueDate: marriageItem.FamilyBookIssueDate, FamilyBookIssuePlace: marriageItem.FamilyBookIssuePlace, Employer: marriageItem.Employer, WorkPlace: marriageItem.WorkPlace, Totalmonthlyincome: marriageItem.Totalmonthlyincome, BankName: marriageItem.BankName, IBAN: marriageItem.BankName) { (json) in
            
            
            print(json)
            DispatchQueue.main.async {
            
                self.stopAnimating(nil)
            }
            guard let ResponseDescriptionEn = json["ResponseDescriptionEn"] as? String else {return}
            guard let ResponseDescriptionAr = json["ResponseDescriptionAr"] as? String else {return}
            guard let ResponseTitle = json["ResponseTitle"] as? String else {return}
            
            
            
            guard let content = json["Content"] as? [String:Any] else {
                
                DispatchQueue.main.async {
             
                    Utils.showAlertWith(title: ResponseTitle, message: AppConstants.isArabic() ? ResponseDescriptionAr : ResponseDescriptionEn, viewController: self)
                }
                return
                
            }
            guard let RequestId = content["RequestId"] as? String else {
                
                DispatchQueue.main.async {
               
                    Utils.showAlertWith(title: ResponseTitle, message: AppConstants.isArabic() ? ResponseDescriptionAr : ResponseDescriptionEn, viewController: self)
                }
                return
                
            }
            
            
            
            DispatchQueue.main.async {
            
                
                self.contentString = RequestId
                
                self.performSegue(withIdentifier: "toDoc", sender: self)
            }
        }
           
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toOtherInfo" {
            let dest = segue.destination as! marriageOtherInformationViewController
            dest.marriageItem = self.marriageItem
        }else if segue.identifier == "toDoc" {
            let dest = segue.destination as! masterDocViewController
            dest.requestType = "0"
            dest.contentString = self.contentString
        }
    }
    
    
}
extension incomeStatmentViewController: UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return incomeArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let item = incomeArray[row]
        
        return AppConstants.isArabic() ? item.NameinArabic : item.Name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if incomeArray.count > 0 {
            let item = incomeArray[row]
               let title = AppConstants.isArabic() ? item.NameinArabic : item.Name
               bankNameView.textField.text = title
            
               marriageItem.BankName  = item.Id
        }
        
    }

   
}
