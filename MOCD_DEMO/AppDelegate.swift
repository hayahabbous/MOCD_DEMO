//
//  AppDelegate.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 6/13/19.
//  Copyright © 2019 Datacellme. All rights reserved.
//

import UIKit
import CoreData

import Reachability
import MMDrawerController
import SwiftyDropbox
import SVProgressHUD
import UserNotifications

var currentViewContoller :  UIViewController? = nil
let dateSelectedFormatter = DateFormatter()


struct Identifiers {
    static let reminderCategory = "reminder"
    static let cancelAction = "cancel"
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var reach: Reachability?

    var quoteOfMonth = [QuoteOfTheMonthModel]()
    
    var mmDrawer: MMDrawerController?
    var centerViewController : AnyObject?
    var isDropBoxUpdateFromSignup: Bool = false
    
    var arrEventOnlyDay = [Int]()
    var strCurrentMonth: String!
    var isReminderOn: Bool = false
    var isBPReminderOn: Bool  = false
    var isBSReminderOn: Bool = false
    
    var aDropboxBackup = Int()
    
    var timeFormatter = DateFormatter()
    
    var diseaseReminder = [DiseasesReminderModel]()
    
    
    
    var ISIncomeMinusShown: Bool = false
    var isNoBackupAvailable: Bool = false
    
    func appDelegateShared() -> AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        
        
        //Medical Agenda
        setupMAG()
        setupED()
        /*
        let parseConfig = ParseClientConfiguration {
            $0.applicationId = AppConstants.APPLICATION_ID
            $0.clientKey = AppConstants.CLIENT_KEY
            $0.server = "https://parseapi.back4app.com/"
        }
        Parse.initialize(with: parseConfig)
        */
  
        do
        {
            self.reach = try Reachability()
        }catch {
        
        }
       
