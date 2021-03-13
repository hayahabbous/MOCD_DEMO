//
//  LocalNotificationHelper.swift
//  LocalNotificationSwiftDemo
//
//  Created by indianic on 16/01/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit
import UserNotifications

enum NotificationType: String {
    
    case Minutes = "Minutes"
    case Hourly = "Hourly"
    case Daily = "Daily"
    case Weekly = "Weekly"
    case Monthly = "Monthly"
    case OnceOnly = "OnceOnly"
}


class LocalNotificationHelper: NSObject {
    
    // MARK:singleton sharedInstance
    static let sharedInstance = LocalNotificationHelper()
    
    /// Create local notification for tasks
    ///
    /// - Parameters:
    ///   - title: Reminder Title
    ///   - task: Reminder Description
    ///   - weekDay: Weekday (Sunday = 1 To Saturday = 7) For Weekly Reminder
    ///   - monthDay: Day of month (1 TO 30) For Monthly Reminder
    ///   - hour: Hour of Day (1 To 24) For Daily Reminder
    ///   - minute: Minutes (1 TO 60) For Hourly Reminder
    ///   - notificationDate: Notification Date for Only Once Reminder
    ///   - repeatMode: Notification Type
    
    func createReminderNotification(_ reminderId: String,_ title: String,_ task: String,weekDay: Int = 0, monthDay: Int = 0, hour: Int = 0, minute: Int = 0, seconds: Int = 00, notificationDate: Date = Date(),_ repeatMode: NotificationType) {
        
        
        if #available(iOS 10.0, *) {
            
            let content = UNMutableNotificationContent()
            content.title = "\(title)"
            content.body = "\(task)!!"
            
            
            content.sound = UNNotificationSound.default
            
            content.categoryIdentifier = Identifiers.reminderCategory
            
            var triggerDate = DateComponents()
            
//            triggerDate.timeZone = Locale.current
            
            switch repeatMode {
            case NotificationType.Minutes:
                triggerDate.second = seconds
                break
            case NotificationType.Hourly:
                triggerDate.minute = minute
//                triggerDate.second = seconds
                break
            case NotificationType.Daily:
                triggerDate.hour = hour
                triggerDate.minute = minute
//                triggerDate.second = seconds
                break
            case NotificationType.Weekly:
                triggerDate.weekday = weekDay
                triggerDate.hour = hour
                triggerDate.minute = minute
//                triggerDate.second = seconds
                break
            case NotificationType.Monthly:
                triggerDate.day = monthDay
                triggerDate.hour = hour
                triggerDate.minute = minute
//                triggerDate.second = seconds
                break
            case NotificationType.OnceOnly:
//                triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: notificationDate)
//                triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: notificationDate)
                print("triggerDate = \(triggerDate)")
                
                
                
//                triggerDate.year = year
//                triggerDate.month = .month
                triggerDate.day = monthDay
                triggerDate.hour = hour
                triggerDate.minute = minute
                
                print("triggerDate day= \(triggerDate.day)")
                print("triggerDate hour= \(triggerDate.hour)")
                print("triggerDate minute= \(triggerDate.minute)")
                
                break
            }
            
            
            let repeatNotification:Bool = (repeatMode != NotificationType.OnceOnly ? true : false)
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate,
                                                        repeats: repeatNotification)
            
            
            // Simply use the task name as our identifier. This means we have a single notification per task... any other notifications created with same identifier will overwrite the existing notification.
            let identifier = "\(reminderId)"
            
