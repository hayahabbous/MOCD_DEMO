//
//  socialPassportViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 6/26/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit


class socialPassportViewController: UIViewController , refreshDelegate {
    func refreshDateView() {
        let date = issueDateView.date
        let datebyOneYear = Calendar.current.date(byAdding: .year, value: 5, to: Date())
        
        
        
        let df = DateFormatter()
        df.dateFormat = "MM/dd/yyyy"
        let now = df.string(from: datebyOneYear ?? Date())
        
        expiryDateView.textField.text = now
        
    }
    
    func refreshMultipleView() {
        
    }
    
    
    
    var toolBar = UIToolbar()
    
    @IBOutlet var emiratePicker: UIPickerView!
    var emiratesArray: [MOCDEmirateService] = []
    
    var socialAidItem: socialAid = socialAid()
    @IBOutlet var passportNoView: textFieldMandatory!
    @IBOutlet var passportIssuePlaceView: selectTextField!
    @IBOutlet var issueDateView: dateTexteField!
    @IBOutlet var immigrationNoView: textFieldMandatory!
    
    @IBOutlet var expiryDateView: dateTexteField!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var previousButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setupField()
        setupToolbar()
        getEmirates()
    }
    
    func setupField() {
        passportNoView.textLabel.text = "Passport No".localize
        passportNoView.textField.placeholder = "Passport No".localize
        
        
        passportIssuePlaceView.textLabel.text = "Passport Issue Place".localize
        passportIssuePlaceView.textField.placeholder = "Please Select".localize
        
        
        issueDateView.textLabel.text = "Issue Date".localize
        issueDateView.viewController = self
        issueDateView.delegate = self
        
        expiryDateView.textLabel.text = "Expiry Date".localize
        expiryDateView.viewController = self
        expiryDateView.isUserInteractionEnabled = false
        expiryDateView.starImage.isHidden = true
        
        
        
        immigrationNoView.textLabel.text = "Immigration No".localize
        immigrationNoView.textField.placeholder = "Immigration No".localize
        
        
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
           
        passportIssuePlaceView.textField.inputAccessoryView = toolBar
           
       
        
        passportIssuePlaceView.textField.inputView = emiratePicker
      
        
        emiratePicker.translatesAutoresizingMaskIntoConstraints = false
  
        
        
    }
    
    @objc func onClickedToolbeltButton(_ sender: Any){
        self.view.endEditing(true)
    }
    
    func validateFields() -> Bool{
        
        //return true
        
        
        socialAidItem.PassportNo = passportNoView.textField.text ?? ""
        socialAidItem.PassportIssueDate = issueDateView.textField.text ?? ""
        socialAidItem.PassportExpiryDate = expiryDateView.textField.text ?? ""
        socialAidItem.ImmigrationNo = immigrationNoView.textField.text ?? ""
        
        
        let df = DateFormatter()
        df.dateFormat = "MM/dd/yyyy"
        socialAidItem.PassportIssueDate  = df.string(from: issueDateView.date )
        socialAidItem.PassportExpiryDate  = df.string(from: expiryDateView.date)
        
        
        
        if socialAidItem.PassportNo == "" ||
            socialAidItem.PassportIssueDate == "" ||
            socialAidItem.ImmigrationNo == "" ||
            socialAidItem.PassportIssuePlaceId == "" 
            {
            
            Utils.showAlertWith(title: "Error".localize, message: "Please Fill All Fields".localize, viewController: self)
            return false
            
            
        }
        
        
        return true
        
    }
    @IBAction func nextButton(_ sender: Any) {
        if !validateFields() {
            return
        }
        self.performSegue(withIdentifier: "toAccomodation", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAccomodation" {
            let dest = segue.destination as! socialAccommodationViewController
            dest.socialAidItem = self.socialAidItem
        }
    }
}
extension socialPassportViewController: UIPickerViewDelegate , UIPickerViewDataSource {
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
            let title = AppConstants.isArabic() ?  item.EmirateTitleAr : item.EmirateTitleEn
            
            return title
        }
        return ""
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == emiratePicker{
            let item = emiratesArray[row]
          
            
           
            socialAidItem.PassportIssuePlaceId = item.EmirateId
            //self.nationality_id = item.CountryId
            self.passportIssuePlaceView.textField.text = AppConstants.isArabic() ?  item.EmirateTitleAr : item.EmirateTitleEn
            
            
            
        } 
        
    }
    
}
