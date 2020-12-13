//
//  marriageContractDataViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 7/1/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class marriageContractDataViewController: UIViewController,NVActivityIndicatorViewable {
    
    
    var marriageItem: marriageService = marriageService()
    @IBOutlet var courtPicker: UIPickerView!
    var courtsArray: [MOCDEducationLevelMaster] = []
    var toolBar = UIToolbar()
    let nvactivity = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    
    
    @IBOutlet var dateOfMarriageContractView: dateTexteField!
    @IBOutlet var shariaCourtView: selectTextField!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var previousButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupField()
        setupToolbar()
        getCourtMaster()
    }
    
    func setupField()
    {
        dateOfMarriageContractView.textLabel.text = "Date of the Marriage Contract".localize
        dateOfMarriageContractView.viewController = self
        
        shariaCourtView.textLabel.text = "Sharia Court Name".localize
        shariaCourtView.textField.placeholder = "Please Select".localize
        
        
        
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
           
           shariaCourtView.textField.inputAccessoryView = toolBar
           

           shariaCourtView.textField.isUserInteractionEnabled = true
           shariaCourtView.textField.inputView = courtPicker
         
           
         
           courtPicker.translatesAutoresizingMaskIntoConstraints = false
           
           
           
           
       }
       
       @objc func onClickedToolbeltButton(_ sender: Any){
           self.view.endEditing(true)
       }
       func getCourtMaster() {
           let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
           
           
           WebService.GetCourtMaster { (json) in
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
                       
                     
                       
                       self.courtsArray.append(item)
                       
                       
                   }
                   
                   DispatchQueue.main.async {
                       
                       
                       self.courtPicker.reloadAllComponents()
                   }
               }else{
                   
                   
                   DispatchQueue.main.async {
                                      
                       Utils.showAlertWith(title: "Error".localize, message: message, viewController: self)
                       
                   }
               }

           }
       }
    
    func validateFields() -> Bool{
        
        
        marriageItem.MarriageContractDate = dateOfMarriageContractView.textField.text ?? ""
        //marriageItem.Court = shariaCourtView.textField.text ?? ""
        marriageItem.marriageContractDate = dateOfMarriageContractView.date 
        
        if dateOfMarriageContractView.textField.text == "" ||
            shariaCourtView.textField.text == "" {
            
            Utils.showAlertWith(title: "Error".localize, message: "Please Fill All Fields".localize, viewController: self)
            return false
            
            
        }
        
        
        if marriageItem.marriageContractDate.calculateMonths() > 6 {
            Utils.showAlertWith(title: "Error".localize, message: "Marriage Contract date should not be older than six months".localize, viewController: self)
            return false
        }
        
        
        
        return true
        
    }
    @IBAction func nextAction(_ sender: Any) {
        if !validateFields() {
            return
        }
        self.performSegue(withIdentifier: "toAbstract", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAbstract" {
            let dest = segue.destination as! abstractEnrollmentViewController
            dest.marriageItem = self.marriageItem
        }
    }
    
}
extension marriageContractDataViewController: UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return courtsArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let item = courtsArray[row]
        
        return AppConstants.isArabic() ? item.NameinArabic : item.Name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if courtsArray.count > 0 {
            let item = courtsArray[row]
               let title = AppConstants.isArabic() ? item.NameinArabic : item.Name
               shariaCourtView.textField.text = title
            
               marriageItem.Court = item.Id
        }
        
    }

   
}
