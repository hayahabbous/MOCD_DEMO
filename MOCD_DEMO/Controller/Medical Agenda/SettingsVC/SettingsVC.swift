//
//  SettingsVC.swift
//  SmartAgenda
//
//  Created by indianic on 13/02/17.
//  Copyright © 2017 demo. All rights reserved.
//

import UIKit
import UserNotifications

class SettingsVC: UIViewController, MMDatePickerDelegate {
    
    //MARK: IBOutlets
    @IBOutlet var lblScreenTitle: UILabel!
    
    @IBOutlet var btnBAck: UIButton!
    @IBOutlet var btnRemDis: [UIButton]!
    
    @IBOutlet var switchReminder: UISwitch!
    @IBOutlet var lblReminderStatic: UILabel!
    
    @IBOutlet weak var lblDiseasesReminder: UILabel!
    @IBOutlet weak var switchDiseasesReminder: UISwitch!
    
    @IBOutlet weak var lblAppointmentReminder: UILabel!
    @IBOutlet weak var switchAppointmentRemidner: UISwitch!
    
    @IBOutlet weak var lblMedicationReminder: UILabel!
    @IBOutlet weak var switchMedicationReminder: UISwitch!
    
    
    @IBOutlet var viewReminder: UIView!
    
    @IBOutlet weak var SwitchBloodPressure: UISwitch!
    @IBOutlet weak var txtReminderTime: UITextField!
    
    @IBOutlet weak var SwitchBloodSugar: UISwitch!
    @IBOutlet weak var txtFastingTime: UITextField!
    @IBOutlet weak var txtEatingTime: UITextField!
    
    @IBOutlet var viewDisease: UIView!
    
    @IBOutlet var viewTimeBloodPressure: UIView!
    @IBOutlet var viewtimeBloodSugar1: UIView!
    @IBOutlet var viewtimeBloodSugar2: UIView!
    
    
    //MARK: Variables
    
    var selectedDateTime: Date?
    var datePicker = MMDatePicker.getFromNib()
    var timeFormatter = DateFormatter()
    var intTagTime: Int!
    var isBoolTimeBP: Bool = false
    var isBoolTimeBSFast: Bool = false
    var isBoolTimeBSEat: Bool = false
    
    var reminderObj = [ReminderModel]()
    var reminderMedicationObj = [ReminderModel]()
    var reminderAppointmentObj = [ReminderModel]()
    var reminderDiseasesObj = [ReminderModel]()
    
    
    
    let dateSelectedFormatter = DateFormatter()
    
    var diseaseReminder = [DiseasesReminderModel]()
    

    //MARK: UIViewController Methods
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        lblScreenTitle.text = JMOLocalizedString(forKey: "SETTINGS", value: "")
        
        self.navigationController?.isNavigationBarHidden = true
        datePicker.delegate = self
        timeFormatter.dateFormat = "HH:mm"
        
        
        let aReminderAllSwitch = UserDefaults().value(forKey: "ReminderSwitch") as? Bool
        if (aReminderAllSwitch != nil) && (aReminderAllSwitch == true) {
            switchDiseasesReminder.setOn(true, animated: true)
            switchMedicationReminder.setOn(true, animated: true)
            switchAppointmentRemidner.setOn(true, animated: true)
            
        }else{
            switchDiseasesReminder.setOn(false, animated: true)
            switchMedicationReminder.setOn(false, animated: true)
            switchAppointmentRemidner.setOn(false, animated: true)
            
        }
        
        
        let aReminderMedicationSwitch = UserDefaults().value(forKey: "ReminderMedicationSwitch") as? Bool
        if (aReminderMedicationSwitch != nil) && (aReminderMedicationSwitch == true) {
            switchMedicationReminder.setOn(true, animated: true)
        }else{
            switchMedicationReminder.setOn(false, animated: true)
        }
        
        
        let aReminderAppointmentSwitch = UserDefaults().value(forKey: "ReminderAppointmentSwitch") as? Bool
        
        if (aReminderAppointmentSwitch != nil) && (aReminderAppointmentSwitch == true) {
            switchAppointmentRemidner.setOn(true, animated: true)
        }else{
            switchAppointmentRemidner.setOn(false, animated: true)
        }
        
