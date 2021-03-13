

//
//  AddAppointmentVC.swift
//  SmartAgenda
//
//  Created by indianic on 03/01/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit

enum Recurring: String {
    case DailyRecurr = "Daily"
    case WeeklyRecurr = "Weekly"
    case MonthlyRecurr = "Monthly"
}
/*

enum WeekDay: Int {
    case Sunday = 1
    case Monday = 2
    case Tuesday = 3
    case Wednesday = 4
    case Thursday = 5
    case Friday = 6
    case Saturday = 7
    
}*/

class AddAppointmentVC: UIViewController, MMDatePickerDelegate ,UITextFieldDelegate,UITextViewDelegate {
    
    @IBOutlet weak var lblScreenTitle: UILabel!
    
    @IBOutlet weak var btnBackEN: UIButton!
    @IBOutlet var btnSaveDelete: UIButton!
    
    @IBOutlet var txtFieldAppointmentName: UITextField!
    @IBOutlet var txtFieldDoctorName: UITextField!
    @IBOutlet var txtFieldClinicName: UITextField!
    @IBOutlet var txtViewNotes: UITextView!
    @IBOutlet var txtFieldDate: UITextField!
    @IBOutlet var txtFieldRecurring: UITextField!
    @IBOutlet var txtFieldTime: UITextField!
    @IBOutlet var txtFieldDay: UITextField!
    @IBOutlet var txtEndDate: UITextField!
    
    @IBOutlet var switchRecurring: UISwitch!
    @IBOutlet var switchReminder: UISwitch!
    
    @IBOutlet weak var lowerView: UIView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet var viewMonth: UIView!
    
    @IBOutlet var scrlView: TPKeyboardAvoidingScrollView!
    
    @IBOutlet weak var heightConstraintRecurringView: NSLayoutConstraint!
    @IBOutlet weak var lowerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var heightTimeConstraint: NSLayoutConstraint!
    
    @IBOutlet var heightEndDate: NSLayoutConstraint!
    @IBOutlet var lblReminderStatic: UILabel!
    
    @IBOutlet var lblRecurringStatic: UILabel!
    

    var datePicker = MMDatePicker.getFromNib()
    var dateFormatter = DateFormatter()
    var dateSelectedFormatter = DateFormatter()
    var timeFormatter = DateFormatter()
    
    var aRRFrequency = [String]()
    var aRRRecurring = [String]()
    var aRRWeekDay = [String]()
    var aRRMonth = [String]()
    
    var isBooltime = false
    
    var selectedDateTime: Date?
    var selectedEndDate: Date?
    var selectedDay: Int?
    var appointmentSelected: getAppointmentReminder?
    var isBoolEdit: Bool? = false
    var isBoolUpdate: Bool? = false
    var strInsertRecurring = String()
    var strinsertFrequency = String()
    var strForCancelNotification: String?
    var boolEndDate = Bool()
    let aObjAppointment = appointmentModel()
    let aObjReminder = ReminderModel()
    
    var isReminderOn: Bool = false
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        btnSaveDelete.isEnabled = true
         isReminderOn = UserDefaults().bool(forKey: "ReminderSwitch")
        
        setPadding()
        
        LanguageManager().localizeThingsInView(parentView: (self.view))
        
        
        
        if GeneralConstants.DeviceType.IS_IPAD {
            customizeFonts(in: lblScreenTitle, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtFieldDate, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtFieldDay, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtFieldTime, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtViewNotes, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtFieldRecurring, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtFieldClinicName, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtFieldDoctorName, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtFieldAppointmentName, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtEndDate, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: lblReminderStatic, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: btnSaveDelete, aFontName: Bold, aFontSize: 0)
            customizeFonts(in: lblRecurringStatic, aFontName: Medium, aFontSize: 0)
        }else{
            customizeFonts(in: lblScreenTitle, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtFieldDate, aFontName: Medium, aFontSize:0)
            customizeFonts(in: txtFieldDay, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtFieldTime, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtViewNotes, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtFieldRecurring, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtFieldClinicName, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtFieldDoctorName, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtFieldAppointmentName, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtEndDate, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: lblReminderStatic, aFontName: Medium, aFontSize:0)
            customizeFonts(in: btnSaveDelete, aFontName: Bold, aFontSize: 0)
            customizeFonts(in: lblRecurringStatic, aFontName: Medium, aFontSize: 0)
        }
        
        
        
        if isBoolEdit! {
            
            self.appointmentAddOrUpdate()
            isBoolEdit = false
            isBoolUpdate = true
            
            btnSaveDelete.setTitle(JMOLocalizedString(forKey: "UPDATE", value: ""), for: .normal)
            self.lblScreenTitle.text = JMOLocalizedString(forKey: kEditAppointment, value: "")
        }else{
            heightConstraintRecurringView.constant = 0
            heightEndDate.constant = 0
            btnSaveDelete.setTitle(JMOLocalizedString(forKey: "ADD", value: ""), for: .normal)
            self.lblScreenTitle.text = JMOLocalizedString(forKey: kAddAppointment, value: "")
        }
        
