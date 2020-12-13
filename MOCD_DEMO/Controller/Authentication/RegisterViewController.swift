//
//  RegisterViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 2/25/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import M13Checkbox


class RegisterViewController: UIViewController {
    
    @IBOutlet var securityPicker: UIPickerView!
    var imagePicker = UIImagePickerController()
    var toolBar = UIToolbar()
    var galleryItem = Gallery()

    var profileImage: UIImage!
    var questionsArray: [MOCDSecurityQuestions] = []
    var countriesArray: [MOCDCountry] = []
    @IBOutlet var profileImageView: UIImageView!
    
    @IBOutlet var nationalitiesPickerView: UIPickerView!
    var didUserChangehisImage = Bool()
    
    @IBOutlet var cameraImageView: UIImageView!
    
    @IBOutlet var firstNameView: textFieldMandatory!
    @IBOutlet var lastNameView: textFieldMandatory!
    @IBOutlet var nationalityView: selectTextField!
    @IBOutlet var genderView: multipleTextField!
    @IBOutlet var emailView: textFieldMandatory!
    @IBOutlet var mobileView: textFieldMandatory!
    @IBOutlet var emiratesIDView: textFieldMandatory!
    @IBOutlet var securityQuestionsView: selectTextField!
    @IBOutlet var answerView: textFieldMandatory!
    @IBOutlet var usernameView: textFieldMandatory!
    @IBOutlet var passwordView: textFieldMandatory!
    @IBOutlet var confirmPasswordView: textFieldMandatory!
    @IBOutlet var twoFactorAuthCheckBox: M13Checkbox!
    @IBOutlet var submitButton: UIButton!
    
    
    
    
    var first_name: String = ""
    var last_name: String = ""
    var password: String = ""
    var confirm_password: String = ""
    var username: String = ""
    var nationality_id: String = ""
    var gender_id: String = ""
    var user_email: String = ""
    var user_mobile: String = ""
    var emirates_id: String = ""
    var question_id: String = ""
    var question_answer: String = ""
    var enable_two_factor_authentication: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupFields()
        setupToolbar()
        getSecurityQuestions()
    
