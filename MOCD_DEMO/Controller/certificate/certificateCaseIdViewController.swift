//
//  certificateCaseIdViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 7/12/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class certificateCaseIdViewController: UIViewController ,NVActivityIndicatorViewable{
    
    
    

    var caseId: String = ""
    @IBOutlet var mobileNumberView: textFieldMandatory!
    @IBOutlet var emailView: textFieldMandatory!
    @IBOutlet var entityView: textFieldMandatory!
    let nvactivity = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var previousButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupFields()
    }
    
    func setupFields() {
        mobileNumberView.textLabel.text = "Mobile Number".localize
        mobileNumberView.textField.placeholder = "Mobile Number".localize
        
        
        emailView.textLabel.text = "Email".localize
        emailView.textField.placeholder = "Email".localize
        
        entityView.textLabel.text = "Entity to whome the letter is addressed".localize
        entityView.textField.placeholder = "Entity to whome the letter is addressed".localize
        
        
       
        
        
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
        
        if mobileNumberView.textField.text == "" ||
            emailView.textField.text == "" ||
            entityView.textField.text == "" {
            
            
            
            Utils.showAlertWith(title: "Error".localize, message: "Please Fill All Fields".localize, viewController: self)
            return false
        }
        
        return true
    }
    @IBAction func submitButton(_ sender: Any) {
        
        var mocd_user = MOCDUser.getMOCDUser()
        if !validateFields() {
            return
        }
        let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        WebService.applyForOfficialLetterWithCaseID(userId: mocd_user?.UserId ?? "", mobileNo: mobileNumberView.textField.text ?? "", caseID: self.caseId, email: emailView.textField.text ?? "", entityAddressed: self.entityView.textField.text ?? "") { (json) in
            print(json)
            
            DispatchQueue.main.async {
                           
                self.stopAnimating(nil)
                
            }
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
                
            
            if code == 1 {
                DispatchQueue.main.async {
                                   
                    Utils.showAlertWith(title: "Success".localize, message: message, viewController: self)
                    
                }
            }else{
                
                
                DispatchQueue.main.async {
                                   
                    Utils.showAlertWith(title: "Error".localize, message: message, viewController: self)
                    
                }
            }
        }
        
        
    }
}