        txtFieldAppointmentName.delegate = self
        txtFieldDoctorName.delegate = self
        txtFieldClinicName.delegate = self
        txtViewNotes.delegate = self
    
        txtFieldTime.placeholder = JMOLocalizedString(forKey: "Time*", value: "") 
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Common Methods
    
    func setPadding(){
        setTextFieldPadding(textfield: txtFieldDate, padding: 5)
        setTextFieldPadding(textfield: txtFieldTime, padding: 5)
        setTextFieldPadding(textfield: txtFieldDay, padding: 5)
        setTextFieldPadding(textfield: txtFieldRecurring, padding: 5)
        setTextFieldPadding(textfield: txtFieldClinicName, padding: 5)
        setTextFieldPadding(textfield: txtFieldDoctorName, padding: 5)
        setTextFieldPadding(textfield: txtFieldAppointmentName, padding: 5)
        setTextFieldPadding(textfield: txtEndDate, padding: 5)
        
        // Set textview border
        txtViewNotes.layer.cornerRadius = 3.0
        txtViewNotes.layer.borderColor = GeneralConstants.hexStringToUIColor(hex: "#BCBCBC").cgColor
        txtViewNotes.layer.borderWidth = 1.0
        txtViewNotes.textColor = GeneralConstants.ColorConstants.kColor_PlaceHolder
        txtViewNotes.text = JMOLocalizedString(forKey: "Note", value: "")
        
    }
    
    fileprivate func appointmentAddOrUpdate() {
        
        
        // Title, Doctor, Clinic
        txtFieldAppointmentName.text = appointmentSelected?.title
        strForCancelNotification = "\((appointmentSelected?.identifier!)!)"
        txtFieldDoctorName.text = appointmentSelected?.doctorName
        txtFieldClinicName.text = appointmentSelected?.clinicName
        
        txtFieldTime.text = appointmentSelected?.reminderTime
        selectedDateTime  =  dateSelectedFormatter.date(from: "2000-12-31 00:\(txtFieldTime.text!)")
        
       
        txtEndDate.text = appointmentSelected?.reminderEndDate
        
        if appointmentSelected?.reminderWithNotification == 1{
            
            switchReminder.isOn = true
        }
        
        if appointmentSelected?.note == JMOLocalizedString(forKey: "Note", value: "") {
            txtViewNotes.text = JMOLocalizedString(forKey: "Note", value: "")
            txtViewNotes.textColor = GeneralConstants.ColorConstants.kColor_PlaceHolder
        }else{
            txtViewNotes.text = appointmentSelected?.note
            txtViewNotes.textColor = GeneralConstants.ColorConstants.kColor_Black
            
        }
        
        if appointmentSelected?.reminderFrequency == nil || appointmentSelected?.reminderFrequency  == ""
        {
            
            txtFieldRecurring.text = JMOLocalizedString(forKey: aRRRecurring[0], value: "")
            
            lowerView.isHidden = false
            dateView.isHidden = false
            lowerViewHeightConstraint.constant = 200
            heightConstraintRecurringView.constant = 0
            heightEndDate.constant = 0
            
        }else{
            
            txtFieldRecurring.text =  JMOLocalizedString(forKey:  (appointmentSelected?.reminderFrequency)!, value: "")
            lowerView.isHidden = true
            lowerViewHeightConstraint.constant = 0
            dateView.isHidden = true
            
//            strInsertRecurring = txtFieldRecurring.text!
            strInsertRecurring = (appointmentSelected?.reminderFrequency)!
            if (JMOLocalizedString(forKey: (appointmentSelected?.reminderFrequency)!, value: "").contains(JMOLocalizedString(forKey: Recurring.DailyRecurr.rawValue, value: ""))) {
                self.heightConstraintRecurringView.constant = 0
                self.lowerViewHeightConstraint.constant = 200
                self.heightTimeConstraint.constant = 50
                self.lowerView.isHidden = false
                
                self.viewMonth.isHidden = true
                
            }else if (JMOLocalizedString(forKey: (appointmentSelected?.reminderFrequency)!, value: "").contains(JMOLocalizedString(forKey: Recurring.WeeklyRecurr.rawValue, value: ""))) {
                
                weeklyAndMonthRecurrUI()
                
                txtFieldDay.text =  JMOLocalizedString(forKey:  (appointmentSelected?.reminderWeaklyDay)!, value: "")
                
                switch JMOLocalizedString(forKey: txtFieldDay.text!, value: "") {
                    
                case JMOLocalizedString(forKey: aRRWeekDay[1], value: ""):
                    self.selectedDay = WeekDay.Sunday.rawValue
                    self.strinsertFrequency = "Sunday"
                case JMOLocalizedString(forKey: aRRWeekDay[2], value: ""):
                    self.selectedDay = WeekDay.Monday.rawValue
                    self.strinsertFrequency = "Monday"
                case JMOLocalizedString(forKey: aRRWeekDay[3], value: ""):
                    self.selectedDay = WeekDay.Tuesday.rawValue
                    self.strinsertFrequency = "Tuesday"
                case JMOLocalizedString(forKey: aRRWeekDay[4], value: ""):
                    self.selectedDay = WeekDay.Wednesday.rawValue
                    self.strinsertFrequency = "Wednesday"
                case JMOLocalizedString(forKey: aRRWeekDay[5], value: ""):
                    self.selectedDay = WeekDay.Thursday.rawValue
                    self.strinsertFrequency = "Thursday"
                case JMOLocalizedString(forKey: aRRWeekDay[6], value: ""):
                    self.selectedDay = WeekDay.Friday.rawValue
                    self.strinsertFrequency = "Friday"
                case JMOLocalizedString(forKey: aRRWeekDay[7], value: ""):
                    self.selectedDay = WeekDay.Saturday.rawValue
                    self.strinsertFrequency = "Saturday"
                default :
                    print("")
                }
                
            }else if (JMOLocalizedString(forKey: (appointmentSelected?.reminderFrequency)!, value: "").contains(JMOLocalizedString(forKey: Recurring.MonthlyRecurr.rawValue, value: "") )) {
                weeklyAndMonthRecurrUI()
                
                txtFieldDay.text =  JMOLocalizedString(forKey:  (appointmentSelected?.reminderMonthlyDay)!, value: "")
                selectedDay = Int((appointmentSelected?.reminderMonthlyDay)!)
            }
            switchRecurring.isOn = true
        }
        
        
        txtFieldDate.text = appointmentSelected?.reminderDate
        
        
        
        
    }
    