        getNationalities()
    }
    
    
    func setupView() {
        
        
        self.cameraImageView.layer.cornerRadius = self.cameraImageView.frame.height / 2
        self.cameraImageView.layer.masksToBounds = true
        
        
        
        self.imagePicker.delegate = self
        
        
        
        profileImageView.layer.cornerRadius = self.profileImageView.frame.height / 2
        
        profileImageView.layer.masksToBounds = true
        
        
        
        profileImageView.layer.borderWidth = 4
        profileImageView.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        
        cameraImageView.layer.borderWidth = 2
        cameraImageView.layer.borderColor = UIColor.white.cgColor
        
        
        let gradient = CAGradientLayer()
        gradient.frame = self.submitButton.bounds
        gradient.colors = [UIColor.green]
        
        self.submitButton.applyGradient(colours: [AppConstants.firstBrownColor, AppConstants.secondBrownColor])
        //self.loginButton.backgroundColor = .green
        self.submitButton.layer.cornerRadius = 20
        self.submitButton.layer.masksToBounds = true
    }
    
    
    func setupFields() {
        
        
        firstNameView.textLabel.text = "First Name".localize
        firstNameView.textField.placeholder = "First Name".localize
        
        
        lastNameView.textLabel.text = "Last Name".localize
        lastNameView.textField.placeholder = "Last Name".localize
        
        
        nationalityView.textLabel.text = "Nationality".localize
        nationalityView.textField.placeholder = "Please Select".localize
        nationalityView.textField.inputView = nationalitiesPickerView
        
        genderView.textLabel.text = "Gender".localize
   
        
        emailView.textLabel.text = "Email".localize
        emailView.textField.placeholder = "Email".localize
        
        
        mobileView.textLabel.text = "Mobile No".localize
        mobileView.textField.placeholder = "Mobile No".localize
        
        
        emiratesIDView.textLabel.text = "Emirates ID".localize
        emiratesIDView.textField.placeholder = "Emirates ID".localize
        
        
        securityQuestionsView.textLabel.text = "Security Question".localize
        securityQuestionsView.textField.placeholder = "Please Select".localize
        securityQuestionsView.textField.inputView = securityPicker
        
        answerView.textLabel.text = "Answer".localize
        answerView.textField.placeholder = "Answer".localize
        
        
        usernameView.textLabel.text = "Username".localize
        usernameView.textField.placeholder = "Username".localize
        
        passwordView.textLabel.text = "Password".localize
        passwordView.textField.placeholder = "Password".localize
        passwordView.textField.isSecureTextEntry = true
        passwordView.descLabel.isHidden = false
        
        confirmPasswordView.textLabel.text = "Password Confirmation".localize
        confirmPasswordView.textField.placeholder = "Password Confirmation".localize
        confirmPasswordView.textField.isSecureTextEntry = true
        
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
           
           
        securityQuestionsView.textField.inputAccessoryView = toolBar
     
      
        nationalityView.textField.inputAccessoryView = toolBar
           
         
           
           
           
           
           
       
    }
    
    
    @objc func onClickedToolbeltButton(_ sender: Any){
        self.view.endEditing(true)
    }
    
    func getNationalities() {
        WebService.getCountries { (json) in
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
            
                guard let data = json["data"] as? [String:Any] else {return}
                guard let results = data["result"] as? [String:Any] else {return}
                guard let list = results["list"] as? [[String:Any]] else {return}
               
                for r in list {
                    
                    
                    let item = MOCDCountry()
                   
                    item.CountryId = String (describing: r["CountryId"] ?? "" )
                    item.CountryNameAr = r["CountryNameAr"] as! String
                    item.CountryNameEn  = r["CountryNameEn"] as! String
                    
                    item.CountryCode = r["CountryCode"] as! String
                    self.countriesArray.append(item)
                }
                
                DispatchQueue.main.async {
                  
                    self.nationalitiesPickerView.reloadAllComponents()
                }
            }
        }
    }
    func getSecurityQuestions() {
     
        WebService.getSecurityQuestions { (json) in
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
                guard let data = json["data"] as? [String:Any] else {return}
                guard let results = data["result"] as? [String:Any] else {return}
                guard let list = results["list"] as? [[String:Any]] else {return}
          
                for r in list {
                    
                    let qItem = MOCDSecurityQuestions()
                    
                    qItem.QuestionId = String (describing: r["QuestionId"] ?? "" )
                    qItem.QuestionAr = r["QuestionAr"] as! String
                    qItem.QuestionEn = r["QuestionEn"] as! String
                    
                
                    
                    self.questionsArray.append(qItem)
                }
                
                
                DispatchQueue.main.async {
                    
                    
                    self.securityPicker.reloadAllComponents()
                }
            }
        }
    }
    
    func checkFields() {
        
        //nationality // gender // securityquestions // enable two factor auth
        
        
        var isEmpty = false
        self.first_name = firstNameView.textField.text ?? ""
        self.last_name = lastNameView.textField.text ?? ""
        self.password = passwordView.textField.text ?? ""
        self.username = usernameView.textField.text ?? ""
        self.user_email = emailView.textField.text ?? ""
        self.user_mobile = mobileView.textField.text ?? ""
        self.emirates_id = emiratesIDView.textField.text ?? ""
        self.question_answer  = answerView.textField.text ?? ""
        self.gender_id = genderView.firstCheckBox.checkState == .checked ? "1" : "2"
        self.enable_two_factor_authentication = twoFactorAuthCheckBox.checkState == .checked ? "true" : "false"
        self.confirm_password = confirmPasswordView.textField.text ?? ""
        if first_name == "" || first_name.count == 0 {
            
            Utils.showErrorMessage(NSLocalizedString("Please enter a valid first name".localize, comment:""), withTitle: NSLocalizedString("firstname is empty".localize, comment:""), andInViewController: self)
            isEmpty = true
        }else if last_name == "" || last_name.count == 0 {
            
            Utils.showErrorMessage(NSLocalizedString("Please enter a valid last name".localize, comment:""), withTitle: NSLocalizedString("lastname is empty".localize, comment:""), andInViewController: self)
            isEmpty = true
        }else if password == "" || password.count == 0 {
            Utils.showErrorMessage(NSLocalizedString("Please enter a valid password".localize, comment:""), withTitle: NSLocalizedString("password is empty".localize, comment:""), andInViewController: self)
            isEmpty = true
        }else if confirm_password == "" || confirm_password.count == 0 {
            Utils.showErrorMessage(NSLocalizedString("Please enter a valid confirm password".localize, comment:""), withTitle: NSLocalizedString("confirm password is empty".localize, comment:""), andInViewController: self)
            isEmpty = true
        }else if username == "" || username.count == 0 {
            Utils.showErrorMessage(NSLocalizedString("Please enter a valid username".localize, comment:""), withTitle: NSLocalizedString("username is empty".localize, comment:""), andInViewController: self)
            isEmpty = true
        }else if user_email == "" || user_email.count == 0 {
            Utils.showErrorMessage(NSLocalizedString("Please enter a valid email ".localize, comment:""), withTitle: NSLocalizedString("email is empty".localize, comment:""), andInViewController: self)
            isEmpty = true
        }else if user_mobile == "" || user_mobile.count == 0 {
            Utils.showErrorMessage(NSLocalizedString("Please enter a valid mobile".localize, comment:""), withTitle: NSLocalizedString("mobile is empty".localize, comment:""), andInViewController: self)
           isEmpty = true
        }else if emirates_id == "" || emirates_id.count == 0 {
            Utils.showErrorMessage(NSLocalizedString("Please enter a valid emirates ID".localize, comment:""), withTitle: NSLocalizedString("emirates ID is empty".localize, comment:""), andInViewController: self)
            isEmpty = true
        }else if question_answer == "" || question_answer.count == 0 {
            Utils.showErrorMessage(NSLocalizedString("Please enter a valid answer".localize, comment:""), withTitle: NSLocalizedString("answer is empty".localize, comment:""), andInViewController: self)
          isEmpty = true
        }else if nationality_id == "" || nationality_id.count == 0 {
            Utils.showErrorMessage(NSLocalizedString("Please enter a valid nationality".localize, comment:""), withTitle: NSLocalizedString("nationality is empty".localize, comment:""), andInViewController: self)
          isEmpty = true
        }else if gender_id == "" || gender_id.count == 0 {
            Utils.showErrorMessage(NSLocalizedString("Please enter a valid gender ".localize, comment:""), withTitle: NSLocalizedString("gender is empty".localize, comment:""), andInViewController: self)
            isEmpty = true
        }else if question_id == "" || question_id.count == 0 {
            Utils.showErrorMessage(NSLocalizedString("Please enter a valid question ".localize, comment:""), withTitle: NSLocalizedString("question is empty".localize, comment:""), andInViewController: self)
           isEmpty = true
        }else if password != confirm_password {
            Utils.showErrorMessage(NSLocalizedString("Password mismatch".localize, comment:""), withTitle: NSLocalizedString("Password and Password Confirmation are not the same".localize, comment:""), andInViewController: self)
            isEmpty = true
        }
        if !Utils.isValidPassword(password) {
           Utils.showErrorMessage(NSLocalizedString("Please enter a password contains at least 8 digits one number and one character ".localize, comment:""), withTitle: NSLocalizedString("Password is not valid".localize, comment:""), andInViewController: self)
            isEmpty = true
        }
        
        
        if !isEmpty {
            registerUser()
        }
    }
    
    func registerUser() {
        
        
        RequestResponseWebServices.addUser(first_name: first_name, last_name: last_name, password: password, username: username, nationality_id: nationality_id, gender_id: gender_id, user_email: user_email, user_mobile: user_mobile, emirates_id: emirates_id, question_id: question_id, question_answer: question_answer, enable_tow_factor_auth: enable_two_factor_authentication, item: galleryItem, view: self.view) { (json, _ , error) in
            
            
            
            print(json)
            
            
            guard let code = json["code"] as? Int else {return}
            guard let data = json["data"] as? [String:Any] else {return}
            
            guard let result = data["result"] as? [String:Any] else {return}
            
            
            if code != 10 {
                let ResponseDescription = result["ResponseDescription"] as? String ?? ""
                let ResponseTitle = result["ResponseTitle"] as? String ?? ""
                
                
                DispatchQueue.main.async {
                    Utils.showAlertWith(title: ResponseTitle, message: ResponseDescription, viewController: self)
                }
            }else{
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
            
            
            
            
            
            if error != nil {
                DispatchQueue.main.async {
                    
                }
            }else {
                
            }
            print(json)
        }
    }
    @IBAction func submitButtonAction(_ sender: Any) {
        
        self.checkFields()
    }
    @IBAction func profileImageEditButtonPressed(_ sender: AnyObject) {
       
       
    let alert:UIAlertController=UIAlertController(title: "Choose Image".localize, message: nil, preferredStyle:
        
        UIAlertController.Style.actionSheet)
       
    let cameraAction = UIAlertAction(title: NSLocalizedString("Camera", comment: ""), style: UIAlertAction.Style.default)
    
    {(UIAlertAction) in
           
    
        self.openCamera()
       
    }
       
    
    let gallaryAction = UIAlertAction(title:NSLocalizedString("Gallary",comment:""), style: UIAlertAction.Style.default)
    
    {(UIAlertAction) in
           
    
        self.openGallary()
       
    }
       
    
    let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel",comment:""), style: UIAlertAction.Style.cancel)
    
    {(UIAlertAction) in
     
    }
       
       // Add the actions
       
    imagePicker.delegate = self
    
        
        
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.view //to set the source of your alert
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // you can set this as per your requirement.
            popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
        }
    alert.addAction(cameraAction)
    
    alert.addAction(gallaryAction)
    
    alert.addAction(cancelAction)
    
    self.present(alert, animated: true, completion: nil)
       
   }
    
    
    
}
extension RegisterViewController: UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    func openCamera()
    {
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            self .present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        let uuid = UUID().uuidString // generate a uuid to save it as the file name
        var filename = uuid + ".jpg"
        var documentPath = FileHelper.documentsPathForImages(filename: filename) // get the file path
        let imageData = info[UIImagePickerController.InfoKey.originalImage] as? UIImage // get the image picked
        
        let imageJpegData = imageData!.jpegData(compressionQuality: 0.7) // make a jpg
        do
        {
            try imageJpegData?.write(to: URL(fileURLWithPath: documentPath),options: .atomic)
             let data = FileManager.default.contents(atPath: documentPath)
             
             let image = UIImage(data: data!)
             var mimetype = FileHelper.mimeTypeForPath(path: documentPath)
             
             

             
             self.profileImageView.image = selectedImage
             self.profileImage = selectedImage
            
             
             galleryItem.type = mimetype
             galleryItem.path = documentPath
             galleryItem.name = filename
             galleryItem.image = imageData!
            
            
            didUserChangehisImage = true
        }
        catch {
                 
            print("error saving file : \(error)")
            return
            
        }
        
        
        
        
        
        picker.dismiss(animated: true, completion: nil);
    }
}
extension RegisterViewController: UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == securityPicker {
            return questionsArray.count
        }else if pickerView == nationalitiesPickerView{
            return countriesArray.count
        }
        
        
        return 0
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == securityPicker {
            let item = questionsArray[row]
            let title = item.QuestionEn
            
            return title
        }else if pickerView == nationalitiesPickerView{
            let item = countriesArray[row]
            let title = item.CountryNameEn
            
            return title
        }
        return ""
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == securityPicker {
            
            if questionsArray.count > 0 {
                let item = questionsArray[row]
                           
                //self.gender = item.key
                
                self.securityQuestionsView.textField.text = item.QuestionEn
                self.question_id = item.QuestionId
            }
           
        }else if pickerView == nationalitiesPickerView{
            let item = countriesArray[row]
          
            
           
            self.nationality_id = item.CountryId
            self.nationalityView.textField.text = item.CountryNameEn
            
            
            
        }
        
    }
    
}
