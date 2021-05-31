//
//  massWeddingApplicantDetailsViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 7/1/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView



struct massWedding {
    
    var husbandName: String = ""
    var nationalForHusband: String = ""
    var wifName: String = ""
    var nationalForWife: String = ""
    var contractDate: String = ""
    var emirate: String = ""
    var city: String = ""
    var mobile: String = ""
    var email: String = ""

    

}
class massWeddingApplicantDetailsViewController: UIViewController ,NVActivityIndicatorViewable{
    
    
    var  massWeddingItem: massWedding = massWedding()
    @IBOutlet var emiratePicker: UIPickerView!
    var emiratesArray: [MOCDEducationLevelMaster] = []
    var toolBar = UIToolbar()
    let nvactivity = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    
    
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var husbandNameView: textFieldMandatory!
    @IBOutlet var nationalNumberView: textFieldMandatory!
    @IBOutlet var dateView: dateTexteField!
    @IBOutlet var wifeNameView: textFieldMandatory!
    @IBOutlet var nationalNumberWifeView: textFieldMandatory!
    @IBOutlet var emirateView: selectTextField!
    @IBOutlet var cityView: textFieldMandatory!
    @IBOutlet var mobileView: textFieldMandatory!
    @IBOutlet var emailView: textFieldMandatory!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupField()
        setupToolbar()
        getEmiratesMaster()
    }
    
    func setupField() {
        
        
        husbandNameView.textLabel.text = "Husband Name".localize
        husbandNameView.textField.placeholder = "Husband Name".localize
        husbandNameView.textField.text = AppConstants.personalUser?.fullEnglishName ?? ""
        
        
        nationalNumberView.textLabel.text = "National Number For the Husband".localize
        nationalNumberView.textField.placeholder = "National Number For the Husband".localize
        nationalNumberView.textField.text = AppConstants.personalUser?.emiratesID ?? ""
        
        
        
        dateView.textLabel.text = "Date of the Marriage Contract".localize
        dateView.viewController = self
        
        wifeNameView.textLabel.text = "Wife Name".localize
        wifeNameView.textField.placeholder = "Wife Name".localize
        
        
        nationalNumberWifeView.textLabel.text = "National Number For the Wife".localize
        nationalNumberWifeView.textField.placeholder = "National Number For the Wife".localize
        
        
        emirateView.textLabel.text = "Emirate".localize
        emirateView.textField.placeholder = "Please Select".localize
        
        
        
        mobileView.textLabel.text = "Mobile No".localize
        mobileView.textField.placeholder = "Mobile No".localize
        mobileView.textField.text = AppConstants.personalUser?.mobileNumber ?? ""
        
        emailView.textLabel.text = "Email".localize
        emailView.textField.placeholder = "Email".localize
        emailView.textField.text = AppConstants.personalUser?.email ?? ""
        
        
        
        cityView.textLabel.text = "City".localize
        cityView.textField.placeholder = "City".localize
        
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
        
        emirateView.textField.inputAccessoryView = toolBar
        

        emirateView.textField.isUserInteractionEnabled = true
        emirateView.textField.inputView = emiratePicker
      
        
      
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
                                   
                    Utils.showAlertWith(title: "Error", message: message, viewController: self)
                    
                }
            }

        }
    }
    
    func validateFields() -> Bool{
        
        
        massWeddingItem.husbandName = husbandNameView.textField.text ?? ""
        massWeddingItem.nationalForHusband = nationalNumberView.textField.text ?? ""
        massWeddingItem.contractDate = dateView.textField.text ?? ""
        massWeddingItem.wifName = wifeNameView.textField.text ?? ""
        massWeddingItem.nationalForWife = nationalNumberWifeView.textField.text ?? ""
        //massWeddingItem.emirate = emirateView.textField.text ?? ""
        massWeddingItem.city = cityView.textField.text ?? ""
        massWeddingItem.mobile = mobileView.textField.text ?? ""
        
        massWeddingItem.email = emailView.textField.text ?? ""
        
        
        if husbandNameView.textField.text == "" ||
            nationalNumberView.textField.text == "" ||
            dateView.textField.text == "" ||
            wifeNameView.textField.text == "" ||
            nationalNumberWifeView.textField.text == "" ||
        emirateView.textField.text == "" ||
        cityView.textField.text == "" ||
        mobileView.textField.text == "" ||
            emailView.textField.text == "" {
            
            Utils.showAlertWith(title: "Error".localize, message: "Please Fill All Fields".localize, viewController: self)
            return false
            
            
        }
        
        
        
        return true
        
    }
    @IBAction func nextAction(_ sender: Any) {
        /*
        if validateFields() {
            self.performSegue(withIdentifier: "toOther", sender: self)
        }*/
        
        if !validateFields() {
            return
        }
        self.performSegue(withIdentifier: "toOther", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toOther" {
            let dest = segue.destination as! massWeddingInfoViewController
            dest.massWeddingItem = self.massWeddingItem
        }
    }
}
extension massWeddingApplicantDetailsViewController: UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return emiratesArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let item = emiratesArray[row]
        
        return item.NameinArabic
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if emiratesArray.count > 0 {
            let item = emiratesArray[row]
               let title = item.NameinArabic
               emirateView.textField.text = title
            
               massWeddingItem.emirate = item.Id
        }
        
    }

   
}
