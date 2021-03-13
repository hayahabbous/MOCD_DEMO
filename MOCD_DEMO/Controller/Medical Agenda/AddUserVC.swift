//
//  AddUserVC.swift
//  SmartAgenda
//
//  Created by indianic on 27/12/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit
import EventKit
import UserNotifications

class AddUserVC: UIViewController {

    @IBOutlet weak var tfUserdob: UITextField!
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var btnReminder: UIButton!
    @IBOutlet weak var constraintPickerBottom: NSLayoutConstraint!
    @IBOutlet weak var pickerDateTime: UIDatePicker?
    @IBOutlet weak var tfReminderDatetime: UITextField!
    @IBOutlet weak var switchReminder: UISwitch!
    
    var toolBar = UIToolbar()
    
    var objUserInfoModel : userInfoModel?
    
    // Sheduel Reminder objects.
    var eventStore : EKEventStore!
    var reminders: [EKReminder]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.objUserInfoModel != nil {
            tfUsername.text = self.objUserInfoModel?.name
            tfUserdob.text = self.objUserInfoModel?.dob
        }
        
        self.PickerviewSetup()
        self.pickerDateTime?.minimumDate = NSDate() as Date
    }
    
    func PickerviewSetup() -> Void {
        
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0, y: (self.pickerDateTime?.frame.origin.y)!-260, width: 300, height: 44))
        toolBar.barStyle = UIBarStyle.blackOpaque
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(doneAction))
        doneButton.tintColor = UIColor.white
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action:#selector(cancelAction))
         cancelButton.tintColor = UIColor.white
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        self.view.addSubview(toolBar)
        toolBar.isHidden = true
    }

    @objc func doneAction() -> Void {

        self.constraintPickerBottom.constant = -216.0
        toolBar.isHidden = true
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        
        let strDate = dateFormatter.string(from: (self.pickerDateTime?.date)!)
        
        //Check if reminderDate is Greater than Right now
        if NSDate().compare((self.pickerDateTime?.date)!) == ComparisonResult.orderedDescending{
            //Do Something...
            self.showAlertController(aStrTitle: "", aStrMsg: "Please shedule reminder for future date", aTag: 0)
        }
        else{
            self.tfReminderDatetime.text = strDate
        }
    }
    
    @objc func cancelAction() -> Void {
        self.constraintPickerBottom.constant = -216.0
        toolBar.isHidden = true
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    @IBAction func btnPickerAction(_ sender: UIButton) {
        self.constraintPickerBottom.constant = 0
        toolBar.isHidden = false
    
        let date = NSDate()
        self.pickerDateTime?.setDate(date as Date, animated: true)
        
    }
    
    @IBAction func btnAddUserDoneAction(_ sender: UIBarButtonItem) {
        
        if (tfUsername.text?.isEmpty)! {
            self.showAlertController(aStrTitle: "", aStrMsg: "Enter Username", aTag: 0)
        }
        else if (tfUserdob.text?.isEmpty)! {
            self.showAlertController(aStrTitle: "", aStrMsg: "Enter Date of birth", aTag: 0)
        }
        else{
           
            if self.objUserInfoModel != nil {
                
                // Update the user details.
                
                self.objUserInfoModel?.name = tfUsername.text!
                self.objUserInfoModel?.dob = tfUserdob.text!
                
                let aInsertStatus : Bool = userInfoManager().UpdateUserInfoDetail(objUserInfo: self.objUserInfoModel!)
                if aInsertStatus == true {
                    self.showAlertController(aStrTitle: "Success", aStrMsg: "Data updated sucessfully", aTag: 0)
                }
                
            }else{
                
                // Insert the user details.
                
                let objUserModel = userInfoModel()
                objUserModel.name = tfUsername.text!
                objUserModel.dob = tfUserdob.text!
                
                let aInsertStatus : Bool = userInfoManager().InsertUserInfoDetail(objUserInfo: objUserModel)
                if aInsertStatus == true {
                    self.showAlertController(aStrTitle: "Sucess", aStrMsg: "Data entred sucessfully", aTag: 0)
                }
            }
            
            
            self.SheduleReminder()
        }
    }
    
    func SheduleReminder() -> Void {
        
        if self.switchReminder.isOn && !(self.tfReminderDatetime.text?.isEmpty)!{
            // shedule the reminder for the date.
        
            print("Reminder Date time = \(self.tfReminderDatetime.text!)")
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
//            dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone!
            dateFormatter.timeZone = NSTimeZone.local
            let aReminderDate = dateFormatter.date(from: self.tfReminderDatetime.text!)!
            print("aReminderDate = \(aReminderDate)")
            
            
            // Register reminder with date time.
            self.eventStore = EKEventStore()
            self.reminders = [EKReminder]()
            self.eventStore.requestAccess(to: EKEntityType.reminder, completion: { (granted : Bool, error : Error?) in
                if granted == true{
                    
                    let reminder = EKReminder(eventStore: self.eventStore)
                    reminder.title = "Reminder of app"
                    reminder.calendar = self.eventStore.defaultCalendarForNewReminders()
                    let calendar = Calendar(identifier: .gregorian)
                    reminder.dueDateComponents = calendar.dateComponents(in: .current, from: aReminderDate)
                    let alarm = EKAlarm(absoluteDate: aReminderDate)
                    alarm.proximity = EKAlarmProximity.enter
                    reminder.addAlarm(alarm)
                    
                    do{
                        try self.eventStore.save(reminder, commit: true)
                        self.scheduleNotification(at: aReminderDate)
                    }catch{
                         print("Error creating and saving new reminder : \(error)")
                    }
                }
                else{
                    self.showAlertController(aStrTitle: "", aStrMsg: "The app is not permitted to access reminders, make sure to grant permission in the settings and try again!", aTag: 0)
                }
            })
        }
    }
    
    
    func scheduleNotification(at date: Date) {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: .current, from: date)
        let newComponents = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
        
//        if #available(iOS 10.0, *) {
//            let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: false)
//        
//            let content = UNMutableNotificationContent()
//            content.title = "Tutorial Reminder"
//            content.body = "Just a reminder to read your tutorial over at appcoda.com!"
//            content.sound = UNNotificationSound.default()
//            content.categoryIdentifier = "myCategory"
//            content.badge = (UIApplication.shared.applicationIconBadgeNumber + 1) as NSNumber
//            
//        
//        
//        if let path = Bundle.main.path(forResource: "logo", ofType: "png") {
//            let url = URL(fileURLWithPath: path)
//            
//            do {
//                    let attachment = try UNNotificationAttachment(identifier: "logo", url: url, options: nil)
//                content.attachments = [attachment]
//            } catch {
//                print("The attachment was not loaded.")
//            }
//        }
//        
//            let request = UNNotificationRequest(identifier: "textNotification", content: content, trigger: trigger)
//        let delegate = UIApplication.shared.delegate as? AppDelegate
//            UNUserNotificationCenter.current().delegate = delegate
//            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
//        
//        
//        
//            UNUserNotificationCenter.current().add(request) {(error) in
//                if let error = error {
//                    print("Uh oh! We had an error: \(error)")
//                }
//            }
//        } else {
//            // Fallback on earlier versions
//        }
    }
    
    func dateComponentFromNSDate(date: NSDate)-> NSDateComponents{
        
        // *** Create date ***
        let date = NSDate()
        
        // *** create calendar object ***
        var calendar = NSCalendar.current
        
        // *** Get components using current Local & Timezone ***
        print(calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date as Date))
        
        // *** define calendar components to use as well Timezone to UTC ***
        let unitFlags = Set<Calendar.Component>([.hour, .year, .minute])
