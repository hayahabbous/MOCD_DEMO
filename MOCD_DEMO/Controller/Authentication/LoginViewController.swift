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


class LoginViewController: UIViewController ,NVActivityIndicatorViewable{
    
    
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
    @IBOutlet var uaePassButton: UIButton!
    
    let nvactivity = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    var activityIndicator: NVActivityIndicatorView!
    
    
    
    var isUAEPass: Bool = false
    var uaePassUserId: String = ""
    var uaePassEmail: String = ""
    var firstname: String = ""
    var lastName: String = ""
    var email: String = ""
    var mobileNumber: String = ""
    var emiratesID: String = ""
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        
        
        userNameView.textLabel.text = "Username".localize
        userNameView.textField.placeholder = "Username".localize
        
        
        passwordView.textLabel.text = "Password".localize
        passwordView.textField.placeholder = "Password".localize
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
    
    @IBAction func uaePassAction(_ sender: Any) {
        
        //self.retrieveUser(email: "datacell11@g.com", userID: "123456678")
        self.actionLoginWithUaePass(sender)
    }
    func setupView() {
        let gradient = CAGradientLayer()
        gradient.frame = self.loginButton.bounds
        gradient.colors = [UIColor.green]
        
        self.loginButton.applyGradient(colours: [firstBrownColor, secondBrownColor])
        //self.loginButton.backgroundColor = .green
        self.loginButton.layer.cornerRadius = 20
        self.loginButton.layer.masksToBounds = true
        
        
        
        
        //self.uaePassButton.applyGradient(colours: [firstBrownColor, secondBrownColor])
        //self.loginButton.backgroundColor = .green
        self.uaePassButton.layer.cornerRadius = 20
        self.uaePassButton.layer.masksToBounds = true
        self.uaePassButton.backgroundColor = .white
        self.uaePassButton.setTitleColor(.black, for: .normal)
        self.uaePassButton.layer.borderWidth = 1.0
        self.uaePassButton.layer.borderColor = UIColor.black.cgColor
        self.uaePassButton.setTitle("Sign in with UAE PASS".localize, for: .normal)
        
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
            Utils.showErrorMessage(NSLocalizedString("Please enter username".localize, comment:"") , withTitle:NSLocalizedString("username is empty", comment:"") , andInViewController: self)
            return false
        }
        
