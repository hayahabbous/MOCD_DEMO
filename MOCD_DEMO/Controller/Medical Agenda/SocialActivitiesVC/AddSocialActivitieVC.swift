//
//  AddSocialActivitieVC.swift
//  SmartAgenda
//
//  Created by indianic on 04/01/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit

class AddSocialActivitieVC: UIViewController, MMDatePickerDelegate,UITextFieldDelegate,UITextViewDelegate{
    
    @IBOutlet weak var lblScreenTitle: UILabel!
    
    @IBOutlet weak var btnBackEN: UIButton!
    @IBOutlet var btnSaveUpdate: UIButton!
    
    @IBOutlet var txtFieldTitle: UITextField!
    @IBOutlet var txtFieldDate: UITextField!
    @IBOutlet var txtFieldTime: UITextField!
    
    @IBOutlet var txtView: UITextView!
    
    var datePicker = MMDatePicker.getFromNib()
    var dateFormatter = DateFormatter()
    var timeFormatter = DateFormatter()
    
    var isBooltime = false
    var isBoolEdit: Bool?
    
    @IBOutlet var viewAdd: UIView!
    @IBOutlet var scrlView: TPKeyboardAvoidingScrollView!
    
    
    var socialSelected: getSocialReminder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        LanguageManager().localizeThingsInView(parentView: (self.view))
        
        if AppConstants.isArabic()
        {
            btnBackEN.imageView?.transform = (btnBackEN.imageView?.transform.rotated(by: CGFloat(M_PI)))!
        }else{
            btnBackEN.imageView?.transform = (btnBackEN.imageView?.transform.rotated(by: CGFloat(M_PI*2)))!
        }
        
        setPadding()

        if isBoolEdit! {
            // Update
            btnSaveUpdate.setTitle(JMOLocalizedString(forKey: "UPDATE", value: ""), for: .normal)
            
            setSelectedData()
        }else{
            // Add
            btnSaveUpdate.setTitle(JMOLocalizedString(forKey: "ADD", value: ""), for: .normal)
        }
        
        
        if GeneralConstants.DeviceType.IS_IPAD {
            customizeFonts(in: lblScreenTitle, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtFieldTime, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtFieldDate, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtFieldTitle, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: btnSaveUpdate, aFontName: Bold, aFontSize: 0)
        }else{
            customizeFonts(in: lblScreenTitle, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtFieldTime, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtFieldDate, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtFieldTitle, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: btnSaveUpdate, aFontName: Bold, aFontSize: 0)
        }
        txtFieldTitle.delegate = self
        txtView.delegate = self
        lblScreenTitle.text = JMOLocalizedString(forKey: "ADD SOCIAL ACTIVITY", value: "")
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupDatePicker()
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Button actions
    @IBAction func btnBackENAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    /// Date button event
    ///
    /// - Parameter sender: Button reference
    @IBAction func btnDateClick(_ sender: UIButton) {
        
        if GeneralConstants.DeviceType.IS_IPAD {
            // iPad
            
            self.view.endEditing(true)
            
            MMDatePickerPopover.appearOn(originView: sender, baseViewController: self, title: "DatePicker", dateMode: .date, initialDate: Date(), maxDate: nil, timeFormat: nil, doneAction: { selectedDate in
                
                print("selectedDate \(selectedDate)")
                
                
                self.setDateOnButton(dat: selectedDate, txtField: self.txtFieldDate)
                
            },
                                         cancelAction: {
                                            print("cancel")
            })
            
            
        }else{
            // iPhone
            isBooltime = false
            
            datePicker.config.dateMode = .date
            datePicker.config.minDate = Date()
            datePicker.show(inVC: self)
            
        }
        
        
        
    }
    
    
    /// Time button event
    ///
    /// - Parameter sender: Button reference
    @IBAction func btnTimeClick(_ sender: UIButton) {
        
        if GeneralConstants.DeviceType.IS_IPAD {
            // iPad
            
            self.view.endEditing(true)
            
            MMDatePickerPopover.appearOn(originView: sender, baseViewController: self, title: "TimePicker", dateMode: .time, initialDate: Date(), maxDate: nil, timeFormat: NSLocale(localeIdentifier: "en_GB"), doneAction: { selectedDate in
                
                print("selectedDate \(selectedDate)")
                
                self.setTimeOnButton(dat: selectedDate, txtField: self.txtFieldTime)
                
            },
                                         cancelAction: {
                                            print("cancel")
            })
            
        }else{
            // iPhone
            
            isBooltime = true
            datePicker.config.dateMode = .time
            datePicker.config.timeFormat = NSLocale(localeIdentifier: "en_GB")
            datePicker.show(inVC: self)
            
        }
        
    }
    
