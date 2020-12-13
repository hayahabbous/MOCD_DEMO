//
//  socialAccommodationViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 7/1/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit


class socialAccommodationViewController: UIViewController {
    
    @IBOutlet var accommodationPicker: UIPickerView!
    @IBOutlet var ownerShipPicker: UIPickerView!
    @IBOutlet var personPicker: UIPickerView!
    @IBOutlet var houseCondition: UIPickerView!
    var toolBar = UIToolbar()
    
    var socialAidItem: socialAid = socialAid()
    var accommodationsArray: [MOCDAccommodationSocial] = []
    var ownershipArray: [MOCDOwnershipSocial] = []
    var personsArray: [MOCDPersonAccommodatedSocial] = []
    var houseArray: [MOCDHouseConditionSocial] = []
    
    @IBOutlet var accommodationTypeView: selectTextField!
    @IBOutlet var ownershipTypeView: selectTextField!
    @IBOutlet var roomsView: textFieldMandatory!
    @IBOutlet var personsView: textFieldMandatory!
    @IBOutlet var personsAccommodatedView: selectTextField!
    @IBOutlet var houseConditionView: selectTextField!
    @IBOutlet var latitiudeView: textFieldMandatory!
    @IBOutlet var longitudeView: textFieldMandatory!
    @IBOutlet var makaniNoView: textFieldMandatory!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var previousButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFeilds()
        
