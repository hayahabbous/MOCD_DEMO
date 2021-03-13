//
//  SignupVC.swift
//  Edkhar
//
//  Created by indianic on 12/01/17.
//  Copyright © 2017 demo. All rights reserved.
//

import UIKit
import SVProgressHUD
import SwiftyDropbox

class SignupVC: UIViewController,UITextFieldDelegate {
    
    var strScreenTitle : String!
    
    @IBOutlet weak var btnBackEN: UIButton!
    @IBOutlet weak var btnBackAR: UIButton!
    
    @IBOutlet weak var lblScreenTitle: UILabel!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfBirthday: UITextField!
    @IBOutlet weak var tfPhoneNumber: UITextField!
    @IBOutlet weak var tfSalary: UITextField!
    @IBOutlet weak var switchPin: UISwitch!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var btnState: UIButton!
    @IBOutlet weak var btnNationality: UIButton!
    @IBOutlet weak var btnSalaryDay: UIButton!
    @IBOutlet weak var btnSignup: UIButton!
    @IBOutlet weak var btnSignupLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var btnDropboxRestore: UIButton!
    @IBOutlet weak var imgSalaryDayArrow: UIImageView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var tfPinForSecurity: UITextField!
    @IBOutlet weak var tfConfirmPin: UITextField!
    @IBOutlet weak var viewSecurityPin: UIView!
    @IBOutlet weak var heightForRequirePinView: NSLayoutConstraint!
    
    var arrStates = [String]()
    
    var arrStates_EN = [String]()
    var arrStates_AR = [String]()
    var arrCountry_EN = [String]()
    var arrCountry_AR = [String]()
    var aMutCountryList = [CountryListModel]()
    var arrSalaryDay = [String]()
    var aGender = Int()
    var aRequirePin = Int()
    var aDropboxBackup = Int()
    
    var aUserInfoModel = userInfoModelT()
    var intSelectedCountryID = Int()
    
    @IBOutlet weak var signupScrollBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        aDropboxBackup = 0
        SVProgressHUD.show()
        
        if (ConstantsT.DeviceType.IS_IPAD) {
            
            Utility.sharedInstance.customizeFonts(in: lblScreenTitle, aFontName: Light, aFontSize: 8)
            Utility.sharedInstance.customizeFonts(in: contentView, aFontName: Medium, aFontSize: 4)
            Utility.sharedInstance.customizeFonts(in: btnSignup, aFontName: Medium, aFontSize: 4)
            Utility.sharedInstance.customizeFonts(in: btnDropboxRestore, aFontName: Medium, aFontSize: 4)
            Utility.sharedInstance.customizeFonts(in: btnNationality, aFontName: Medium, aFontSize: 0)
        }
        else{
            Utility.sharedInstance.customizeFonts(in: lblScreenTitle, aFontName: Light, aFontSize: 0)
            Utility.sharedInstance.customizeFonts(in: contentView, aFontName: Medium, aFontSize: 0)
            Utility.sharedInstance.customizeFonts(in: btnSignup, aFontName: Medium, aFontSize: 0)
            Utility.sharedInstance.customizeFonts(in: btnDropboxRestore, aFontName: Medium, aFontSize: 0)
            Utility.sharedInstance.customizeFonts(in: btnNationality, aFontName: Medium, aFontSize: 0)
        }
        
        
        LanguageManager.sharedInstance.localizeThingsInView(parentView: self.view)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        SVProgressHUD.dismiss()
        
        aMutCountryList = userInfoManagerT.sharedInstance.GetAllCountryList()
        
        if aMutCountryList.count > 0{
            
            for i in 0..<aMutCountryList.count {
                
                let objCountryListModel = aMutCountryList[i] as CountryListModel
                self.arrCountry_EN.append(objCountryListModel.country_en)
                self.arrCountry_AR.append(objCountryListModel.country_ar)
            }
        }
        
        let aMutStateList = userInfoManagerT.sharedInstance.GetAllStateList()
        
        if aMutStateList.count > 0{
            
            for i in 0..<aMutStateList.count {
                
                let objStateListModel = aMutStateList[i] as StateListModel
                self.arrStates_AR.append(objStateListModel.state_en)
                self.arrStates_EN.append(objStateListModel.state_ar)
            }
        }
        
        
        
