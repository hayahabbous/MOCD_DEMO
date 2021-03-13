//
//  lostCardInformationViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 7/6/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView


class lostCardInformationViewController: UIViewController ,NVActivityIndicatorViewable{
    
    var requestArray: [MOCDLostRequestType] = []
    var toolBar = UIToolbar()
    let nvactivity = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    @IBOutlet var requestPicker: UIPickerView!
    @IBOutlet var emailView: textFieldMandatory!
    @IBOutlet var requestTypeView: selectTextField!
    @IBOutlet var commentsView: textFieldMandatory!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var previousButton: UIButton!
    
    var lostCardItem: lostCard!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupFields()
        setupToolbar()
        getRequests()
    }
    
    func setupFields() {
        emailView.textField.placeholder = "Email".localize
        emailView.textLabel.text = "Email".localize
        emailView.textField.text = lostCardItem.emailAddress
        
        
        
        
        requestTypeView.textField.placeholder = "Please Select".localize
        requestTypeView.textLabel.text = "Request Type".localize
        
        commentsView.textField.placeholder = "Comments".localize
        commentsView.textLabel.text = "Comments".localize
        
        
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
        
        requestTypeView.textField.inputAccessoryView = toolBar
        

        requestTypeView.textField.isUserInteractionEnabled = true
        requestTypeView.textField.inputView = requestPicker
      
        
      
        requestPicker.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        
    }
    
    @objc func onClickedToolbeltButton(_ sender: Any){
        self.view.endEditing(true)
    }
    
    func getRequests() {
        let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        
        
        WebService.RetrieveDisabledCardReplacementRequestTypes { (json) in
            print(json)
            DispatchQueue.main.async {
                self.stopAnimating(nil)
            }
            
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
                
                guard let data = json["data"] as? [String: Any] else{return}
                guard let result = data["result"] as? [String: Any] else {return}
                guard let list = result["list"] as? [[String: Any]] else {return}
                
                for r in list {
                let item: MOCDLostRequestType = MOCDLostRequestType()
                    
                    item.RequestTypeId = String(describing: r["RequestTypeId"]  ?? "")
                    item.RequestTypeNameEN = String(describing: r["RequestTypeNameEN"]  ?? "")
                    item.RequestTypeNameAR = String(describing: r["RequestTypeNameAR"]  ?? "")
                  
                    
                    self.requestArray.append(item)
                    
                    
                }
                
                DispatchQueue.main.async {
                    
                    
                    self.requestPicker.reloadAllComponents()
                    
                    guard let requestType = self.requestArray.filter({ (item) -> Bool in
                        item.RequestTypeId == self.lostCardItem.requestTypeId
                    }).first else {
                        return
                    }
                    let title = AppConstants.isArabic() ? requestType.RequestTypeNameAR : requestType.RequestTypeNameEN
                    self.requestTypeView.textField.text = title
                    
                    
                }
            }else{
                
                
                DispatchQueue.main.async {
                                   
                    Utils.showAlertWith(title: "Error".localize, message: message, viewController: self)
                    
                }
            }

        }
    }
    
    func validateFields() -> Bool{
        
        
        
        
        self.lostCardItem.emailAddress = self.emailView.textField.text ?? ""
        self.lostCardItem.comments = self.commentsView.textField.text ?? ""
       
        if self.lostCardItem.emailAddress == "" ||
        self.lostCardItem.comments == "" ||
        self.lostCardItem.requestTypeId == ""  {
            
            Utils.showAlertWith(title: "Error".localize, message: "Please Fill All Fields".localize, viewController: self)
            return false
        }
        return true
    }
    @IBAction func nextAction(_ sender: Any) {
        
        if validateFields() {
            self.performSegue(withIdentifier: "toAttachment", sender: self)
        }
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAttachment" {
            let dest = segue.destination as! lostCardAttachemntViewcontroller
            dest.lostCardItem = self.lostCardItem
        }
    }
}
extension lostCardInformationViewController: UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return requestArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let item = requestArray[row]
        
        return AppConstants.isArabic() ? item.RequestTypeNameAR : item.RequestTypeNameEN
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let item = requestArray[row]
        let title = AppConstants.isArabic() ? item.RequestTypeNameAR : item.RequestTypeNameEN
        lostCardItem.requestTypeId = item.RequestTypeId
        requestTypeView.textField.text = title
     
    }

    
}
