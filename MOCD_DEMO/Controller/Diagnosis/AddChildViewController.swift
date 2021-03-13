//
//  AddChildViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 6/19/19.
//  Copyright © 2019 Datacellme. All rights reserved.
//

import Foundation
import SkyFloatingLabelTextField
import AssetsLibrary
import NVActivityIndicatorView



class AddChildViewController: UIViewController ,UITextFieldDelegate ,UINavigationControllerDelegate,UIImagePickerControllerDelegate ,WWCalendarTimeSelectorProtocol ,NVActivityIndicatorViewable{
    
    @IBOutlet var emirateHeightConstraint: NSLayoutConstraint!
    
    var galleryItem = Gallery()
    var gendersArray: [String: String] = [:]

   
    var countriesArray: [MOCDCountry] = []
    
    var imagePicker = UIImagePickerController()
    var emiratesArray: [MOCDEmirate] = []
    var isEdit:Bool = false
    var childItem: ChildObject = ChildObject()
     var toolBar = UIToolbar()
    @IBOutlet var birthdateButton: UIButton!
    @IBOutlet var cameraImageView: UIImageView!
    @IBOutlet var backImageView: UIImageView!
    
    @IBOutlet var genderPickerView: UIPickerView!
    @IBOutlet var nationalitiesPickerView: UIPickerView!
    @IBOutlet var emiratePickerView: UIPickerView!
    
    var didUserChangehisImage = Bool()
    var profileImage: UIImage!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var addChildButton: UIButton!
    
    
    var firstName: String = ""
    var lastName: String = ""
    var mobile: String = ""
    var email: String = ""
    var gender: String = ""
    var emirate: String = ""
    var nationalities: String = ""
    var emiratesID: String = ""
    //var address: String = ""
    var birthdate: String = ""
 
    @IBOutlet var emirateTextField: SkyFloatingLabelTextField!

    

    @IBOutlet var lastNameTextField: SkyFloatingLabelTextField!
    @IBOutlet var firstNameTextField: SkyFloatingLabelTextField!
    @IBOutlet var addressTextField: SkyFloatingLabelTextField!
    @IBOutlet var nationalityTextField: SkyFloatingLabelTextField!
    @IBOutlet var birthdateTextField: SkyFloatingLabelTextField!
   
    @IBOutlet var genderTextField: SkyFloatingLabelTextField!
    
    

    let nvactivity = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    var newChild: ChildObject = ChildObject()
    
    let unitsArray = ["USD","SAR","AED","KWD"]
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if self.childItem.countryCode == "ARE" || self.childItem.countryCode == "ARE"{
            self.emirateTextField.isHidden = false
            emirateHeightConstraint.constant = 40
        }else{
            self.emirateTextField.isHidden = true
            emirateHeightConstraint.constant = 0
        }
        
        
        profileImage = UIImage(named: "placeholder_baby")
        
        backImageView.addCurvedView(imageview: backImageView ,backgroundColor: .brown, curveRadius: 30, shadowColor: .lightGray, shadowRadius: 4.0, heightOffset: 0.0)
        
        self.addChildButton.applyGradient(colours: [AppConstants.FIRST_GREEN_COLOR, AppConstants.SECOND_GREEN_COLOR])
        //self.loginButton.backgroundColor = .green
        self.addChildButton.layer.cornerRadius = self.addChildButton.frame.height / 2
        self.addChildButton.layer.masksToBounds = true
        
        if isEdit {
            addChildButton.setTitle("Save child".localize, for: .normal)
        }else {
            addChildButton.setTitle("Add child".localize, for: .normal)
        }
        
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
        
        
        self.getEmirates()
        self.getGenders()
        self.getNationalities()
        setupToolbar()
        
        
        firstNameTextField.placeholder = "First Name".localize
        lastNameTextField.placeholder = "Last Name".localize
      
        birthdateTextField.placeholder = "Birthdate".localize
        nationalityTextField.placeholder = "Nationality".localize
    
        emirateTextField.placeholder = "Emirate".localize
        addressTextField.placeholder = "Emirates ID".localize
        genderTextField.placeholder = "Gender".localize
        
        
        
        firstNameTextField.textAlignment = AppConstants.isArabic() ? .right : .left
        lastNameTextField.textAlignment = AppConstants.isArabic() ? .right : .left
        birthdateTextField.textAlignment = AppConstants.isArabic() ? .right : .left
        nationalityTextField.textAlignment = AppConstants.isArabic() ? .right : .left
        emirateTextField.textAlignment = AppConstants.isArabic() ? .right : .left
        addressTextField.textAlignment = AppConstants.isArabic() ? .right : .left
        genderTextField.textAlignment = AppConstants.isArabic() ? .right : .left
        
        
        