        WebService.getTokenJson { (json) in
            
            
            print(json)
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 1 {
                guard let data = json["data"] as? [String:Any] else {return}
                guard let results = data["result"] as? [String:Any] else {return}
                
                AppConstants.MASTER_TOKEN = results["accessToken"] as? String ?? ""
                
                print("MASTER TOKEN :: \(AppConstants.MASTER_TOKEN)")
            }
        }
            
        
        //self.reach!.reachableOnWWAN = false
        if UserDefaults.standard.value(forKey: "Language") as? String == nil {
            UserDefaults.standard.setValue("en", forKey: "Language")
        }
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: self.reach)
        do{
            try self.reach?.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
   
        
    
        /*
        if (PFUser.current() != nil) {
            
            
            let rootViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "mainViewController")
            self.window!.rootViewController = rootViewController
            
        }else{
            let rootViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController")
            self.window!.rootViewController = rootViewController
            
        }*/
        
        
        loadAssesmnts()
        return true
    }

    func setupMAG() {
        timeFormatter.dateFormat = "HH:mm"
        
        Database().createEditableCopyOfDatabaseIfNeeded {
            
        }
        
        dateSelectedFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateSelectedFormatter.locale = Locale(identifier: "en_US_POSIX")
        //            dateSelectedFormatter.timeZone = NSTimeZone(abbreviation: "IST") as TimeZone!
        dateSelectedFormatter.timeZone = NSTimeZone.local
        
        if !UserDefaults().bool(forKey: "VeryFirst") {
            // app install very first time- remove all previous reminder..
            
            UserDefaults().set(true, forKey: "ReminderSwitch")
            UserDefaults().set(true, forKey: "ReminderMedicationSwitch")
            UserDefaults().set(true, forKey: "ReminderAppointmentSwitch")
            UserDefaults().set(true, forKey: "ReminderDiseaseSwitch")
            
            //                UserDefaults().set(false, forKey: "ReminderSwitch")
            UserDefaults().set(true, forKey: "BloodPressureSwitch")
            UserDefaults().set(true, forKey: "BloodSugarSwitch")
            UserDefaults().set(true, forKey: "VeryFirst")
            
            UserDefaults().synchronize()
            
            isReminderOn = UserDefaults().bool(forKey: "ReminderSwitch")
            isBPReminderOn = UserDefaults().bool(forKey: "BloodPressureSwitch")
            isBSReminderOn = UserDefaults().bool(forKey: "BloodSugarSwitch")
            
            LocalNotificationHelper().removeAllPendingNotifications()
            
            // Set reminder BP & BS
            
            // set BP time
            
        }else{
            
            isReminderOn = UserDefaults().bool(forKey: "ReminderSwitch")
            isBPReminderOn = UserDefaults().bool(forKey: "BloodPressureSwitch")
            isBSReminderOn = UserDefaults().bool(forKey: "BloodSugarSwitch")
            
        }
        
        
        // Set Status bar light content
        //UIApplication.shared.statusBarStyle = .lightContent
        
        // Set Status bar background
        //let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        
        //statusBar.backgroundColor = GeneralConstants.hexStringToUIColor(hex: GeneralConstants.ColorConstants.kTop)
        
        
        // Donr by Akash Thakkar
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for:.normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for:.selected)
        
        //self.setDrawerController()
        /*
        LanguageManager.sharedInstance.setSupportedLanguages(["en", "ar"])
        LanguageManager.sharedInstance.setNotificationEnable(false)
        
        let langStr = Locale.current.languageCode
        
        let aStrUserdefultLanguage = UserDefaults.standard.value(forKey: "Language") as? String
        
        if((aStrUserdefultLanguage) != nil)
        {
            LanguageManager.sharedInstance.setLanguage((aStrUserdefultLanguage)!)
            
        }else{
            var aLangauage = langStr?.components(separatedBy: CharacterSet(charactersIn: "-"))
            
            var aLangCode: String
            if (aLangauage?[0].contains("en"))! {
                // System langaueg english
                aLangCode = "en"
            }else if (aLangauage?[0].contains("ar"))! {
                // System langaueg arabic
                aLangCode = "ar"
            }else{
                aLangCode = "en"
            }
            
            LanguageManager.sharedInstance.setLanguage(aLangCode)
            UserDefaults.standard.setValue(aLangCode, forKey: "Language")
            UserDefaults.standard.synchronize()
        }
        
        
        */
        if #available(iOS 10.0, *) {
            
            // Register ourselves as a delegate so we can be notified when actions pressed
            UNUserNotificationCenter.current().delegate = self
            
            // Request permission
            UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert, .badge]) {
                granted, error in
                if granted {
                    print("Approval granted to send notifications")
                }
            }
        }else{
            self.setupNotificationSettings()
        }
        
        
        
        self.addCategory()
        
        print(JMOLocalizedString(forKey: "Dose", value: ""))
        
        // Get quote of month from DB table quote_of_the_month
        quoteOfMonth = QuoteOfTheMonthModel().getQuoteOfTheDay()
        
        
        // Dropbox integration code. (Start)
    }
    
    func loadAssesmnts() {
        /*
        var assessmentQuery = PFQuery(className: "Aspects")
        
        assessmentQuery.findObjectsInBackground { (objects, error) in
            
            
            guard let objectsArray = objects else {return}
            for currentObject: PFObject in objectsArray {
                let aspectEl: AspectElement = AspectElement()
                
                let title = currentObject["aspect_name"] as? String ?? ""
                let objectId = currentObject.objectId ?? ""
                
                aspectEl.title = title
                aspectEl.objectId = objectId
                
                
                AppConstants.AssessmentsArray.append(aspectEl)
                
            }
            
        }*/
    }
    func setupNotificationSettings() {
        
        let notificationSettings: UIUserNotificationSettings! = UIApplication.shared.currentUserNotificationSettings
        
        if (notificationSettings.types == UIUserNotificationType()){
            // Specify the notification types.
            
            let notificationTypes: UIUserNotificationType = [UIUserNotificationType.alert, UIUserNotificationType.sound]
            
            // Specify the category related to the above actions.
            let shoppingListReminderCategory = UIMutableUserNotificationCategory()
            shoppingListReminderCategory.identifier = Identifiers.reminderCategory
            let categoriesForSettings = NSSet(objects: shoppingListReminderCategory)
            
            let newNotificationSettings = UIUserNotificationSettings.init(types: notificationTypes, categories: categoriesForSettings as? Set<UIUserNotificationCategory>)
            
            UIApplication.shared.registerUserNotificationSettings(newNotificationSettings)
        }
    }
    
    func openMG() {
        
        
        let MainStoryboard = UIStoryboard.init(name: SegueIdentifiers.kMainStoryboard.rawValue, bundle: nil)
         self.centerViewController = MainStoryboard.instantiateViewController(withIdentifier: SegueIdentifiers.kTabbarVC.rawValue) as! TabbarVC // Center Navigation Controller
        
        let leftViewController : SideMenuVC = MainStoryboard.instantiateViewController(withIdentifier: SegueIdentifiers.kSideMenuVC.rawValue) as! SideMenuVC // Left Side Drawer
        
        let rightViewController : SideMenuRightVC = MainStoryboard.instantiateViewController(withIdentifier: SegueIdentifiers.kSideMenuRightVC.rawValue) as! SideMenuRightVC // Left Side Drawer
        
        let centerNav = UINavigationController(rootViewController: self.centerViewController as! UIViewController)
        let leftSideNav = UINavigationController(rootViewController: leftViewController)
        let rightNav = UINavigationController(rootViewController: rightViewController)
        
        // disable interactive gesture
        centerNav.interactivePopGestureRecognizer?.isEnabled = false
        mmDrawer = MMDrawerController(center: centerNav, leftDrawerViewController: leftSideNav, rightDrawerViewController:rightNav)
        //            mmDrawer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode()
        
        //            mmDrawer!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.panningCenterView
        
        //            mmDrawer!.closeDrawerGestureModeMask = .all
        mmDrawer!.closeDrawerGestureModeMask = [.tapNavigationBar, .tapCenterView]
        mmDrawer!.centerHiddenInteractionMode = .none
        mmDrawer!.setMaximumLeftDrawerWidth(min(300, ((self.window?.frame.size.width)! - 60)), animated: true, completion: nil)
        mmDrawer!.showsShadow = true
        mmDrawer!.shouldStretchDrawer = true
        mmDrawer!.restorationIdentifier = SegueIdentifiers.kMMDrawer.rawValue
        mmDrawer!.setDrawerVisualStateBlock(MMDrawerVisualState.parallaxVisualStateBlock(withParallaxFactor: 5.0))
        
        let rootNav : RootNavigationController = MainStoryboard.instantiateViewController(withIdentifier: SegueIdentifiers.kRootNavigationController.rawValue) as! RootNavigationController
        rootNav.viewControllers = [mmDrawer!]
        //window!.rootViewController = rootNav
        //window!.makeKeyAndVisible()
        
        AppDelegate().appDelegateShared().topMostController().present(rootNav, animated: true, completion: nil)
    }
    func setDrawerController() {
        
        let MainStoryboard = UIStoryboard.init(name: SegueIdentifiers.kMainStoryboard.rawValue, bundle: nil)
        
        let aBoolSignUpCompleted = UserDefaults.standard.bool(forKey: kSignUpCompleted)
        
        if !aBoolSignUpCompleted
        {
            self.centerViewController = MainStoryboard.instantiateViewController(withIdentifier: SegueIdentifiers.kLanguageSelectionVC.rawValue) as! LanguageSelectionVC // Center Navigation Controller
        }
        else{
            self.centerViewController = MainStoryboard.instantiateViewController(withIdentifier: SegueIdentifiers.kTabbarVC.rawValue) as! TabbarVC // Center Navigation Controller
        }
        
        let leftViewController : SideMenuVC = MainStoryboard.instantiateViewController(withIdentifier: SegueIdentifiers.kSideMenuVC.rawValue) as! SideMenuVC // Left Side Drawer
        
        let rightViewController : SideMenuRightVC = MainStoryboard.instantiateViewController(withIdentifier: SegueIdentifiers.kSideMenuRightVC.rawValue) as! SideMenuRightVC // Left Side Drawer
        
        let centerNav = UINavigationController(rootViewController: self.centerViewController as! UIViewController)
        let leftSideNav = UINavigationController(rootViewController: leftViewController)
        let rightNav = UINavigationController(rootViewController: rightViewController)
        
        // disable interactive gesture
        centerNav.interactivePopGestureRecognizer?.isEnabled = false
        mmDrawer = MMDrawerController(center: centerNav, leftDrawerViewController: leftSideNav, rightDrawerViewController:rightNav)
        //            mmDrawer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode()
        
        //            mmDrawer!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.panningCenterView
        
        //            mmDrawer!.closeDrawerGestureModeMask = .all
        mmDrawer!.closeDrawerGestureModeMask = [.tapNavigationBar, .tapCenterView]
        mmDrawer!.centerHiddenInteractionMode = .none
        mmDrawer!.setMaximumLeftDrawerWidth(min(300, ((self.window?.frame.size.width)! - 60)), animated: true, completion: nil)
        mmDrawer!.showsShadow = true
        mmDrawer!.shouldStretchDrawer = true
        mmDrawer!.restorationIdentifier = SegueIdentifiers.kMMDrawer.rawValue
        mmDrawer!.setDrawerVisualStateBlock(MMDrawerVisualState.parallaxVisualStateBlock(withParallaxFactor: 5.0))
        
        let rootNav : RootNavigationController = MainStoryboard.instantiateViewController(withIdentifier: SegueIdentifiers.kRootNavigationController.rawValue) as! RootNavigationController
        rootNav.viewControllers = [mmDrawer!]
        window!.rootViewController = rootNav
        window!.makeKeyAndVisible()
        
    }
    
    
    /**
     Registers a notification category with the UNUserNotificationCenter.
     
     Enables us to add 'quick actions' users can interact with directly from the notification.
     */
    
    
    func addCategory() {
        
        if #available(iOS 10.0, *) {
            // Add action
            let cancelAction = UNNotificationAction(identifier: Identifiers.cancelAction,
                                                    title: "Cancel",
                                                    options: [.foreground])
            
            // Create category
            let category = UNNotificationCategory(identifier: Identifiers.reminderCategory,
                                                  actions: [cancelAction],
                                                  intentIdentifiers: [],
                                                  options: [])
            
            UNUserNotificationCenter.current().setNotificationCategories([category])
        }
        
    }
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "MOCD_DEMO")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    func topMostController() -> UIViewController {
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            
            while let presentedViewController = topController.presentedViewController {
                
                topController = presentedViewController
            }
            
            // topController should now be your topmost view controller
            return topController
        }
        return (self.window?.rootViewController)!
    }

    
    private func setNotifications(reminderModelObjs: [ReminderModel]) {
        
        for reminderObj in reminderModelObjs {
            // Loop for each and every reminder
            
            print(reminderObj)
            
            
            // Daily
            // Weekly
            // Monthly
            // Once
            if reminderObj.reminderTime != ""{
                
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
    
    func setNotifications(identifire: String, strname: String, h:Int, m: Int, s: Int, type: NotificationType, monthDay: Int, week:Int) {
        
        print("identifire ==\(identifire)")
        LocalNotificationHelper.sharedInstance.createReminderNotification(identifire,"\(strname)", "\(strname)", weekDay: week, monthDay: monthDay, hour: h, minute:m, seconds: s, notificationDate: Date(), NotificationType(rawValue: type.rawValue)!)
        
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
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
            
        case .cellular:
            print("Reachable via Cellular")
            
            
        case .none:
            print("Network not reachable")
        case .unavailable:
            print("Network not available ")
            
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    @available(iOS 10.0, *)
    public func userNotificationCenter(_ center: UNUserNotificationCenter,
                                       didReceive response: UNNotificationResponse,
                                       withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier == Identifiers.cancelAction {
            let request = response.notification.request
            print("Removing item with identifier \(request.identifier)")
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [request.identifier])
        }
        
        completionHandler()
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        // Show notifications when app is in foreground, by calling completion handler with our desired presentation type.
        completionHandler(.alert)
    }
    
    
   
    
    
}