        let aMutUserInfoList = userInfoManagerT.sharedInstance.GetAllUserInfoList()
        
        if aMutUserInfoList.count > 0 {
            
            aUserInfoModel = aMutUserInfoList.first!
        }
        
        self.setupUI()
        
        // fetch user's data from database user_info table.
        print("aUserInfoModel = \(aUserInfoModel)")
        
        if aUserInfoModel.identifier != nil{
            
            self.tfSalary.isHidden = true
            self.btnSalaryDay.isHidden = true
            self.imgSalaryDayArrow.isHidden = true
            signupScrollBottomConstraint.constant = -50
            
            tfName.text = aUserInfoModel.name
            tfBirthday.text = aUserInfoModel.dob
            tfPhoneNumber.text = aUserInfoModel.phoneNumber
            
            btnSignupLeadingConstraint.constant = 0
            btnDropboxRestore.isHidden  = true
            
            if aUserInfoModel.gender == 0 {
                btnMale.isSelected = true
                btnFemale.isSelected = false
            }else{
                btnFemale.isSelected = true
                btnMale.isSelected = false
            }
            
            if aUserInfoModel.requiredPin != nil {
                if aUserInfoModel.requiredPin == 1 {
                    switchPin.setOn(true, animated: true)
                }else{
                    switchPin.setOn(false, animated: true)
                }
                self.changePinSwitchStatus()
            }
            
            let CountryID : Int = Int(aUserInfoModel.nationality!)!
            var CountryTitle = String()
            
            if CountryID == 0 {
                
                CountryTitle = JMOLocalizedString(forKey: "Nationality", value: "")
                
            }else{
                
                for i in 0..<aMutCountryList.count {
                    
                    let objCountryListModel = aMutCountryList[i] as CountryListModel
                    if(objCountryListModel.identifier == CountryID){
                    
                        if AppConstants.isArabic() {
                            CountryTitle = objCountryListModel.country_ar
                        }else{
                            CountryTitle = objCountryListModel.country_en
                        }
                    }
                }
                
    
            }
            btnNationality.setTitle(CountryTitle, for: .normal)
            
            
            
            let StateID : Int = Int(aUserInfoModel.state!)!
            var StateTitle = String()
            
            if StateID == 0 {
                
                StateTitle = JMOLocalizedString(forKey: "Emirate", value: "")
                
            }else{
                if AppConstants.isArabic() {
                    StateTitle = self.arrStates_AR[(StateID)]
                }else{
                    StateTitle = self.arrStates_EN[(StateID)]
                }
            }
            
            print("StateTitle = \(StateTitle)")
            btnState.setTitle(StateTitle, for: .normal)
            
            tfSalary.text = aUserInfoModel.yourSalary
            
            if aUserInfoModel.salaryDay != "" {
                let arrSalaryDays = aUserInfoModel.salaryDay.components(separatedBy: "-")
                
                if arrSalaryDays.count == 3{
                    btnSalaryDay.setTitle(JMOLocalizedString(forKey: arrSalaryDays[2], value: ""), for: .normal)
                }else{
                    btnSalaryDay.setTitle(aUserInfoModel.salaryDay, for: .normal)
                }
            }
            else{
                btnSalaryDay.setTitle(JMOLocalizedString(forKey: "Salary day", value: ""), for: .normal)
            }
            
            tfPinForSecurity.text = aUserInfoModel.pinForSecurity
            tfConfirmPin.text = aUserInfoModel.pinForSecurity
            
            if aUserInfoModel.requiredPin == 1 {
                switchPin.setOn(true, animated: true)
            }else{
                switchPin.setOn(false, animated: true)
            }
            
            self.lblScreenTitle.text = JMOLocalizedString(forKey: "User Profile", value: "")
            
            btnSignup.setTitle(JMOLocalizedString(forKey: "Save", value: ""), for: .normal)
            
            if AppConstants.isArabic(){
                self.btnBackEN.isHidden = true
                self.btnBackAR.isHidden = false
            }
            else{
                self.btnBackEN.isHidden = false
                self.btnBackAR.isHidden = true
            }
            
            
            if self.aDropboxBackup == 1 {
                self.btnSignupAction(self)
            }
            
        }
        else{
            self.tfSalary.isHidden = false
            self.btnSalaryDay.isHidden = false
            self.imgSalaryDayArrow.isHidden = false
            
            self.lblScreenTitle.text = JMOLocalizedString(forKey: "Sign up", value: "")
            signupScrollBottomConstraint.constant = -111
            btnSignupLeadingConstraint.constant = 55
            btnDropboxRestore.isHidden  = false
            
            btnSignup.setTitle(JMOLocalizedString(forKey: "Sign up", value: ""), for: .normal)
            
            if AppConstants.isArabic(){
                self.btnBackEN.isHidden = true
                self.btnBackAR.isHidden = false
            }
            else{
                self.btnBackEN.isHidden = false
                self.btnBackAR.isHidden = true
            }
        }
        
