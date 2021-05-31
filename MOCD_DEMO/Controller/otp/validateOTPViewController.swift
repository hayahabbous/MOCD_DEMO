//
//  validateOTPViewController.swift
//  MOCD_DEMO
//
//  Created by haya habbous on 17/03/2021.
//  Copyright © 2021 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView



class validateOTPViewController: UIViewController ,NVActivityIndicatorViewable{
    
    var mobileNumberBase16: String = ""
    
    @IBOutlet var validateView: textFieldMandatory!
    @IBOutlet var doneButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.hidesBackButton = true
        
        
        validateView.textLabel.text = "OTP".localize
        validateView.textField.placeholder = "OTP".localize
        
        let gradient = CAGradientLayer()
        gradient.frame = self.doneButton.bounds
        gradient.colors = [UIColor.green]
        
        self.doneButton.applyGradient(colours: [AppConstants.FIRST_GREEN_COLOR, AppConstants.SECOND_GREEN_COLOR])
        //self.loginButton.backgroundColor = .green
        self.doneButton.layer.cornerRadius = 20
        self.doneButton.layer.masksToBounds = true
        
        
        
    }
    
    @IBAction func doneAction(_ sender: Any) {
        let otp = self.validateView.textField.text ?? ""
        
        do{
            let otpencrypy = try otp.aesEncrypt(key: "", iv: "")
            let base16 = otpencrypy.data(using: .utf8)?.toHexString() ?? ""
            self.validateOTP(otp: base16)
            
        }catch{
            
        }
        
    }
    @IBAction func dismissAxction(_ sender: Any) {
        
        self.view.endEditing(true)
    }
    func validateOTP(otp: String) {
        let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        
        
        WebService.validateOTP(otp: otp, mobileNumber: mobileNumberBase16) { (json) in
            print(json)
            DispatchQueue.main.async {
                self.stopAnimating(nil)
            }
            

            guard let otpsessionid = json["otpsessionid"] as? String else {
                
                DispatchQueue.main.async {
                    
                    Utils.showAlertWith(title: "Error".localize, message: "No user found", viewController: self)
                }
                
                
                return
                
            }
            
            DispatchQueue.main.async {
                self.navigationController?.dismiss(animated: true, completion: {
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "openService"), object: nil)
                })
            }
            
        }
    }
}