    private func weeklyAndMonthRecurrUI() {
        self.heightConstraintRecurringView.constant = 53
        self.lowerViewHeightConstraint.constant = 200
        self.heightTimeConstraint.constant = 50
        self.lowerView.isHidden = false
        
        self.viewMonth.isHidden = false
    }
    
    /// Default initial setup
    fileprivate func setUp() {
        
        if AppConstants.isArabic()
        {
            btnBackEN.imageView?.transform = (btnBackEN.imageView?.transform.rotated(by: CGFloat(M_PI)))!
        }else{
            btnBackEN.imageView?.transform = (btnBackEN.imageView?.transform.rotated(by: CGFloat(M_PI*2)))!
        }
        
        self.navigationController?.isNavigationBarHidden = true
        
        self.lblScreenTitle.text = JMOLocalizedString(forKey: kAddAppointment, value: "")
        
        
        
        // Set Picker
        setupDatePicker()
        
        aRRFrequency = [JMOLocalizedString(forKey: "Frequency", value: ""),"1 day before", "2 day before", "A week before"]
        aRRRecurring = [JMOLocalizedString(forKey: "Recurring", value: ""), JMOLocalizedString(forKey: Recurring.DailyRecurr.rawValue, value: "") , JMOLocalizedString(forKey: Recurring.WeeklyRecurr.rawValue, value: ""), JMOLocalizedString(forKey: Recurring.MonthlyRecurr.rawValue, value: "")]
        aRRWeekDay = [JMOLocalizedString(forKey: "Select Day", value: ""),
                      JMOLocalizedString(forKey: "Sunday", value: ""),
                      JMOLocalizedString(forKey: "Monday", value: ""),
                      JMOLocalizedString(forKey: "Tuesday", value: ""),
                      JMOLocalizedString(forKey: "Wednesday", value: ""),
                      JMOLocalizedString(forKey: "Thursday", value: ""),
                      JMOLocalizedString(forKey: "Friday", value: ""),
                      JMOLocalizedString(forKey: "Saturday", value: "")]
        
        
        aRRMonth = [JMOLocalizedString(forKey: "Select Day", value: ""),"1", "2", "3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18",
                    "19","20","21","22","23","24","25","26","27","28"]
        
        heightConstraintRecurringView.constant = 0
        
        switchRecurring.setOn(false, animated: true)
        switchReminder.setOn(false, animated: true)
        
        LanguageManager.sharedInstance.localizeThingsInView(parentView: scrlView)
        
    }
    
    /// Setup datepicker
    fileprivate func setupDatePicker() {
        
        datePicker.delegate = self
        dateSelectedFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        dateSelectedFormatter.locale = Locale(identifier: "en_US_POSIX")
        if AppConstants.isArabic() {
            dateSelectedFormatter.locale = NSLocale(localeIdentifier: "ar") as Locale?
        
        }else{
            dateSelectedFormatter.locale = NSLocale(localeIdentifier: "en") as Locale?
        }
        
//        dateSelectedFormatter.timeZone = NSTimeZone(abbreviation: "IST") as TimeZone!
//        dateSelectedFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = "yyyy-MM-dd"
        timeFormatter.dateFormat = "HH:mm"
        
        datePicker.config.minDate = dateFormatter.date(from: "2000-12-31")
        datePicker.config.maxDate = dateFormatter.date(from: "3000-12-31")
        datePicker.config.startDate = Date()
        
    }
    
    
    /// Set selected value on button
    ///
    /// - Parameters:
    ///   - dat: Selected date
    ///   - button: Button reference
    fileprivate func setDateOnButton(dat: Date, txtField: UITextField) {
        
//        if AppConstants.isArabic() {
//            dateFormatter.locale = NSLocale(localeIdentifier: "ar") as Locale!
//        }else{
//            dateFormatter.locale = NSLocale(localeIdentifier: "en") as Locale!
//        }
        let aStrDate = dateFormatter.string(from: dat)
        
        txtField.text = aStrDate
        
    }
    
