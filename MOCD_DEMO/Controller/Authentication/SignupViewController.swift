//
//  SignupViewController.swift
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

class SignupViewController: UIViewController {
    
    
    
    @IBOutlet var nationalitiesPickerView: UIPickerView!
    @IBOutlet var genderPickerView: UIPickerView!

    @IBOutlet var emiratesPickerView: UIPickerView!
    var gendersArray: [String: String] = [:]
    var nationalitiesArray: [String: String] = [:]
    var emiratesArray: [String: String] = [:]
    var activityData = ActivityData()
    var username: String = ""
    var first_name: String = ""
    var last_name: String = ""
    var emiratesID: String = ""
    var email: String = ""
    
    var password: String = ""
    var confPassword: String = ""
    
    
    var phone: String = ""
    var emirate: String = ""
    
    var address: String = ""
    var gender: String = ""
    
    var nationalities: String = ""
    
    let firstGreenColor = UIColor(red: 111/256 , green: 187/256, blue: 119/256, alpha: 1.0)
    let secondGreenColor = UIColor(red: 147/256 , green: 202/256, blue: 90/256, alpha: 1.0)
    
    var toolBar = UIToolbar()
    @IBOutlet var backLogoView: UIView!
    @IBOutlet var logoImageView: UIImageView!
    

    @IBOutlet var usernameTextField: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet var firstNameTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet var lastNameTextField: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet var emiratesIDTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet var emailTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet var passwordTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet var confirmPasswordTextField: SkyFloatingLabelTextFieldWithIcon!
   
    @IBOutlet var genderTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet var phoneTextField: SkyFloatingLabelTextFieldWithIcon!
    
    @IBOutlet var emirateTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet var addressTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet var nationalitiesTextField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let gradient = CAGradientLayer()
        gradient.frame = self.loginButton.bounds
        gradient.colors = [UIColor.green]
        
        self.loginButton.applyGradient(colours: [firstGreenColor, secondGreenColor])
        //self.loginButton.backgroundColor = .green
        self.loginButton.layer.cornerRadius = 20
        self.loginButton.layer.masksToBounds = true
        
        
        
        self.logoImageView.layer.borderWidth = 0.1
        self.logoImageView.layer.borderColor = UIColor.lightGray.cgColor
        
        self.logoImageView.layer.cornerRadius = self.logoImageView.frame.height / 2
        self.logoImageView.layer.masksToBounds = true
        
        backLogoView.addShadow(offset: CGSize(width: 0, height: 4), color: .lightGray, radius: self.logoImageView.frame.height / 2, opacity: 0.5)
        
        self.backLogoView.addSubview(self.logoImageView)
        
        self.getGenders()
        self.getCountries()
        self.getEmirates()
        
        
        
