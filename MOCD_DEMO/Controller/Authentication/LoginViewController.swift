//
//  LoginViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 6/14/19.
//  Copyright © 2019 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import SkyFloatingLabelTextField
import Reachability

import NVActivityIndicatorView


class LoginViewController: UIViewController {
    
    
    @IBOutlet var userNameView: textFieldMandatory!
    @IBOutlet var passwordView: textFieldMandatory!
    var user: MOCDUser?
    let firstGreenColor = UIColor(red: 111/256 , green: 187/256, blue: 119/256, alpha: 1.0)
    let secondGreenColor = UIColor(red: 147/256 , green: 202/256, blue: 90/256, alpha: 1.0)
    
    let firstBrownColor = UIColor(red: 170/256 , green: 121/256, blue: 66/256, alpha: 1.0)
    let secondBrownColor = UIColor(red: 207/256 , green: 179/256, blue: 63/256, alpha: 1.0)
    @IBOutlet var backLogoView: UIView!
    @IBOutlet var logoImageView: UIImageView!
    //@IBOutlet var userTextField: SkyFloatingLabelTextFieldWithIcon!
    //@IBOutlet var passwordTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet var loginButton: UIButton!
    
    let activityData = ActivityData()
    var activityIndicator: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        
        
        userNameView.textLabel.text = "Username"
        userNameView.textField.placeholder = "Username"
        
        
        passwordView.textLabel.text = "Password"
        passwordView.textField.placeholder = "Password"
        passwordView.textField.isSecureTextEntry = true
        

        
        activityIndicator = NVActivityIndicatorView(frame: view.frame, type: .ballScaleMultiple, color: AppConstants.BROWN_COLOR, padding: nil)
        
