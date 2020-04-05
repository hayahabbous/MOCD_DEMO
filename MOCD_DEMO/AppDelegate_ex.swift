//
//  AppDelegate_ex.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 6/22/19.
//  Copyright © 2019 Datacellme. All rights reserved.
//

import Foundation
import SwiftyDropbox
import UserNotifications
import MMDrawerController
import SVProgressHUD
extension AppDelegate {
    func setupED() {
        DatabaseEdkhar.sharedInstance.createEditableCopyOfDatabaseIfNeeded {
        }
        
        self.setDrawerControllerT()
        
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
        
        
        self.addCategoryT()
    }
    
    func addCategoryT() {
        
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
    
    func setDrawerControllerT() {
        
        var aStrSignUpPin : String!
        let userInfo : [userInfoModelT] = userInfoManagerT.sharedInstance.GetAllUserInfoList()
        if userInfo.count > 0 {
            // already signuped
            aStrSignUpPin = userInfo.first?.pinForSecurity
            
            print("aStrSignUpPin = \(aStrSignUpPin)")
            
        }
        let MainStoryboard = UIStoryboard.init(name: "Tejori", bundle: nil)
        
        let aStrUserdefultLanguage = UserDefaults.standard.value(forKey: "Language")
        let aStrUserSignupStatus = UserDefaults.standard.value(forKey: "signstatus")
        
        UserDefaults.standard.set("en", forKey: "Language")
        UserDefaults.standard.set("done", forKey: "signstatus")
        if((aStrUserdefultLanguage) == nil)
        {
            
            self.centerViewController = MainStoryboard.instantiateViewController(withIdentifier: "LanguageSelectionVC") as! LanguageSelectionVCT // Center Navigation Controller
        }
        else if((aStrUserSignupStatus) == nil)
        {
            
            self.centerViewController = MainStoryboard.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC // Center Navigation Controller
        }/*
        else if(aStrSignUpPin != ""){
            self.centerViewController = MainStoryboard.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC // Center Navigation Controller
        }else{
            self.centerViewController = MainStoryboard.instantiateViewController(withIdentifier: "CommanVC") as! CommanVC // Center Navigation Controller
            
        }*/
        self.centerViewController = MainStoryboard.instantiateViewController(withIdentifier: "CommanVC") as! CommanVC // Center Navigation Controller
        let leftViewController : SideMenuVCT = MainStoryboard.instantiateViewController(withIdentifier: "SideMenuVC") as! SideMenuVCT // Left Side Drawer
        
        
        let rightViewController : SideMenuRightVCT = MainStoryboard.instantiateViewController(withIdentifier: "SideMenuRightVC") as! SideMenuRightVCT // Left Side Drawer
        
        
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
        //window!.rootViewController = rootNav
        //window!.makeKeyAndVisible()
        
    }
    func openED() {
        
        let MainStoryboard = UIStoryboard.init(name: "Tejori", bundle: nil)
        
        self.centerViewController = MainStoryboard.instantiateViewController(withIdentifier: "CommanVC") as! CommanVC // Center Navigation Controller
        let leftViewController : SideMenuVCT = MainStoryboard.instantiateViewController(withIdentifier: "SideMenuVC") as! SideMenuVCT // Left Side Drawer
        
        
        let rightViewController : SideMenuRightVCT = MainStoryboard.instantiateViewController(withIdentifier: "SideMenuRightVC") as! SideMenuRightVCT // Left Side Drawer
        
        
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
        //window!.rootViewController = rootNav
        //window!.makeKeyAndVisible()
        
        AppDelegate().appDelegateShared().topMostController().present(rootNav, animated: true, completion: nil)
    }
    
    func HandleDropboxAfterLoginT() -> Void {
        
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
                            Utility.sharedInstance.showAlert(AppDelegate().appDelegateShared().topMostController(), message: JMOLocalizedString(forKey: "Backup process done successfully", value: ""))
                        }
                        else{
                            Utility.sharedInstance.showAlert(AppDelegate().appDelegateShared().topMostController(), message: JMOLocalizedString(forKey: "No backup available", value: ""))
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
                    Utility.sharedInstance.showAlert(AppDelegate().appDelegateShared().topMostController(), message: JMOLocalizedString(forKey: "Backup process done successfully", value: ""))
                })
            })
            let btnCancelAction = UIAlertAction(title: JMOLocalizedString(forKey: "Cancel", value: ""), style: .cancel, handler: { (action) in
            })
            alertController.addAction(btnUploadAction)
            alertController.addAction(btnCancelAction)
            self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
            
        }
    }
}