            // Construct the request with the above components
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) {
                error in
                if let error = error {
                    print("Problem adding notification: \(error.localizedDescription)")
                }
                else {
                    print("Notification set for task : \(task)")
                }
            }
        }
        else{
            // iOS 9 and below support
            
            let localNotification = UILocalNotification()
            localNotification.alertTitle = String(title)
            localNotification.alertBody = String(task)
            localNotification.soundName = UILocalNotificationDefaultSoundName
            localNotification.category = Identifiers.reminderCategory
            localNotification.timeZone = NSTimeZone.system
            localNotification.userInfo = ["identifier": reminderId]
            
            //            localNotification.alertAction = "View List"
            
            var triggerDate = DateComponents()
            var notificationFireDate = Date()
            switch repeatMode {
            case NotificationType.Minutes:
                triggerDate.second = seconds
                notificationFireDate = Calendar.current.date(from: triggerDate)!
                localNotification.repeatInterval = NSCalendar.Unit.minute
                break
            case NotificationType.Hourly:
                triggerDate.minute = minute
                triggerDate.second = seconds
                notificationFireDate = Calendar.current.date(from: triggerDate)!
                localNotification.repeatInterval = NSCalendar.Unit.hour
                break
            case NotificationType.Daily:
                triggerDate.hour = hour
                triggerDate.minute = minute
                triggerDate.second = seconds
                notificationFireDate = Calendar.current.date(from: triggerDate)!
                localNotification.repeatInterval = NSCalendar.Unit.day
                break
            case NotificationType.Weekly:
                triggerDate.weekday = weekDay
                triggerDate.hour = hour
                triggerDate.minute = minute
                triggerDate.second = seconds
                triggerDate.weekOfYear = Calendar.current.component(.weekOfYear, from: notificationDate)
                notificationFireDate = Calendar.current.date(from: triggerDate)!
                localNotification.repeatInterval = NSCalendar.Unit.weekOfYear
                break
            case NotificationType.Monthly:
                triggerDate.day = monthDay
                triggerDate.hour = hour
                triggerDate.minute = minute
                triggerDate.second = seconds
                notificationFireDate = Calendar.current.date(from: triggerDate)!
                localNotification.repeatInterval = NSCalendar.Unit.month
                break
            case NotificationType.OnceOnly:
                triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: notificationDate)
                notificationFireDate = Calendar.current.date(from: triggerDate)!
                break
            }
            
            // Scheduling Notification
            localNotification.fireDate = notificationFireDate
            UIApplication.shared.scheduleLocalNotification(localNotification)
            
        }
    }
    
    
    /// Attempts to find the notification scheduled for the given task name.
    @available(iOS 10.0, *)
    func retrieveNotification(for task: String, completion: @escaping (UNNotificationRequest?) -> ()) {
        UNUserNotificationCenter.current().getPendingNotificationRequests {
            requests in
            // The pending requests are fetched on a background thread, so need to ensure we access our properties and UI elements on main thread
            DispatchQueue.main.async {
                let request = requests.filter { $0.identifier == task }.first
                completion(request)
            }
        }
    }
    
    
    
    func retriveNotificationForiOS9Below(task: String, completion: @escaping ([UILocalNotification]) -> ()) {
        var localNotify = [UILocalNotification]()
        for notification in UIApplication.shared.scheduledLocalNotifications! as [UILocalNotification] {
            localNotify.append(notification)
            
        }
        completion(localNotify)
    }
    
    
    /// Remove Notification with task name
    ///
    /// - Parameter task: Array of tasks
    
    @available(iOS 9.0, *)
    func retriveAllNotificationForiOS9Below(completion: @escaping ([UILocalNotification]) -> ()) {
        var localNotify = [UILocalNotification]()
        for notification in UIApplication.shared.scheduledLocalNotifications! as [UILocalNotification] {
            localNotify.append(notification)
        }
        completion(localNotify)
    }
    
    func removeNotification(_ task: [String],completion:@escaping (Bool) -> ()){
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: task)
            completion(true)
        }else{
            self.retriveAllNotificationForiOS9Below(completion: { (notificaitons) in
                print(notificaitons)
                
                let uilocalNotificationList: [UILocalNotification] = notificaitons
                
                let aFilterNotification : [UILocalNotification] = uilocalNotificationList.filter({ (objNotification) -> Bool in
                    return (objNotification.userInfo!["identifier"] as! String) == task.first
                })
                
                if aFilterNotification.count > 0{
                    for objDeleteNotification in aFilterNotification{
                        UIApplication.shared.cancelLocalNotification(objDeleteNotification)
                    }
                    completion(true)
                }
                else{
                    completion(false)
                }
            })
        }
    }
    
    
    
    
    /// Remove All Pending Notificaitons
    func removeAllPendingNotifications() -> Void {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        }
        else{
            // iOS 9 and below support
            UIApplication.shared.cancelAllLocalNotifications()
        }
    }
    
    
    /// Remove All Delivered Notifications
    func removeAllDeliveredNotifications() -> Void {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        }
        else{
            // iOS 9 and below support
            UIApplication.shared.cancelAllLocalNotifications()
        }
    }
    
    
    
    //MARK:- Retrieve All Notifications
    // Retrieve All Notifications
    @available(iOS 10.0, *)
    func retrieveAllNotification(completion:@escaping ([UNNotificationRequest]) -> (Void)){
        UNUserNotificationCenter.current().getPendingNotificationRequests {
            requests in
            completion(requests)
        }
    }
    
    
    
    //MARK:- Rescheduled All Notification
    @available(iOS 10.0, *)
    func rescheduleAllNotification(_ arrNotificationRequests: [UNNotificationRequest]){
        for request in arrNotificationRequests{
            UNUserNotificationCenter.current().add(request) {
                error in
                if let error = error {
                    print("Problem adding notification: \(error.localizedDescription)")
                }
                else {
                    print("Notification set for task : \(request)")
                }
            }
        }
    }
    
    @available(iOS 9.0, *)
    func rescheduleAllNotificationForiOS9Below(_ arrNotificationRequests: [UILocalNotification]){
        for request in arrNotificationRequests{
            UIApplication.shared.scheduleLocalNotification(request)
        }
    }
    
}
