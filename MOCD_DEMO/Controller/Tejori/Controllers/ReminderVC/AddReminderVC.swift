//
//  AddReminderVC.swift
//  SmartTejoori
//
//  Created by indianic on 08/02/17.
//  Copyright © 2017 demo. All rights reserved.
//

import UIKit

enum ReminderType: String {
    case Daily = "1"
    case Weekly = "2"
    case Monthly = "3"
}


enum WeekDay: Int {
    case Sunday = 1
    case Monday = 2
    case Tuesday = 3
    case Wednesday = 4
    case Thursday = 5
    case Friday = 6
    case Saturday = 7
    
}

class AddReminderVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var lblScreenTitle: UILabel!
    @IBOutlet weak var btnBackEN: UIButton!
    @IBOutlet weak var btnBackAR: UIButton!
    
    @IBOutlet weak var btnDailyReminderType: UIButton!
    @IBOutlet weak var btnWeeklyReminderType: UIButton!
    @IBOutlet weak var btnMonthlyReminderType: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var tfNote: UITextField!
    @IBOutlet weak var btnReminderTime: UIButton!
    @IBOutlet weak var btnReminderSubtype: UIButton!
    @IBOutlet weak var tfMonyGoal: UITextField!
    @IBOutlet weak var tfMonyGoalTitle: UITextField!
    @IBOutlet weak var viewReminderSubtype: UIView!
    @IBOutlet weak var topNoteConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewReminderTime: UIView!
    @IBOutlet weak var topReminderTimeConstraint: NSLayoutConstraint!
    
    var aRRRecurring = [String]()
    var aRRWeekDay = [String]()
    var aRRMonth = [String]()
    var aRRMonthAR = [String]()
    var selectedDateTime: Date?
    var selectedDay: Int?
    var selectedWeekDay: Int = 0
    var selectedMonthDay: Int = 0
    var hour: Int = 0
    var minutes: Int = 0
    
    var aReminderModel = ReminderModelT()
    
    var selectedReminderType = String()
    var taskTitle = String()
    var taskDetail = String()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if AppConstants.isArabic() {
            
            btnBackEN.isHidden = true
            
            btnReminderSubtype.contentHorizontalAlignment = .right
            btnReminderSubtype.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
            
            btnReminderTime.contentHorizontalAlignment = .right
            btnReminderTime.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
            
            btnDailyReminderType.imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
            btnMonthlyReminderType.imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
            btnWeeklyReminderType.imageEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        }
        else{
            
            btnBackAR.isHidden = true
            btnReminderSubtype.contentHorizontalAlignment = .left
            btnReminderSubtype.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            
            btnReminderTime.contentHorizontalAlignment = .left
            btnReminderTime.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            
        }
        
        LanguageManager.sharedInstance.localizeThingsInView(parentView: self.view)
        
        self.topReminderTimeConstraint.constant = 16

        
        aRRRecurring = [JMOLocalizedString(forKey: "ReminderType", value: ""), JMOLocalizedString(forKey: "Daily", value: ""), JMOLocalizedString(forKey: "Weekly", value: ""), JMOLocalizedString(forKey: "Monthly", value: "")]
        aRRWeekDay = [JMOLocalizedString(forKey: "Sunday", value: ""),
                      JMOLocalizedString(forKey: "Monday", value: ""),
                      JMOLocalizedString(forKey: "Tuesday", value: ""),
                      JMOLocalizedString(forKey: "Wednesday", value: ""),
                      JMOLocalizedString(forKey: "Thrusday", value: ""),
                      JMOLocalizedString(forKey: "Friday", value: ""),
                      JMOLocalizedString(forKey: "Saturday", value: "")]
        aRRMonth = [JMOLocalizedString(forKey: "Select Day", value: ""),"1", "2", "3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18",
                    "19","20","21","22","23","24","25","26","27","28","29","30","31"]
        
        aRRMonthAR = [JMOLocalizedString(forKey: "Select Day", value: ""),"١", "٢", "٣","٤","٥","٦","٧","٨","٩","١٠","١١","١٢","١٣","١٤","١٥","١٦","١٧","١٨",
                    "١٩","٢٠","٢١","٢٢","٢٣","٢٤","٢٥","٢٦","٢٧","٢٨","٢٩","٣٠","٣١"]
        
        self.topReminderTimeConstraint.constant = 16
        self.topNoteConstraint.constant = 16
        self.viewReminderSubtype.isHidden = true
        self.viewReminderTime.isHidden = true
        
        if aReminderModel.identifier != nil{
            self.lblScreenTitle.text = JMOLocalizedString(forKey: "EDIT REMINDER", value: "")
            self.btnSave.setTitle(JMOLocalizedString(forKey: "Update", value: ""), for: .normal)
            self.tfMonyGoalTitle.text = aReminderModel.reminderMoneyGoalTitle!
            self.tfMonyGoal.text = aReminderModel.reminderMoneyGoalAmount!
            self.tfNote.text = aReminderModel.reminderNote!
            
            
            if aReminderModel.reminderType! == ReminderType.Daily.rawValue{
                self.btnDailyReminderTypeAction(btnDailyReminderType)
            }
            else if aReminderModel.reminderType! == ReminderType.Weekly.rawValue{
                self.btnWeeklyReminderTypeAction(btnWeeklyReminderType)
                self.selectWeeklyReminderSubType(firstindex: (Int(aReminderModel.reminderWeaklyDay)! - 1))
            }
            else if aReminderModel.reminderType! == ReminderType.Monthly.rawValue{
                self.btnMonthlyReminderTypeAction(btnMonthlyReminderType)
                self.selectMonthlyReminderSubType(firstindex: Int(aReminderModel.reminderMonthlyDay)!)
            }
            
            let reminderDate = self.createDateFromComponents(aStrTime: aReminderModel.reminderTime!)
            self.selectReminderTime(date: reminderDate)
            
        }else{
            self.lblScreenTitle.text = JMOLocalizedString(forKey: "ADD REMINDER", value: "")
            self.btnSave.setTitle(JMOLocalizedString(forKey: "Add", value: ""), for: .normal)
        }
    }
    
    func RRMonthDays() -> [String] {
        if(AppConstants.isArabic()){
            return aRRMonthAR;
        }else{
            return aRRMonth;
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        Utility.sharedInstance.setPaddingAndShadowForUIComponents(parentView: self.view)
        Utility.sharedInstance.setShadowForView(view: btnReminderTime)
        Utility.sharedInstance.setShadowForView(view: btnReminderSubtype)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:- Button Click Events
    
    @IBAction func btnSaveAction(_ sender: UIButton) {
        if self.validateForm(){
            
            hour = Utility.sharedInstance.getHMS(date: selectedDateTime!).0
            minutes = Utility.sharedInstance.getHMS(date: selectedDateTime!).1
            
            let objReminderModel = ReminderModelT()
            
            if aReminderModel.identifier != nil {
                objReminderModel.identifier = aReminderModel.identifier
            }
            
            objReminderModel.reminderType = selectedReminderType
            objReminderModel.reminderMonthlyDay = "\(selectedMonthDay)"
            objReminderModel.reminderWeaklyDay = "\(selectedWeekDay)"
            objReminderModel.reminderTime = "\(hour):\(minutes)"
            objReminderModel.reminderDate = ""
            objReminderModel.reminderEndDate = ""
            objReminderModel.reminderNote = "\(self.tfNote.text!)"
            objReminderModel.reminderMoneyGoalAmount = Utility.sharedInstance.convertNumberToEnglish(aStr: self.tfMonyGoal.text!)
            objReminderModel.reminderMoneyGoalTitle = self.tfMonyGoalTitle.text!
            objReminderModel.reminderWithNotification = 1
            
            var aReminderInfoAdded : Bool = false
            var aDBSucessMsg = ""
            
            if aReminderModel.identifier != nil{
                aReminderInfoAdded = userInfoManagerT.sharedInstance.UpdateReminderDetail(objReminderModel: objReminderModel)
                aDBSucessMsg = "your modifications are saved successfully"
            }
            else{
                aReminderInfoAdded = userInfoManagerT.sharedInstance.InsertReminderDetail(objReminderModel: objReminderModel)
                aDBSucessMsg = "addition process done successfully"
            }
            
            // user signup - insert query for database.
            
            if aReminderInfoAdded == true {
                
                var reminderId: Int = 0
                if aReminderModel.identifier == nil{
                    reminderId = userInfoManagerT.sharedInstance.GetReminderId(objReminderModel: objReminderModel)
                }
                else{
                    
                    reminderId = aReminderModel.identifier
                    
                    LocalNotificationHelperT.sharedInstance.removeNotification([String(reminderId)]) { (status) in
                    }
                }
                
                if reminderId != 0{
                    self.taskTitle = "\(self.tfMonyGoalTitle.text!)"
                    
                    if AppConstants.isArabic(){
                        self.taskDetail = "مرحباً ! لديك هدف مالي بقيمة \(self.tfMonyGoal.text!). \(self.tfNote.text!)"
                    }
                    else{
                        self.taskDetail = "Hey! You have money goal of \(self.tfMonyGoal.text!).\(self.tfNote.text!)"
                    }
                    
                    
                    self.setReminder(reminderId: "\(reminderId)")
                    let alertController = UIAlertController(title:  JMOLocalizedString(forKey: "Edkhar", value: ""), message: JMOLocalizedString(forKey: aDBSucessMsg, value: ""), preferredStyle: .alert)
                    let okAction = UIAlertAction(title: JMOLocalizedString(forKey: "OK", value: ""), style: .default, handler: { (action) in
                        _ = self.navigationController?.popViewController(animated: true)
                    })
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func btnDailyReminderTypeAction(_ sender: Any) {
        
        Utility.sharedInstance.removePickerView()
        
        self.btnDailyReminderType.isSelected = true
        self.btnWeeklyReminderType.isSelected = false
        self.btnMonthlyReminderType.isSelected = false
        selectedReminderType = ReminderType.Daily.rawValue
        
        // Hide Reminder SubType
        self.topReminderTimeConstraint.constant = 16
        self.topNoteConstraint.constant = 72
        self.viewReminderSubtype.isHidden = true
        self.viewReminderTime.isHidden = false
        
        btnReminderTime.setTitle(JMOLocalizedString(forKey: "Reminder time *", value: ""), for: .normal)
    }
    
    @IBAction func btnWeeklyReminderTypeAction(_ sender: Any) {
        
        Utility.sharedInstance.removePickerView()
        
        self.btnDailyReminderType.isSelected = false
        self.btnWeeklyReminderType.isSelected = true
        self.btnMonthlyReminderType.isSelected = false
        selectedReminderType = ReminderType.Weekly.rawValue
        
        // Unhide Reminder SubType
        self.topReminderTimeConstraint.constant = 72
        self.topNoteConstraint.constant = 72
        self.viewReminderSubtype.isHidden = false
        self.viewReminderTime.isHidden = true
        
        btnReminderSubtype.setTitle(JMOLocalizedString(forKey: "Reminder day", value: ""), for: .normal)
        btnReminderTime.setTitle(JMOLocalizedString(forKey: "Reminder time *", value: ""), for: .normal)
    }
    
    @IBAction func btnMonthlyReminderTypeAction(_ sender: Any) {
        
        Utility.sharedInstance.removePickerView()
        
        self.btnDailyReminderType.isSelected = false
        self.btnWeeklyReminderType.isSelected = false
        self.btnMonthlyReminderType.isSelected = true
        selectedReminderType = ReminderType.Monthly.rawValue
        
        // Unhide Reminder SubType
        self.topReminderTimeConstraint.constant = 72
        self.topNoteConstraint.constant = 72
        self.viewReminderSubtype.isHidden = false
        self.viewReminderTime.isHidden = true
        
        btnReminderSubtype.setTitle(JMOLocalizedString(forKey: "Reminder day", value: ""), for: .normal)
        btnReminderTime.setTitle(JMOLocalizedString(forKey: "Reminder time *", value: ""), for: .normal)
    }
    
    @IBAction func btnRemidnerSubtypeAction(_ sender: UIButton) {
        self.view.endEditing(true)
        if selectedReminderType == ReminderType.Weekly.rawValue{
            Utility.sharedInstance.addPicker(self, onTextFieldORButton: btnReminderSubtype, typePicker: PickerType.SimplePicker.rawValue, pickerArray: aRRWeekDay,showMinDate: false) { (picker,buttonindex,firstindex) in
                if (picker != nil)
                {
                    if self.aRRWeekDay.count > 0{
                        self.selectWeeklyReminderSubType(firstindex: firstindex)
                    }
                }
            }
        }
        else if selectedReminderType == ReminderType.Monthly.rawValue{
            Utility.sharedInstance.addPicker(self, onTextFieldORButton: btnReminderSubtype, typePicker: PickerType.SimplePicker.rawValue, pickerArray: RRMonthDays(),showMinDate: false) { (picker,buttonindex,firstindex) in
                if (picker != nil)
                {
                    if self.RRMonthDays().count > 0{
                        self.btnReminderSubtype.setTitle(self.RRMonthDays()[firstindex], for: .normal)
                        if !(self.btnReminderSubtype.title(for: .normal) == JMOLocalizedString(forKey: "Reminder day", value: "") || self.btnReminderSubtype.title(for: .normal) == JMOLocalizedString(forKey: "Select Day", value: "")){
                            self.selectMonthlyReminderSubType(firstindex: firstindex)
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func btnReminderTimeAction(_ sender: UIButton) {
        self.view.endEditing(true)
        Utility.sharedInstance.addPicker(self, onTextFieldORButton: btnReminderTime, typePicker: PickerType.TimePicker.rawValue, pickerArray: [],showMinDate: false) { (picker,buttonindex,firstindex) in
            if (picker != nil)
            {
                let datePicker = picker as! UIDatePicker
                self.selectReminderTime(date: datePicker.date)
            }
        }
    }
    
    @IBAction func btnBackENAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnBackARAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Other Mothods
    
    func validateForm() -> Bool{
        
        if  !Utility.sharedInstance.validateBlank(strVal: self.tfMonyGoalTitle.text!) && !Utility.sharedInstance.validateBlank(strVal: self.tfMonyGoal.text!) && selectedReminderType != ReminderType.Daily.rawValue && selectedReminderType != ReminderType.Weekly.rawValue && selectedReminderType != ReminderType.Monthly.rawValue && btnReminderSubtype.title(for: .normal) == JMOLocalizedString(forKey: "Reminder day", value: "") && btnReminderTime.title(for: .normal) == JMOLocalizedString(forKey: "Reminder time *", value: "") && !Utility.sharedInstance.validateBlank(strVal: self.tfNote.text!){
            
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please fill all mandatory fields", value: ""))
            return false
        }
        else if !Utility.sharedInstance.validateBlank(strVal: self.tfMonyGoalTitle.text!) {
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please fill money goal title field", value: ""))
            return false
        }
        else if !Utility.sharedInstance.validateBlank(strVal: self.tfMonyGoal.text!) {
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please fill money goal amount field", value: ""))
            return false
        }
        else if !Utility.sharedInstance.convertNumberToEnglish(aStr: self.tfMonyGoal.text!).isNumeric {
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please fill valid money goal amount", value: ""))
            return false
        }
        else if selectedReminderType != ReminderType.Daily.rawValue && selectedReminderType != ReminderType.Weekly.rawValue && selectedReminderType != ReminderType.Monthly.rawValue {
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please select reminder type", value: ""))
            return false
        }
        else if selectedReminderType != ReminderType.Daily.rawValue && (btnReminderSubtype.title(for: .normal) == JMOLocalizedString(forKey: "Reminder day", value: "") || btnReminderSubtype.title(for: .normal) == JMOLocalizedString(forKey: "Select Day", value: "")){
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please select reminder day", value: ""))
            return false
        }
        else if btnReminderTime.title(for: .normal) == JMOLocalizedString(forKey: "Reminder time *", value: ""){
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please select reminder time", value: ""))
            return false
        }
        else{
            return true
        }
    }
    
    func setSelectedDayForWeeklyReminder(selectedIndex: Int) -> Void{
        switch selectedIndex {
        case 1:
            self.selectedDay = WeekDay.Sunday.rawValue
        case 2:
            self.selectedDay = WeekDay.Monday.rawValue
        case 3:
            self.selectedDay = WeekDay.Tuesday.rawValue
        case 4:
            self.selectedDay = WeekDay.Wednesday.rawValue
        case 5:
            self.selectedDay = WeekDay.Thursday.rawValue
        case 6:
            self.selectedDay = WeekDay.Friday.rawValue
        case 7:
            self.selectedDay = WeekDay.Saturday.rawValue
        default :
            print("")
        }
    }
    
    func  selectWeeklyReminderSubType(firstindex: Int) -> Void {
        self.btnReminderSubtype.setTitle(self.aRRWeekDay[firstindex], for: .normal)
        self.setSelectedDayForWeeklyReminder(selectedIndex: firstindex + 1)
        self.selectedWeekDay = self.selectedDay!
        
        self.topReminderTimeConstraint.constant = 72
        self.topNoteConstraint.constant = 128
        self.viewReminderSubtype.isHidden = false
        self.viewReminderTime.isHidden = false
    }
    
    func selectMonthlyReminderSubType(firstindex: Int) -> Void {
        self.btnReminderSubtype.setTitle(RRMonthDays()[firstindex], for: .normal)
        self.selectedDay = firstindex
        self.selectedMonthDay = self.selectedDay!
        
        self.topReminderTimeConstraint.constant = 72
        self.topNoteConstraint.constant = 128
        self.viewReminderSubtype.isHidden = false
        self.viewReminderTime.isHidden = false
    }
    
    func selectReminderTime(date: Date) -> Void {
        let strTime = Utility.sharedInstance.getStringFromDate("hh:mm a", date: date)
        self.btnReminderTime.setTitle(strTime, for: .normal)
        self.selectedDateTime = date
    }
    
    func createDateFromComponents(aStrTime: String) -> Date{
        let arrTime = aStrTime.components(separatedBy: ":")
        let hour = Int(arrTime[0])
        let minutes = Int(arrTime[1])
        let currentDate = Date()
        let calender = Calendar.current
        let day = calender.component(.day, from: currentDate)
        let month = calender.component(.month, from: currentDate)
        let year = calender.component(.year, from: currentDate)
        var dateComp = DateComponents()
        dateComp.day = day
        dateComp.month = month
        dateComp.year = year
        dateComp.hour = hour
        dateComp.minute = minutes
        dateComp.second = 0
        let date = calender.date(from: dateComp)
        return date!
    }
    
    //MARK:- Set Reminder
    func setReminder(reminderId: String) -> Void{
        if selectedReminderType == ReminderType.Daily.rawValue{
            self.setNotificationDaily(reminderId: reminderId)
        }else if selectedReminderType == ReminderType.Weekly.rawValue{
            self.setNotificationWeekly(reminderId: reminderId)
        }else if selectedReminderType == ReminderType.Monthly.rawValue{
            self.setNotificationMonthly(reminderId: reminderId)
        }
    }
    
    //MARK:- Set Daily Reminder
    func setNotificationDaily(reminderId: String) {
        LocalNotificationHelperT.sharedInstance.createReminderNotification(reminderId, "\(taskTitle)", "\(taskDetail)", weekDay: 0, monthDay: 0, hour: hour, minute: minutes, seconds: 0, notificationDate: Date(), NotificationType.Daily)
    }
    
    //MARK:- Set Weekly Reminder
    func setNotificationWeekly(reminderId: String) {
        LocalNotificationHelperT.sharedInstance.createReminderNotification(reminderId,"\(taskTitle)", "\(taskDetail)", weekDay: selectedDay!, monthDay: 0, hour: hour, minute: minutes, seconds: 0, notificationDate: Date(), NotificationType.Weekly)
    }
    
    //MARK:- Set Monthly Reminder
    func setNotificationMonthly(reminderId: String) {
        LocalNotificationHelperT.sharedInstance.createReminderNotification(reminderId, "\(taskTitle)", "\(taskDetail)", weekDay: 0, monthDay: selectedDay!, hour: hour, minute: minutes, seconds: 0, notificationDate: Date(), NotificationType.Monthly)
    }
    
    //MARK:- Textfield Delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        if textField == tfMonyGoal {
            let newLength = text.count + string.count - range.length
            if string.isNumeric {
                if newLength > 7{
                    return false
                }else{
                    if let x = tfMonyGoal.text{
                        if (!AppConstants.isArabic() && !string.isEmpty){
                            let s:String  = x.appending(string);
                            tfMonyGoal.text = Utility.sharedInstance.convertNumberToEnglish(aStr: s)
                            return false;
                        }else{
                            return true;
                        }
                    }
                }

        
            }else{
                return false
            }
        }
        
        return true
    }
    
}