//        calendar.timeZone = TimeZone(identifier: "UTC")!
        calendar.timeZone = NSTimeZone.local
        
        
        // *** Get components from date ***
        let components = calendar.dateComponents(unitFlags, from: date as Date)
        print("Components : \(components)")
        
        return components as NSDateComponents
    }
    
    func showAlertController(aStrTitle : String , aStrMsg : String , aTag : Int) -> Void {
        let aAlertController = UIAlertController.init(title: aStrTitle, message: aStrMsg, preferredStyle: UIAlertController.Style.alert)
        let aAlertAction = UIAlertAction.init(title: kOK, style: UIAlertAction.Style.default) { (action) in
            if aTag == 1{
                _ = self.navigationController?.popViewController(animated: true)
            }
        }
        aAlertController.addAction(aAlertAction)
        self.present(aAlertController, animated: true, completion: nil)
    }
    
    @IBAction func reminderStatus(_ sender: UISwitch) {
        
    }
}

extension AddUserVCT: UNUserNotificationCenterDelegate {
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        // Response has actionIdentifier, userText, Notification (which has Request, which has Trigger and Content)
        switch response.actionIdentifier {
            //        case UNNotificationAction.HighFive.rawValue:
            //            case UNNotificationAction
        //            print("High Five Delivered!")
        default: break
        }
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        // Delivers a notification to an app running in the foreground.
    }
}