    @IBAction func btnSaveAndUpdateClick(_ sender: UIButton) {
        if GeneralConstants.trimming(txtFieldTitle.text!) {
            if GeneralConstants.checkLength(txtFieldTitle.text!, length: kSetChar256) {
                if GeneralConstants.trimming(txtFieldDate.text!) {
                    if GeneralConstants.trimming(txtFieldTime.text!) {
                        // Insert and update DB
                        insertAndUpdateInDB()
                        
                    }else{
                        showAlert(message: JMOLocalizedString(forKey: kRequireFields, value: ""))
                    }
                }else{
                    showAlert(message: JMOLocalizedString(forKey: kRequireFields, value: ""))
                }
            }else{
                showAlert(message: JMOLocalizedString(forKey: kRequireFields, value: ""))
            }
        }else{
            showAlert(message: JMOLocalizedString(forKey: kRequireFields, value: ""))
        }
    }
    
    // MARK: - Custom Methods
    
    
    func setSelectedData() {
        
        txtFieldTitle.text = socialSelected?.title
        txtFieldDate.text = socialSelected?.date
        txtFieldTime.text = socialSelected?.reminderTime
        
        if socialSelected?.comment == JMOLocalizedString(forKey: "Add comment", value: "") {
            txtView.text = JMOLocalizedString(forKey: "Add comment", value: "")
            txtView.textColor = GeneralConstants.ColorConstants.kColor_PlaceHolder
        }else{
            txtView.text = socialSelected?.comment
            txtView.textColor = GeneralConstants.ColorConstants.kColor_Black
        }
    }
    