        let aReminderDiseaseSwitch = UserDefaults().value(forKey: "ReminderDiseaseSwitch") as? Bool
        if (aReminderDiseaseSwitch != nil) && (aReminderDiseaseSwitch == true) {
            switchDiseasesReminder.setOn(true, animated: true)
        }else{
            switchDiseasesReminder.setOn(false, animated: true)
        }
        
        ReminderModel().getAllReminder(completion: { (reminders: [ReminderModel]) in
            
            if self.reminderObj.count > 0{
                self.reminderObj.removeAll()
            }
            
            self.reminderObj = reminders
        })
        
        ReminderModel().getAllMedicationReminder(completion: { (reminders: [ReminderModel]) in
            
            if self.reminderMedicationObj.count > 0{
                self.reminderMedicationObj.removeAll()
            }
            
            self.reminderMedicationObj = reminders
        })
        
        
        ReminderModel().getAllAppointmentReminder(completion: { (reminders: [ReminderModel]) in
            
            if self.reminderAppointmentObj.count > 0{
                self.reminderAppointmentObj.removeAll()
            }
            
            self.reminderAppointmentObj = reminders
        })
        
        
        ReminderModel().getAllDiseasesReminder(completion: { (reminders: [ReminderModel]) in
            
            if self.reminderDiseasesObj.count > 0{
                self.reminderDiseasesObj.removeAll()
            }
            
            self.reminderDiseasesObj = reminders
        })
        
        

        diseaseReminder = DiseaseModel().getBloodPS()
        print(diseaseReminder)
        // set BP time

