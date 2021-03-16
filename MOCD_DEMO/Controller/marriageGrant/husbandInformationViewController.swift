//
//  husbandInformationViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 7/1/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView
import CryptoSwift


struct marriageService {
    
    var HusbandNationalId: String = ""
    var WifeNationalId: String = ""
    var Court: String = ""
    var EmployerCategory: String = ""
    var MarriageContractDate: String = ""
    var HusbandFullNameArabic: String = ""
    var HusbandFullNameEnglish: String = ""
    var HusbandBirthDate: String = ""
    var HusbandEducationLevel: String = ""
    var HusbandMobile1: String = ""
    var HusbandMobile2: String = ""
    var HusbandEmail: String = ""
    var WifeFullNameArabic: String = ""
    var WifeFullNameEnglish: String = ""
    var WifeBirthDate: String = ""
    var WifeEducationLevel: String = ""
    var WifeMobile1: String = ""
    var WifeEmail: String = ""
    var FamilyBookNumber: String = ""
    var TownNumber: String = ""
    var FamilyNumber: String = ""
    var FamilyBookIssueDate: String = ""
    var FamilyBookIssuePlace: String = ""
    var Employer: String = ""
    var WorkPlace: String = ""
    var Totalmonthlyincome: String = ""
    var BankName: String = ""
    var IBAN: String = ""
    
    
    var marriageContractDate: Date = Date()
    var familyBookDate: Date = Date()

}

class husbandInformationViewController: UIViewController ,NVActivityIndicatorViewable{
    
    var marriageItem: marriageService = marriageService()
    @IBOutlet var educationPicker: UIPickerView!
    var educationsArray: [MOCDEducationLevelMaster] = []
    var toolBar = UIToolbar()
    let nvactivity = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    @IBOutlet var husbandNameView: textFieldMandatory!
    @IBOutlet var husbandNameEnView: textFieldMandatory!
    @IBOutlet var dateOfBirthView: dateTexteField!
    @IBOutlet var nationalNumberView: textFieldMandatory!
    @IBOutlet var educationalLevelView: selectTextField!
    @IBOutlet var emailView: textFieldMandatory!
    @IBOutlet var mobileoneView: textFieldMandatory!
    @IBOutlet var mobiletowView: textFieldMandatory!
    @IBOutlet var nextButton: UIButton!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupField()
        getToken()
        setupToolbar()
        
        getEducationLevelMaster()
        
        let user = MOCDUser.getMOCDUser()
        getPersonProfile(id: user?.DId ?? "")
        