    /// Set selected time on button
    ///
    /// - Parameters:
    ///   - dat: Selected time
    ///   - button: Button reference
    fileprivate func setTimeOnButton(dat: Date, txtField: UITextField) {
        
        if AppConstants.isArabic() {
            timeFormatter.locale = NSLocale(localeIdentifier: "ar") as Locale?
        }else{
            timeFormatter.locale = NSLocale(localeIdentifier: "en") as Locale?
        }
        let aStrDate = timeFormatter.string(from: dat)
        txtField.text = aStrDate
        
        
    }
    
    /// Open picker common method
    typealias pickerComplition = (_ selectedObject: Any , _ objectIndex: Int , _ isCancel : Bool) -> Void
    
    fileprivate func openPicker(array:[String], sender: UITextField, completion:@escaping (pickerComplition)) {
        
        var kpPickerView : KPPickerView?
        kpPickerView = KPPickerView.getFromNib()
        
        kpPickerView!.show(self , sender: sender , data: array , defaultSelected: sender.text!) { (selectedObject , selectedIndex , isCancel) in
            
            print(selectedObject)
            
            if !isCancel {
                completion(selectedObject , selectedIndex , isCancel)
            }
        }
        
    }
    
    /// Check reminder switch is on or off
    fileprivate func checkReminderSwich() {
        if switchReminder.isOn {
            
            if GeneralConstants.trimming(txtFieldTime.text!) {
                insertAppointment()
            }else{
                showAlert(message: JMOLocalizedString(forKey: kEnterAppointment, value: ""))
            }
            
        }else{
            insertAppointment()
        }
    }
    
    
    /// Check if recurring is selected then any recurring type is selected
    fileprivate func checkRecurringIsSelected() {
        
        if switchRecurring.isOn {
            
            if (txtFieldRecurring.text?.contains(aRRRecurring[0]))! {
                showAlert(message: JMOLocalizedString(forKey: kEnterAppointment, value: ""))
            }
            else if (txtFieldRecurring.text == "") {
                showAlert(message: JMOLocalizedString(forKey: kEnterAppointment, value: ""))
            }
            else if (txtFieldTime.text  == "") {
                showAlert(message: JMOLocalizedString(forKey: kEnterAppointment, value: ""))
            }
            else if (txtEndDate.text  == "") {
                showAlert(message: JMOLocalizedString(forKey: kEnterAppointment, value: ""))
            }
            else{
                // Check recurring data
                
                if txtFieldRecurring.text! == JMOLocalizedString(forKey: Recurring.WeeklyRecurr.rawValue, value: "")  {
                    // Weekly
                    if txtFieldDay.text == "" {
                        showAlert(message: JMOLocalizedString(forKey: kEnterAppointment, value: ""))
                        
                    }else{
                        checkReminderSwich()
                    }
                }
                else if txtFieldRecurring.text! == JMOLocalizedString(forKey: Recurring.MonthlyRecurr.rawValue, value: "")  {
                    // Monthly
                    if txtFieldDay.text == "" {
                        showAlert(message: JMOLocalizedString(forKey: kEnterAppointment, value: ""))
                        
                    }else{
                        checkReminderSwich()
                    }
                    
                }else{
                    // daily
                    checkReminderSwich()
                }
            }
        }
    }
    
    /// Show alert
    ///
    /// - Parameter message: Message text
    fileprivate func showAlert(message: String) {
          btnSaveDelete.isEnabled = true
        UIAlertController.showAlertWithOkButton(self, aStrMessage: message, completion: { (Int, String) in
            
        })
    }
    