        if isEdit {
            fillChildInformation()
        }
    }
    
    func fillChildInformation() {
        firstNameTextField.text = childItem.firstName
        lastNameTextField.text = childItem.lastName
        
        birthdateTextField.text = childItem.birthdate
        
        nationalityTextField.text = AppConstants.isArabic() ?  childItem.nationalityAr : childItem.nationalityEn
        
        emirateTextField.text = AppConstants.isArabic() ?  childItem.emirateStringAr : childItem.emirateStringEn
        addressTextField.text = childItem.emiratesId
        genderTextField.text = AppConstants.isArabic() ?  childItem.genderStringAr : childItem.genderStringEn
        
        
        
        
        let string = "\(AppConstants.WEB_SERVER_IMAGE_MOCD_URL)\(childItem.child_picture )"
        let url = URL(string: string)
        profileImageView.kf.setImage(with: url, placeholder: UIImage(named: "profile") ?? UIImage())
    }
    func setupToolbar() {
        toolBar.tintColor = AppConstants.BROWN_COLOR
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        
        toolBar.sizeToFit()
        
        
        var items = [UIBarButtonItem]()
        
        /*
        items.append(
            UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(onClickedToolbeltButton(_:)))
        )
        items.append(
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace , target: self, action: nil))*/
        items.append(
            UIBarButtonItem(barButtonSystemItem: .done , target: self, action: #selector(onClickedToolbeltButton(_:)))
        )
        
        toolBar.items = items
        toolBar.backgroundColor = AppConstants.GREEN_COLOR
        
        
        genderPickerView.translatesAutoresizingMaskIntoConstraints = false
        nationalitiesPickerView.translatesAutoresizingMaskIntoConstraints = false
        emiratePickerView.translatesAutoresizingMaskIntoConstraints = false
        
        
        

        genderTextField.inputAccessoryView = toolBar
        genderTextField.inputView = genderPickerView
        //genderTextField.delegate = self

        genderTextField.text = ""
        genderTextField.isUserInteractionEnabled = true
        
        nationalityTextField.inputAccessoryView = toolBar
        nationalityTextField.inputView = nationalitiesPickerView
        //nationalitiesTextField.delegate = self

        nationalityTextField.text = ""
        nationalityTextField.isUserInteractionEnabled = true
        
        
        
        emirateTextField.inputAccessoryView = toolBar
        emirateTextField.inputView = emiratePickerView
        //nationalitiesTextField.delegate = self

        emirateTextField.text = ""
        emirateTextField.isUserInteractionEnabled = true
        
        
        
        
        
        
    }
    
    @objc func onClickedToolbeltButton(_ sender: Any){
        self.view.endEditing(true)
    }
    
    func getGenders() {
     
        WebService.getGenders { (json) in
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
    func getNationalities() {
        WebService.getNationalities { (json) in
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
            
                guard let data = json["data"] as? [String:Any] else {return}
                guard let results = data["result"] as? [[String:Any]] else {return}
                //guard let list = results["list"] as? [[String:Any]] else {return}
               
                for r in results {
                    
                    
                    let item = MOCDCountry()
                   
                    item.CountryId = String (describing: r["country_code"] ?? "" )
                    item.CountryNameAr = r["country_arName"] as! String
                    item.CountryNameEn  = r["country_enName"] as! String
                    
                    item.CountryCode = r["country_code"] as! String
                    self.countriesArray.append(item)
                }
                
                DispatchQueue.main.async {
                  
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
                    
                    
                    let emirateItem = MOCDEmirate()
                    emirateItem.id = r["id"] as! String
                    emirateItem.emirate_en = r["emirate_en"] as! String
                    emirateItem.emirate_ar = r["emirate_ar"] as! String
                    
                    self.emiratesArray.append(emirateItem)
                    
                }
                
                
                DispatchQueue.main.async {
                    
                    self.emiratePickerView.reloadAllComponents()
                }
            }
            
        }
    }
    
    func createChild() {
        
         
        //let size = CGSize(width: 30, height: 30)
            
            
            //self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        
        
        _ = RequestResponseWebServices.uploadUsingAFNetworkingFromUrl(isEdit: isEdit , childId: childItem.objectID ,parent_id: "1", first_name: self.firstName, last_name: self.lastName, nationality: self.nationalities, gender: self.gender, mobile: self.mobile, email: self.email, emirates_id: self.emiratesID, emirate: self.emirate, address: "", data_of_birth: self.birthdate, view: self.view, type: "", item: galleryItem ,completation: {json,_  in
            
            
            
            print(json)
            
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
                guard let data = json["data"] as? [String: Any] else{return}
                guard let result = data["result"] as? [String: Any] else {return}
                
                
                
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }else{
                DispatchQueue.main.async {
                    Utils.showAlertWith(title: "Error", message: message, viewController: self)
                }
            }
            
            
        })
        /*
        
        WebService.createChild(parent_id: "1", first_name: self.firstName, last_name: self.lastName, nationality: self.nationalities, gender: self.gender, mobile: self.mobile, email: self.email, emirates_id: self.emiratesID, emirate: self.emirate, address: self.address, data_of_birth: self.birthdate, child_picture: "") { (json) in
            DispatchQueue.main.async {
                self.stopAnimating(nil)
            }
             
            print(json)
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
                                           
            if code == 200 {
                guard let data = json["data"] as? [String: Any] else{return}
                guard let result = data["result"] as? [[String: Any]] else {return}
                           
                
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
                
            }else{
                DispatchQueue.main.async {
                    Utils.showAlertWith(title: "Error", message: message, viewController: self)
                }
            }
                                
            
        }*/
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
  
   
    func WWCalendarTimeSelectorShouldSelectDate(_ selector: WWCalendarTimeSelector, date: Date) -> Bool {
        
        let currdate = Date()
        if date > currdate {
            return false
        }
        
        return true
        
    }
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
        
        
        
        birthdateTextField.text = date.stringFromFormat("MM/dd/yyyy")
        self.birthdate = date.stringFromFormat("MM/dd/yyyy")
        
        
        childItem.birthdate = date.stringFromFormat("MM/dd/yyyy")
        
       
        
        let formatter = DateFormatter()
       
        formatter.dateFormat = "MM/dd/yyyy"
        formatter.locale = Locale(identifier: "en")

        let dateString = formatter.string(from: date)
        childItem.birthdate = dateString
        
        self.birthdate = dateString
        
        
        let now = Date()
        let birthday: Date = date
        let calendar = Calendar.current
        
        let ageComponents = calendar.dateComponents([.year ,.month], from: birthday, to: now)
        let age = ageComponents.year!
        let ageMonth = ageComponents.month ?? 0
        
        //ageTextField.text = String(describing: "\(age) Years and \(ageMonth) Months ")
        
        print(date)
    }

    
    @IBAction func AddChildAction(_ sender: Any) {
        checkFields()
        
    }
    
    
    func saveFleb() {
        
        /*
        let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        let childObject:PFObject =  PFObject(className:"Child")
        
        childObject["child_birthdate"] =  birthdateTextField.text ?? ""
        childObject["child_name"] = nameTextField.text ?? ""
        childObject["child_address"] = addressTextField.text ?? ""
        childObject["child_nationality"] = nationalityTextField.text ?? ""
        childObject["child_age"] = ageTextField.text ?? ""
        childObject["child_status"] = "3"
        childObject["parent"] = PFUser.current()
        if didUserChangehisImage{
            if  let userProfileUIImage = self.profileImage {
                let userProfileImageData = userProfileUIImage.pngData()
                if let userProfileImageData = userProfileImageData {
                    let userProfileImagePFfile = PFFileObject(data: userProfileImageData ,contentType:"image/jpeg")
                    childObject.setValue(userProfileImagePFfile, forKey: "picture")
                }
            }
        }
        
        
        */
        
        if isEdit {
            //Edit Object
        }else{
            //Save to DB ...

/*            childObject.saveInBackground(block: {(succeeded, error)in
                print("Finish")
                DispatchQueue.main.async {
                    self.newChild = ChildObject()
                    
       
                    self.navigationController?.popViewController(animated: true)
                    self.stopAnimating(nil)
                    
                }
            })*/
        }
        
    
        
    }
    
    
    func checkFields() {
        var isFilled = true
        
        let msg = "Please Fill all Fields"
        
        
        self.firstName  = firstNameTextField.text ?? ""
        self.lastName = lastNameTextField.text ?? ""
        self.emiratesID = addressTextField.text ?? ""

        //self.emiratesID = addressTextField.text ?? ""
       
        
        if isFilled {
            
            if isEdit {
                
                self.birthdate = childItem.birthdate
                self.gender = childItem.genderID
                self.emirate = childItem.emirateID
                self.nationalities = childItem.countryCode
                self.emiratesID = childItem.emiratesId
                
                
                createChild()
            }else{
                if self.emirate == "" || self.emirate.count == 0 {
                    self.emirate = "1"
                }
                createChild()
            }
            
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
extension AddChildViewController: UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == genderPickerView {
            return gendersArray.count
        }else if pickerView == nationalitiesPickerView{
            return countriesArray.count
        }
        else if pickerView == emiratePickerView{
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
            let item = countriesArray[row]
            let title = AppConstants.isArabic() ? item.CountryNameAr : item.CountryNameEn
            
            return title
        }
        else if pickerView == emiratePickerView{
            let item = emiratesArray[row]
            let title = AppConstants.isArabic() ? item.emirate_ar :  item.emirate_en
            
            return title
        }
        
        return ""
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == genderPickerView {
            let item = Array(gendersArray)[row]
            self.gender = item.key
            self.genderTextField.text = item.value
            childItem.genderID = item.key
        }else if pickerView == nationalitiesPickerView{
            let item = countriesArray[row]
          
            self.nationalities = item.CountryCode
            childItem.countryCode = item.CountryCode
            self.nationalityTextField.text = AppConstants.isArabic() ? item.CountryNameAr : item.CountryNameEn
            
            
            if item.CountryCode == "AE" {
                
                self.emirateTextField.isHidden = false
                self.emirateHeightConstraint.constant = 40
                
            }
            else{
                self.emirateHeightConstraint.constant = 0
                self.emirateTextField.isHidden = true
            }
        }
        else if pickerView == emiratePickerView{
            let item = emiratesArray[row]
            
              self.emirate = item.id
           
            childItem.emirateID = item.id
            self.emirateTextField.text = AppConstants.isArabic() ? item.emirate_ar :  item.emirate_en
        }
        
    }
    
}