    func insertAndUpdateInDB() {
        
        let aObjSocialAct = socialActivitiesModel()
        let aObjReminder = ReminderModel()
        
        aObjSocialAct.title = txtFieldTitle.text
        if aObjSocialAct.title.contains("'") {
            aObjSocialAct.title.replace("'", with: "")
        }
        
        aObjSocialAct.date = txtFieldDate.text
        
        

        if JMOLocalizedString(forKey: txtView.text, value: "") == JMOLocalizedString(forKey: "Add comment", value: ""){
            // Blank
            aObjSocialAct.comment = ""
            
        }else{
            //
            aObjSocialAct.comment = txtView.text
        }

        if aObjSocialAct.comment.contains("'") {
            aObjSocialAct.comment.replace("'", with: "")
        }
        
        aObjReminder.type = 5
        aObjReminder.reminderTxt = txtFieldTitle.text
        
        if aObjReminder.reminderTxt.contains("'") {
            aObjReminder.reminderTxt.replace("'", with: "")
        }
        aObjReminder.reminderDate = txtFieldDate.text
        aObjReminder.reminderEndDate = txtFieldDate.text
        aObjReminder.reminderTime = txtFieldTime.text
        
        aObjReminder.reminderFrequency = ""
        aObjReminder.reminderWithNotification = 0
        
        aObjReminder.reminderWeaklyDay = ""
        aObjReminder.reminderMonthlyDay = ""
        
        if isBoolEdit! {
            aObjSocialAct.identifier = socialSelected?.identifier
        }
        
        if isBoolEdit! {
            socialActivity().deleteSocialActivity(deleteID: (socialSelected?.identifier)!) { (result: Bool) in
                
                UserActivityModel().deleteActivity(type: (socialSelected?.type)!, typeid: (socialSelected?.typeID)!,  userActivityDate: "", reminderID: (socialSelected?.reminderID!)!, complition: { (result: Bool) in
                })
            }
        }

        socialActivity().insertINTOSocialActivity(object: aObjSocialAct, aObjReminder: aObjReminder, isInsert: false) { (result: Bool) in
            print(result)
            
            if result {
                // Success
                
                
                if isBoolEdit! {
                    UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey:JMOLocalizedString(forKey: modificationAlert, value: ""), value: ""), completion: { (Int, String) in
                        _ = self.navigationController?.popViewController(animated: true)
                    })
                    
                }else{
                    UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey: "Addition process done successfully", value: ""), completion: { (Int, String) in
                        _ = self.navigationController?.popViewController(animated: true)
                    })
                }
                
                
            }else{
                
            }
        }
        
    }
    
    
    /// Set selected value on button
    ///
    /// - Parameters:
    ///   - dat: Selected date
    ///   - button: Button reference
    fileprivate func setDateOnButton(dat: Date, txtField: UITextField) {
        
        let aStrDate = dateFormatter.string(from: dat)
        txtField.text = aStrDate
        
    }
    
    /// Setup datepicker
    fileprivate func setupDatePicker() {
        
        datePicker.delegate = self
        dateFormatter.dateFormat = "yyyy-MM-dd"
        timeFormatter.dateFormat = "HH:mm"
        
        datePicker.config.minDate = dateFormatter.date(from: "2000-12-31")
        datePicker.config.maxDate = dateFormatter.date(from: "3000-12-31")
        datePicker.config.startDate = Date()
        
    }
    
    /// Show alert
    ///
    /// - Parameter message: Message text
    fileprivate func showAlert(message: String) {
        UIAlertController.showAlertWithOkButton(self, aStrMessage: message, completion: { (Int, String) in
            
        })
    }
    
    
    /// Set selected time on button
    ///
    /// - Parameters:
    ///   - dat: Selected time
    ///   - button: Button reference
    fileprivate func setTimeOnButton(dat: Date, txtField: UITextField) {
        
        let aStrDate = timeFormatter.string(from: dat)
        txtField.text = aStrDate
        
    }
    
    func setPadding(){
        setTextFieldPadding(textfield: txtFieldDate, padding: 5)
        setTextFieldPadding(textfield: txtFieldTime, padding: 5)
        setTextFieldPadding(textfield: txtFieldTitle, padding: 5)
        
        // Set textview border
        txtView.layer.cornerRadius = 3.0
        txtView.layer.borderColor = GeneralConstants.hexStringToUIColor(hex: "#BCBCBC").cgColor
        txtView.layer.borderWidth = 1.0
        txtView.textColor = GeneralConstants.ColorConstants.kColor_PlaceHolder
        txtView.text = JMOLocalizedString(forKey: "Add comment", value: "")
        
    }
    
    //MARK: MMDatePickerDelegate
    
    /// Date picker delegate Done event
    ///
    /// - Parameters:
    ///   - amDatePicker: Picker object
    ///   - date: Selected date
    func mmDatePicker(_ amDatePicker: MMDatePicker, didSelect date: Date) {
        
        if isBooltime {
            
            setTimeOnButton(dat: date, txtField: txtFieldTime)
            
        }else{
            
            setDateOnButton(dat: date, txtField: txtFieldDate)
        }
        
    }
    
    
    
    //MARK: MMDatePickerDelegate
    /// Date picker cancel delegate
    ///
    /// - Parameter amDatePicker: Picker object
    func mmDatePickerDidCancelSelection(_ amDatePicker: MMDatePicker) {
        // NOP
    }
    //MARK: UITextViewDelegate
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == GeneralConstants.ColorConstants.kColor_PlaceHolder {
            textView.text = nil
            textView.textColor = GeneralConstants.ColorConstants.kColor_Black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = JMOLocalizedString(forKey: "Add comment", value: "")
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
        if textView == txtView{
            if (textView.text?.count)! <= kSetChar1024  {
                let newLength = (textView.text?.count)! + text.count - range.length
                return newLength <= kSetChar1024
            }
        }
        return true
    }
    
    //MARK: UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        if textField == txtFieldTitle {
            if (textField.text?.count)! <= kSetChar256  {
                let newLength = (textField.text?.count)! + string.count - range.length
                return newLength <= kSetChar256
            }else{
                return false
            }
        }
        return true
    }
}