        if AppDelegate().appDelegateShared().isNoBackupAvailable {
            AppDelegate().appDelegateShared().isNoBackupAvailable = false
        }
        
        SVProgressHUD.dismiss()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Utility.sharedInstance.setPaddingAndShadowForUIComponents(parentView: contentView)
        Utility.sharedInstance.setShadowForView(view: btnSalaryDay)
        Utility.sharedInstance.setShadowForView(view: btnState)
        Utility.sharedInstance.setShadowForView(view: btnNationality)
        
        SVProgressHUD.dismiss()
    }
    
    @IBAction func btnBackENAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnBackARAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func switchRequirePinAction(_ sender: Any) {
        self.changePinSwitchStatus()
    }
    
    @IBAction func btnStateAction(_ sender: Any) {
        self.view.endEditing(true)
        
        if AppConstants.isArabic() {
        
            Utility.sharedInstance.addPicker(self, onTextFieldORButton: btnState, typePicker: PickerType.SimplePicker.rawValue, pickerArray: self.arrStates_AR,showMinDate: false) { (picker,buttonindex,firstindex) in
                if (picker != nil)
                {
                    self.btnState.setTitle(self.arrStates_AR[firstindex], for: .normal)
                }
            }
        }else{
            Utility.sharedInstance.addPicker(self, onTextFieldORButton: btnState, typePicker: PickerType.SimplePicker.rawValue, pickerArray: self.arrStates_EN,showMinDate: false) { (picker,buttonindex,firstindex) in
                if (picker != nil)
                {
                    self.btnState.setTitle(self.arrStates_EN[firstindex], for: .normal)
                }
            }
        }
        
        
    }
    
    @IBAction func btnNationalityAction(_ sender: Any) {
        self.view.endEditing(true)
        
        if AppConstants.isArabic() {
            Utility.sharedInstance.addPicker(self, onTextFieldORButton: btnNationality, typePicker: PickerType.SimplePicker.rawValue, pickerArray: self.arrCountry_AR,showMinDate: false) { (picker,buttonindex,firstindex) in
                if (picker != nil)
                {
                    self.btnNationality.setTitle(self.arrCountry_AR[firstindex], for: .normal)
                    self.intSelectedCountryID = (firstindex + 1)
                }
            }
        }else{
            Utility.sharedInstance.addPicker(self, onTextFieldORButton: btnNationality, typePicker: PickerType.SimplePicker.rawValue, pickerArray: self.arrCountry_EN,showMinDate: false) { (picker,buttonindex,firstindex) in
                if (picker != nil)
                {
                    self.btnNationality.setTitle(self.arrCountry_EN[firstindex], for: .normal)
                    self.intSelectedCountryID = (firstindex + 1)
                }
            }
        }
    }
    
    @IBAction func btnGenderAction(_ sender: UIButton) {
        self.view.endEditing(true)
        if sender == btnMale {
            btnFemale.isSelected = false
            btnMale.isSelected = true
            aGender = 0
        }else{
            btnFemale.isSelected = true
            btnMale.isSelected = false
            aGender = 1
        }
    }
    
    @IBAction func btnSalaryDayAction(_ sender: Any) {
        
        self.view.endEditing(true)
        
        Utility.sharedInstance.addPicker(self, onTextFieldORButton: btnState, typePicker: PickerType.SimplePicker.rawValue, pickerArray: arrSalaryDay,showMinDate: false) { (picker,buttonindex,firstindex) in
            if (picker != nil)
            {

                self.btnSalaryDay.setTitle(self.arrSalaryDay[firstindex], for: .normal)
            }
        }
        
    }
    
    @IBAction func btnDropboxRestoreAction(_ sender: UIButton) {
        
        currentViewContoller = self
        
        // Backup to dropbox Option
        DropboxClientsManager.authorizeFromController(UIApplication.shared,
                                                      controller: self,
                                                      openURL: { (url: URL) -> Void in
                                                        
                                                        if #available(iOS 10.0, *)
                                                        {
                                                            UIApplication.shared.open(url, options: [:], completionHandler: { (status : Bool) in
                                                                
                                                                
                                                                
                                                                DropboxClientsManager.handleRedirectURL(url) { (authResult) in
                                                                    switch authResult {
                                                                    case .success:
                                                                        print("Success! User is logged into DropboxClientsManager.")
                                                                        
                                                                        currentViewContoller = self
                                                                    case .cancel:
                                                                        print("Authorization flow was manually canceled by user!")
                                                                        
                                                                        self.aDropboxBackup = 0
                                                                        
                                                                    case .error(_, let description):
                                                                        print("Error: \(description)")
                                                                        
                                                                        self.aDropboxBackup = 0
                                                                        
                                                                    case .none:
                                                                        print("Error:")
                                                                    }
                                                                }
                                                            
                                                                
                                                            })
                                                        }
                                                        else{
                                                            
                                                            let status = UIApplication.shared.openURL(url)
                                                            
                                                            
                                                            
                                                         DropboxClientsManager.handleRedirectURL(url, completion: { (result) in
                                                                switch result {
                                                                case .success:
                                                                    print("Success! User is logged into DropboxClientsManager.")
                                                                    
                                                                    
                                                                    currentViewContoller = self
                                                                    
                                                                case .cancel:
                                                                    print("Authorization flow was manually canceled by user!")
                                                                    
                                                                    self.aDropboxBackup = 0
                                                                    
                                                                case .error(_, let description):
                                                                    print("Error: \(description)")
                                                                    
                                                                    self.aDropboxBackup = 0
                                                                    
                                                                case .none:
                                                                    print("Error:")
                                                                }
                                                            })
                                                            
                                                            
                                                            
                                                        }
                                                        
        })
        
        
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
        let objCountryListModel = aMutCountryList[aSelectedCountryID] as CountryListModel
        return objCountryListModel.identifier
    }
    
    func GetStateID(aStateTitle : String) -> Int {
        
        var aSelectedStateID : Int = 0
        
        if aStateTitle != JMOLocalizedString(forKey: "Emirate", value: "") {
            if AppConstants.isArabic(){
                aSelectedStateID = self.arrStates_AR.index(of: aStateTitle)!
            }else{
                aSelectedStateID = self.arrStates_EN.index(of: aStateTitle)!
            }
        }
        
        return aSelectedStateID
    }
    
    @IBAction func btnSignupAction(_ sender: Any) {
        
        self.view.endEditing(true)
        
        if self.validateForm() {
            
            //Here I’m creating the calendar instance that we will operate with:
            let calendar = NSCalendar.init(calendarIdentifier: NSCalendar.Identifier.gregorian)
            
            //Now asking the calendar what month are we in today’s date:
            let currentMonthInt = (calendar?.component(NSCalendar.Unit.month, from: Date()))
            
            //Now asking the calendar what year are we in today’s date:
            let currentYearInt = (calendar?.component(NSCalendar.Unit.year, from: Date()))
            
            let aaStrSelectedMonth = String.init(format: "0%d",currentMonthInt!)
            let aaStrSelectedYear = String.init(format: "%d",currentYearInt!)
            
            var aSalaryDay: String = ""
            
            if (btnSalaryDay.title(for: .normal)! == JMOLocalizedString(forKey: "Salary day", value: "")){
                aSalaryDay = ""
            }else{
                aSalaryDay = String.init(format: "%@-%@-%@", aaStrSelectedYear,aaStrSelectedMonth,btnSalaryDay.title(for: .normal)!)
            }
            
            let aObjUserInfoModel = userInfoModelT()
            
            aObjUserInfoModel.name = tfName.text!
            aObjUserInfoModel.dob = tfBirthday.text!
            aObjUserInfoModel.phoneNumber = tfPhoneNumber.text!
            
            aObjUserInfoModel.gender = aGender
            let getCountryID = self.GetCountryID(aCountryTitle: btnNationality.title(for: .normal)!)
            aObjUserInfoModel.nationality = String(getCountryID)
            
            let getStateID = self.GetStateID(aStateTitle: btnState.title(for: .normal)!)
            aObjUserInfoModel.state = String(getStateID)
            
            aObjUserInfoModel.yourSalary =  Utility.sharedInstance.convertNumberToEnglish(aStr: tfSalary.text!)
            aObjUserInfoModel.salaryDay = aSalaryDay
            aObjUserInfoModel.profilePicture = ""
            
            aObjUserInfoModel.requiredPin = switchPin.isOn ? 1 : 0
            
            if switchPin.isOn{
                if Utility.sharedInstance.convertNumberToEnglish(aStr: self.tfPinForSecurity.text!) == "0" {
                    aObjUserInfoModel.pinForSecurity = "0000"
                }
                else{
                    aObjUserInfoModel.pinForSecurity = Utility.sharedInstance.convertNumberToEnglish(aStr: self.tfPinForSecurity.text!)
                }
            }else{
                aObjUserInfoModel.pinForSecurity = ""
            }
            
            
            var aUserInfoAdded : Bool = false
            var aDBSucessMsg = ""
            
            
            if aUserInfoModel.identifier == nil{
                
                //Here I’m creating the calendar instance that we will operate with:
                let calendar = NSCalendar.init(calendarIdentifier: NSCalendar.Identifier.gregorian)
                
                //Now asking the calendar what month are we in today’s date:
                let currentMonthInt = (calendar?.component(NSCalendar.Unit.month, from: Date()))
                
                //Now asking the calendar what year are we in today’s date:
                let currentYearInt = (calendar?.component(NSCalendar.Unit.year, from: Date()))
                
                let aaStrSelectedMonth = String.init(format: "0%d",currentMonthInt!)
                let aaStrSelectedYear = String.init(format: "%d",currentYearInt!)
                
                let aSalaryDay = String.init(format: "%@-%@-%@", aaStrSelectedYear,aaStrSelectedMonth,btnSalaryDay.title(for: .normal)!)
                
                // user signup - insert query for database.
                aUserInfoAdded = userInfoManagerT.sharedInstance.InsertUserInfoDetail(objUserInfo: aObjUserInfoModel)
                
                // Insert Income if User has added salary and salary day
                if (Utility.sharedInstance.validateBlank(strVal: self.tfSalary.text!) && btnSalaryDay.title(for: .normal) != JMOLocalizedString(forKey: "Salary day", value: "")) {
                    let objIncomeModel = IncomeModel()
                    objIncomeModel.income_value = Utility.sharedInstance.convertNumberToEnglish(aStr: tfSalary.text!)
                    objIncomeModel.income_type_id = 1
                    objIncomeModel.income_type_isrecurring = 1
                    objIncomeModel.income_date = aSalaryDay
                    objIncomeModel.income_note = ""
                    aUserInfoAdded = userInfoManagerT.sharedInstance.InsertIncomeDetail(objIncomeModel: objIncomeModel)
                }
                
                aDBSucessMsg = "Registration completed successfully"
                
                // Set Default System Reminders
                self.setWeeklyNotification()
                self.setMonthlyNotification()
                self.setMonthlyNotificationForBackupToDropBox()
                
            }
            else{
                aObjUserInfoModel.identifier = aUserInfoModel.identifier
                aUserInfoAdded = userInfoManagerT.sharedInstance.UpdateUserInfoDetail(objUserInfo: aObjUserInfoModel)
                
                aDBSucessMsg = "your modifications are saved successfully"
            }
            
            if self.aDropboxBackup == 1 {
                
                UserDefaults.standard.set("done", forKey: "signstatus")
                UserDefaults.standard.synchronize()
                
                self.performSegue(withIdentifier: "segueMainTab", sender: nil)
            }
            else{
                if aUserInfoAdded == true {
                    
                    let alertController = UIAlertController(title:  JMOLocalizedString(forKey: "Edkhar", value: ""), message: JMOLocalizedString(forKey: aDBSucessMsg, value: ""), preferredStyle: .alert)
                    let okAction = UIAlertAction(title: JMOLocalizedString(forKey: "OK", value: ""), style: .default, handler: { (action) in
                        
                        UserDefaults.standard.set("done", forKey: "signstatus")
                        UserDefaults.standard.synchronize()
                        
                        if self.aUserInfoModel.identifier == nil{
                            self.performSegue(withIdentifier: "segueMainTab", sender: nil)
                        }else{
                            _ = self.navigationController?.popViewController(animated: true)
                        }
                        
                    })
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                }
            }
            
            
        }
    }
    
    //MARK: UITextField Delegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        Utility.sharedInstance.removePickerView()
        if textField == tfBirthday {
            Utility.sharedInstance.addPicker(self, onTextFieldORButton: tfBirthday, typePicker: PickerType.DatePicker.rawValue, pickerArray: [],showMinDate: true) { (picker,buttonindex,firstindex) in
                if (picker != nil)
                {
                    let datePicker = picker as! UIDatePicker
                    let strTime = Utility.sharedInstance.getStringFromDate("yyyy-MM-dd", date: datePicker.date)
                    self.tfBirthday.text = strTime
                    self.tfBirthday.resignFirstResponder()
                }
                self.tfBirthday.resignFirstResponder()
            }
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == tfBirthday {
            Utility.sharedInstance.removePickerView()
        }
        
        self.view.endEditing(true)
    }
    
    //MARK: Other Methods
    
    func changePinSwitchStatus() -> Void {
        if switchPin.isOn {
            viewSecurityPin.isHidden = false
            switchPin.thumbTintColor = UIColor.colorFromRGB(R: 0, G: 132, B: 61, Alpha: 1)
            heightForRequirePinView.constant = 112
            aRequirePin = 1
        }
        else{
            switchPin.thumbTintColor = UIColor.lightGray
            viewSecurityPin.isHidden = true
            heightForRequirePinView.constant = 0
            aRequirePin = 0
        }
        
    }
 
    func validateForm() -> Bool{
        
        if !Utility.sharedInstance.validateBlank(strVal: self.tfName.text!) {
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please fill the name field", value: ""))
            return false
        }
        else if (aRequirePin == 1 && !Utility.sharedInstance.validateBlank(strVal: tfPinForSecurity.text!)){
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please enter security pin", value: ""))
            return false
        }
        else if (aRequirePin == 1 && (tfPinForSecurity.text?.count != 4)){
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Pin for security must be 4 numbers", value: ""))
            return false
        }
        else if (aRequirePin == 1 && !Utility.sharedInstance.validateBlank(strVal: tfConfirmPin.text!)){
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please fill Confirm Pin field", value: ""))
            return false
        }
        else if (aRequirePin == 1 && (tfConfirmPin.text?.count != 4)){
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Pin for security must be 4 numbers", value: ""))
            return false
        }
        else if (aRequirePin == 1 && (tfPinForSecurity.text != tfConfirmPin.text!)) {
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please check that the Pin for Security and Confirm Pin are identical", value: ""))
            return false
        }
        else if(((tfPhoneNumber.text?.count)! > 0) && (((tfPhoneNumber.text?.count)! > 16) || (tfPhoneNumber.text?.count)! < 8)){
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Incorrect phone number", value: ""))
            return false
        }
        else if ((tfSalary.text?.count)! > 7){
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "The salary field should be maximum 7 digits", value: ""))
            return false
        }
        else if (Utility.sharedInstance.validateBlank(strVal: self.tfSalary.text!) && btnSalaryDay.title(for: .normal) == JMOLocalizedString(forKey: "Salary day", value: "")) {
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please select the salary day", value: ""))
            return false
        }
        else if (!Utility.sharedInstance.validateBlank(strVal: self.tfSalary.text!) && btnSalaryDay.title(for: .normal) != JMOLocalizedString(forKey: "Salary day", value: "")) {
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please fill the salary field", value: ""))
            return false
        }
        else{
            return true
        }
    }
    /*
    func validateForm() -> Bool{
        
        if !Utility.sharedInstance.validateBlank(strVal: self.tfName.text!) && !Utility.sharedInstance.validateBlank(strVal: self.tfBirthday.text!) && !Utility.sharedInstance.validateBlank(strVal: self.tfNationality.text!) && !Utility.sharedInstance.validateBlank(strVal: self.tfPhoneNumber.text!) && !Utility.sharedInstance.validateBlank(strVal: self.tfSalary.text!) && !Utility.sharedInstance.validateBlank(strVal: self.tfPinForSecurity.text!) && !Utility.sharedInstance.validateBlank(strVal: self.tfConfirmPin.text!) && (btnState.title(for: .normal) == JMOLocalizedString(forKey: "Emirate", value: "")) && (btnSalaryDay.title(for: .normal) == JMOLocalizedString(forKey: "Salary day", value: "")){
            
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please fill all mandatory fields", value: ""))
            return false
        }
        else if !Utility.sharedInstance.validateBlank(strVal: self.tfName.text!) {
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please fill the name field", value: ""))
            return false
        }
        else if(!Utility.sharedInstance.validateBlank(strVal: self.tfBirthday.text!)){
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please fill the birthday field", value: ""))
            return false
        }
            //        else if (btnState.title(for: .normal) == JMOLocalizedString(forKey: "Emirate", value: "")){
            //            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please select emirate", value: ""))
            //            return false
            //        }
        else if(!Utility.sharedInstance.validateBlank(strVal: self.tfNationality.text!)){
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please fill the Nationality field", value: ""))
            return false
        }
        else if (aRequirePin == 1 && !Utility.sharedInstance.validateBlank(strVal: tfPinForSecurity.text!)){
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please enter security pin", value: ""))
            return false
        }
            //        else if (aRequirePin == 1 && (Float(Utility.sharedInstance.removeWhiteSpace(strVal: tfPinForSecurity.text!)) != 4)){
            //            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Security pin should be 4 digit", value: ""))
            //            return false
            //        }
        else if (aRequirePin == 1 && (tfPinForSecurity.text?.characters.count != 4)){
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Pin for security must be 4 numbers", value: ""))
            return false
        }
        else if (aRequirePin == 1 && !Utility.sharedInstance.validateBlank(strVal: tfConfirmPin.text!)){
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please fill Confirm Pin field", value: ""))
            return false
        }
        else if (aRequirePin == 1 && (tfConfirmPin.text?.characters.count != 4)){
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Pin for security must be 4 numbers", value: ""))
            return false
        }
        else if (aRequirePin == 1 && (tfPinForSecurity.text != tfConfirmPin.text!)) {
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please check that the Pin for Security and Confirm Pin are identical", value: ""))
            return false
        }
        else if((((tfPhoneNumber.text?.characters.count)! > 16) && (tfPhoneNumber.text?.characters.count)! < 8)){
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Incorrect phone number", value: ""))
            return false
        }
        else if(!Utility.sharedInstance.validateBlank(strVal: tfSalary.text!)){
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please fill the salary field", value: ""))
            return false
        }
        else if ((tfSalary.text?.characters.count)! > 16){
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "The salary field should be maximum 16 digits", value: ""))
            return false
        }
        else if (btnSalaryDay.title(for: .normal) == JMOLocalizedString(forKey: "Salary day", value: "")){
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please select the salary day", value: ""))
            return false
        }
        else{
            return true
        }
    }
    */
    func setupUI(){
        
        btnMale.isSelected = true
        switchPin.isOn = false
        aGender = 1
        aRequirePin = 0
        heightForRequirePinView.constant = 0
        viewSecurityPin.isHidden = true
        
//        arrStates = [JMOLocalizedString(forKey: "Emirate", value: ""),JMOLocalizedString(forKey: "Abu Dhabi", value: ""), JMOLocalizedString(forKey: "Dubai", value: ""), JMOLocalizedString(forKey: "Sharjah", value: ""), JMOLocalizedString(forKey: "Ras Al Khaimah", value: ""), JMOLocalizedString(forKey: "Ajman", value: ""), JMOLocalizedString(forKey: "Umm Al Qaiwain", value: ""),JMOLocalizedString(forKey: "Fujerah", value: "")]
        
        self.arrStates_EN = ["Emirate","Abu Dhabi","Dubai","Sharjah","Ras Al Khaimah","Ajman","Umm Al Qaiwain","Fujerah"]
        
        self.arrStates_AR = ["الإمارة","أبو ظبي","دبي","الشارقة","رأس الخيمة","عجمان","ام القيوين","الفجيرة"]
        
        
        
        arrSalaryDay.append(JMOLocalizedString(forKey: "Salary day", value: ""))
        
        
        for i in 1...31 {
            if i < 10 {
                arrSalaryDay.append(String.init(format: "0%d", i))
            }else{
                arrSalaryDay.append(String(i))
            }
        }
        
        
        if AppConstants.isArabic() {
            btnState.contentHorizontalAlignment = .right
            btnSalaryDay.contentHorizontalAlignment = .right
            btnNationality.contentHorizontalAlignment = .right
            btnState.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
            btnSalaryDay.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
            btnNationality.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
            
            // Image and Title Inset For Gender Buttons
            let spacing: CGFloat = -20
            btnMale.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
            btnFemale.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
            
        }
        else{
            btnState.contentHorizontalAlignment = .left
            btnSalaryDay.contentHorizontalAlignment = .left
            btnNationality.contentHorizontalAlignment = .left
            
            btnState.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            btnSalaryDay.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            btnNationality.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            
            // Image and Title Inset For Gender Buttons
            let spacing: CGFloat = 10
            btnMale.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
            btnFemale.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: spacing)
            
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        if textField == tfPhoneNumber {
             if (string.isNumeric){
                let newLength = text.count + string.count - range.length
                return newLength <= 16 // Bool
             }else{
                return false;
            }
        }
        else if textField == tfPinForSecurity{
            if (string.isNumeric){
                let newLength = text.count + string.count - range.length
                return newLength <= 4 // Bool    return true
            }else{
                return false
            }
        }
        else if textField == tfConfirmPin{
            if (string.isNumeric){
                let newLength = text.count + string.count - range.length
                return newLength <= 4 // Bool    return true
            }else{
                return false
            }
        }
        else if textField == tfSalary{
            if (string.isNumeric){
                let newLength = text.count + string.count - range.length
                return newLength <= 7 // Bool    return true
            }else{
                return false
            }
        }
        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueMainTab" {
            let objCommanVC: CommanVC = segue.destination as! CommanVC
            if (!Utility.sharedInstance.validateBlank(strVal: self.tfSalary.text!) && btnSalaryDay.title(for: .normal) == JMOLocalizedString(forKey: "Salary day", value: "") && aUserInfoModel.identifier == nil) {
                objCommanVC.isIncomeNotAdded = true
            }
            else{
                objCommanVC.isIncomeNotAdded = false
            }
        }
    }
    
    //MARK:- Set Weekly Reminder
    func setWeeklyNotification() {
        LocalNotificationHelperT.sharedInstance.createReminderNotification("Weekly-AddSpending",JMOLocalizedString(forKey: "Edkhar", value: ""), JMOLocalizedString(forKey: "Don’t forget to add your spending and saving this week", value: ""), weekDay: 1, monthDay: 0, hour: 10, minute: 0, seconds: 0, notificationDate: Date(), NotificationType.Weekly)
    }
    
    //MARK:- Set Monthly Reminder
    func setMonthlyNotification() {
        LocalNotificationHelperT.sharedInstance.createReminderNotification("Monthly-AddSaving", JMOLocalizedString(forKey: "Edkhar", value: ""), JMOLocalizedString(forKey: "Don’t forget your financial targets, add saving to it now!", value: ""), weekDay: 0, monthDay: 1, hour: 10, minute: 0, seconds: 0, notificationDate: Date(), NotificationType.Monthly)
    }
    
    //MARK:- Set Monthly Reminder For Backup To DropBox
    func setMonthlyNotificationForBackupToDropBox() {
        LocalNotificationHelperT.sharedInstance.createReminderNotification("Monthly-BackupDropBox", JMOLocalizedString(forKey: "Edkhar", value: ""), JMOLocalizedString(forKey: "Don’t forget to back up your data to dropbox from the application side menu, don’t lose your data", value: ""), weekDay: 0, monthDay: 1, hour: 10, minute: 1, seconds: 0, notificationDate: Date(), NotificationType.Monthly)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
