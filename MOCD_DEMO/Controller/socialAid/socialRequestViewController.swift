//
//  socialRequestViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 6/25/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit


class socialRequestViewController: UIViewController {
    
    @IBOutlet var requestTypeView: multipleTextField!
    @IBOutlet var nextButton: UIButton!
    
    
    var caseId: String = ""
    var Case_Type_Desc_English: String = ""
    var Case_Type_Desc_Arabic: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupField()
        getRequestTypes()
    }
    
    func setupField() {
        
        requestTypeView.textLabel.text = "Request Type"
        requestTypeView.firstLabel.text = "Normal"
        
        requestTypeView.secondLabel.isHidden = true
        requestTypeView.secondCheckBox.isHidden = true
        
        
        
        let gradient = CAGradientLayer()
               
        gradient.frame = self.nextButton.bounds
        
        gradient.colors = [UIColor.green]
               
        
        self.nextButton.applyGradient(colours: [AppConstants.firstBrownColor, AppConstants.secondBrownColor])
               //self.loginButton.backgroundColor = .green
        
        self.nextButton.layer.cornerRadius = 20
        
        self.nextButton.layer.masksToBounds = true
        
    }
    
    func getRequestTypes() {
        WebService.RetrieveRequestTypeSocial { (json) in
            print(json)
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
                guard let data = json["data"] as? [String: Any] else{return}
                guard let result = data["result"] as? [String: Any] else {return}
                guard let list = result["list"] as? [[String: Any]] else {return}
                
                for r in list {
       
                    self.caseId = String(describing: r["Case_Type_Id"] ?? "")
                    self.Case_Type_Desc_English = String(describing: r["Case_Type_Desc_English"] ?? "")
                    self.Case_Type_Desc_Arabic = String(describing: r["Case_Type_Desc_Arabic"] ?? "")
                    /*
                    let item = MOCDCenterService()
                    item.EmirateId = String(describing: r["EmirateId"] ?? "")
                    item.CenterId = String(describing: r["CenterId"] ?? "")
                    item.OfficeNameAR = String(describing: r["OfficeNameAR"] ?? "")
                    item.OfficeNameEN = String(describing: r["OfficeNameEN"] ?? "")
                    */
                   // self.centersArray.append(item)
                    
                }
                
                
                DispatchQueue.main.async {
                    self.requestTypeView.firstLabel.text = AppConstants.isArabic() ? self.Case_Type_Desc_Arabic : self.Case_Type_Desc_English
                    //self.centerPicker.reloadAllComponents()
                }
            }
            
        }
    }
    
    @IBAction func nextAction(_ sender: Any) {
        
        self.performSegue(withIdentifier: "toFinancial", sender: self)
    }
}
