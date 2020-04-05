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
    
    var imagePicker = UIImagePickerController()
    
    var galleryItem = Gallery()
    
    var profileImage: UIImage!
    
    @IBOutlet var profileImageView: UIImageView!
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupFields()
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
        
        
        firstNameView.textLabel.text = "First Name"
        firstNameView.textField.placeholder = "First Name"
        
        
        lastNameView.textLabel.text = "Last Name"
        lastNameView.textField.placeholder = "Last Name"
        
        
        nationalityView.textLabel.text = "Nationality"
        nationalityView.textField.placeholder = "Please Select"
       
        
        genderView.textLabel.text = "Gender"
        
        
        emailView.textLabel.text = "Email"
        emailView.textField.placeholder = "Email"
        
        
        mobileView.textLabel.text = "Mobile No"
        mobileView.textField.placeholder = "Mobile No"
        
        
        emiratesIDView.textLabel.text = "Emirates ID"
        emiratesIDView.textField.placeholder = "Emirates ID"
        
        
        securityQuestionsView.textLabel.text = "Security Question"
        securityQuestionsView.textField.placeholder = "Please Select"
        
        
        answerView.textLabel.text = "Answer"
        answerView.textField.placeholder = "Answer"
        
        
        usernameView.textLabel.text = "Username"
        usernameView.textField.placeholder = "Username"
        
        passwordView.textLabel.text = "Password"
        passwordView.textField.placeholder = "Password"
        passwordView.textField.isSecureTextEntry = true
        passwordView.descLabel.isHidden = false
        
        confirmPasswordView.textLabel.text = "Password Confirmation"
        confirmPasswordView.textField.placeholder = "Password Confirmation"
        confirmPasswordView.textField.isSecureTextEntry = true
        
    }
   @IBAction func profileImageEditButtonPressed(_ sender: AnyObject) {
       
       
    let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle:
        
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
