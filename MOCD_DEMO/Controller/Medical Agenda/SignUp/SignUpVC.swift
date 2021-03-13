//
//  SignUpVC.swift
//  SmartAgenda
//
//  Created by indianic on 12/01/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit
import SwiftyDropbox

class SignUpVC: UIViewController, MMDatePickerDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    
    // IBOutlets
    @IBOutlet var lblNavTitle: UILabel!
    @IBOutlet var scrlView: TPKeyboardAvoidingScrollView!
    
    @IBOutlet var txtName: UITextField!
    
    @IBOutlet var btnBirthDay: UIButton!
    @IBOutlet var txtDOB: UITextField!
    
    @IBOutlet var btnBloodType: UIButton!
    @IBOutlet var txtBloodType: UITextField!
    
    @IBOutlet var txtState: UITextField!
    @IBOutlet var btnState: UIButton!
    
    @IBOutlet var txtNationality: UITextField!
    @IBOutlet var btnNationality: UIButton!
    
    @IBOutlet var txtPhoneNumber: UITextField!
    @IBOutlet var txtEmergencyNumber: UITextField!
    @IBOutlet var txtIDNumber: UITextField!
    @IBOutlet var txtHealthCNumber: UITextField!
    @IBOutlet var txtHeight: UITextField!
    @IBOutlet var txtWeight: UITextField!
    @IBOutlet var txtViewNotes: UITextView!
    
    @IBOutlet var btnFemale: UIButton!
    @IBOutlet var btnMale: UIButton!
    
    @IBOutlet var btnSignUp: UIButton!
    
    @IBOutlet var btnBack: UIButton!
    
    @IBOutlet var viewTop: UIView!
    @IBOutlet var viewUp: UIView!
    @IBOutlet var viewMiddle: UIView!
    @IBOutlet var viewBottom: UIView!
    
    @IBOutlet var lblMale: UILabel!
    @IBOutlet var lblFemale: UILabel!
    
    @IBOutlet var switchSmoker: UISwitch!
    
    @IBOutlet weak var btnBackupDropBox: UIButton!
    
    @IBOutlet var signUpBottom: NSLayoutConstraint!
    @IBOutlet var dropboxHeight: NSLayoutConstraint!
//    @IBOutlet weak var btnSignupLeadingConstraint: NSLayoutConstraint!
    
    var datePicker = MMDatePicker.getFromNib()
    var dateFormatter = DateFormatter()
    var objUserModel = userInfoModel()
    var aRRState = [String]()
    var aRRBloodType = [String]()
    var intGender = 2
    var intSmoker = 2
    var isUpdateProfile = Bool()
    
    var arrCountry_EN = [String]()
    var arrCountry_AR = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate.aDropboxBackup = 0
        currentViewContoller = self
