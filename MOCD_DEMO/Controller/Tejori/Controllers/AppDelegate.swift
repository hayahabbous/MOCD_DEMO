
//
//  AppDelegate.swift
//  Edkhar
//
//  Created by indianic on 27/12/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit
import UserNotifications
import MMDrawerController
import SwiftyDropbox
import SVProgressHUD


import SSZipArchive


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var mmDrawer: MMDrawerController?
    var centerViewController : AnyObject?
    var isNoBackupAvailable: Bool = false
    var ISIncomeMinusShown: Bool = false
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UIApplication.shared.statusBarStyle = .lightContent
        Utility.sharedInstance.setStatusBarBackgroundColor(color: Utility.sharedInstance.uicolorFromHex(rgbValue: 0x00843D))
        
        
        
        /**
         *  This line will Check & Copy the existing database into the applciation.
         *  Developer : Akash.
         */
        
        Database.sharedInstance.createEditableCopyOfDatabaseIfNeeded {
        }
        
        self.setDrawerController()
        
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
        
        // Dropbox integration code. (Start)
        DropboxClientsManager.setupWithAppKey(DropboxAppkey)
        
        
        if #available(iOS 10.0, *) {
            
            // LocalNotification
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
        
        
        
        return true
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
    
    func setDrawerController() {
        
        var aStrSignUpPin : String!
        let userInfo : [userInfoModel] = userInfoManager.sharedInstance.GetAllUserInfoList()
        if userInfo.count > 0 {
            // already signuped
            aStrSignUpPin = userInfo.first?.pinForSecurity as String!
            
            print("aStrSignUpPin = \(aStrSignUpPin)")
            
        }
        let MainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        let aStrUserdefultLanguage = UserDefaults.standard.value(forKey: "Language")
        let aStrUserSignupStatus = UserDefaults.standard.value(forKey: "signstatus")
        
        if((aStrUserdefultLanguage) == nil)
        {
            
            self.centerViewController = MainStoryboard.instantiateViewController(withIdentifier: "LanguageSelectionVC") as! LanguageSelectionVC // Center Navigation Controller
        }
        else if((aStrUserSignupStatus) == nil)
        {
            
            self.centerViewController = MainStoryboard.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC // Center Navigation Controller
        }
        else if(aStrSignUpPin != ""){
            self.centerViewController = MainStoryboard.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC // Center Navigation Controller
        }else{
            self.centerViewController = MainStoryboard.instantiateViewController(withIdentifier: "CommanVC") as! CommanVC // Center Navigation Controller
            
        }
        
        let leftViewController : SideMenuVC = MainStoryboard.instantiateViewController(withIdentifier: "SideMenuVC") as! SideMenuVC // Left Side Drawer
        
        
        let rightViewController : SideMenuRightVC = MainStoryboard.instantiateViewController(withIdentifier: "SideMenuRightVC") as! SideMenuRightVC // Left Side Drawer
        
        
        let centerNav = UINavigationController(rootViewController: self.centerViewController as! UIViewController)
        let leftSideNav = UINavigationController(rootViewController: leftViewController)
        let rightNav = UINavigationController(rootViewController: rightViewController)
        
        mmDrawer = MMDrawerController(center: centerNav, leftDrawerViewController: leftSideNav, rightDrawerViewController:rightNav)
        mmDrawer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode()
        mmDrawer!.closeDrawerGestureModeMask = [.tapNavigationBar, .tapCenterView]
        //        mmDrawer!.openDrawerGestureModeMask = MMOpenDrawerGestureMode.panningCenterView
        //        mmDrawer!.closeDrawerGestureModeMask = MMCloseDrawerGestureMode.panningCenterView
        
        
//        mmDrawer!.closeDrawerGestureModeMask = .all
        mmDrawer!.centerHiddenInteractionMode = .none
        mmDrawer!.setMaximumLeftDrawerWidth(min(300, ((self.window?.frame.size.width)! - 60)), animated: true, completion: nil)
        mmDrawer!.showsShadow = true
        mmDrawer!.shouldStretchDrawer = true
        mmDrawer!.restorationIdentifier = "MMDrawer"
        mmDrawer!.setDrawerVisualStateBlock(MMDrawerVisualState.parallaxVisualStateBlock(withParallaxFactor: 5.0))
        
        let rootNav : RootNavigationController = MainStoryboard.instantiateViewController(withIdentifier: "RootNavigationController") as! RootNavigationController
        rootNav.viewControllers = [mmDrawer!]
        window!.rootViewController = rootNav
        window!.makeKeyAndVisible()
        
    }
    
    func HandleDropboxAfterLogin() -> Void {
        
        if  (currentViewContoller != nil) && (currentViewContoller is SignupVC) {
            
            let alertController = UIAlertController(title:  JMOLocalizedString(forKey: "Edkhar", value: ""), message: JMOLocalizedString(forKey: "Dropbox restore ?", value: ""), preferredStyle: .alert)
            
            let btnDownloadAction = UIAlertAction(title: JMOLocalizedString(forKey: "Download", value: ""), style: .default, handler: { (action) in
                DispatchQueue.main.asyncAfter(wallDeadline: .now(), execute: {
                    SVProgressHUD.show()
                })
                
                Utility.sharedInstance.DownloadFileFromDropboxAC(completionBlock: { (status) in
                    DispatchQueue.main.asyncAfter(wallDeadline: .now(), execute: {
                        SVProgressHUD.dismiss()
                        if status {
                            Utility.sharedInstance.showAlert(AppDelegate.getAppDelegate().topMostController(), message: JMOLocalizedString(forKey: "Backup process done successfully", value: ""))
                        }
                        else{
                            Utility.sharedInstance.showAlert(AppDelegate.getAppDelegate().topMostController(), message: JMOLocalizedString(forKey: "No backup available", value: ""))
                        }
                    })
                })
            })
            let btnCancelAction = UIAlertAction(title: JMOLocalizedString(forKey: "Cancel", value: ""), style: .cancel, handler: { (action) in
                
            })
            alertController.addAction(btnCancelAction)
            alertController.addAction(btnDownloadAction)
            self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
            
            
        }else{
            
            let alertController = UIAlertController(title:  JMOLocalizedString(forKey: "Edkhar", value: ""), message: JMOLocalizedString(forKey: "Backup to Dropbox?", value: ""), preferredStyle: .alert)
            let btnUploadAction = UIAlertAction(title: JMOLocalizedString(forKey: "Upload", value: ""), style: .default, handler: { (action) in
                
                DispatchQueue.main.asyncAfter(wallDeadline: .now(), execute: {
                    SVProgressHUD.show()
                })
                Utility.sharedInstance.UploadFileToDropboxAC()
                
                DispatchQueue.main.asyncAfter(wallDeadline: .now() + 3, execute: {
                    SVProgressHUD.dismiss()
                    Utility.sharedInstance.showAlert(AppDelegate.getAppDelegate().topMostController(), message: JMOLocalizedString(forKey: "Backup process done successfully", value: ""))
                })
            })
            let btnCancelAction = UIAlertAction(title: JMOLocalizedString(forKey: "Cancel", value: ""), style: .cancel, handler: { (action) in
            })
            alertController.addAction(btnUploadAction)
            alertController.addAction(btnCancelAction)
            self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
            
        }
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        if let authResult = DropboxClientsManager.handleRedirectURL(url) {
            switch authResult {
            case .success:
                print("Success! User is logged into DropboxClientsManager.")
//                Utility.sharedInstance.showAlert(AppDelegate.getAppDelegate().topMostController(), message: "Success! User is logged into Dropbox.")
                self.HandleDropboxAfterLogin()
                
            case .cancel:
                print("Authorization flow was manually canceled by user!")
            case .error(_, let description):
                print("Error: \(description)")
            }
        }
        
        return true
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
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        print("Notification userinfo = \(userInfo)")
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        
        print("notification.alertBody = \(notification.alertBody)")
        print("notification.alertTitle = \(notification.alertTitle)")
        
        Utility.sharedInstance.showAlertWithTitleMsg(appDelegate.topMostController(), title: notification.alertTitle!, message: notification.alertBody!)
        
    }
    
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, for notification: UILocalNotification, completionHandler: @escaping () -> Void) {
        
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
        completionHandler([.sound, .alert])
    }
}

extension AppDelegate {
    class func getAppDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}
