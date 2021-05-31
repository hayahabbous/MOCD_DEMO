//
//  edaadabstractEnrollmentViewController.swift
//  MOCD_DEMO
//
//  Created by haya habbous on 24/05/2021.
//  Copyright © 2021 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView



class edaadabstractEnrollmentViewController: UIViewController,NVActivityIndicatorViewable {
    
    var marriageItem: marriageService = marriageService()
    @IBOutlet var emiratePicker: UIPickerView!
    var emiratesArray: [MOCDEducationLevelMaster] = []
    var toolBar = UIToolbar()
    let nvactivity = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    var contentString: String = ""
    
    @IBOutlet var numberofFamilyBookView: textFieldMandatory!
    @IBOutlet var NumberTown: textFieldMandatory!
    @IBOutlet var familyNoView: textFieldMandatory!
    @IBOutlet var dateOfIssuanceView: dateTexteField!
    @IBOutlet var placeIssuanceView: selectTextField!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var previousButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupField()
        
        setupToolbar()
        getEmiratesMaster()
    }
    
    func setupField()
    {
        
        numberofFamilyBookView.textLabel.text = "Number of Family Book".localize
        numberofFamilyBookView.textField.placeholder = "Number of Family Book".localize
        
        NumberTown.textLabel.text = "Number Town".localize
        NumberTown.textField.placeholder = "Number Town".localize
        
        
        familyNoView.textLabel.text = "Family No".localize
        familyNoView.textField.placeholder = "Family No".localize
        
        
        dateOfIssuanceView.textLabel.text = "Date of Issuance of the Family Book".localize
        dateOfIssuanceView.viewController = self
        
        placeIssuanceView.textLabel.text = "Place Issuance of a Passport".localize
        placeIssuanceView.textField.placeholder = "Please Select".localize
        
        
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
        
        placeIssuanceView.textField.inputAccessoryView = toolBar
        

        placeIssuanceView.textField.isUserInteractionEnabled = true
        placeIssuanceView.textField.inputView = emiratePicker
      
        
      
        emiratePicker.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        
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
                                   
                    Utils.showAlertWith(title: "Error".localize, message: message, viewController: self)
                    
                }
            }

        }
    }
    
    func validateFields() -> Bool{
        
    
        marriageItem.FamilyBookNumber = numberofFamilyBookView.textField.text ?? ""
        marriageItem.TownNumber = NumberTown.textField.text ?? ""
        marriageItem.FamilyNumber = familyNoView.textField.text ?? ""
        marriageItem.FamilyBookIssueDate = dateOfIssuanceView.textField.text ?? ""
        marriageItem.familyBookDate = dateOfIssuanceView.date ?? Date()
        //marriageItem.FamilyBookIssuePlace = placeIssuanceView.textField.text ?? ""
       
        
        
        
        if numberofFamilyBookView.textField.text == "" ||
            NumberTown.textField.text == "" ||
            familyNoView.textField.text == "" ||
            dateOfIssuanceView.textField.text == "" ||
            placeIssuanceView.textField.text == ""{
            
            Utils.showAlertWith(title: "Error".localize, message: "Please Fill All Fields".localize, viewController: self)
            return false
            
            
        }
        
        if marriageItem.familyBookDate < marriageItem.marriageContractDate {
            Utils.showAlertWith(title: "Error".localize, message: "Family book date should be same or after marriage contract date".localize, viewController: self)
            return false
        }
        
        return true
        
    }
    @IBAction func nextAction(_ sender: Any) {
        if !validateFields() {
            return
        }
        //self.performSegue(withIdentifier: "toSatatment", sender: self)
        saveAction(sender)
    }
    @IBAction func saveAction(_ sender: Any) {
        
        //self.performSegue(withIdentifier: "toDoc", sender: self)
        
        
        if !validateFields() {
            return
        }
        let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        WebService.SubmitEdaadRequest(HusbandNationalId: marriageItem.HusbandNationalId, WifeNationalId: marriageItem.WifeNationalId, MarriageContractDate: marriageItem.MarriageContractDate, HusbandFullNameEnglish: marriageItem.HusbandFullNameEnglish, HusbandEmail: marriageItem.HusbandEmail, WifeFullNameEnglish: marriageItem.WifeFullNameEnglish, FamilyBookIssuePlace: marriageItem.FamilyBookIssuePlace) { (json) in
            
            print(json)
            
            DispatchQueue.main.async {
            
                self.stopAnimating(nil)
            }
            guard let Code = json["Code"] as? Int else {return}
            guard let ResponseDescriptionEn = json["ResponseDescriptionEn"] as? String else {return}
            guard let ResponseDescriptionAr = json["ResponseDescriptionAr"] as? String else {return}
            guard let ResponseTitle = json["ResponseTitle"] as? String else {return}
            
            
            
            guard let content = json["Content"] as? String else {
                
                DispatchQueue.main.async {
             
                    Utils.showAlertWith(title: ResponseTitle, message: AppConstants.isArabic() ? ResponseDescriptionAr : ResponseDescriptionEn, viewController: self)
                }
                return
                
            }
            if Code != 200 {
                DispatchQueue.main.async {
                
                       Utils.showAlertWith(title: ResponseTitle, message: AppConstants.isArabic() ? ResponseDescriptionAr : ResponseDescriptionEn, viewController: self)
                   }
                   return
            }
            DispatchQueue.main.async {
            
                
                self.contentString = content
                
                self.performSegue(withIdentifier: "toDoc", sender: self)
            }
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSatatment" {
            let dest = segue.destination as! statmenetOfWorkViewController
            dest.marriageItem = self.marriageItem
        }
        if segue.identifier == "toDoc" {
            let dest = segue.destination as! masterDocViewController
            dest.requestType = "1"
            dest.contentString = self.contentString
        }
    }
}
extension edaadabstractEnrollmentViewController: UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return emiratesArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let item = emiratesArray[row]
        
        return AppConstants.isArabic() ? item.NameinArabic : item.Name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if emiratesArray.count > 0 {
            let item = emiratesArray[row]
               let title = AppConstants.isArabic() ? item.NameinArabic : item.Name
               placeIssuanceView.textField.text = title
            
               marriageItem.FamilyBookIssuePlace = item.Id
        }
        
    }

   
}