//        btnBack.isHidden = true
       
        
        aRRState  = [JMOLocalizedString(forKey: "Emirates", value: ""),
                     JMOLocalizedString(forKey: "Abu Dhabi", value: ""),
                     JMOLocalizedString(forKey: "Dubai", value: ""),
                     JMOLocalizedString(forKey: "Sharjah", value: ""),
                     JMOLocalizedString(forKey: "Ras Al Khaimah", value: ""),
                     JMOLocalizedString(forKey: "Ajman", value: ""),
                     JMOLocalizedString(forKey: "Umm Al Qaiwain", value: ""),
                     JMOLocalizedString(forKey: "Fujerah", value: "")]
        // A, A+, B-, B+, Ab-, Ab+ ,O- and O+
        aRRBloodType = [JMOLocalizedString(forKey: "Blood Type", value: ""), "A", "A+", "B-", "B+", "Ab-", "Ab+" ,"O-", "O+"]
        
        // Set Picker
        setupDatePicker()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        btnState.setTitleColor(GeneralConstants.ColorConstants.kColor_PlaceHolder, for: .normal)
        btnNationality.setTitleColor(GeneralConstants.ColorConstants.kColor_PlaceHolder, for: .normal)
        btnBirthDay.setTitleColor(GeneralConstants.ColorConstants.kColor_PlaceHolder, for: .normal)
        btnBloodType.setTitleColor(GeneralConstants.ColorConstants.kColor_PlaceHolder, for: .normal)
        
        // To localize VC
        LanguageManager.sharedInstance.localizeThingsInView(parentView: self.view)
        
        
        if AppConstants.isArabic()
        {
            btnBack.imageView?.transform = (btnBack.imageView?.transform.rotated(by: CGFloat(M_PI)))!
        }else{
            btnBack.imageView?.transform = (btnBack.imageView?.transform.rotated(by: CGFloat(M_PI*2)))!
        }
        
        
        // Set fonts
        if GeneralConstants.DeviceType.IS_IPAD {
            
            customizeFonts(in: btnSignUp, aFontName: Bold, aFontSize: 0)
            customizeFonts(in: lblNavTitle, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtName, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtDOB, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtState, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtNationality, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtPhoneNumber, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtEmergencyNumber, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtIDNumber, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtHealthCNumber, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: lblMale, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: lblFemale, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtHeight, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtWeight, aFontName: Medium, aFontSize: 0)
            
        }else{
            customizeFonts(in: btnSignUp, aFontName: Bold, aFontSize: 0)
            customizeFonts(in: lblNavTitle, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtName, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtDOB, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtState, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtNationality, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtPhoneNumber, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtEmergencyNumber, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtIDNumber, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtHealthCNumber, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: lblMale, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: lblFemale, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtHeight, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtWeight, aFontName: Medium, aFontSize: 0)
        }
        
        txtIDNumber.delegate = self
        txtPhoneNumber.delegate = self
        txtHealthCNumber.delegate = self
        txtEmergencyNumber.delegate = self
        txtName.delegate = self
        txtWeight.delegate = self
        txtHeight.delegate = self
        txtViewNotes.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        
        let aMutCountryList = userInfoManager.sharedInstance.GetAllCountryList()
        self.arrCountry_EN.append(JMOLocalizedString(forKey: "Nationality", value: ""))
        self.arrCountry_AR.append(JMOLocalizedString(forKey: "Nationality", value: ""))
        
        if aMutCountryList.count > 0{
            
            for i in 0..<aMutCountryList.count {
                
                let objCountryListModel = aMutCountryList[i] as CountryListModel
                self.arrCountry_EN.append(objCountryListModel.country_en)
                self.arrCountry_AR.append(objCountryListModel.country_ar)
            }
        }
        
        // Set Padding in text field
        setPadding()
        
        if AppDelegate().appDelegateShared().isDropBoxUpdateFromSignup {
            isUpdateProfile = true
        }
        btnBack.isHidden = false
        if isUpdateProfile {
            btnBack.isHidden = false
            
            let userDetail  = userInfoManager.sharedInstance.GetAllUserInfoList()
            
            if userDetail.count > 0 {
                objUserModel = userDetail[0]
            }
            
            self.setUpProfileData()
            
        }
        else{
//            self.btnSignupLeadingConstraint.constant = (GeneralConstants.ScreenSize.SCREEN_WIDTH/2)+5
        }
        
        // Set navigation title
        if isUpdateProfile {
            dropboxHeight.constant = 0
            signUpBottom.constant = 0
//            btnBackupDropBox.setTitleColor(.clear, for: .normal)
            lblNavTitle.text = JMOLocalizedString(forKey: "\(kUserProfile)", value: "")
            btnSignUp.setTitle(JMOLocalizedString(forKey: "\(kUpdateProfile)", value: ""), for: .normal)
        }else{


            lblNavTitle.text = JMOLocalizedString(forKey: "\(kSignUpTitle)", value: "")
            btnSignUp.setTitle(JMOLocalizedString(forKey: "\(kSignUpTitle)", value: ""), for: .normal)
        }
        
        
        
        
        if AppDelegate().appDelegateShared().isDropBoxUpdateFromSignup {

            self.btnSignUpClick()

        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Common methods
    fileprivate func setupDatePicker() {
        
        datePicker.delegate = self
        
        datePicker.config.maxDate = Date()
        datePicker.config.startDate = Date()
        
    }
    
    func setUpProfileData(){
        var CountryTitle = String()
        
        if objUserModel.nationality != nil {
        
            let CountryID : Int = Int(objUserModel.nationality!)!
            
            
            if CountryID == 0 {
                
                CountryTitle = JMOLocalizedString(forKey: "Nationality", value: "")
                
            }else{
                if AppConstants.isArabic() {
                    CountryTitle = self.arrCountry_AR[(CountryID)]
                }else{
                    CountryTitle = self.arrCountry_EN[(CountryID)]
                }
            }
            
        }else{
            CountryTitle = JMOLocalizedString(forKey: "Nationality", value: "")
        }
        
        
        self.txtName.text = objUserModel.name
        self.txtDOB.text = objUserModel.dob
        self.txtEmergencyNumber.text = objUserModel.emergencyPhoneNumber
        
        if AppConstants.isArabic() {
            self.txtState.text = JMOLocalizedString(forKey: objUserModel.state, value: "")
        }
        else{
            let aEnglishStateTitle = getEnglishStateTitle(aArabicState: objUserModel.state)
            
            if aEnglishStateTitle != "" || aEnglishStateTitle != nil {
                self.txtState.text = aEnglishStateTitle
            }
            else{
                self.txtState.text = JMOLocalizedString(forKey: objUserModel.state, value: "")
            }
            
            
        }
        
        self.txtNationality.text = CountryTitle
        
        self.txtIDNumber.text = objUserModel.idNumber
        self.txtBloodType.text = objUserModel.bloodType
        self.txtPhoneNumber.text = objUserModel.phoneNumber
        self.txtHealthCNumber.text = objUserModel.healthCardNumber
        self.txtWeight.text = objUserModel.weight
        self.txtHeight.text = objUserModel.height
        self.txtViewNotes.text = objUserModel.notes
        
        if objUserModel.notes == "Notes" {
            self.txtViewNotes.text = JMOLocalizedString(forKey: objUserModel.notes, value: "")
        }
        
//        self.btnSignupLeadingConstraint.constant = 0
        
        dropboxHeight.constant = 0
        signUpBottom.constant = 0
//        btnBackupDropBox.setTitleColor(.clear, for: .normal)

        if objUserModel.notes!.isEmpty{
            txtViewNotes.textColor = GeneralConstants.ColorConstants.kColor_PlaceHolder
        }else{
            txtViewNotes.textColor = GeneralConstants.ColorConstants.kColor_Black
        }
        
        if objUserModel.gender != nil {
            intGender = objUserModel.gender
            if intGender == 0 {
                setImageOnRadioBtn(btn1: btnFemale, btn2: btnMale, image1: "btn-radio-filled", image2: "btn-radio")
            }else if intGender == 1 {
                setImageOnRadioBtn(btn1: btnFemale, btn2: btnMale, image1: "btn-radio", image2: "btn-radio-filled")
            }else{
                setImageOnRadioBtn(btn1: btnFemale, btn2: btnMale, image1: "btn-radio", image2: "btn-radio")
            }
        }
        
        if objUserModel.smoker != nil {
            intSmoker = objUserModel.smoker
            if intSmoker == 1 {
                self.switchSmoker.isOn = true
            }else{
                self.switchSmoker.isOn = false
            }
        }
    }
    
    func setPadding(){
        setTextFieldPadding(textfield: txtName, padding: 5)
        setTextFieldPadding(textfield: txtDOB, padding: 5)
        setTextFieldPadding(textfield: txtState, padding: 5)
        setTextFieldPadding(textfield: txtNationality, padding: 5)
        setTextFieldPadding(textfield: txtBloodType, padding: 5)
        setTextFieldPadding(textfield: txtIDNumber, padding: 5)
        setTextFieldPadding(textfield: txtPhoneNumber, padding: 5)
        setTextFieldPadding(textfield: txtHealthCNumber, padding: 5)
        setTextFieldPadding(textfield: txtEmergencyNumber, padding: 5)
        setTextFieldPadding(textfield: txtWeight, padding: 5)
        setTextFieldPadding(textfield: txtHeight, padding: 5)
        txtViewNotes.textColor = GeneralConstants.ColorConstants.kColor_PlaceHolder
        
    }
    
    func GetCountryID(aCountryTitle : String) -> Int {
        
        var aSelectedCountryID : Int = 0
        
        if aCountryTitle != JMOLocalizedString(forKey: "Nationality", value: "") {
            if AppConstants.isArabic(){
                aSelectedCountryID = self.arrCountry_AR.index(of: aCountryTitle)!
            }else{
                aSelectedCountryID = self.arrCountry_EN.index(of: aCountryTitle)!
            }
        }
        
        return aSelectedCountryID
    }
 
    
    func getEnglishStateTitle(aArabicState : String) -> String {
        
        var aEngStateName = String()
        
        if aArabicState == JMOLocalizedString(forKey: "الإمارة", value: "") {
            aEngStateName = "Emirates"
        }
        else if aArabicState == JMOLocalizedString(forKey: "أبو ظبي", value: "") {
            aEngStateName = "Abu Dhabi"
        }
        else if aArabicState == JMOLocalizedString(forKey: "دبي", value: "") {
            aEngStateName = "Dubai"
        }
        else if aArabicState == JMOLocalizedString(forKey: "الشارقة", value: "") {
            aEngStateName = "Sharjah"
        }
        else if aArabicState == JMOLocalizedString(forKey: "رأس الخيمة", value: "") {
            aEngStateName = "Ras Al Khaimah"
        }
        else if aArabicState == JMOLocalizedString(forKey: "عجمان", value: "") {
            aEngStateName = "Ajman"
        }
        else if aArabicState == JMOLocalizedString(forKey: "ام القيوين", value: "") {
            aEngStateName = "Umm Al Qaiwain"
        }
        else if aArabicState == JMOLocalizedString(forKey: "الفجيرة", value: "") {
            aEngStateName = "Fujerah"
        }
            
        else  if aArabicState == JMOLocalizedString(forKey: "Emirates", value: "") {
            aEngStateName = "Emirates"
        }
        else if aArabicState == JMOLocalizedString(forKey: "Abu Dhabi", value: "") {
            aEngStateName = "Abu Dhabi"
        }
        else if aArabicState == JMOLocalizedString(forKey: "Dubai", value: "") {
            aEngStateName = "Dubai"
        }
        else if aArabicState == JMOLocalizedString(forKey: "Sharjah", value: "") {
            aEngStateName = "Sharjah"
        }
        else if aArabicState == JMOLocalizedString(forKey: "Ras Al Khaimah", value: "") {
            aEngStateName = "Ras Al Khaimah"
        }
        else if aArabicState == JMOLocalizedString(forKey: "Ajman", value: "") {
            aEngStateName = "Ajman"
        }
        else if aArabicState == JMOLocalizedString(forKey: "Umm Al Qaiwain", value: "") {
            aEngStateName = "Umm Al Qaiwain"
        }
        else if aArabicState == JMOLocalizedString(forKey: "Fujerah", value: "") {
            aEngStateName = "Fujerah"
        }
        return aEngStateName
        
    }
    fileprivate func insertInDB() {
        
        objUserModel.name = GeneralConstants.trimming(txtName.text!) ? (txtName.text)! : ""
        objUserModel.dob = GeneralConstants.trimming(txtDOB.text!) ? (txtDOB.text)! : ""
        objUserModel.bloodType = GeneralConstants.trimming(txtBloodType.text!) ? (txtBloodType.text)! : ""
        objUserModel.state = GeneralConstants.trimming(txtState.text!) ? (txtState.text)! : ""
//        objUserModel.nationality = GeneralConstants.trimming(txtNationality.text!) ? (txtNationality.text)! : ""
        objUserModel.phoneNumber = GeneralConstants.trimming(txtPhoneNumber.text!) ? (txtPhoneNumber.text)! : ""
        objUserModel.emergencyPhoneNumber = GeneralConstants.trimming(txtEmergencyNumber.text!) ? (txtEmergencyNumber.text)! : ""
        objUserModel.healthCardNumber = GeneralConstants.trimming(txtHealthCNumber.text!) ? (txtHealthCNumber.text)! : ""
        objUserModel.idNumber = GeneralConstants.trimming(txtIDNumber.text!) ? (txtIDNumber.text)! : ""
        objUserModel.gender = intGender
        objUserModel.smoker = intSmoker
        
        objUserModel.weight = GeneralConstants.trimming(txtWeight.text!) ? (txtWeight.text!) : ""
        objUserModel.height = GeneralConstants.trimming(txtHeight.text!) ? (txtHeight.text!) : ""
        objUserModel.notes = GeneralConstants.trimming(txtViewNotes.text!) ? (txtViewNotes.text)! : ""
        
        
        
        
       let getCountryID = self.GetCountryID(aCountryTitle: GeneralConstants.trimming(txtNationality.text!) ? (txtNationality.text)! : JMOLocalizedString(forKey: "Nationality", value: ""))
        objUserModel.nationality = String(getCountryID)
        
        
        // Set name for todat extension
        let defaults: UserDefaults = UserDefaults(suiteName: smartAgendaExtension)!
        defaults.addSuite(named: smartAgendaExtension)
        defaults.set(txtName.text!, forKey: "Name")
        defaults.set(txtBloodType.text!, forKey: "BloodType")
        defaults.set(txtEmergencyNumber.text!, forKey: "EmergencyNumber")
        defaults.synchronize()
        
        
        /*
         gender not selected = 2
         female 0, male 1
         
         smoker not selected = 2
         yes 1, no 0
         */
        if isUpdateProfile {
            
            let aUserUpdateStatus =   userInfoManager.sharedInstance.UpdateUserInfoDetail(objUserInfo: objUserModel)
            
            if appDelegate.aDropboxBackup == 1 {
            
                
                UserDefaults.standard.set(true, forKey: kSignUpCompleted)
                UserDefaults.standard.synchronize()
                self.performSegue(withIdentifier: kSegueMainTab, sender: self)
                
            }else{
            
                if aUserUpdateStatus == true {
                    UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey: kprofileUpdate, value: "") , completion: { (index: Int, str: String) in
                        
                        UserDefaults.standard.set(true, forKey: kSignUpCompleted)
                        UserDefaults.standard.synchronize()
                        //
                        
//                        self.performSegue(withIdentifier: kSegueMainTab, sender: self)
                        //                    if (self.objUserModel.identifier == nil){
                        //
                        //                    }else{
                                                _ = self.navigationController?.popViewController(animated: true)
                        //                    }
                    })
                }
            }
            
        
        }else{
            userInfoManager().SignUpUser(objUserInfo: objUserModel) { (result: Bool) in
                
                if result == true {
                    
                    //                UIAlertController.showAlertWithOkButton(self, aStrMessage: ksignUpDone, completion: { (index: Int, str: String) in
                    //                    print(index)
                    //                    print(str)
                    
                    UserDefaults.standard.set(true, forKey: kSignUpCompleted)
                    UserDefaults.standard.synchronize()
                    self.performSegue(withIdentifier: kSegueMainTab, sender: self)
                    
                    
                    //                })
                }
            }
            
        }
    }
    
    
    /// Common Alert method
    ///
    /// - Parameter message: Pass alert message
    fileprivate func showAlert(message: String) {
        UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey: message, value: ""), completion: { (Int, String) in
            
        })
    }
    
    fileprivate func setDateForDOB(dat: Date) {
        
        let aStrDate = dateFormatter.string(from: dat)
        txtDOB.text = aStrDate
        
    }
    
    fileprivate func setImageOnRadioBtn(btn1: UIButton, btn2: UIButton, image1: String, image2: String) {
        
        btn1.setImage(UIImage(named: image1), for: UIControl.State.normal)
        btn2.setImage(UIImage(named: image2), for: UIControl.State.normal)
        
    }
    
    // MARK: IBActions
    
    
    @IBAction func btnBackClick(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnGenderClick(_ sender: UIButton) {
        
        if sender.tag == 100 {
            setImageOnRadioBtn(btn1: btnFemale, btn2: btnMale, image1: "btn-radio-filled", image2: "btn-radio")
            intGender = 0
        }else{
            setImageOnRadioBtn(btn1: btnFemale, btn2: btnMale, image1: "btn-radio", image2: "btn-radio-filled")
            intGender = 1
        }
    }
    
    
    @IBAction func switchSmokerClick(_ sender: UISwitch) {
        
        if sender.isOn {
            intSmoker = 1
        }else{
            intSmoker = 0
        }
    }
    
    @IBAction func btnBackupDropBoxClick(_ sender: Any) {
        // Backup to dropbox Option
        DropboxClientsManager.authorizeFromController(UIApplication.shared,
                                                      controller: self,
                                                      openURL: { (url: URL) -> Void in
                                                        if #available(iOS 10.0, *){
                                                            UIApplication.shared.open(url, options: [:], completionHandler: { (status : Bool) in
                                                                DropboxClientsManager.handleRedirectURL(url) { (authResult) in
                                                                    switch authResult {
                                                                    case .success:
                                                                        print("Success! User is logged into DropboxClientsManager.")
                                                                        currentViewContoller = self
                                                                        appDelegate.aDropboxBackup = 1
                                                                    case .cancel:
                                                                        print("Authorization flow was manually canceled by user!")
                                                                        appDelegate.aDropboxBackup = 0
                                                                    case .error(_, let description):
                                                                        print("Error: \(description)")
                                                                        appDelegate.aDropboxBackup = 0
                                                                    case .none:
                                                                        print("Error:")
                                                                    }
                                                                }
                                                                
                                                                
                                                            })
                                                        }else{
                                                            let status = UIApplication.shared.openURL(url)
                                                            DropboxClientsManager.handleRedirectURL(url) { (authResult) in
                                                                switch authResult {
                                                                case .success:
                                                                    print("Success! User is logged into DropboxClientsManager.")
                                                                    currentViewContoller = self
                                                                    appDelegate.aDropboxBackup = 1
                                                                case .cancel:
                                                                    print("Authorization flow was manually canceled by user!")
                                                                    appDelegate.aDropboxBackup = 0
                                                                case .error(_, let description):
                                                                    print("Error: \(description)")
                                                                    appDelegate.aDropboxBackup = 0
                                                                case .none:
                                                                    print("Error:")
                                                                }
                                                            }
                                                           
                                                            
                                                        }
                                                        
        })
        
    }
    @IBAction func btnSignUpClick() {
        
        if GeneralConstants.trimming((txtName?.text)!) {
            if GeneralConstants.trimming((txtDOB.text)!) {
                if GeneralConstants.trimming((txtBloodType.text)!) {
                    if GeneralConstants.checkLength(txtName.text!, length: 1024) {
                        
                        var aStrPN = txtPhoneNumber.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                        if GeneralConstants.checkLength(txtPhoneNumber.text!, length: 10) {
                            if aStrPN.count > 0 {
//                                if (aStrPN.hasPrefix("05") || aStrPN.hasPrefix("٠٥")) {
                                
                                    if conditionCheck() {
                                        // Insert into DB
                                        insertInDB()
                                    }
                                    
//                                }else{
                                    // Name is too long
//                                    showAlert(message: kInCorrectPhoneNumber)
//                                }
                            }else{
                                if conditionCheck() {
                                    // Insert into DB
                                    insertInDB()
                                }
                            }
                            
                            
                        }else{
                            // Phone number is too long
                            showAlert(message: kInCorrectPhoneNumber)
                        }
                    }else{
                        // Name is too long
                        showAlert(message: kInCorrectPhoneNumber)
                    }
                    
                }else{
                    showAlert(message: kSelectBlood)
                    
                }
            }else{
                showAlert(message: kSelectBirthDay)
                
            }
        }else{
            showAlert(message: kEnterName)
            
        }
    }
    
    
    func conditionCheck() -> Bool {
        if GeneralConstants.checkLength(txtEmergencyNumber.text!, length: 16) {
            if GeneralConstants.checkLength(txtIDNumber.text!, length: 15) {
                if GeneralConstants.checkLength(txtHealthCNumber.text!, length: 30) {
                    
                    return true
                    
                }else{
                    // Health card number is too long
                    showAlert(message: kInCorrectHealthCardNumber)
                }
            }else{
                // ID number is too long
                showAlert(message: kInCorrectIDNumber)
            }
        }else{
            // Emerency Phone number is too long
            showAlert(message: kInCorrectEmergencyNumber)
        }
        
        return true
    }
    
    
    @IBAction func btnDOBClick(_ sender: UIButton) {
        
        if GeneralConstants.DeviceType.IS_IPAD {
            // iPad
            
            self.view.endEditing(true)
            
            MMDatePickerPopover.appearOn(originView: sender, baseViewController: self, title: "DatePicker", dateMode: .date, initialDate: nil, maxDate: Date(), timeFormat: nil, doneAction: { selectedDate in
                
                print("selectedDate \(selectedDate)")
                
                self.setDateForDOB(dat: selectedDate)
                
            },
                                         cancelAction: {
                                            print("cancel")
            })
            
        }else{
            // iPhone
            datePicker.config.dateMode = .date
            
            datePicker.show(inVC: self)
            
        }
        
    }
    
    
    @IBAction func btnStateClick(_ sender: Any) {
        
        let button = sender as? UIButton
        
        self.view.endEditing(true)
        
        var kpPickerView : KPPickerView?
        kpPickerView = KPPickerView.getFromNib()
        
        kpPickerView!.show(self , sender: button , data: aRRState , defaultSelected: JMOLocalizedString(forKey: txtState.text!, value: "")) { (selectedObject , selectedIndex , isCancel) in
            
            print(selectedObject)
            
            if !isCancel {
                
                if JMOLocalizedString(forKey: self.aRRState[0], value: "") == selectedObject as? String {
                    self.txtState.text = ""
                }else{
                    self.txtState.text = selectedObject as? String
                }
            }
        }
    }
    
    @IBAction func btnNationalityClick(_ sender: Any) {
        
        let button = sender as? UIButton
        
        self.view.endEditing(true)
        
        var kpPickerView : KPPickerView?
        kpPickerView = KPPickerView.getFromNib()
        
        if AppConstants.isArabic() {
            
            kpPickerView!.show(self , sender: button , data: self.arrCountry_AR , defaultSelected: JMOLocalizedString(forKey: txtNationality.text!, value: "")) { (selectedObject , selectedIndex , isCancel) in
                
                print(selectedObject)
                
                if !isCancel {
                    
                    if JMOLocalizedString(forKey: self.arrCountry_AR[0], value: "") == selectedObject as? String {
                        self.txtNationality.text = ""
                    }else{
                        self.txtNationality.text = selectedObject as? String
                    }
//                    self.txtNationality.text = selectedObject as? String
                }
            }
        }else{
            
            
            kpPickerView!.show(self , sender: button , data: self.arrCountry_EN , defaultSelected: JMOLocalizedString(forKey: txtNationality.text!, value: "")) { (selectedObject , selectedIndex , isCancel) in
                
                print(selectedObject)
                
                if !isCancel {
                    
                    if JMOLocalizedString(forKey: self.arrCountry_EN[0], value: "") == selectedObject as? String {
                        self.txtNationality.text = ""
                    }else{
                        self.txtNationality.text = selectedObject as? String
                    }
//                    self.txtNationality.text = selectedObject as? String
                }
            }
        }
        
    }
    
    
    
    @IBAction func btnBloodTypeClick(_ sender: Any) {
        
        let button = sender as? UIButton
        self.view.endEditing(true)
        
        var kpPickerView : KPPickerView?
        kpPickerView = KPPickerView.getFromNib()
        
        kpPickerView!.show(self , sender: button , data: aRRBloodType , defaultSelected: txtBloodType.text!) { (selectedObject , selectedIndex , isCancel) in
            
            print(selectedObject)
            
            if !isCancel {
                
                if self.aRRBloodType[0] == selectedObject as? String {
                    self.txtBloodType.text = ""
                }else{
                    self.txtBloodType.text = selectedObject as? String
                }
            }
        }
    }
    
    //MARK: MMDatePickerDelegate
    func mmDatePicker(_ amDatePicker: MMDatePicker, didSelect date: Date) {
        
        setDateForDOB(dat: date)
        
    }
    
    func mmDatePickerDidCancelSelection(_ amDatePicker: MMDatePicker) {
        // NOP
    }
    
    
    //MARK: UITextViewDelegate
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.textColor == GeneralConstants.ColorConstants.kColor_PlaceHolder {
            textView.text = nil
            textView.textColor = GeneralConstants.ColorConstants.kColor_Black
        }else if (textView.text == JMOLocalizedString(forKey: "Notes", value: "")){
            textView.text = ""
            textView.textColor = GeneralConstants.ColorConstants.kColor_Black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = JMOLocalizedString(forKey: "Notes", value: "")
            textView.textColor = GeneralConstants.ColorConstants.kColor_PlaceHolder
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // Remove placeholder
        if textView.textColor == GeneralConstants.ColorConstants.kColor_PlaceHolder && text.count > 0 {
            textView.text = ""
            textView.textColor = GeneralConstants.ColorConstants.kColor_Black
        }
        
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        
        return true
    }
    
    //MARK: UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        if textField == txtPhoneNumber || textField == txtEmergencyNumber{
            if (textField.text?.count)! <= kSetChar16  {
                let newLength = (textField.text?.count)! + string.count - range.length
                return newLength <= kSetChar16
            }
        }else if textField == txtName {
            if (textField.text?.count)! <= kSetChar1024 {
                let newLength = (textField.text?.count)! + string.count - range.length
                return newLength <= kSetChar1024
            }
        }else if textField == txtHealthCNumber{
            if (textField.text?.count)! <= kSetChar30 {
                let newLength = (textField.text?.count)! + string.count - range.length
                return newLength <= kSetChar30
            }
        }else if textField == txtIDNumber{
            if (textField.text?.count)! <= kSetChar15 {
                let newLength = (textField.text?.count)! + string.count - range.length
                return newLength <= kSetChar15
            }
        }else if textField == txtWeight || textField == txtHeight {
            let newLength = (textField.text?.count)! + string.count - range.length
            return newLength <= 3 // Bool
        }

        
        return true
    }
    
    
//    //MARK:- TextField Delegate
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        guard let text = textField.text else { return true }
//        if textField == txtWeight || textField == txtHeight {
//            let newLength = text.characters.count + string.characters.count - range.length
//            return newLength <= 3 // Bool
//        }
//        return true
//    }
    
}




