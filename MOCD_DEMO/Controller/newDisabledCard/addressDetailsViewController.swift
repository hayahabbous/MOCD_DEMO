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
    
    var isRenewal: Bool = false
    var newCardItem: newCardStruct!
    var emiratesArray: [MOCDEmirateService] = []
    var selectedEmirate: MOCDEmirateService = MOCDEmirateService()
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
        
        
        if isRenewal {
            fillFields()
        }
    }
    
    func setupFields() {
        
        adressView.textLabel.text = "Address".localize
        adressView.textField.placeholder = "Address".localize
        
        
        emirateView.textLabel.text = "Emirate".localize
        emirateView.textField.placeholder = "Emirate".localize
        
        
        poBoxView.textLabel.text = "PO Box".localize
        poBoxView.textField.placeholder = "PO Box".localize
        poBoxView.starImage.isHidden = true
        
        mobileNoView.textLabel.text = "Mobile No".localize
        mobileNoView.textField.placeholder = "Mobile No".localize
        mobileNoView.textField.keyboardType = .numberPad
        
        
        
        
        otherMobileNoView.textLabel.text = "Other Mobile No".localize
        otherMobileNoView.textField.placeholder = "Other Mobile No".localize
        otherMobileNoView.starImage.isHidden = true
         otherMobileNoView.textField.keyboardType = .numberPad
        
        
        telephoneView.textLabel.text = "Telephone".localize
        telephoneView.textField.placeholder = "Telephone".localize
        telephoneView.starImage.isHidden = true
        telephoneView.textField.keyboardType = .numberPad
        
        
        
        emailView.textLabel.text = "Email".localize
        emailView.textField.placeholder = "Email".localize
        
        
        makaniView.textLabel.text = "Makani No".localize
        makaniView.textField.placeholder = "Makani No".localize
        makaniView.starImage.isHidden = true
        
        xCordinateView.textLabel.text = "X Cordinate".localize
        xCordinateView.textField.placeholder = "X Cordinate".localize
        xCordinateView.starImage.isHidden = true
        
        yCordinateView.textLabel.text = "Y Cordinate".localize
        yCordinateView.textField.placeholder = "Y Cordinate".localize
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
    
    func fillFields() {
        
        self.adressView.textField.text = self.newCardItem.Address
        self.mobileNoView.textField.text = self.newCardItem.MobileNo
        self.otherMobileNoView.textField.text = self.newCardItem.OtherMobileNo
        self.telephoneView.textField.text = self.newCardItem.PhoneNo
        self.emailView.textField.text = self.newCardItem.Email
        self.makaniView.textField.text = self.newCardItem.MakaniNo
        self.xCordinateView.textField.text = self.newCardItem.XCoord
        self.yCordinateView.textField.text = self.newCardItem.YCoord
        
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
           WebService.RetrieveEmirate { (json) in
               
               guard let code = json["code"] as? Int else {return}
               guard let message = json["message"] as? String else {return}
               
               if code == 200 {
                   guard let data = json["data"] as? [String:Any] else {return}
                   guard let results = data["result"] as? [String:Any] else {return}
                   guard let list = results["list"] as? [[String:Any]] else {return}
                   
                   var emiratesA: [String: String] = [:]
                   for r in list {
                       
                       
                       let emirateItem = MOCDEmirateService()
                       emirateItem.EmirateId = String(describing: r["EmirateId"] ?? "" )
                       emirateItem.EmirateTitleAr = String(describing: r["EmirateTitleAr"] ?? "")
                       emirateItem.EmirateTitleEn = String(describing: r["EmirateTitleEn"] ?? "")
                       
                       self.emiratesArray.append(emirateItem)
                       
                       
                       
                   }
                   
                   
                   DispatchQueue.main.async {
                       
                       self.emiratePicker.reloadAllComponents()
                    
                    if self.isRenewal {
                        guard let mItem = self.emiratesArray.filter({ (item) -> Bool in
                            item.EmirateId == self.newCardItem.EmirateId
                        }).first else {
                            return
                        }
                        let title = AppConstants.isArabic() ? mItem.EmirateTitleAr : mItem.EmirateTitleEn
                        self.emirateView.textField.text = title
                        
                        self.selectedEmirate = mItem
                    }
                    
                   }
               }
               
           }
       }
    
    func validateFields() -> Bool {
        self.newCardItem.Address = self.adressView.textField.text ?? ""
        self.newCardItem.POBox = self.poBoxView.textField.text ?? ""
        self.newCardItem.MobileNo = self.mobileNoView.textField.text ?? ""
        self.newCardItem.OtherMobileNo = self.otherMobileNoView.textField.text ?? ""
        self.newCardItem.Email = self.emailView.textField.text ?? ""
        self.newCardItem.PhoneNo = self.telephoneView.textField.text ?? ""
        self.newCardItem.MakaniNo = self.makaniView.textField.text ?? ""
        self.newCardItem.XCoord = self.xCordinateView.textField.text ?? ""
        self.newCardItem.YCoord = self.yCordinateView.textField.text ?? ""
        
        
        
        if self.newCardItem.Address == "" ||
        self.newCardItem.EmirateId == "" ||
        self.newCardItem.MobileNo == "" ||
        self.newCardItem.Email == ""
            
        {
            Utils.showAlertWith(title: "Error".localize, message: "Please Fill All Fields".localize, viewController: self)
               return false
        }
        
        
        if selectedEmirate.EmirateTitleEn == "Dubai" {
            if self.newCardItem.MakaniNo == "" {
                Utils.showAlertWith(title: "Error".localize, message: "Makani Number is Mandatory".localize, viewController: self)
                return false
            }
        }
        return true
        
    }
    @IBAction func nextButtonAction(_ sender: Any) {
        if validateFields() {
            self.performSegue(withIdentifier: "toDiagnosisInfo", sender: self)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDiagnosisInfo" {
            let dest = segue.destination as! diagnosisInformationViewController
            dest.newCardItem = self.newCardItem
            dest.isRenewal = self.isRenewal
        }
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
            let title = AppConstants.isArabic() ? item.EmirateTitleAr :  item.EmirateTitleEn
            
            return title
        }
        
        return ""
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == emiratePicker{
            let item = emiratesArray[row]
            
              //self.emirate = item.id
           
            //childItem.emirateID = item.id
            self.emirateView.textField.text = AppConstants.isArabic() ? item.EmirateTitleAr :  item.EmirateTitleEn
            self.newCardItem.EmirateId = item.EmirateId
            
            selectedEmirate = item
            if item.EmirateTitleEn == "Dubai" {
                makaniView.starImage.isHidden = false
            }else{
                makaniView.starImage.isHidden = true
            }
        }
        
    }
    
}