        setupToolbar()
        getOwnership()
        getAccommodations()
        getHouseCondition()
        getPersonAccommodated()
    }
    
    func setupFeilds() {
      
        accommodationTypeView.textLabel.text = "Accommodation Type".localize
        accommodationTypeView.textField.placeholder = "Please Select".localize
        accommodationTypeView.starImage.isHidden = true
        
        ownershipTypeView.textLabel.text = "Ownership Type".localize
        ownershipTypeView.textField.placeholder = "Please Select".localize
        ownershipTypeView.starImage.isHidden = true
        
        
        roomsView.textLabel.text = "No. of Rooms".localize
        roomsView.textField.placeholder = "No. of Rooms".localize
        roomsView.starImage.isHidden = true
        
        
        personsView.textLabel.text = "No. of Persons".localize
        personsView.textField.placeholder = "No. of Persons".localize
        personsView.starImage.isHidden = true
        
        
        
        personsAccommodatedView.textLabel.text = "Persons Accommodated".localize
        personsAccommodatedView.textField.placeholder = "Please Select".localize
        personsAccommodatedView.starImage.isHidden = true
        
        
        houseConditionView.textLabel.text = "House Condition".localize
        houseConditionView.textField.placeholder = "Please Select".localize
        houseConditionView.starImage.isHidden = true
        
        
        
        latitiudeView.textLabel.text = "Latitude".localize
        latitiudeView.textField.placeholder = "Latitude".localize
        latitiudeView.starImage.isHidden = true
        
        
        longitudeView.textLabel.text = "Longitude".localize
        longitudeView.textField.placeholder = "Longitude".localize
        longitudeView.starImage.isHidden = true
        
        
        makaniNoView.textLabel.text = "Makani No".localize
        makaniNoView.textField.placeholder = "Makani No".localize
        makaniNoView.starImage.isHidden = true
        
        
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
        
        accommodationTypeView.textField.inputAccessoryView = toolBar
        

        accommodationTypeView.textField.isUserInteractionEnabled = true
        accommodationTypeView.textField.inputView = accommodationPicker
      
        
      
        accommodationPicker.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        
        
        ownershipTypeView.textField.inputAccessoryView = toolBar
          

          
        ownershipTypeView.textField.isUserInteractionEnabled = true
        
        ownershipTypeView.textField.inputView = ownerShipPicker
        
        ownerShipPicker.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        personsAccommodatedView.textField.inputAccessoryView = toolBar
          

          
        personsAccommodatedView.textField.isUserInteractionEnabled = true
        
        personsAccommodatedView.textField.inputView = personPicker
        personPicker.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        
        houseConditionView.textField.inputAccessoryView = toolBar
          

          
        houseConditionView.textField.isUserInteractionEnabled = true
        
        houseConditionView.textField.inputView = houseCondition
        houseCondition.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    @objc func onClickedToolbeltButton(_ sender: Any){
        self.view.endEditing(true)
    }
    
    func getAccommodations() {
        WebService.RetrieveAccommodationTypesSocial { (json) in
            print(json)
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
                guard let data = json["data"] as? [String:Any] else {return}
                guard let results = data["result"] as? [String:Any] else {return}
                guard let list = results["list"] as? [[String:Any]] else {return}
                
                
                for r in list {
                    
                    
                    let item = MOCDAccommodationSocial()
                    item.AccommodationTypeId = String(describing: r["AccommodationTypeId"] ?? "" )
                    item.AccommodationTypeAR = String(describing: r["AccommodationTypeAR"] ?? "" )
                    item.AccommodationTypeEN = String(describing: r["AccommodationTypeEN"] ?? "" )
                    
                    self.accommodationsArray.append(item)
                    
                }
                
                
                DispatchQueue.main.async {
                    
                    self.accommodationPicker.reloadAllComponents()
                }
            }
            
      
        }
    }
    
    func getOwnership() {
        WebService.RetrieveOwnershipTypesSocial { (json) in
            print(json)
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
                guard let data = json["data"] as? [String:Any] else {return}
                guard let results = data["result"] as? [String:Any] else {return}
                guard let list = results["list"] as? [[String:Any]] else {return}
                
                
                for r in list {
                    
                    
                    let item = MOCDOwnershipSocial()
                    item.OwnershipTypeId = String(describing: r["OwnershipTypeId"] ?? "" )
                    item.DisplayOrder = String(describing: r["DisplayOrder"] ?? "" )
                    item.OwnershipTypeTitleAr = String(describing: r["OwnershipTypeTitleAr"] ?? "" )
                    item.OwnershipTypeTitleEn = String(describing: r["OwnershipTypeTitleEn"] ?? "" )
                    
                    self.ownershipArray.append(item)
                    
                }
                
                
                DispatchQueue.main.async {
                    
                    self.ownerShipPicker.reloadAllComponents()
                }
            }
            
      
        }
    }
    func getPersonAccommodated() {
        WebService.RetrievePersonAccommodatedTypesSocial { (json) in
            print(json)
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
                guard let data = json["data"] as? [String:Any] else {return}
                guard let results = data["result"] as? [String:Any] else {return}
                guard let list = results["list"] as? [[String:Any]] else {return}
                
                
                for r in list {
                    
                    
                    let item = MOCDPersonAccommodatedSocial()
                    item.PersonsAccommodatedId = String(describing: r["PersonsAccommodatedId"] ?? "" )
                    item.DisplayOrder = String(describing: r["DisplayOrder"] ?? "" )
                    item.PersonsAccommodatedTitleEn = String(describing: r["PersonsAccommodatedTitleEn"] ?? "" )
                    item.PersonsAccommodatedTitleAr = String(describing: r["PersonsAccommodatedTitleAr"] ?? "" )
                    
                    self.personsArray.append(item)
                    
                }
                
                
                DispatchQueue.main.async {
                    
                    self.personPicker.reloadAllComponents()
                }
            }
            
      
        }
    }
    
    func getHouseCondition() {
        WebService.RetrieveHouseConditionTypesSocial { (json) in
            print(json)
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
                guard let data = json["data"] as? [String:Any] else {return}
                guard let results = data["result"] as? [String:Any] else {return}
                guard let list = results["list"] as? [[String:Any]] else {return}
                
                
                for r in list {
                    
                    
                    let item = MOCDHouseConditionSocial()
                    item.ConditionId = String(describing: r["ConditionId"] ?? "" )
                    item.DisplayOrder = String(describing: r["DisplayOrder"] ?? "" )
                    item.ConditionTitleAr = String(describing: r["ConditionTitleAr"] ?? "" )
                    item.ConditionTitleEn = String(describing: r["ConditionTitleEn"] ?? "" )
                    
                    self.houseArray.append(item)
                    
                }
                
                
                DispatchQueue.main.async {
                    
                    self.houseCondition.reloadAllComponents()
                }
            }
            
      
        }
    }
    
    func validateFields() -> Bool{
        
        //return true
        
        
        socialAidItem.NoOfRooms = roomsView.textField.text ?? ""
        socialAidItem.NoOfPersons = personsView.textField.text ?? ""
        socialAidItem.Latitude = latitiudeView.textField.text ?? ""
        socialAidItem.Longitude = longitudeView.textField.text ?? ""
        socialAidItem.MakaniNo = makaniNoView.textField.text ?? ""
     
        
        if socialAidItem.AccommodationTypeId == "" ||
            socialAidItem.PersonsAccommodatedId == "" ||
            socialAidItem.OwnershipTypeId == "" ||
            socialAidItem.ConditionId == "" ||
            socialAidItem.NoOfRooms == "" ||
            socialAidItem.NoOfPersons == ""{
            Utils.showAlertWith(title: "Error".localize, message: "Please Fill All Fields".localize, viewController: self)
            return false
        }
        
        return true
        
    }
    @IBAction func nextAction(_ sender: Any) {
        //self.performSegue(withIdentifier: "toAttachment", sender: self)
        if !validateFields() {
            return
        }
        self.performSegue(withIdentifier: "toIncome", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toIncome" {
            let dest = segue.destination as! socialIncomeSourceViewController
            dest.socialAidItem = self.socialAidItem
        }
    }
}
extension socialAccommodationViewController: UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == accommodationPicker{
            return accommodationsArray.count
        }else if pickerView == ownerShipPicker{
            return ownershipArray.count
        }else if pickerView == personPicker{
            return personsArray.count
        }else if pickerView == houseCondition{
            return houseArray.count
        }
        
        
        return 0
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == accommodationPicker{
            let item = accommodationsArray[row]
            let title = AppConstants.isArabic() ? item.AccommodationTypeAR :  item.AccommodationTypeEN
            
            return title
        }else if pickerView == ownerShipPicker{
            let item = ownershipArray[row]
            let title = AppConstants.isArabic() ? item.OwnershipTypeTitleAr :  item.OwnershipTypeTitleEn
            
            return title
        }else if pickerView == personPicker{
            let item = personsArray[row]
            let title = AppConstants.isArabic() ? item.PersonsAccommodatedTitleAr :  item.PersonsAccommodatedTitleEn
            
            return title
        }else if pickerView == houseCondition{
            let item = houseArray[row]
            let title = AppConstants.isArabic() ? item.ConditionTitleAr :  item.ConditionTitleEn
            
            return title
        }
        
        return ""
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == accommodationPicker{
            let item = accommodationsArray[row]
            
              //self.emirate = item.id
           
            //childItem.emirateID = item.id
            socialAidItem.AccommodationTypeId  = item.AccommodationTypeId
            self.accommodationTypeView.textField.text = AppConstants.isArabic() ? item.AccommodationTypeAR :  item.AccommodationTypeEN
        }else if pickerView == ownerShipPicker{
            let item = ownershipArray[row]
            
              //self.emirate = item.id
           
            //childItem.emirateID = item.id
            socialAidItem.OwnershipTypeId  = item.OwnershipTypeId
            self.ownershipTypeView.textField.text = AppConstants.isArabic() ? item.OwnershipTypeTitleAr :  item.OwnershipTypeTitleEn
        }else if pickerView == personPicker{
            let item = personsArray[row]
            
              //self.emirate = item.id
           
            //childItem.emirateID = item.id
            socialAidItem.PersonsAccommodatedId  = item.PersonsAccommodatedId
            self.personsAccommodatedView.textField.text = AppConstants.isArabic() ? item.PersonsAccommodatedTitleAr :  item.PersonsAccommodatedTitleEn
        }else if pickerView == houseCondition{
            let item = houseArray[row]
            
              //self.emirate = item.id
           
            //childItem.emirateID = item.id
            socialAidItem.ConditionId  = item.ConditionId
            self.houseConditionView.textField.text = AppConstants.isArabic() ? item.ConditionTitleAr :  item.ConditionTitleEn
        }
        
    }
    
}
