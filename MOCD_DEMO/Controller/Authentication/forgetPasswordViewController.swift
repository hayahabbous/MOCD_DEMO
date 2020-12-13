//
//  forgetPasswordViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 2/24/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView


class forgetPasswordViewController: UIViewController ,NVActivityIndicatorViewable{
    
    let nvactivity = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    let firstBrownColor = UIColor(red: 170/256 , green: 121/256, blue: 66/256, alpha: 1.0)
    let secondBrownColor = UIColor(red: 207/256 , green: 179/256, blue: 63/256, alpha: 1.0)
    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var sendButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {
        let gradient = CAGradientLayer()
        gradient.frame = self.sendButton.bounds
        gradient.colors = [UIColor.green]
        
        self.sendButton.applyGradient(colours: [firstBrownColor, secondBrownColor])
        //self.loginButton.backgroundColor = .green
        self.sendButton.layer.cornerRadius = 20
        self.sendButton.layer.masksToBounds = true
        
        
    }
    
    
    func forgetPassword() {
    
        DispatchQueue.main.async {
             //NVActivityIndicatorPresenter.sharedInstance.startAnimating(self.activityData)
            //self.view.isUserInteractionEnabled = false
            let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        }
        
        
        
        let email = emailTextField.text ?? ""
        
        
        WebService.forgetPassword(emailAddress: email) { (json) in
            print(json)
            
            
            DispatchQueue.main.async {
                self.stopAnimating(nil)
                //self.view.isUserInteractionEnabled = false
            }
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
                guard let data = json["data"] as? [String: Any] else{return}
                guard let result = data["result"] as? [String: Any] else {return}
                
                
                
            }else{
                DispatchQueue.main.async {
                    Utils.showAlertWith(title: "Error", message: message, viewController: self)
                }
            }
        }
    }
    @IBAction func sendButtonAction(_ sender: Any) {
        
        if emailTextField.text?.count == 0 {
            Utils.showErrorMessage(NSLocalizedString("Please enter your email", comment:"") , withTitle:NSLocalizedString("email is empty", comment:"") , andInViewController: self)
            
            return
        }
        
        self.forgetPassword()
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