        for dis in diseaseReminder {
        
            if dis.reminderID == 14 {
                // BP
                UserDefaults().set(diseaseReminder[2].reminderTime!, forKey: "BPTime")
                txtReminderTime.text = UserDefaults().value(forKey: "BPTime") as! String?
                UserDefaults().synchronize()

            }else if dis.reminderID == 13 {
                // Fasting
                UserDefaults().set(diseaseReminder[1].reminderTime!, forKey: "BSFastingTime")
                txtFastingTime.text = UserDefaults().value(forKey: "BSFastingTime") as! String?
                UserDefaults().synchronize()
            }else if dis.reminderID == 12 {
                // Eating
                UserDefaults().set(diseaseReminder[0].reminderTime!, forKey: "BSEatingTime")
                txtEatingTime.text = UserDefaults().value(forKey: "BSEatingTime") as! String?
                UserDefaults().synchronize()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setPadding()
        
        dateSelectedFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateSelectedFormatter.locale = Locale(identifier: "en_US_POSIX")
//        dateSelectedFormatter.timeZone = NSTimeZone(abbreviation: "IST") as TimeZone!
        dateSelectedFormatter.timeZone = NSTimeZone.local

        
        customizeFonts(in: btnRemDis[0], aFontName: Medium, aFontSize: 0)
        customizeFonts(in: btnRemDis[1], aFontName: Medium, aFontSize: 0)
        
        customizeFonts(in: lblScreenTitle, aFontName: Medium, aFontSize: 0)
        
        customizeFonts(in: lblReminderStatic, aFontName: Medium, aFontSize: 0)
        customizeFonts(in: lblDiseasesReminder, aFontName: Medium, aFontSize: 0)
        customizeFonts(in: lblAppointmentReminder, aFontName: Medium, aFontSize: 0)
        customizeFonts(in: lblMedicationReminder, aFontName: Medium, aFontSize: 0)
        
        customizeFonts(in: txtReminderTime, aFontName: Medium, aFontSize: 0)
        customizeFonts(in: txtFastingTime, aFontName: Medium, aFontSize: 0)
        customizeFonts(in: txtEatingTime, aFontName: Medium, aFontSize: 0)
        
        // Switch
        let isReminderOn = UserDefaults().bool(forKey: "ReminderSwitch")
        let isBPOn =  UserDefaults().bool(forKey: "BloodPressureSwitch")
        let isBSOn = UserDefaults().bool(forKey: "BloodSugarSwitch")
        txtReminderTime.text = UserDefaults().value(forKey: "BPTime") as! String?
        txtFastingTime.text = UserDefaults().value(forKey: "BSFastingTime") as! String?
        txtEatingTime.text = UserDefaults().value(forKey: "BSEatingTime") as! String?
   
        if isReminderOn {
            // Reminder
            switchReminder.isOn = isReminderOn
//            viewReminder.isHidden = false
        }else{
//            viewReminder.isHidden = true
            switchReminder.isOn = isReminderOn
        }
        
        if isBPOn {
            // BP
            SwitchBloodPressure.isOn = isBPOn
            viewTimeBloodPressure.isHidden = false
        }else{
            viewTimeBloodPressure.isHidden = true
            SwitchBloodPressure.isOn = isBPOn
        }
        
        if isBSOn {
            // BS
            SwitchBloodSugar.isOn = isBSOn
            viewtimeBloodSugar1.isHidden = false
            viewtimeBloodSugar2.isHidden = false
        }else{
            viewtimeBloodSugar1.isHidden = true
            viewtimeBloodSugar2.isHidden = true
            SwitchBloodSugar.isOn = isBSOn
            
        }
        
        
        if AppConstants.isArabic()
        {
            btnBAck.imageView?.transform = (btnBAck.imageView?.transform.rotated(by: CGFloat(M_PI)))!
            
            btnRemDis[0].imageEdgeInsets =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -10)
            btnRemDis[1].imageEdgeInsets =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -10)
        }else{
            btnBAck.imageView?.transform = (btnBAck.imageView?.transform.rotated(by: CGFloat(M_PI*2)))!
            btnRemDis[0].imageEdgeInsets =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
            btnRemDis[1].imageEdgeInsets =  UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)

        }
        
        LanguageManager().localizeThingsInView(parentView: (self.view))
        
        viewReminder.isHidden = false
        viewDisease.isHidden = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setPadding(){
        
        setTextFieldPadding(textfield: txtEatingTime, padding: 5)
        setTextFieldPadding(textfield: txtFastingTime, padding: 5)
        setTextFieldPadding(textfield: txtReminderTime, padding: 5)
        
    }
    
    //MARK: IBActions
    @IBAction func btnBackClick(_ sender: UIButton) {
        
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func btnReminderClick(_ sender: UIButton) {
        
        intTagTime = 100
        isBoolTimeBP = true
        self.showTimePicker(txtField: txtReminderTime, sender: sender)
        
        
    }
    
    @IBAction func btnFastingTimeClick(_ sender: UIButton) {
        
        intTagTime = 101
        isBoolTimeBSFast = true
        self.showTimePicker(txtField: txtFastingTime, sender: sender)
        
        UserDefaults().setValue(txtFastingTime.text!, forKey: "BSFastingTime")

        
        
    }
    
    @IBAction func btnAfterEatingClick(_ sender: UIButton) {
        isBoolTimeBSEat = true
        intTagTime = 102
        self.showTimePicker(txtField: txtEatingTime, sender: sender)
        UserDefaults().setValue(txtEatingTime.text!, forKey: "BSEatingTime")

    }
    
    @IBAction func btnRemDisClick(_ sender: UIButton) {
        
        print(sender)
        
        for index in 10...11 {
            let myBtn = self.view.viewWithTag(index) as! UIButton
            myBtn.isSelected = false
            if (sender.isEqual(myBtn)) {
                myBtn.isSelected = true
                if myBtn.tag == 10{
                    
                    viewReminder.isHidden = false
                    viewDisease.isHidden = true
                    btnRemDis[0].backgroundColor = GeneralConstants.hexStringToUIColor(hex: GeneralConstants.ColorConstants
                        .themeColor)
                    btnRemDis[1].backgroundColor = GeneralConstants.hexStringToUIColor(hex: GeneralConstants.ColorConstants.btnUnselected)
                    
                }else{
                    
                    viewReminder.isHidden = true
                    viewDisease.isHidden = false
                    btnRemDis[0].backgroundColor = GeneralConstants.hexStringToUIColor(hex: GeneralConstants.ColorConstants.btnUnselected)
                    btnRemDis[1].backgroundColor = GeneralConstants.hexStringToUIColor(hex: GeneralConstants.ColorConstants.themeColor)
                }
            }
        }
        
    }
    
    @IBAction func switchMedicationClick(_ sender: UISwitch) {
        
        if sender.isOn {
            // On
            print(sender.isOn)
            
            UserDefaults().set(true, forKey: "ReminderMedicationSwitch")
            UserDefaults().synchronize()
            setNotifications(reminderModelObjs: self.reminderMedicationObj)
            
        }else{
            // Off
            print(sender.isOn)
            
            UserDefaults().set(false, forKey: "ReminderMedicationSwitch")
            UserDefaults().synchronize()
//            if #available(iOS 10.0, *) {
            
                print("self.reminderMedicationObj = \(self.reminderMedicationObj)")
                
                
                for objReminderMedication in self.reminderMedicationObj {
                    
                    print("objReminderMedication = \(objReminderMedication)")
                    
                    let aRemoveReminderID = String(objReminderMedication.reminderID)
                    LocalNotificationHelper.sharedInstance.removeNotification([aRemoveReminderID], completion: { (status) in
                        
                    })
                }
//            }
        }
     
        UserDefaults().synchronize()
    }
    
    
    
    @IBAction func switchAppointmentClick(_ sender: UISwitch) {
        
        if sender.isOn {
            // On
            print(sender.isOn)
            
            UserDefaults().set(true, forKey: "ReminderAppointmentSwitch")
            UserDefaults().synchronize()
            setNotifications(reminderModelObjs: self.reminderAppointmentObj)
            
        }else{
            // Off
            print(sender.isOn)
            
            UserDefaults().set(false, forKey: "ReminderAppointmentSwitch")
            UserDefaults().synchronize()
            //            if #available(iOS 10.0, *) {
            
            print("self.reminderAppointmentObj = \(self.reminderAppointmentObj)")
            
            
            for ObjreminderAppointment in self.reminderAppointmentObj {
                
                print("ObjreminderAppointment = \(ObjreminderAppointment)")
                
                let aRemoveReminderID = String(ObjreminderAppointment.reminderID)
                LocalNotificationHelper.sharedInstance.removeNotification([aRemoveReminderID], completion: { (status) in
                    
                })
            }
            
        }
        
        UserDefaults().synchronize()
        
    }
    
    @IBAction func switchDiseasesClick(_ sender: UISwitch) {
        
        if sender.isOn {
            // On
            print(sender.isOn)
            
            UserDefaults().set(true, forKey: "ReminderDiseaseSwitch")
            UserDefaults().synchronize()
            setNotifications(reminderModelObjs: self.reminderDiseasesObj)
            
        }else{
            // Off
            print(sender.isOn)
            
            UserDefaults().set(false, forKey: "ReminderDiseaseSwitch")
            UserDefaults().synchronize()
            //            if #available(iOS 10.0, *) {
            
            print("self.reminderDiseasesObj = \(self.reminderDiseasesObj)")
            
            
            for objReminderDiseases in self.reminderDiseasesObj {
                
                print("objReminderDiseases = \(objReminderDiseases)")
                
                let aReminderDiseasesID = String(objReminderDiseases.reminderID)
                LocalNotificationHelper.sharedInstance.removeNotification([aReminderDiseasesID], completion: { (status) in
                    
                })
            }
            
        }
        
        UserDefaults().synchronize()
        
    }
    
    
    @IBAction func switchReminderClick(_ sender: UISwitch) {
        
        if sender.isOn {
            // On
            print(sender.isOn)
            
            switchDiseasesReminder.setOn(true, animated: true)
            switchMedicationReminder.setOn(true, animated: true)
            switchAppointmentRemidner.setOn(true, animated: true)
            
            
            UserDefaults().set(true, forKey: "ReminderSwitch")
            UserDefaults().set(true, forKey: "ReminderMedicationSwitch")
            UserDefaults().set(true, forKey: "ReminderAppointmentSwitch")
            UserDefaults().set(true, forKey: "ReminderDiseaseSwitch")
            
            setNotifications(reminderModelObjs: reminderObj)
            UserDefaults().synchronize()
            
        }else{
            // Off
            print(sender.isOn)
            
            UserDefaults().set(false, forKey: "ReminderSwitch")
            UserDefaults().set(false, forKey: "ReminderMedicationSwitch")
            UserDefaults().set(false, forKey: "ReminderAppointmentSwitch")
            UserDefaults().set(false, forKey: "ReminderDiseaseSwitch")
            
            
            switchDiseasesReminder.setOn(false, animated: true)
            switchMedicationReminder.setOn(false, animated: true)
            switchAppointmentRemidner.setOn(false, animated: true)
            
            UserDefaults().synchronize()
            if #available(iOS 10.0, *) {
                
                
                LocalNotificationHelper.sharedInstance.retrieveAllNotification(completion: { (requests) -> (Void) in
                    
                    let arrAllReminders: [UNNotificationRequest] = requests
                    
                    for aReminder in arrAllReminders{
                        //                    "Blood pressure" = "Blood pressure";
                        //                    "Blood Sugar" = "Blood Sugar";
                        if (aReminder.content.title == JMOLocalizedString(forKey: "Blood pressure", value: "")) || (aReminder.content.title == JMOLocalizedString(forKey: "Blood sugar", value: "")) {
                            print("Do not removed: \(aReminder.content.title)")
                        }else{
                            LocalNotificationHelper.sharedInstance.removeNotification([aReminder.identifier], completion: { (status) in
                                
                            })
                        }
                    }
                    
                })
                
            }
        }
        
        UserDefaults().synchronize()
    }
    
    
    public func setNotifications(reminderModelObjs: [ReminderModel]) {
        
        for reminderObj in reminderModelObjs {
            // Loop for each and every reminder
            
            print(reminderObj)
            
            
            // Daily 
            // Weekly 
            // Monthly
            // Once
            if reminderObj.reminderTime != ""{
                
                let dateSelectedFormatter = DateFormatter()
                dateSelectedFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//                dateSelectedFormatter.locale = Locale(identifier: "en_US_POSIX")
                if(AppConstants.isArabic()){
                    dateSelectedFormatter.locale = NSLocale(localeIdentifier: "ar") as Locale?
                }else{
                    dateSelectedFormatter.locale = NSLocale(localeIdentifier: "en") as Locale?
                }
                
//                dateSelectedFormatter.locale = Locale(identifier: "en_US_POSIX")
                //        dateSelectedFormatter.timeZone = NSTimeZone(abbreviation: "IST") as TimeZone!
//                dateSelectedFormatter.timeZone = NSTimeZone.local
                
                let dateFromReminder = dateSelectedFormatter.date(from: "2000-12-31 \(reminderObj.reminderTime!):00")
                
                
                let hour = getHMS(date: dateFromReminder!).0
                let minutes = getHMS(date: dateFromReminder!).1
                
                if reminderObj.reminderFrequency == JMOLocalizedString(forKey: Recurring.DailyRecurr.rawValue, value: ""){
                    // Daily
                    setNotifications(identifire: "\(reminderObj.reminderID!)", strname: reminderObj.reminderTxt, h: hour, m: minutes, s: 0, type: NotificationType.Daily, monthDay:0, week:0)
                }else if reminderObj.reminderFrequency == JMOLocalizedString(forKey: Recurring.MonthlyRecurr.rawValue, value: ""){
                    //Monthly
                    
            
                    setNotifications(identifire: "\(reminderObj.reminderID!)", strname: reminderObj.reminderTxt, h: hour, m: minutes, s: 0, type: NotificationType.Monthly, monthDay:Int(reminderObj.reminderMonthlyDay!)!, week:0)
                }else if reminderObj.reminderFrequency == JMOLocalizedString(forKey: Recurring.WeeklyRecurr.rawValue, value: ""){
                    //Weekly
                    
                    var selectedDay: Int!
                    
                    switch JMOLocalizedString(forKey: reminderObj.reminderWeaklyDay!, value: "") {
                        
                    case JMOLocalizedString(forKey: reminderObj.reminderWeaklyDay!, value: ""):
                        selectedDay = WeekDay.Sunday.rawValue
                    case JMOLocalizedString(forKey: reminderObj.reminderWeaklyDay!, value: ""):
                        selectedDay = WeekDay.Monday.rawValue
                    case JMOLocalizedString(forKey: reminderObj.reminderWeaklyDay!, value: ""):
                        selectedDay = WeekDay.Tuesday.rawValue
                    case JMOLocalizedString(forKey: reminderObj.reminderWeaklyDay!, value: ""):
                        selectedDay = WeekDay.Wednesday.rawValue
                    case JMOLocalizedString(forKey: reminderObj.reminderWeaklyDay!, value: ""):
                        selectedDay = WeekDay.Thursday.rawValue
                    case JMOLocalizedString(forKey: reminderObj.reminderWeaklyDay!, value: ""):
                        selectedDay = WeekDay.Friday.rawValue
                    case JMOLocalizedString(forKey: reminderObj.reminderWeaklyDay!, value: ""):
                        selectedDay = WeekDay.Saturday.rawValue
                    default :
                        print("")
                    }
                    
                    
                    setNotifications(identifire: "\(reminderObj.reminderID!)", strname: reminderObj.reminderTxt, h: hour, m: minutes, s: 0, type: NotificationType.Weekly, monthDay:0, week:selectedDay)
                }else if reminderObj.reminderFrequency == ""{
                    //Once
                    
                    let dateFromReminder1 = dateSelectedFormatter.date(from: "\(reminderObj.reminderDate!) \(reminderObj.reminderTime!):00")
                    
                    let calendar = Calendar.current
                    let monthDay = calendar.component(.day, from: dateFromReminder1!)
                    
                    setNotifications(identifire: "\(reminderObj.reminderID!)", strname: reminderObj.reminderTxt, h: hour, m: minutes, s: 0, type: NotificationType.OnceOnly,monthDay:monthDay, week:0)

                }
            }
        }
    }
    
    /// Get hours, minutes, seconds
    ///
    /// - Parameter date: Selected date
    /// - Returns: Hours, minutes, seconds
    func getHMS(date: Date) -> (Int, Int, Int) {
        
        let date = date
        let calendar = Calendar.current
        
        let h = calendar.component(.hour, from: date)
        let m = calendar.component(.minute, from: date)
        let s = calendar.component(.second, from: date)
        print("hours = \(h):\(m):\(s)")
        
        return (h, m, s)
    }
    
    
    func setNotifications(identifire: String, strname: String, h:Int, m: Int, s: Int, type: NotificationType, monthDay: Int, week:Int) {
        
        print("identifire ==\(identifire)")
        LocalNotificationHelper.sharedInstance.createReminderNotification(identifire,"\(strname)", "\(strname)", weekDay: week, monthDay: monthDay, hour: h, minute:m, seconds: s, notificationDate: Date(), NotificationType(rawValue: type.rawValue)!)
        
    }
    
    
    @IBAction func switchBloodPressureClick(_ sender: UISwitch) {
        
        if sender.isOn {
            // On
            print(sender.isOn)
            
            UserDefaults().set(true, forKey: "BloodPressureSwitch")
            viewTimeBloodPressure.isHidden = false
            UserDefaults().synchronize()
            SwitchBloodPressure.isOn = true
            
            if isBoolTimeBP {
                setBP()
            }
        }else{
            // Off
            
            isBoolTimeBP = false
            SwitchBloodPressure.isOn = false
            
            txtReminderTime.text = ""
            
            UserDefaults().set(false, forKey: "BloodPressureSwitch")
            viewTimeBloodPressure.isHidden = true
UserDefaults().synchronize()
            
            if #available(iOS 10.0, *) {
                
                LocalNotificationHelper().retrieveAllNotification(completion: { (notificationRequest: [UNNotificationRequest]) -> (Void) in
                    
                    print(notificationRequest)
                    
                    for notifi in notificationRequest{
                        
                        if notifi.content.title != JMOLocalizedString(forKey: "Blood pressure", value: "") && notifi.content.title != JMOLocalizedString(forKey: "Blood sugar", value: "") {
                            
//                            LocalNotificationHelper().removeNotification([notifi.identifier])
                            
                            LocalNotificationHelper.sharedInstance.removeNotification([notifi.identifier], completion: { (status) in
                                
                            })
                            
                        }else{
                            print(notifi.content.title)
                        }
                    }
                    
                })
            }
            
            
        }
        
        UserDefaults().synchronize()
        
    }
    
    func setBS(){
        
        updateReminderBS()
        

    }
   
    func setBP(){
        
        // Update BP reminder time in DB tabel
        
        updateReminderPB()
        
        // Set reminder
        setNotificationsForBP(reminderModelObjs: diseaseReminder)
        
    }
    
    func updateReminderBS() {
        
        
        for dis in diseaseReminder {
            
            if dis.reminderID == 13 {
                // BS fasting
                
                DiseaseModel().updateSettingReminderTime(reminderTm:txtFastingTime.text! , type: dis.type, typeID: dis.typeID, reminderID: dis.reminderID)
                UserDefaults().set(diseaseReminder[2].reminderTime!, forKey: "BSFastingTime")
                UserDefaults().synchronize()
                let dateFromReminder2 = dateSelectedFormatter.date(from: "2000-12-31 \(txtFastingTime.text!):00")
                let hour = getHMS(date: dateFromReminder2!).0
                let minutes = getHMS(date: dateFromReminder2!).1
                
                setNotifications(identifire: "\(dis.reminderID!)", strname: "Blood sugar", h: hour, m: minutes, s: 0, type: NotificationType.Daily, monthDay: 0, week: 0)
                
            }else if dis.reminderID == 12 {
                // BS eating
                DiseaseModel().updateSettingReminderTime(reminderTm:txtEatingTime.text! , type: dis.type, typeID: dis.typeID, reminderID: dis.reminderID)
                UserDefaults().set(diseaseReminder[2].reminderTime!, forKey: "BSEatingTime")
                UserDefaults().synchronize()
                let dateFromReminder1 = dateSelectedFormatter.date(from: "2000-12-31 \(txtEatingTime.text!):00")
                let hour1 = getHMS(date: dateFromReminder1!).0
                let minutes1 = getHMS(date: dateFromReminder1!).1
                
                setNotifications(identifire: "\(dis.reminderID!)", strname: "Blood sugar", h: hour1, m: minutes1, s: 0, type: NotificationType.Daily, monthDay: 0, week: 0)
            }
        }
        
    }
    
    
    func updateReminderPB() {
        
        
        for dis in diseaseReminder {
            
            if dis.reminderID == 14 {
                // BP
                
                DiseaseModel().updateSettingReminderTime(reminderTm:txtReminderTime.text! , type: dis.type, typeID: dis.typeID, reminderID: dis.reminderID)
                UserDefaults().set(diseaseReminder[2].reminderTime!, forKey: "BPTime")
                UserDefaults().synchronize()
            }
        }
        
    }
    
    func setNotificationsForBP(reminderModelObjs: [DiseasesReminderModel]) {
        
        for reminderDisease in reminderModelObjs {
            
            if reminderDisease.reminderID == 14 {
                //            if reminderDisease.type == 1 && (JMOLocalizedString(forKey: reminderDisease.reminderTxt!, value: "") == JMOLocalizedString(forKey: "Blood pressure", value: "")){
                // BP
                
                UserDefaults().setValue(txtReminderTime.text!, forKey: "BPTime")
                UserDefaults().synchronize()
                
                let dateFromReminder = dateSelectedFormatter.date(from: "2000-12-31 \(txtReminderTime.text!):00")
                let hour = getHMS(date: dateFromReminder!).0
                let minutes = getHMS(date: dateFromReminder!).1
                setNotifications(identifire: "\(reminderDisease.reminderID!)", strname: "\(reminderDisease.reminderTxt!)", h: hour, m: minutes, s: 0, type: NotificationType.Daily, monthDay: 0, week: 0)
            }
            
        }
        
    }
    
    
    @IBAction func switchBloodSugarClick(_ sender: UISwitch) {
        
        
        if sender.isOn {
            // On
            print(sender.isOn)
        
            SwitchBloodSugar.isOn = true
            UserDefaults().set(true, forKey: "BloodSugarSwitch")
            viewtimeBloodSugar1.isHidden = false
            viewtimeBloodSugar2.isHidden = false
            UserDefaults().synchronize()
            if self.isBoolTimeBSFast && self.isBoolTimeBSEat && self.SwitchBloodSugar.isOn {
                self.setBS()
            }
            
        }else{
            // Off
            SwitchBloodSugar.isOn = false
            isBoolTimeBSEat = false
            isBoolTimeBSFast = false
            
            txtEatingTime.text = ""
            txtFastingTime.text = ""
            
            UserDefaults().set(false, forKey: "BloodSugarSwitch")
            viewtimeBloodSugar1.isHidden = true
            viewtimeBloodSugar2.isHidden = true
            UserDefaults().synchronize()
            
            if #available(iOS 10.0, *) {
            
                LocalNotificationHelper().retrieveAllNotification(completion: { (notificationRequest: [UNNotificationRequest]) -> (Void) in
                    
                    print(notificationRequest)
                    
                })
            }
            
            
        }
        
        UserDefaults().synchronize()
    }
    
    //MARK: Custom Methods
    
    
    func showTimePicker(txtField:UITextField,sender:UIButton) {
       
        if GeneralConstants.DeviceType.IS_IPAD {
            // iPad
            
            self.view.endEditing(true)
            
            MMDatePickerPopover.appearOn(originView: sender, baseViewController: self, title: "TimePicker", dateMode: .time, initialDate: Date(), maxDate: nil, timeFormat: NSLocale(localeIdentifier: "en_GB"), doneAction: { selectedDate in
                
                print("selectedDate \(selectedDate)")
                self.selectedDateTime = selectedDate
                
                self.setTimeOnButton(dat: selectedDate, txtField: txtField)
                
            
                if self.isBoolTimeBP && self.SwitchBloodPressure.isOn {
                    self.setBP()
                }
                
                if self.isBoolTimeBSFast && self.isBoolTimeBSEat && self.SwitchBloodSugar.isOn {
                    self.setBS()
                }
                
            },
                                         cancelAction: {
                                            print("cancel")
            })
            
        }else{
            // iPhone
            
            //            isBooltime = true
            datePicker.config.dateMode = .time
            datePicker.config.timeFormat = NSLocale(localeIdentifier: "en_GB")
            datePicker.show(inVC: self)
            
        }
        
    }
    
    fileprivate func setTimeOnButton(dat: Date, txtField: UITextField) {
        
        let aStrDate = timeFormatter.string(from: dat)
        txtField.text = aStrDate
        
    }
    
    //MARK: MMDatePickerDelegate
    
    /// Date picker delegate Done event
    ///
    /// - Parameters:
    ///   - amDatePicker: Picker object
    ///   - date: Selected date
    
    func mmDatePicker(_ amDatePicker: MMDatePicker, didSelect date: Date) {
        
        selectedDateTime = date
        
        if intTagTime == 100 {
            setTimeOnButton(dat: date, txtField: txtReminderTime)
            if isBoolTimeBP && SwitchBloodPressure.isOn {
                setBP()
            }
        } else if intTagTime == 101 {
            setTimeOnButton(dat: date, txtField: txtFastingTime)
            
            if self.isBoolTimeBSFast && self.isBoolTimeBSEat && self.SwitchBloodSugar.isOn {
                self.setBS()
            }
        }else if intTagTime == 102 {
            setTimeOnButton(dat: date, txtField: txtEatingTime)
            
            if self.isBoolTimeBSFast && self.isBoolTimeBSEat && self.SwitchBloodSugar.isOn {
                self.setBS()
            }
        }
    }
    
    
    /// Date picker cancel delegate
    ///
    /// - Parameter amDatePicker: Picker object
    func mmDatePickerDidCancelSelection(_ amDatePicker: MMDatePicker) {
        // NOP
    }
    
    
}