        cipherText()
        
    }
    func cipherText() {
        let password: [UInt8] = Array("s33krit".utf8)
        let salt: [UInt8] = Array("nacllcan".utf8)

        /* Generate a key from a `password`. Optional if you already have a key */
        let key = try! PKCS5.PBKDF2(
            password: password,
            salt: salt,
            iterations: 4096,
            keyLength: 32, /* AES-256 */
            variant: .sha256
        ).calculate()

        /* Generate random IV value. IV is public value. Either need to generate, or get it from elsewhere */
        let iv = AES.randomIV(AES.blockSize)

        /* AES cryptor instance */
        let aes = try! AES(key: key, blockMode: CBC(iv: iv), padding: .pkcs7)

        /* Encrypt Data */
        let inputData = Data()
        let encryptedBytes = try! aes.encrypt(inputData.bytes)
        let encryptedData = Data(encryptedBytes)

        /* Decrypt Data */
        let decryptedBytes = try! aes.decrypt(encryptedData.bytes)
        let decryptedData = Data(decryptedBytes)
        
        let s = String(describing: "Zvrsjn#:Pbhdz32R@'=&\\WW*")
        do {
            let aes = try AES(key: s , iv: "drowssapdrowssap") // aes128
            let ciphertext = try aes.encrypt(Array("Nullam quis risus eget urna mollis ornare vel eu leo.".utf8))
            
            
            print(ciphertext)
            
            let ciphertext1 = try aes.encrypt(ciphertext).toBase64()
            print(ciphertext1)
        } catch { }
    }
    func setupField()
    {
        
        husbandNameView.textLabel.text = "Husband Name".localize
        husbandNameView.textField.placeholder = "Husband Name".localize
        
        
        husbandNameEnView.textLabel.text = "Husband Name [EN]".localize
        husbandNameEnView.textField.placeholder = "Husband Name [EN]".localize
        
        
        dateOfBirthView.textLabel.text = "Date of Birth of Husband".localize
        dateOfBirthView.viewController = self
        
        nationalNumberView.textLabel.text = "National Number For The Husband".localize
        nationalNumberView.textField.placeholder = "National Number For The Husband".localize
        
        educationalLevelView.textLabel.text = "Educational Level"
        educationalLevelView.textField.placeholder = "Please Select"
        
        
        emailView.textLabel.text = "Email".localize
        emailView.textField.placeholder = "Email".localize
        
        mobileoneView.textLabel.text = "Mobile 1".localize
        mobileoneView.textField.placeholder = "Mobile 1".localize
        
        
        mobiletowView.textLabel.text = "Mobile 2".localize
        mobiletowView.textField.placeholder = "Mobile 2".localize
        
        
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
        
        educationalLevelView.textField.inputAccessoryView = toolBar
        

        educationalLevelView.textField.isUserInteractionEnabled = true
        educationalLevelView.textField.inputView = educationPicker
      
        
      
        educationPicker.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        
    }
    
    @objc func onClickedToolbeltButton(_ sender: Any){
        self.view.endEditing(true)
    }
    func getToken() {
        let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        
        
        WebService.getToken { (json) in
            print(json)
            DispatchQueue.main.async {
                self.stopAnimating(nil)
            }
            

        }
    }
    
    func getPersonProfile(id: String) {
        let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        
        
        WebService.getPersonalProfile(id: id) { (json) in
            print(json)
            DispatchQueue.main.async {
                self.stopAnimating(nil)
            }
            

        }
    }
    
    func getEducationLevelMaster() {
        let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        
        
        WebService.GetEducationLevelMaster { (json) in
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
                    item.ICA_ID = String(describing: r["ICA_ID"] ?? "")
                    
                  
                    
                    self.educationsArray.append(item)
                    
                    
                }
                
                DispatchQueue.main.async {
                    
                    
                    self.educationPicker.reloadAllComponents()
                }
            }else{
                
                
                DispatchQueue.main.async {
                                   
                    Utils.showAlertWith(title: "Error", message: message, viewController: self)
                    
                }
            }

        }
    }
    
    func validateFields() -> Bool{
        
        //return true
        
        
        marriageItem.HusbandFullNameArabic = husbandNameView.textField.text ?? ""
        marriageItem.HusbandFullNameEnglish = husbandNameEnView.textField.text ?? ""
        marriageItem.HusbandBirthDate = dateOfBirthView.textField.text ?? ""
        marriageItem.HusbandNationalId = nationalNumberView.textField.text ?? ""
        //marriageItem.HusbandEducationLevel = educationalLevelView.textField.text ?? ""
        marriageItem.HusbandEmail = emailView.textField.text ?? ""
        marriageItem.HusbandMobile1 = mobileoneView.textField.text ?? ""
        marriageItem.HusbandMobile2 = mobiletowView.textField.text ?? ""

        let age = self.dateOfBirthView.date.calculateAge() ?? 0
        print(age ?? 0)
        
        if husbandNameView.textField.text == "" ||
            husbandNameEnView.textField.text == "" ||
            dateOfBirthView.textField.text == "" ||
            nationalNumberView.textField.text == "" ||
            educationalLevelView.textField.text == "" ||
        emailView.textField.text == "" ||
        mobileoneView.textField.text == "" ||
        mobiletowView.textField.text == "" {
            
            Utils.showAlertWith(title: "Error".localize, message: "Please Fill All Fields".localize, viewController: self)
            return false
            
            
        }
        
        
        if age < 21 {
            Utils.showAlertWith(title: "Error".localize, message: "Date of Birth of Husband is requird (should be more than 21 years)".localize, viewController: self)
            return false
        }
        
        return true
        
    }
    @IBAction func nextAction(_ sender: Any) {
        
        if !validateFields() {
            return
        }
        self.performSegue(withIdentifier: "toWifeInformation", sender: self)
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWifeInformation" {
            let dest = segue.destination as! wifeInformationViewController
            dest.marriageItem = self.marriageItem
            dest.myString = "MMMMMMM"
            print(dest.marriageItem)
        }
    }
}
extension husbandInformationViewController: UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return educationsArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let item = educationsArray[row]
        
        return AppConstants.isArabic() ? item.NameinArabic : item.Name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if educationsArray.count > 0 {
            
            let item = educationsArray[row]
               let title = AppConstants.isArabic() ? item.NameinArabic : item.Name
               educationalLevelView.textField.text = title
            
               marriageItem.HusbandEducationLevel = item.Id
        }
        
    }

   
}