        setupToolbar()
        self.usernameTextField.placeholder = "Username".localize
        self.passwordTextField.placeholder = "Password".localize
        self.firstNameTextField.placeholder = "First Name".localize
        self.lastNameTextField.placeholder = "Last Name".localize
        self.emiratesIDTextField.placeholder = "Emirates ID".localize
        self.emailTextField.placeholder = "Email".localize
        self.confirmPasswordTextField.placeholder = "Confirm Password".localize
        self.phoneTextField.placeholder = "Mobile".localize
        self.emirateTextField.placeholder = "Emirate".localize
        self.addressTextField.placeholder = "Address".localize
        self.nationalitiesTextField.placeholder = "Nationality".localize
        self.genderTextField.placeholder = "Gender".localize
        
    }
    func setupToolbar() {
        toolBar.tintColor = AppConstants.BROWN_COLOR
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        
        toolBar.sizeToFit()
        
        
        var items = [UIBarButtonItem]()
        items.append(
            UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(onClickedToolbeltButton(_:)))
        )
        items.append(
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace , target: self, action: nil))
        items.append(
            UIBarButtonItem(barButtonSystemItem: .done , target: self, action: #selector(onClickedToolbeltButton(_:)))
        )
        
        toolBar.items = items
        toolBar.backgroundColor = AppConstants.GREEN_COLOR
        
        
        genderPickerView.translatesAutoresizingMaskIntoConstraints = false
        nationalitiesPickerView.translatesAutoresizingMaskIntoConstraints = false
        emiratesPickerView.translatesAutoresizingMaskIntoConstraints = false
        
        
        

        genderTextField.inputAccessoryView = toolBar
        genderTextField.inputView = genderPickerView
        //genderTextField.delegate = self

        genderTextField.text = ""
        genderTextField.isUserInteractionEnabled = true
        
        nationalitiesTextField.inputAccessoryView = toolBar
        nationalitiesTextField.inputView = nationalitiesPickerView
        //nationalitiesTextField.delegate = self

        nationalitiesTextField.text = ""
        nationalitiesTextField.isUserInteractionEnabled = true
        
        
        
        emirateTextField.inputAccessoryView = toolBar
        emirateTextField.inputView = emiratesPickerView
        //nationalitiesTextField.delegate = self

        emirateTextField.text = ""
        emirateTextField.isUserInteractionEnabled = true
        
        
        
        
        
        
    }
    
    @objc func onClickedToolbeltButton(_ sender: Any){
        self.view.endEditing(true)
    }
    func getGenders() {
     
        WebService.RetrieveGender { (json) in
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
                guard let data = json["data"] as? [String:Any] else {return}
                guard let results = data["result"] as? [[String:Any]] else {return}
                
                var gendersA: [String: String] = [:]
                for r in results {
                    let id = r["id"] as! String
                    let gender_en = r["gender_en"] as! String
                    let gender_ar = r["gender_ar"] as! String
                    
                    gendersA[id] = gender_en
                    
                }
                
                
                DispatchQueue.main.async {
                    self.gendersArray = gendersA
                    
                    self.genderPickerView.reloadAllComponents()
                }
            }
        }
    }
    func getCountries() {
        WebService.getNationalities { (json) in
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
            
                guard let data = json["data"] as? [String:Any] else {return}
                guard let results = data["result"] as? [[String:Any]] else {return}
                
                var nationalitiesA: [String: String] = [:]
                for r in results {
                    let id = r["country_code"] as! String
                    let country_enNationality = r["country_enNationality"] as! String
                    let country_arNationality = r["country_arNationality"] as! String
                    
                    nationalitiesA[id] = country_enNationality
                    
                }
                
                DispatchQueue.main.async {
                    self.nationalitiesArray = nationalitiesA
                    
                    self.nationalitiesPickerView.reloadAllComponents()
                }
            }
        }
    }
    
    func getEmirates() {
        WebService.getEmirates { (json) in
            
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
                guard let data = json["data"] as? [String:Any] else {return}
                guard let results = data["result"] as? [[String:Any]] else {return}
                
                var emiratesA: [String: String] = [:]
                for r in results {
                    let id = r["id"] as! String
                    let emirate_en = r["emirate_en"] as! String
                    let emirate_ar = r["emirate_ar"] as! String
                    
                    emiratesA[id] = emirate_en
                    
                }
                
                
                DispatchQueue.main.async {
                    self.emiratesArray = emiratesA
                    
                    self.emiratesPickerView.reloadAllComponents()
                }
            }
            
        }
    }
    
    func emptyValidation() -> Bool {
        let isOK: Bool = true

        self.username = self.usernameTextField.text!
        self.first_name = self.firstNameTextField.text!
        self.last_name = self.lastNameTextField.text!
        self.emiratesID = self.emiratesIDTextField.text!
        self.email = self.emailTextField.text!
        
        self.password = self.passwordTextField.text!
        self.confPassword = self.confirmPasswordTextField.text!
        
        
        self.phone = self.phoneTextField.text!
       
        
        self.address = self.addressTextField.text!
    
        
        
        if username.count  == 0 {
            Utils.showErrorMessage(NSLocalizedString("Please enter a valid username", comment:""), withTitle: NSLocalizedString("username is empty", comment:""), andInViewController: self)
            return false
        }
        
        if first_name.count  == 0 {
            Utils.showErrorMessage(NSLocalizedString("Please enter a valid first name", comment:""), withTitle: NSLocalizedString("firstname  is empty", comment:""), andInViewController: self)
            return false
        }
        if last_name.count  == 0 {
            Utils.showErrorMessage(NSLocalizedString("Please enter a valid last name", comment:""), withTitle: NSLocalizedString("lastname is empty", comment:""), andInViewController: self)
            return false
        }
        
        
        
        
        
        
        if emiratesID.count  == 0 {
            Utils.showErrorMessage(NSLocalizedString("Please enter a valid emirates ID", comment:""), withTitle: NSLocalizedString("Emirates ID is empty", comment:""), andInViewController: self)
            return false
        }
        
        
        if email.count  == 0 {
            Utils.showErrorMessage(NSLocalizedString("Please enter a valid email address", comment:""), withTitle: NSLocalizedString("Email is empty", comment:""), andInViewController: self)
            return false
        }
        
        var isvalidEmail = validate(YourEMailAddress: email)
        if !isvalidEmail{
            Utils.showErrorMessage(NSLocalizedString("Please enter a valid email address", comment:""), withTitle: NSLocalizedString("Email is empty", comment:""), andInViewController: self)
            return false
        }
        
        if password.count  == 0 {
            Utils.showErrorMessage(NSLocalizedString("Please enter a valid password", comment:""), withTitle: NSLocalizedString("Password is empty", comment:""), andInViewController: self)
            return false
        }
        
        if confPassword.count  == 0 {
            Utils.showErrorMessage(NSLocalizedString("Please enter a  password confirmation", comment:""), withTitle: NSLocalizedString("Password Confirmation is empty", comment:""), andInViewController: self)
            return false
        }
        
        
        if phone.count  == 0 {
            Utils.showErrorMessage(NSLocalizedString("Please enter a valid Phone number", comment:""), withTitle: NSLocalizedString("Phone is empty", comment:""), andInViewController: self)
            return false
        }
        
        
        if emirate.count  == 0 {
            Utils.showErrorMessage(NSLocalizedString("Please enter a valid emirate", comment:""), withTitle: NSLocalizedString("Emirate is empty", comment:""), andInViewController: self)
            return false
        }
        
        
        if address.count  == 0 {
            Utils.showErrorMessage(NSLocalizedString("Please enter a valid address", comment:""), withTitle: NSLocalizedString("Address is empty", comment:""), andInViewController: self)
            return false
        }
        
        if gender.count  == 0 {
            Utils.showErrorMessage(NSLocalizedString("Please enter a valid gender", comment:""), withTitle: NSLocalizedString("gender is empty", comment:""), andInViewController: self)
            return false
        }
        
        if nationalities.count  == 0 {
            Utils.showErrorMessage(NSLocalizedString("Please enter a valid nationality", comment:""), withTitle: NSLocalizedString("Nationality is empty", comment:""), andInViewController: self)
            return false
        }
        
        
        if password != confPassword {
            Utils.showErrorMessage(NSLocalizedString("Psswords dismatch ", comment:""), withTitle: NSLocalizedString("Password and Password Confirmation are not the same", comment:""), andInViewController: self)
            return false
        }
        if !isValidPassword(password) {
           Utils.showErrorMessage(NSLocalizedString("Please enter a password contains at least 8 digits one number and one character ", comment:""), withTitle: NSLocalizedString("Password is not valid", comment:""), andInViewController: self)
            return false
        }
        
        
        return isOK
    }
    
    
    func signup() {
        
        
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        WebService.signup(firstName: self.first_name, lastName: last_name, email: self.email, username: self.username, emiratesId: self.emiratesID, phone: self.phone, emirate: self.emirate, password: self.password, address: self.address, gender: self.gender, nationality: self.nationalities) { (json) in
            
            
            
            DispatchQueue.main.async {
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            }
            
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
                
                print(json)
                
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }else{
                
                DispatchQueue.main.async {
                    Utils.showAlertWith(title: "Error", message: message, viewController: self)
                }
                
            }
            
            
            
        }
    }
    
    /*
    func login() {
       
        
        
        let user: PFUser = PFUser()
      
        
        user.password = self.password
        user.email = self.email
        
        // other fields
        user["emiratesID"] = self.emiratesID
        user["username"] = self.email
    
        
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        let reach = Reachability.Connection.self
        if reach != .none {
            //self.activityIndicator.startAnimating()
            self.loginButton.isEnabled = false
            DispatchQueue.main.async(execute: {() -> Void in
                user.signUpInBackground(block: {(succeeded, error)  in
                    
                    DispatchQueue.main.async {
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                    }
                    if succeeded {
                        //TODO Fix Chat issue
                        //self.signupToChatServer()
                        
                        let installition = PFInstallation.current()
                        installition!["user"] = PFUser.current()
                        installition!.saveInBackground()
                        
                        
                        let rootViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "mainViewController")
                        self.view.window!.rootViewController = rootViewController
                        rootViewController.modalPresentationStyle = .fullScreen
                        self.dismiss(animated: true, completion: {() -> Void in
                            self.present(rootViewController, animated: true, completion: {() -> Void in
                            })
                        })
                    }
                    else {
                        Utils.handleParseError(error! as NSError, inViewController: self)
                        // self.activityIndicator.stopAnimating()
                        self.loginButton.isEnabled = true
                    }
                })
            })
        }
        else {
            DispatchQueue.main.async(execute: {() -> Void in
                Utils.noInternetConnectionErrorInViewController(self)
                //self.activityIndicator.stopAnimating()
                self.loginButton.isEnabled = true
            })
        }
    }*/
    @IBAction func dismissView(_ sender: Any) {
        self.view.endEditing(true)
    }
    @IBAction func signupAction(_ sender: Any) {
        
        if self.emptyValidation() == false {
            return
        }
        /*
         if self.felidValueValidation() == false {
         return
         }
         //Start animating after validation only ...
         self.activityIndicator.startAnimating()*/
        self.signup()
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    func isValidPassword(_ pass: String) -> Bool {
        let emailRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: pass)
    }
    
    func validate(YourEMailAddress: String) -> Bool {
        let REGEX: String
        REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with: YourEMailAddress)
    }
}

extension SignupViewController: UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == genderPickerView {
            return gendersArray.count
        }else if pickerView == nationalitiesPickerView{
            return nationalitiesArray.count
        }
        else if pickerView == emiratesPickerView{
            return emiratesArray.count
        }
        
        
        return 0
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == genderPickerView {
            let item = Array(gendersArray)[row]
            let title = item.value
            
            return title
        }else if pickerView == nationalitiesPickerView{
            let item = Array(nationalitiesArray)[row]
            let title = item.value
            
            return title
        }
        else if pickerView == emiratesPickerView{
            let item = Array(emiratesArray)[row]
            let title = item.value
            
            return title
        }
        
        return ""
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == genderPickerView {
            let item = Array(gendersArray)[row]
            self.gender = item.key
            self.genderTextField.text = item.value
            
        }else if pickerView == nationalitiesPickerView{
            let item = Array(nationalitiesArray)[row]
          
            self.nationalities = item.key
            self.nationalitiesTextField.text = item.value
        }
        else if pickerView == emiratesPickerView{
            let item = Array(emiratesArray)[row]
            
              self.emirate = item.key
            self.emirateTextField.text = item.value
        }
        
    }
    
}
