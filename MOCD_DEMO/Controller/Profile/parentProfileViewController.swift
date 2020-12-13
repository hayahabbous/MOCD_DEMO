//
//  parentProfileViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 9/8/19.
//  Copyright © 2019 Datacellme. All rights reserved.
//

import Foundation

import SkyFloatingLabelTextField
import AssetsLibrary
import NVActivityIndicatorView



class parentProfileViewController: UIViewController ,UITextFieldDelegate ,UINavigationControllerDelegate,UIImagePickerControllerDelegate ,WWCalendarTimeSelectorProtocol ,NVActivityIndicatorViewable{
    
    
    var imagePicker = UIImagePickerController()
    
    @IBOutlet var birthdateButton: UIButton!
    @IBOutlet var cameraImageView: UIImageView!
    @IBOutlet var backImageView: UIImageView!
    
    
    var didUserChangehisImage = Bool()
    var profileImage: UIImage!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var addChildButton: UIButton!
    
    
    @IBOutlet var pickerView: UIPickerView!
    
    
    @IBOutlet var emiratesIDTextFields: SkyFloatingLabelTextField!
    @IBOutlet var firstNameTextField: SkyFloatingLabelTextField!
    @IBOutlet var lastNameTextField: SkyFloatingLabelTextField!
    @IBOutlet var nationalityTextField: SkyFloatingLabelTextField!

    
    
    
    
    let nvactivity = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    var newChild: ChildObject = ChildObject()
    
    let unitsArray = ["USD","SAR","AED","KWD"]
    
    var isEdit: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage = UIImage(named: "placeholder_baby")
        
        backImageView.addCurvedView(imageview: backImageView ,backgroundColor: .brown, curveRadius: 30, shadowColor: .lightGray, shadowRadius: 4.0, heightOffset: 0.0)
        
        self.addChildButton.applyGradient(colours: [AppConstants.FIRST_GREEN_COLOR, AppConstants.SECOND_GREEN_COLOR])
        //self.loginButton.backgroundColor = .green
        self.addChildButton.layer.cornerRadius = self.addChildButton.frame.height / 2
        self.addChildButton.layer.masksToBounds = true
        
        
        self.cameraImageView.layer.cornerRadius = self.cameraImageView.frame.height / 2
        self.cameraImageView.layer.masksToBounds = true
        
        
        
        self.imagePicker.delegate = self
        
        
        
        profileImageView.layer.cornerRadius = self.profileImageView.frame.height / 2
        
        profileImageView.layer.masksToBounds = true
        
        
        
        profileImageView.layer.borderWidth = 4
        profileImageView.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        
        cameraImageView.layer.borderWidth = 2
        cameraImageView.layer.borderColor = UIColor.white.cgColor
        
        //showCalendar()
        
        /*
        if let userPicture = PFUser.current()?.value(forKey: "picture") as? PFFileObject{
            userPicture.getDataInBackground({ (imageData: Data?, error: Error?) -> Void in
                let image = UIImage(data: imageData!)
                if image != nil {
                    DispatchQueue.main.async {
                        self.profileImageView.image = image
                    }
                    
                    
                }
            })
        }
        
        emiratesIDTextFields.text = PFUser.current()?.value(forKey: "emiratesID") as? String ?? ""
        firstNameTextField.text = PFUser.current()?.value(forKey: "first_name") as? String ?? ""
        lastNameTextField.text = PFUser.current()?.value(forKey: "last_name") as? String ?? ""
        nationalityTextField.text = PFUser.current()?.value(forKey: "Nationality") as? String ?? ""
        
        */
    }
    
    func showCalendar() {
        let selector = WWCalendarTimeSelector.instantiate()
        selector.delegate = self
        /*
         Any other options are to be set before presenting selector!
         */
        
        selector.optionStyles.showDateMonth(true)
        selector.optionStyles.showMonth(false)
        selector.optionStyles.showYear(true)
        selector.optionStyles.showTime(false)
        
        present(selector, animated: true, completion: nil)
    }
    
    
    
    @IBAction func AddChildAction(_ sender: Any) {
        checkFields()
        
    }
    
    
    func saveFleb() {
        
        
        let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
       
        /*
        
        let currentUser = PFUser.current()
        
        if let currentUser = currentUser {
            currentUser["emiratesID"] =  emiratesIDTextFields.text ?? ""
           
            currentUser["last_name"] = lastNameTextField.text ?? ""
            currentUser["first_name"] = firstNameTextField.text ?? ""
            currentUser["Nationality"] = nationalityTextField.text ?? ""
           
            
            if didUserChangehisImage{
                if  let userProfileUIImage = self.profileImage {
                    let userProfileImageData = userProfileUIImage.pngData()
                    if let userProfileImageData = userProfileImageData {
                        let userProfileImagePFfile = PFFileObject(data: userProfileImageData ,contentType:"image/jpeg")
                        currentUser.setValue(userProfileImagePFfile, forKey: "picture")
                    }
                }
            }
            
            
            currentUser.saveInBackground(block: {(succeeded, error)in
                print("Finish")
                DispatchQueue.main.async {
                    self.newChild = ChildObject()
                    
                    
                    self.navigationController?.popViewController(animated: true)
                    self.stopAnimating(nil)
                    
                }
            })
            
        }
        
        
        
        
        
        if isEdit {
            //Edit Object
        }else{
            //Save to DB ...
            
        }
        
        */
        
    }
    
    
    func checkFields() {
        var isFilled = true
        
        let msg = "Please Fill all Fields"
        if firstNameTextField.text == "" || lastNameTextField.text == "" || nationalityTextField.text == "" || emiratesIDTextFields.text == ""  {
            isFilled = false
        }
        
        
        if isFilled {
            saveFleb()
        }else{
            Utils.showErrorMessage(msg, withTitle: "Missing Information", andInViewController: self)
        }
    }
    @IBAction func birthdateAction(_ sender: Any) {
        
        showCalendar()
    }
    @IBAction func profileImageEditButtonPressed(_ sender: AnyObject) {
        
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
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
        self.profileImageView.image = selectedImage
        self.profileImage = selectedImage
        
        didUserChangehisImage = true
        
        picker.dismiss(animated: true, completion: nil);
    }
}
