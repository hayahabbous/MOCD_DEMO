//
//  addIncomeViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 7/2/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit
protocol addIncomeDelegate {
    func addIncome(incomeItem: Incom)
    func addFamily(familyItem: FamilyMember)
}
struct Incom{
    var incomeSource: String = ""
    var incomeId: String = ""
    var incomAmount: String = ""
    var companyName: String = ""
}
class addIncomeViewController: UIViewController {
    
    var incomeItem = Incom()
    var delegate: addIncomeDelegate!
    var incomeArray: [MOCDIncomeSource] = []
    var toolBar = UIToolbar()
    @IBOutlet var incomePicker: UIPickerView!
    @IBOutlet var incomeSourceView: selectTextField!
    @IBOutlet var incomeAmountView: textFieldMandatory!
    @IBOutlet var companyNameView: textFieldMandatory!
    
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupField()
        setupToolbar()
        
        getIncomes()
    }
    
    func setupField() {
        
        incomeSourceView.textLabel.text = "Income source".localize
        incomeSourceView.textField.placeholder = "Please Select".localize
        
        
        incomeAmountView.textLabel.text = "Income Amount".localize
        incomeAmountView.textField.placeholder = "Income Amount".localize
        incomeAmountView.textField.keyboardType = .numberPad
        
        
        companyNameView.textLabel.text = "Company Name".localize
        companyNameView.textField.placeholder = "Company Name".localize
        
        
        
        
        let gradient = CAGradientLayer()
        gradient.frame = self.saveButton.bounds
        gradient.colors = [UIColor.green]
        
        self.saveButton.applyGradient(colours: [AppConstants.firstBrownColor, AppConstants.secondBrownColor])
        //self.loginButton.backgroundColor = .green
        self.saveButton.layer.cornerRadius = 20
        self.saveButton.layer.masksToBounds = true
        
        
        gradient.frame = self.cancelButton.bounds
        gradient.colors = [UIColor.green]
        
        self.cancelButton.applyGradient(colours: [AppConstants.firstBrownColor, AppConstants.secondBrownColor])
        //self.loginButton.backgroundColor = .green
        self.cancelButton.layer.cornerRadius = 20
        self.cancelButton.layer.masksToBounds = true
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
           
        incomeSourceView.textField.inputAccessoryView = toolBar
           
  
        
        incomeSourceView.textField.inputView = incomePicker
     
        
        incomePicker.translatesAutoresizingMaskIntoConstraints = false

        
        
    }
    
    @objc func onClickedToolbeltButton(_ sender: Any){
        self.view.endEditing(true)
    }
    
    func getIncomes() {
        WebService.RetrieveIncomeSourceTypeSocial { (json) in
            print(json)
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
                guard let data = json["data"] as? [String:Any] else {return}
                guard let results = data["result"] as? [String:Any] else {return}
                guard let list = results["list"] as? [[String:Any]] else {return}
                var emiratesA: [String: String] = [:]
                for r in list {
                    
                    
                    let incomeItem = MOCDIncomeSource()
                    incomeItem.IncomeSourceTypeId = String(describing: r["IncomeSourceTypeId"]  ?? "" )
                    incomeItem.IncomeSourceTypeAR = String(describing: r["IncomeSourceTypeAR"] ?? "" )
                    incomeItem.IncomeSourceTypeEN = String(describing: r["IncomeSourceTypeEN"] ?? "")
                    
                    self.incomeArray.append(incomeItem)
                    
                }
                
                
                DispatchQueue.main.async {
                    
                    self.incomePicker.reloadAllComponents()
                }
            }
            
        }
    }
    @IBAction func saveAction(_ sender: Any) {
        
        incomeItem.incomeSource = incomeSourceView.textField.text ?? ""
        
        incomeItem.incomAmount = incomeAmountView.textField.text ?? ""
        incomeItem.companyName = companyNameView.textField.text ?? ""
        
        
        
        if incomeItem.incomeSource == "" ||
            incomeItem.incomAmount == "" ||
            incomeItem.companyName == "" {
            
            
            Utils.showAlertWith(title: "Error".localize, message: "Please Fill All Fields".localize, viewController: self)
            return 
        }
        delegate.addIncome(incomeItem: incomeItem)
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension addIncomeViewController: UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == incomePicker{
            return incomeArray.count
        }
        
        return 0
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == incomePicker{
            let item = incomeArray[row]
            let title = AppConstants.isArabic() ?  item.IncomeSourceTypeAR : item.IncomeSourceTypeEN
            
            return title
        }
        return ""
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == incomePicker{
            let item = incomeArray[row]
          
            
           
            //self.nationality_id = item.CountryId
            self.incomeSourceView.textField.text = AppConstants.isArabic() ?  item.IncomeSourceTypeAR : item.IncomeSourceTypeEN
            incomeItem.incomeId = item.IncomeSourceTypeId
        }
        
    }
    
}