        view.addSubview(activityIndicator)
        /*
        
        activityIndicator = NVActivityIndicatorView(frame: self.view.frame)
        activityIndicator.type = .ballScaleMultiple
        activityIndicator.color = AppConstants.BROWN_COLOR
        activityIndicator.backgroundColor = .red
        */
        
        
    }
    
    func setupView() {
        let gradient = CAGradientLayer()
        gradient.frame = self.loginButton.bounds
        gradient.colors = [UIColor.green]
        
        self.loginButton.applyGradient(colours: [firstBrownColor, secondBrownColor])
        //self.loginButton.backgroundColor = .green
        self.loginButton.layer.cornerRadius = 20
        self.loginButton.layer.masksToBounds = true
        
        
        
        self.logoImageView.layer.borderWidth = 0.1
        self.logoImageView.layer.borderColor = UIColor.lightGray.cgColor
        
        self.logoImageView.layer.cornerRadius = self.logoImageView.frame.height / 2
        self.logoImageView.layer.masksToBounds = true
        
        backLogoView.addShadow(offset: CGSize(width: 0, height: 4), color: .lightGray, radius: self.logoImageView.frame.height / 2, opacity: 0.5)
        
        self.backLogoView.addSubview(self.logoImageView)
        
        
        //self.userTextField.placeholder = "username".localize
        //self.passwordTextField.placeholder = "password".localize
    }
    
    func emptyValidation() -> Bool {
        
        let isOK: Bool = true
        let username: String = self.userNameView.textField.text!
        let password: String = self.passwordView.textField.text!
        
        
       
        if username.count == 0 {
            Utils.showErrorMessage(NSLocalizedString("Please enter username", comment:"") , withTitle:NSLocalizedString("username is empty", comment:"") , andInViewController: self)
            return false
        }
        
        if  password.count == 0 {
            
            Utils.showErrorMessage(NSLocalizedString("Please enter a valid password", comment:"") , withTitle:NSLocalizedString("Password is empty", comment:"") , andInViewController: self)
            return false
        }
        return isOK
    }
    
    func login() {
    
        DispatchQueue.main.async {
             NVActivityIndicatorPresenter.sharedInstance.startAnimating(self.activityData)
            //self.view.isUserInteractionEnabled = false
        }
        
        
        
        let username = userNameView.textField.text ?? ""
        let password = passwordView.textField.text ?? ""
        
        
        
        WebService.authenticateUser(username: username, password: password) { (json) in
            print(json)
            
            
            DispatchQueue.main.async {
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                //self.view.isUserInteractionEnabled = false
            }
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
                guard let data = json["data"] as? [String: Any] else{return}
                guard let result = data["result"] as? [String: Any] else {return}
                
                guard let userId = result["UserId"] as? String else {
                    DispatchQueue.main.async {
                        Utils.showAlertWith(title: "Error", message: "Username or Password not correct", viewController: self)
                    }
                    
                    return
                }
                
                var _: MOCDUser = MOCDUser(dict: result)
                
                self.user = MOCDUser.getMOCDUser()
            
                DispatchQueue.main.async {
                    
                    let rootViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "mainViewController")
                    self.view.window!.rootViewController = rootViewController
                    rootViewController.modalPresentationStyle = .fullScreen
                    self.dismiss(animated: true, completion: {() -> Void in
                        self.present(rootViewController, animated: true, completion: {() -> Void in
                        })
                    })
                }
                
                
            }else{
                DispatchQueue.main.async {
                    Utils.showAlertWith(title: "Error", message: message, viewController: self)
                }
            }
        }
    }
    /*
    func login11() {
        
        self.view.endEditing(true)
        
        let email: String = self.userTextField.text!
        let password: String = self.passwordTextField.text!
        
        let reach = Reachability.Connection.self
        if reach != .none {
            
            //self.activityIndicatroView.startAnimating()
            self.loginButton.isEnabled = false
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
            DispatchQueue.main.async(execute: {() -> Void in
                PFUser.logInWithUsername(inBackground: email, password: password, block: {(user, error) in
                    
                    DispatchQueue.main.async {
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                    }
                    if (user != nil) {
                        //TODO need to be checked after moving to Swift ...
                        //self.signupToChatServer()
                        
                        print(user)
                        let installition = PFInstallation.current()
                        installition!["user"] = PFUser.current()
                        installition!.saveInBackground()
                        
                        
                        //add token for user
                        //                        let installation = PFInsta
                        /*
                         
                         
                         
                         1- after login & signup
                         let installation = PFInstalation.currentInstallation()
                         installation["user"] = PFUser.currentUser()
                         installation.saveInBackgroune()
                         */
                        
                        //Temparory Code until we fix Layer issue ...
                        
                        //let rootViewController: TabbarViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarViewController") as! TabbarViewController
                        //self.view.window!.rootViewController = rootViewController
                        //rootViewController.modalPresentationStyle = .fullScreen
                        //self.dismiss(animated: true, completion: {() -> Void in
                        //     self.present(rootViewController, animated: true, completion: {() -> Void in
                        //     })
                        // })
                        
                        
                        let rootViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "mainViewController") 
                        self.view.window!.rootViewController = rootViewController
                        rootViewController.modalPresentationStyle = .fullScreen
                        self.dismiss(animated: true, completion: {() -> Void in
                            self.present(rootViewController, animated: true, completion: {() -> Void in
                            })
                        })
                    }
                    else {
                        print(error)
                        Utils.handleParseError(error as! NSError, inViewController: self)
                        //self.activityIndicatroView.stopAnimating()
                        self.loginButton.isEnabled = true
                    }
                })
            })
        }
        else {
            DispatchQueue.main.async(execute: {() -> Void in
                Utils.noInternetConnectionErrorInViewController(self)
                //self.activityIndicatroView.stopAnimating()
                self.loginButton.isEnabled = true
            })
        }
    }*/
    
    
    @IBAction func signinAction(_ sender: Any) {
        
        if self.emptyValidation() == false {
            
            return
        }
        
        self.login()
    }
    
    
    @IBAction func dismissView(_ sender: Any) {
        self.view.endEditing(true)
    }
    @IBAction func guestLogineAction(_ sender: Any) {
        
        let rootViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "mainViewController")
        self.view.window!.rootViewController = rootViewController
        rootViewController.modalPresentationStyle = .fullScreen
        self.dismiss(animated: true, completion: {() -> Void in
            self.present(rootViewController, animated: true, completion: {() -> Void in
            })
        })
    }
}
