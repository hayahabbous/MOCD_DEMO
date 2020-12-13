//
//  edaadContactDetailsViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 7/1/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class edaadContactDetailsViewController: UIViewController ,NVActivityIndicatorViewable{
    
    var eddadItem: eddadApp!
    
    let nvactivity = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    var contentString: String = ""
    @IBOutlet var mobileView: textFieldMandatory!
    @IBOutlet var emailView: textFieldMandatory!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var previousButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupField()
    }
    
    func setupField() {
        mobileView.textLabel.text = "Mobile No".localize
        mobileView.textField.placeholder = "Mobile No".localize
        
        
        emailView.textLabel.text = "Email".localize
        emailView.textField.placeholder = "Email".localize
        
        
        
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
    
    
    func validateFields() -> Bool{
        
        
      
        
        eddadItem.mobile = mobileView.textField.text ?? ""
        
        eddadItem.email = emailView.textField.text ?? ""
        
        
        if  mobileView.textField.text == "" ||
            emailView.textField.text == "" {
            
            Utils.showAlertWith(title: "Error".localize, message: "Please Fill All Fields".localize, viewController: self)
            return false
            
            
        }
        
        
        
        return true
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDoc" {
            let dest = segue.destination as! masterDocViewController
            dest.requestType = "1"
            dest.contentString = self.contentString
        }
    }
    @IBAction func saveAction(_ sender: Any) {
        
        //self.performSegue(withIdentifier: "toDoc", sender: self)
        
        
        if !validateFields() {
            return
        }
        let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        WebService.SubmitEdaadRequest(HusbandNationalId: eddadItem.nationalForHusband, WifeNationalId: eddadItem.nationalForWife, MarriageContractDate: eddadItem.contractDate, HusbandFullNameEnglish: eddadItem.husbandName, HusbandEmail: eddadItem.email, WifeFullNameEnglish: eddadItem.wifName, FamilyBookIssuePlace: eddadItem.emirate) { (json) in
            
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
}