    /// Insert appointment in DB
    fileprivate func insertAppointment() {
        
        
        aObjAppointment.title = txtFieldAppointmentName.text
        if aObjAppointment.title.contains("'") {
            aObjAppointment.title.replace("'", with: "")
        }
        
        aObjAppointment.doctorName = txtFieldDoctorName.text
        if aObjAppointment.doctorName.contains("'") {
            aObjAppointment.doctorName.replace("'", with: "")
        }
        aObjAppointment.clinicName = txtFieldClinicName.text
        if aObjAppointment.clinicName.contains("'") {
            aObjAppointment.clinicName.replace("'", with: "")
        }
        aObjReminder.reminderEndDate = ""
        if txtFieldTime.text == nil { aObjReminder.reminderTime = "" }else{ aObjReminder.reminderTime = txtFieldTime.text }
        
        if txtFieldDate.text == nil || txtFieldDate.text?.count == 0{
            aObjReminder.reminderDate = dateFormatter.string(from: Date())
            aObjAppointment.date = dateFormatter.string(from: Date())

        }
        else
        {
            aObjReminder.reminderDate = txtFieldDate.text
            aObjAppointment.date = txtFieldDate.text
        }
        
    
        if switchRecurring.isOn {
            if txtEndDate.text == nil { aObjReminder.reminderEndDate = "" }else{ aObjReminder.reminderEndDate = txtEndDate.text }
        }else{
            aObjReminder.reminderEndDate = txtFieldDate.text
        }

        
        if JMOLocalizedString(forKey: txtViewNotes.text, value: "") == JMOLocalizedString(forKey: "Note", value: "") {
            aObjAppointment.note = ""
        }else{
            aObjAppointment.note = txtViewNotes.text
        }
        
        if aObjAppointment.note.contains("'") {
            aObjAppointment.note.replace("'", with: "")
        }

        
        if switchRecurring.isOn {
//            aObjReminder.reminderDate = ""
            
            if txtFieldRecurring.text == JMOLocalizedString(forKey: Recurring.DailyRecurr.rawValue, value: "") {
                // Daily
                aObjReminder.reminderFrequency = strInsertRecurring
                aObjReminder.reminderTime = txtFieldTime.text
                
            }else if txtFieldRecurring.text == JMOLocalizedString(forKey: Recurring.WeeklyRecurr.rawValue, value: "") {
                // Weekly
                aObjReminder.reminderFrequency = strInsertRecurring
                aObjReminder.reminderWeaklyDay = strinsertFrequency
                
            }
            else if txtFieldRecurring.text == JMOLocalizedString(forKey: Recurring.MonthlyRecurr.rawValue, value: "") {
                // Monthly
                aObjReminder.reminderFrequency = strInsertRecurring
                aObjReminder.reminderMonthlyDay = txtFieldDay.text
                
            }
//            aObjReminder.reminderDate = ""
//            aObjAppointment.date = ""
            
        }else{
            aObjReminder.reminderFrequency = ""
            aObjReminder.reminderDate = aObjAppointment.date
            aObjReminder.reminderWeaklyDay = ""
            aObjReminder.reminderMonthlyDay = ""
            
        }
        
        
        aObjReminder.reminderWithNotification = switchReminder.isOn ? 1 : 0
        
        if switchReminder.isOn {
            aObjReminder.reminderWithNotification =  1
        }else{
            aObjReminder.reminderWithNotification =  0
        }
        
        // will occure condition on update
        if isBoolUpdate! {
            aObjAppointment.identifier = appointmentSelected?.identifier
        }
        
        aObjReminder.reminderTxt = aObjAppointment.title
        aObjReminder.type = 4
        
        
        if isBoolUpdate! {
            deleteAppointment()
        }else{
            insertIntoTable()
        }
    
    }
    
