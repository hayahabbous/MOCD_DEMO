//
//  SettingViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 11/25/19.
//  Copyright © 2019 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class SettingViewController: UIViewController ,UITableViewDelegate ,UITableViewDataSource {
    
    var reloadDelegate: reloadHomePage!
    let activityData = ActivityData()
    var mocd_user = MOCDUser.getMOCDUser()
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView()
        
        
        setupView()
        
    }
    
    
    func setupView() {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "mocd_logo")
        
        let logoview = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        let logoavatarImage = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        
        logoavatarImage.setImage(logoImageView.image, for: .normal)
        logoavatarImage.imageView?.contentMode = .scaleAspectFill
        //avatarImage.imageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "profile"))
        logoavatarImage.clipView(withRadius: logoavatarImage.frame.width/2, withBoarderWidth: 0, borderColor: UIColor.clear)
        
        
        
        logoview.addSubview(logoavatarImage)
        let leftButton = UIBarButtonItem(customView: logoview)
        self.navigationItem.leftBarButtonItems = [leftButton]
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if mocd_user?.isCenter == "1" || mocd_user?.isCenter == "true".lowercased() {
            
            return 2
        }
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellIdentifier = ""
        
        
        if mocd_user?.isCenter == "1" || mocd_user?.isCenter == "true".lowercased() {
            
            cellIdentifier = "Cell"
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            if indexPath.row == 0 {
                
                cell.textLabel?.text  = "Change language".localize
                
            }else if indexPath.row == 1 {
                
                if mocd_user?.userToken == nil {
                    cell.textLabel?.text  = "Login".localize
                }else{
                    cell.textLabel?.text  = "Logout".localize
                    
                }
                
            }
            
            return cell
            
        }else {
            
            
            if indexPath.row < 4 {
                 cellIdentifier = "appCell"
                 
             }else{
                 cellIdentifier = "Cell"
             }
             let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
             
            
             
             if indexPath.row == 4 {
                 
                 cell.textLabel?.text  = "Change language".localize
                 
             }else if indexPath.row == 5 {
                 
                 if mocd_user?.userToken == nil {
                     cell.textLabel?.text  = "Login".localize
                 }else{
                     cell.textLabel?.text  = "Logout".localize
                     
                 }
                 
             }else{
                 var titleText = cell.viewWithTag(1) as! UILabel
                 var switchComponent = cell.viewWithTag(2) as! UISwitch
                 
                 switchComponent.addTarget(self, action: #selector(switchComponentChanged), for: .valueChanged)
                 switch indexPath.row {
                 case 0:
                     titleText.text = "Nemo".localize
                     switchComponent.isOn = UserDefaults.standard.value(forKey: AppConstants.isNemowEnabled) as? Bool ?? true
                 case 1:
                     titleText.text = "Edkhar".localize
                     switchComponent.isOn = UserDefaults.standard.value(forKey: AppConstants.isEdkharEnabled) as? Bool ?? true
                 case 2:
                     titleText.text = "Medical Agenda".localize
                     switchComponent.isOn = UserDefaults.standard.value(forKey: AppConstants.isMGEnabled) as? Bool ?? true
                 case 3:
                     titleText.text = "Stories".localize
                     switchComponent.isOn = UserDefaults.standard.value(forKey: AppConstants.isStoriesEnabled) as? Bool ?? true
                 default:
                     titleText.text = ""
                 }
             }
            
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if mocd_user?.isCenter == "1" || mocd_user?.isCenter == "true".lowercased() {
            
            if indexPath.row == 0{
                
               changeLanguage()
               
               
            }else if indexPath.row == 1 {
                self.logout()
            }
            
        }else if indexPath.row == 4 {
            
           changeLanguage()
           
           
        }else if indexPath.row == 5 {
            self.logout()
        }
    }
    
    func changeLanguage() {
        
        // Language selection option.
        let alertController = UIAlertController.init(title: JMOLocalizedString(forKey: "Alert", value: ""), message: JMOLocalizedString(forKey: "Choose your language", value: ""), preferredStyle: UIAlertController.Style.alert)
        let alertActionCancel = UIAlertAction.init(title: JMOLocalizedString(forKey: "Cancel", value: ""), style: UIAlertAction.Style.cancel, handler: nil)
        let alertActionLanguage = UIAlertAction.init(title: AppConstants.isArabic() ? "English" : "العربية", style: UIAlertAction.Style.default, handler: { (action) in
            
            self.LanguageChangeMethod()
        })
        
        alertController.addAction(alertActionCancel)
        alertController.addAction(alertActionLanguage)
        
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func switchComponentChanged(sender: UISwitch) {
        let position = sender.convert(CGPoint.zero, to: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: position)
        
       
        if indexPath != nil {
            switch indexPath?.row {
            case 0:
                UserDefaults.standard.set(sender.isOn, forKey: AppConstants.isNemowEnabled)
                reloadDelegate.reloadHome()
                
            case 1:
                UserDefaults.standard.set(sender.isOn, forKey: AppConstants.isEdkharEnabled)
                reloadDelegate.reloadHome()
            case 2:
                UserDefaults.standard.set(sender.isOn, forKey: AppConstants.isMGEnabled)
                reloadDelegate.reloadHome()
            case 3:
                UserDefaults.standard.set(sender.isOn, forKey: AppConstants.isStoriesEnabled)
                reloadDelegate.reloadHome()
            default:
                print("")
            }
        }
        
    }
    func logout() {
        
        
        
        let logOutAlertActionController = UIAlertController(title:"", message: NSLocalizedString("Are you sure you want to signout ?", comment:""), preferredStyle: .alert )
               
               
        let yesAlerActionOption = UIAlertAction(title:NSLocalizedString("Sure",comment:""), style: UIAlertAction.Style.default, handler: { (UIAlertAction) -> Void in
                DispatchQueue.main.async {
                     
                    NVActivityIndicatorPresenter.sharedInstance.startAnimating(self.activityData)
                }
            
            DispatchQueue.main.async {
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                UserDefaults.standard.set(nil, forKey: AppConstants.MOCDUserData)
            }
            if let window = self.view.window{
            
                
                let welcomeNavigationViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
                                   
                
                window.rootViewController = welcomeNavigationViewController
                
                window.makeKeyAndVisible()
                
                
            }
            
            let username = self.mocd_user?.username ?? ""
                /*
                WebService.logout(username: username){ (json) in
                    
                    DispatchQueue.main.async {
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                    }
                    guard let code = json["code"] as? Int else {return}
                              
                    guard let message = json["message"] as? String else {return}
                               
                    
                    if code == 200 {
                   
                        UserDefaults.standard.set(nil, forKey: AppConstants.MOCDUserData)
                        DispatchQueue.main.async {
                            if let window = self.view.window{
                            
                                
                                let welcomeNavigationViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
                                                   
                                
                                window.rootViewController = welcomeNavigationViewController
                                
                                window.makeKeyAndVisible()
                                
                                
                            }
                        }
                        
                        
                    }else{
                                
                        Utils.showAlertWith(title: "Error", message: message, viewController: UIApplication.shared.topMostViewController()!)
                                                               
                                                            
                        return
                    }
                    
                }*/
            
        })
        
        let noAlertActionOption = UIAlertAction(title:NSLocalizedString("No",comment:""), style: .default, handler: nil)
        
        logOutAlertActionController.addAction(yesAlerActionOption)
        logOutAlertActionController.addAction(noAlertActionOption)
        
        self.present(logOutAlertActionController, animated: true, completion: nil)
        
        
                           
        
        
        /*
        let logOutAlertActionController = UIAlertController(title:"", message: NSLocalizedString("Are you sure you want to signout ?", comment:""), preferredStyle: .alert )
        
        let yesAlerActionOption = UIAlertAction(title:NSLocalizedString("Sure",comment:""), style: UIAlertAction.Style.default, handler: { (UIAlertAction) -> Void in
            
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(self.activityData)
            PFUser.logOutInBackground(
                block: {(error) in
                    DispatchQueue.main.async {
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                    }
                    
                    if let window = self.view.window{
                        let welcomeNavigationViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
                        
                        window.rootViewController = welcomeNavigationViewController
                        window.makeKeyAndVisible()
                        
                    }
            }
            )
        })
        
        let noAlertActionOption = UIAlertAction(title:NSLocalizedString("No",comment:""), style: .default, handler: nil)
        
        logOutAlertActionController.addAction(yesAlerActionOption)
        logOutAlertActionController.addAction(noAlertActionOption)
        
        self.present(logOutAlertActionController, animated: true, completion: nil)*/
    }
    @IBAction func dismissView(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func setAppleLAnguageTo(lang: String) {
    
        let userdef = UserDefaults.standard
    
        if lang == "ar" {
            userdef.set("en", forKey: AppConstants.APPLE_LANGUAGE_KEY)
        }else if lang == "en" {
            userdef.set("ar", forKey: AppConstants.APPLE_LANGUAGE_KEY)
        }
        
        
        
    
        userdef.synchronize()
    }
    
   
    
  
    
    func LanguageChangeMethod() -> Void {
    
        if AppConstants.isArabic() {
            
            UserDefaults.standard.setValue(["en"], forKey: AppConstants.APPLE_LANGUAGE_KEY)
            
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }else{
            UserDefaults.standard.setValue(["ar"], forKey: AppConstants.APPLE_LANGUAGE_KEY)
            
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }
        
        let rootViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "mainViewController")
        
        let appDlg = UIApplication.shared.delegate as? AppDelegate
           
        appDlg?.window?.rootViewController = rootViewController
        
        Bundle.swizzleLocalization()
        UserDefaults.standard.synchronize()
    }
    
}