        if  password.count == 0 {
            
            Utils.showErrorMessage(NSLocalizedString("Please enter a valid password".localize, comment:"") , withTitle:NSLocalizedString("Password is empty".localize, comment:"") , andInViewController: self)
            return false
        }
        return isOK
    }
    
    func login() {
    
        DispatchQueue.main.async {
            let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
             //NVActivityIndicatorPresenter.sharedInstance.startAnimating(self.activityData)
            //self.view.isUserInteractionEnabled = false
        }
        
        
        
        let username = userNameView.textField.text ?? ""
        let password = passwordView.textField.text ?? ""
        
        
        
        WebService.authenticateUser(username: username, password: password) { (json) in
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
                
                guard let userId = result["UserId"] as? String else {
                    DispatchQueue.main.async {
                        Utils.showAlertWith(title: "Error".localize, message: "Username or Password not correct".localize, viewController: self)
                    }
                    
                    return
                }
                
                var _: MOCDUser = MOCDUser(dict: result)
                
                self.user = MOCDUser.getMOCDUser()
            
                DispatchQueue.main.async {
                    
                    
                    
                    if self.isUAEPass {
                        self.mapuUser(uaePassUserID: self.uaePassUserId, userId: userId)
                    }else{
                        let rootViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "mainViewController")
                        self.view.window!.rootViewController = rootViewController
                        rootViewController.modalPresentationStyle = .fullScreen
                        self.dismiss(animated: true, completion: {() -> Void in
                            self.present(rootViewController, animated: true, completion: {() -> Void in
                            })
                        })
                    }
                    
                }
                
                
            }else{
                DispatchQueue.main.async {
                    Utils.showAlertWith(title: "Error", message: message, viewController: self)
                }
            }
        }
    }
    
    func retrieveUser(email: String  , userID: String) {
    
        DispatchQueue.main.async {
            let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
             //NVActivityIndicatorPresenter.sharedInstance.startAnimating(self.activityData)
            //self.view.isUserInteractionEnabled = false
        }
        
        
        WebService.RetrieveUAEPassUser(email: "", uaePassUserId: userID) { (json) in // email should be empty and user id should be pass by parmaeter
            print(json)
            
            
            DispatchQueue.main.async {
                self.stopAnimating(nil)
                //self.view.isUserInteractionEnabled = false
            }
            
            
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            
            //user is found
            if code > 0 {
                
                guard let data = json["data"] as? [String: Any] else{return}
                guard let result = data["result"] as? [String: Any] else {return}
                guard let responseDescription = result["ResponseDescription"] as? [String: Any] else {return}
                
                guard let userId = responseDescription["UserId"] as? String else {
                    DispatchQueue.main.async {
                        Utils.showAlertWith(title: "Error".localize, message: "Username or Password not correct".localize, viewController: self)
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
                
                
            }else if code == -100 {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Do you have an Account?".localize, message: "if you have an account please enter your credentials or you can create a new account ".localize, preferredStyle: .alert)
                    
                    let signupAction = UIAlertAction(title: "SIGN UP".localize, style: .default) { (action) in
                        
                        
                        self.isUAEPass = true
                        self.uaePassUserId = userID
                        self.performSegue(withIdentifier: "toRegister", sender: self)
                    }
                    
                    
                    let signinAction = UIAlertAction(title: "SIGN IN".localize, style: .default) { (action) in
                        
                        self.isUAEPass = true
                        self.uaePassUserId = userID
                        self.uaePassEmail = email
                        //self.login()
                        //self.mapuUser(uaePassUserID: self.uaePassUserId, userId: self.user.id)
                        
                    }
                    
                    alert.addAction(signupAction)
                    alert.addAction(signinAction)
                    
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }else {
                DispatchQueue.main.async {
                    Utils.showAlertWith(title: "Error", message: message, viewController: self)
                }
            }
        }
    }
    func mapuUser(uaePassUserID: String ,userId: String) {
    
        DispatchQueue.main.async {
            let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
             //NVActivityIndicatorPresenter.sharedInstance.startAnimating(self.activityData)
            //self.view.isUserInteractionEnabled = false
        }
        
        

        WebService.CreateUAEPassUserMapping(uaePassUserId: uaePassUserID, uaePassUserType: "SOP3", userId: userId ) { (json) in
            print(json)
            
            
            DispatchQueue.main.async {
                self.stopAnimating(nil)
                //self.view.isUserInteractionEnabled = false
            }
            
            
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code > 0 {
                
                DispatchQueue.main.async {
                    self.retrieveUser(email: self.uaePassEmail, userID: self.uaePassUserId)
                }
                
                /*
                guard let data = json["data"] as? [String: Any] else{return}
                guard let result = data["result"] as? [String: Any] else {return}
                
                guard let userId = result["UserId"] as? String else {
                    DispatchQueue.main.async {
                        Utils.showAlertWith(title: "Error".localize, message: "Username or Password not correct".localize, viewController: self)
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
                */
                
            }else{
                DispatchQueue.main.async {
                    Utils.showAlertWith(title: "Error".localize, message: message, viewController: self)
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
            let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
            DispatchQueue.main.async(execute: {() -> Void in
                PFUser.logInWithUsername(inBackground: email, password: password, block: {(user, error) in
                    
                    DispatchQueue.main.async {
                        self.stopAnimating(nil)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRegister" {
            let dest = segue.destination as! RegisterViewController
            dest.isUAEPass = self.isUAEPass
            dest.uaePassUserId = self.uaePassUserId
            dest.user_email = self.email
            dest.first_name = self.firstname
            dest.last_name = self.lastName
            dest.emirates_id = self.emiratesID
            dest.user_mobile = self.mobileNumber
        }
    }
    
    @objc public var uaePassAccessToken: String!
    
    @IBAction func actionLoginWithUaePass(_ sender: Any) {
        
        let webVC = self.storyboard?.instantiateViewController(withIdentifier: "UAEPassWebViewController") as? UAEPassWebViewController
        webVC?.urlString = UAEPassConfiguration.getServiceUrlForType(serviceType: .loginURL)
        webVC?.onUAEPassSuccessBlock = {(code: String?) -> Void in
            if let code = code {
                self.startAnimating(message: "Generating Login Token", type: .pacman)
                self.getUaePassTokenForCode(code: code)
            }
        }
        webVC?.onUAEPassFailureBlock = {(response: String?) -> Void in
            
            let alert = UIAlertController(title: "Error".localize, message: response, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok".localize, style: .default) { (action) in
                
            }
            
            alert.addAction(okAction)
            self.navigationController?.present(alert, animated: true, completion: nil)
            
            
        }
        if let viewController = webVC {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func getUaePassTokenForCode(code: String) {
        Service1.shared.getUAEPassToken(code: code, completion: { (uaePassToken) in
            self.stopAnimating()
            
            if uaePassToken.isEmpty {
                self.showErrorAlert(title: "Error", message: "Unable to get user token, Please try again.")
                return
            }
            self.uaePassAccessToken = uaePassToken
            self.getUaePassProfileForToken(token: uaePassToken)
            
        }) { (error) in
            self.stopAnimating()
            self.showErrorAlert(title: "Error", message: error.rawValue)
        }
    }
    
    
    func getUaePassProfileForToken(token: String) {
        Service1.shared.getUAEPassUserProfile(token: token, completion: { (userProfile) in
            if let userProfile = userProfile {
                self.showProfileDetails(userProfile: userProfile, userToken: token)
            } else {
                self.showErrorAlert(title: "Error", message: "Couldn't get user profile, Please try again later")
            }
        }) { (error) in
            self.showErrorAlert(title: "Error", message: error.rawValue)
        }
    }

    func showProfileDetails(userProfile: UAEPassUserProfile, userToken: String) {
        
        self.firstname = userProfile.firstnameEN ?? ""
        self.lastName = userProfile.lastnameEN ?? ""
        self.email = userProfile.email ?? ""
        self.mobileNumber = userProfile.mobile ?? ""
        self.emiratesID = userProfile.idn ?? ""
        
        if userProfile.userType == "SOP1" {
            let alert = UIAlertController(title: "Error".localize, message: "Your account is unverified, please upgrade your account following instructions in the UAEPASS app.".localize, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok".localize, style: .default) { (action) in
                
            }
            alert.addAction(okAction)
            self.navigationController?.present(alert, animated: true, completion: nil)
        }else {
            self.retrieveUser(email: userProfile.email ?? "", userID: userProfile.uuid ?? "")
        }
        
        /*
        let userProfileVC = self.storyboard?.instantiateViewController(withIdentifier: "UserProfileViewController") as? UserProfileViewController
        userProfileVC?.userProfile = userProfile
        userProfileVC?.userToken = userToken
        if let userProfileVC = userProfileVC {
            self.navigationController?.pushViewController(userProfileVC, animated: true)
        } else {
            self.showErrorAlert(title: "Error", message: "Can't find User Profile View, Please check your storyboard")
        }*/
    }
    
    func showErrorAlert(title: String, message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
        }
        alertController.addAction(action1)
        self.present(alertController, animated: true, completion: nil)
    }
}