    @objc func insertIntoTable() {
        _ = appointmentModel().insertAppointment(objAppointment: aObjAppointment, aObjReminder: aObjReminder, flageUpdate: false) { (success: Bool) in
            if success {
                
                if !isBoolUpdate! {
                    strForCancelNotification = "0"
                }
                if switchReminder.isOn {
                    
                    cancelNotification(str: strForCancelNotification!, complition: { (Void) in
                        if switchReminder.isOn {
                            
                            
                            appointmentModel().getMaxCount(complitionCount: { (count: String) in
                                setNotifiction(notificationID: count)
                            })
                        }
                        
                        selectedDay = nil
                        selectedDateTime = nil
                        
                        if isBoolUpdate! {
                            UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey:JMOLocalizedString(forKey: modificationAlert, value: ""), value: ""), completion: { (Int, String) in
                                _ = self.navigationController?.popViewController(animated: true)
                            })
                            
                        }else{
                            UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey: "Addition process done successfully", value: ""), completion: { (Int, String) in
                                _ = self.navigationController?.popViewController(animated: true)
                            })
                            
                        }
                    })
                }else{
                    cancelNotification(str: strForCancelNotification!, complition: { (Void) in
                        
                    })
                    
                    selectedDay = nil
                    selectedDateTime = nil
                    
                    if isBoolUpdate! {
                        UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey:JMOLocalizedString(forKey: modificationAlert, value: ""), value: ""), completion: { (Int, String) in
                            _ = self.navigationController?.popViewController(animated: true)
                        })
                        
                    }else{
                    UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey: "Addition process done successfully", value: ""), completion: { (Int, String) in
                        _ = self.navigationController?.popViewController(animated: true)
                    })
                        
                    }
                }
                
                
            }
            
        }

    }
    private func deleteAppointment() {
        
        UserActivityModel().deleteActivity(type: (appointmentSelected?.type)!, typeid: (appointmentSelected?.typeID)!,  userActivityDate: "", reminderID: (appointmentSelected?.reminderID!)!, complition: { (result: Bool) in
            appointmentModel().deleteAppointment(deleteID: (appointmentSelected?.identifier)!) { (result: Bool) in
                
                print(result)
                
                self.perform(#selector(insertIntoTable), with: nil, afterDelay: 1)

                self.cancelNotification(str: "\((appointmentSelected?.identifier!)!)", complition: { (Void) in
                    
                })
            }
        })
    }
    
    
    //MARK: IBActions
    
    
    /// Back button
    ///
    /// - Parameter sender: Button reference
    @IBAction func btnBackENAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    /// Switch recurring click
    ///
    /// - Parameter sender: Button reference
    @IBAction func switchRecurringClick(_ sender: UISwitch) {
        
        txtFieldTime.text = ""
        txtEndDate.text = ""
        
        txtFieldTime.placeholder = JMOLocalizedString(forKey: "Time*", value: "")
        
        if sender.isOn {
            
            txtFieldRecurring.placeholder = JMOLocalizedString(forKey: "Recurring*", value: "")
            
            txtEndDate.placeholder = JMOLocalizedString(forKey: "End date*", value: "")
            
            lowerView.isHidden = false
            lowerViewHeightConstraint.constant = 200
            dateView.isHidden = true
            
            self.heightEndDate.constant = 40
            
        }else{
            
            txtFieldRecurring.placeholder = JMOLocalizedString(forKey: "Recurring", value: "")
            
            txtEndDate.placeholder = JMOLocalizedString(forKey: "End date", value: "")
        
            
            txtFieldRecurring.text = aRRRecurring[0]
            txtFieldTime.text = ""
            txtFieldDate.text = ""
            
            lowerView.isHidden = false
            dateView.isHidden = false
            lowerViewHeightConstraint.constant = 200
            heightConstraintRecurringView.constant = 0
            self.heightEndDate.constant = 0
        }
    }
    
    
    /// Recurring Click event
    ///
    /// - Parameter sender: Button reference
    @IBAction func btnRecurringClick(_ sender: UIButton) {
        self.view.endEditing(true)
        
        openPicker(array: aRRRecurring, sender: txtFieldRecurring) { (selectedObject , selectedIndex , isCancel) in
            
            print(selectedObject)
            let aStrSelected = selectedObject as? String
            
            if (aStrSelected == JMOLocalizedString(forKey: "Recurring", value: "") && self.switchRecurring.isOn){
            
                self.txtFieldRecurring.placeholder = JMOLocalizedString(forKey: "Recurring*", value: "")
                
            }else if (aStrSelected == JMOLocalizedString(forKey: "Recurring", value: "") && (!self.switchRecurring.isOn)){
                
                self.txtFieldRecurring.placeholder = JMOLocalizedString(forKey: "Recurring", value: "")
                
            }else{
                self.txtFieldRecurring.text  = selectedObject as? String
            }
            
            
            
            
            self.txtFieldDay.placeholder = JMOLocalizedString(forKey: "Select Day", value: "")
            self.txtFieldTime.text = ""
            self.txtFieldDay.text = ""
            self.txtEndDate.text = ""
            self.heightConstraintRecurringView.constant = 53
            self.heightEndDate.constant = 40
            self.heightTimeConstraint.constant = 50
            self.lowerViewHeightConstraint.constant = 200
            self.lowerView.isHidden = false
            
            switch selectedIndex {
            case 1:
                self.strInsertRecurring  = Recurring.DailyRecurr.rawValue
            case 2:
                self.strInsertRecurring  = Recurring.WeeklyRecurr.rawValue
            case 3:
                self.strInsertRecurring  = Recurring.MonthlyRecurr.rawValue
            default:
                print("Deault")
            }
            
            if !isCancel {
                
                self.txtFieldRecurring.text  = selectedObject as? String
                
                if (selectedObject as? String) == JMOLocalizedString(forKey: Recurring.DailyRecurr.rawValue, value: "") {
                    self.heightConstraintRecurringView.constant = 0
                    self.viewMonth.isHidden = true
                }else if (selectedObject as? String) == JMOLocalizedString(forKey: Recurring.WeeklyRecurr.rawValue, value: "") {
                    self.viewMonth.isHidden = false
                }else if (selectedObject as? String) == JMOLocalizedString(forKey: Recurring.MonthlyRecurr.rawValue, value: "") {
                    self.viewMonth.isHidden = false
                }else{
                    self.txtFieldRecurring.text  = ""
                    if (self.switchRecurring.isOn){
                        
                        self.txtFieldRecurring.placeholder = JMOLocalizedString(forKey: "Recurring*", value: "")
                        
                    }else if (!self.switchRecurring.isOn){
                        
                        self.txtFieldRecurring.placeholder = JMOLocalizedString(forKey: "Recurring", value: "")
                        
                    }
                    
                    self.heightConstraintRecurringView.constant = 0
                    self.lowerViewHeightConstraint.constant = 0
                    self.lowerView.isHidden = true
                    
                }
            }
            
        }
    }
    
    
    /// Switch reminder event
    ///
    /// - Parameter sender: Switch reference
    @IBAction func switchReminderClick(_ sender: UISwitch) {
        
    }
    
    
    func setNotifiction(notificationID: String) {
        print("Set notification id : \(notificationID)")
        
        let date = selectedDateTime
        let calendar = Calendar.current
        
        let day = calendar.component(.day, from: date!)
        let month = calendar.component(.month, from: date!)
        let weekDay = calendar.component(.weekday, from: date!)
        print("\(day):\(month):\(weekDay)")
        
        let hour = calendar.component(.hour, from: date!)
        let minutes = calendar.component(.minute, from: date!)
        let seconds = calendar.component(.second, from: date!)
        print("hours = \(hour):\(minutes):\(seconds)")
        
        
        if txtFieldRecurring.text == JMOLocalizedString(forKey: Recurring.DailyRecurr.rawValue, value: "") {
            // Daily
            // Time
            if isReminderOn {
                LocalNotificationHelper.sharedInstance.createReminderNotification(notificationID, "\(txtFieldAppointmentName.text!)", "\(txtFieldAppointmentName.text!)", weekDay: 0, monthDay: 0, hour: hour, minute: minutes, seconds: 00, notificationDate: Date(), NotificationType.Daily)
                
            }
            
        }else if txtFieldRecurring.text == JMOLocalizedString(forKey: Recurring.WeeklyRecurr.rawValue, value: "") {
            // Weekly
            // Day / Time
            
            if isReminderOn {
            LocalNotificationHelper.sharedInstance.createReminderNotification(notificationID,"\(txtFieldAppointmentName.text!)", "\(txtFieldAppointmentName.text!)", weekDay: selectedDay!, monthDay: 0, hour: hour, minute: minutes, seconds: seconds, notificationDate: Date(), NotificationType.Weekly)
            }
        }
        else if txtFieldRecurring.text == JMOLocalizedString(forKey: Recurring.MonthlyRecurr.rawValue, value: "") {
            // Monthly
            //Day / Time
                        if isReminderOn {
            LocalNotificationHelper.sharedInstance.createReminderNotification(notificationID,"\(txtFieldAppointmentName.text!)", "\(txtFieldAppointmentName.text!)", weekDay: 0, monthDay: selectedDay!, hour: hour, minute: minutes, seconds: seconds, notificationDate: Date(), NotificationType.Monthly)
            }
        }else{
            // Normal
            // Date / Time
            
            if UserDefaults().bool(forKey: "ReminderSwitch") {
                            print("date = \(date!)")
                
                let monthDay = calendar.component(.day, from: date!)
            LocalNotificationHelper.sharedInstance.createReminderNotification(notificationID,"\(txtFieldAppointmentName.text!)", "\(txtFieldAppointmentName.text!)", weekDay: 0, monthDay: monthDay, hour: hour, minute: minutes, seconds: 00, notificationDate: date!, NotificationType.OnceOnly)
                
            }
            
        }
    }
    
    func cancelNotification(str: String, complition: ((Void)-> Void)) {
        
        print("cancel notification - \(str)")
//        LocalNotificationHelper.sharedInstance.removeNotification([str])
        
        LocalNotificationHelper.sharedInstance.removeNotification([str], completion: { (status) in
            
        })
     
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
                
                self.selectedDateTime = selectedDate
                
                
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
    
    
    @IBAction func btnEndDateClick(_ sender: UIButton) {
        
        if GeneralConstants.DeviceType.IS_IPAD {
            // iPad
            
            
            self.view.endEditing(true)
            
            MMDatePickerPopover.appearOn(originView: sender, baseViewController: self, title: "DatePicker", dateMode: .date, initialDate: Date(), maxDate: nil, timeFormat: nil, doneAction: { selectedDate in
                
                print("selectedDate \(selectedDate)")
                
                self.selectedEndDate = selectedDate
                self.boolEndDate = true
                
                self.setDateOnButton(dat: selectedDate, txtField: self.txtEndDate)
                
            },
                                         cancelAction: {
                                            print("cancel")
            })
            
            
        }else{
            // iPhone
            self.boolEndDate = true

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
                self.selectedDateTime = selectedDate
                
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
    
    
    /// Frequency button event
    ///
    /// - Parameter sender: Button reference
    //    @IBAction func btnFrequencyClick(_ sender: UIButton) {
    //
    //        self.view.endEditing(true)
    //
    //        openPicker(array: aRRFrequency, sender: btnFrequency) { (selectedObject , selectedIndex , isCancel) in
    //
    //            print(selectedObject)
    //
    //            if !isCancel {
    //                self.btnFrequency.setTitle(selectedObject as? String, for: UIControlState.normal)
    //            }
    //        }
    //    }
    
    
    /// Day button event
    ///
    /// - Parameter sender: Button reference
    @IBAction func btnDayClick(_ sender: UIButton) {
        
        if (txtFieldRecurring.text) == (JMOLocalizedString(forKey: Recurring.WeeklyRecurr.rawValue, value: "") ) {
            
            openPicker(array: aRRWeekDay, sender: txtFieldDay, completion: { (selectedObject , selectedIndex , isCancel) in
                
                
                switch selectedIndex {
                    
                case 1:
                    self.selectedDay = WeekDay.Sunday.rawValue
                    self.strinsertFrequency = "Sunday"
                case 2:
                    self.selectedDay = WeekDay.Monday.rawValue
                    self.strinsertFrequency = "Monday"
                case 3:
                    self.selectedDay = WeekDay.Tuesday.rawValue
                    self.strinsertFrequency = "Tuesday"
                case 4:
                    self.selectedDay = WeekDay.Wednesday.rawValue
                    self.strinsertFrequency = "Wednesday"
                case 5:
                    self.selectedDay = WeekDay.Thursday.rawValue
                    self.strinsertFrequency = "Thursday"
                case 6:
                    self.selectedDay = WeekDay.Friday.rawValue
                    self.strinsertFrequency = "Friday"
                case 7:
                    self.selectedDay = WeekDay.Saturday.rawValue
                    self.strinsertFrequency = "Saturday"
                default :
                    print("")
                }
                
                let aStrSelectedDay = selectedObject as? String
                
                if (aStrSelectedDay == "" || aStrSelectedDay == JMOLocalizedString(forKey: "Select Day", value: "")){
                    self.txtFieldDay.text = ""
                    self.txtFieldDay.placeholder = JMOLocalizedString(forKey: "Select Day", value: "")
                }else{
                    self.txtFieldDay.text = selectedObject as? String
                }
                
            })
        }else if (txtFieldRecurring.text) == (JMOLocalizedString(forKey: Recurring.MonthlyRecurr.rawValue, value: "") ) {
            openPicker(array: aRRMonth, sender: txtFieldDay, completion: { (selectedObject , selectedIndex , isCancel) in
                self.selectedDay = Int((selectedObject as? String)!)
                self.txtFieldDay.text = selectedObject as? String
            })
        }
    }
    
    
    /// Save and update button event
    ///
    /// - Parameter sender: Button reference
    @IBAction func btnSaveAndUpdateClick(_ sender: UIButton) {
        
        btnSaveDelete.isEnabled = false
        
        if GeneralConstants.trimming(txtFieldAppointmentName.text!) {
            if GeneralConstants.checkLength(txtFieldAppointmentName.text!, length: 256) {
                
                if GeneralConstants.checkLength(txtFieldDoctorName.text!, length: 256) {
                    
                    if GeneralConstants.checkLength(txtFieldClinicName.text!, length: 256) {
                        
                        if GeneralConstants.checkLength(txtViewNotes.text!, length: 1024) {
                            
                            if switchRecurring.isOn {
                                checkRecurringIsSelected()
                            }else{
                                if GeneralConstants.trimming(txtFieldDate.text!) && GeneralConstants.trimming(txtFieldTime.text!) {
                                    checkReminderSwich()
                                }else{
                                    showAlert(message: JMOLocalizedString(forKey: kReminderOn, value: ""))
                                }
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
                
            }else{
                showAlert(message: JMOLocalizedString(forKey: kRequireFields, value: ""))
            }
        }else{
            showAlert(message: JMOLocalizedString(forKey: kReminderOn, value: ""))
        }
    }
    
    
    //MARK: MMDatePickerDelegate
    
    /// Date picker delegate Done event
    ///
    /// - Parameters:
    ///   - amDatePicker: Picker object
    ///   - date: Selected date
    func mmDatePicker(_ amDatePicker: MMDatePicker, didSelect date: Date) {
        
        
        
        if isBooltime {
            selectedDateTime = date
            setTimeOnButton(dat: date, txtField: txtFieldTime)
            
        }else{
            if boolEndDate {
                selectedEndDate = date
                setDateOnButton(dat: date, txtField: txtEndDate)
                boolEndDate = false
            }else{
                selectedDateTime = date
                setDateOnButton(dat: date, txtField: txtFieldDate)
            }

        }
        
    }
    
    
    /// Date picker cancel delegate
    ///
    /// - Parameter amDatePicker: Picker object
    func mmDatePickerDidCancelSelection(_ amDatePicker: MMDatePicker) {
        // NOP
        self.boolEndDate = false

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
            textView.text = JMOLocalizedString(forKey: "Note", value: "")
            textView.textColor = GeneralConstants.ColorConstants.kColor_PlaceHolder
        }
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        // Remove placeholder
        if textView.textColor == GeneralConstants.ColorConstants.kColor_PlaceHolder && text.count > 0 {
            textView.text = ""
            textView.textColor = GeneralConstants.ColorConstants.kColor_Black
        }
        
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        
        if textView == txtViewNotes {
            if (textView.text?.count)! <= kSetChar8192  {
                let newLength = (textView.text?.count)! + text.count - range.length
                return newLength <= kSetChar8192
            }
        }
        
        return true
    }
    
    //MARK: UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        if textField == txtFieldAppointmentName || textField == txtFieldDoctorName  || textField == txtFieldClinicName{
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


