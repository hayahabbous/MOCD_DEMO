//
//  SideMenuVC.swift
//  Edkhar
//
//  Created by indianic on 31/12/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit
import MMDrawerController

class SideMenuVCT: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var tblSidemenu: UITableView!

    var arrSidemenuList = [String]()
    var arrSidemenuImgList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = true
        
        // Do any additional setup after loading the view.
        self.tblSidemenu.tableFooterView = UIView()
        
        if (ConstantsT.DeviceType.IS_IPAD) {
            Utility.sharedInstance.customizeFonts(in: tblSidemenu, aFontName: Medium, aFontSize: 6)
        }else{
            Utility.sharedInstance.customizeFonts(in: tblSidemenu, aFontName: Medium, aFontSize: 0)
        }
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        self.arrSidemenuList = [JMOLocalizedString(forKey: "User Profile", value: ""),JMOLocalizedString(forKey: "Reminder", value: ""),JMOLocalizedString(forKey: "Share on Social media", value: ""),JMOLocalizedString(forKey: "Contact Us", value: ""),JMOLocalizedString(forKey: "About US", value: ""),JMOLocalizedString(forKey: "Feedback", value: ""),JMOLocalizedString(forKey: "ENGLISH/عربي", value: ""),JMOLocalizedString(forKey: "Backup to Dropbox", value: "")]
//
        
        self.arrSidemenuImgList = ["ic_userprofile","ic_reminder","ic_audiotext","ic_contactus","ic_aboutus","ic_feedback","ic_language","ic_dropbox"]
//        ,"ic_language"
        
        self.tblSidemenu.reloadData()
        
        LanguageManager.sharedInstance.localizeThingsInView(parentView: self.tblSidemenu)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSidemenuList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let SideMenuCell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell", for: indexPath) as! SideMenuCellT
        
        SideMenuCell.lblSidemenuTitle.text = arrSidemenuList[indexPath.row]
        SideMenuCell.imgSidemenu?.image = UIImage(named: self.arrSidemenuImgList[indexPath.row])
        LanguageManager.sharedInstance.localizeThingsInView(parentView: SideMenuCell)
        
        return SideMenuCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        appDelegate.mmDrawer?.closeDrawer(animated: false, completion: { (status) in
        
            let aStrSideMenuOps = self.arrSidemenuList[indexPath.row] as String?
            let arrNavigationArr = appDelegate.mmDrawer?.centerViewController as! UINavigationController
            
            var indexComman : Int = 0
            for objViewcontoller in arrNavigationArr.viewControllers {
                if objViewcontoller is CommanVC {
                    indexComman = arrNavigationArr.viewControllers.index(of: objViewcontoller)!
                    break
                }
            }
            
            let objCommanVC = arrNavigationArr.viewControllers[indexComman] as! CommanVC
            let objTabbarVC = objCommanVC.children.first as! TabbarVCT
            let objIncomeVC = objTabbarVC.viewControllers?.first as! IncomeVC
            
            
            if (aStrSideMenuOps == "ENGLISH/عربي") {
                objIncomeVC.SideMenuSelectionMethod(SideMenuIndex: 1)
            }
            else if (aStrSideMenuOps == JMOLocalizedString(forKey: "User Profile", value: "")) {
                objIncomeVC.SideMenuSelectionMethod(SideMenuIndex: 2)
            }
            else if (aStrSideMenuOps == JMOLocalizedString(forKey: "Feedback", value: "")) {
                objIncomeVC.SideMenuSelectionMethod(SideMenuIndex: 3)
            }
            else if (aStrSideMenuOps == JMOLocalizedString(forKey: "NOTES", value: "")) {
               objIncomeVC.SideMenuSelectionMethod(SideMenuIndex: 4)
            }
            else if (aStrSideMenuOps == JMOLocalizedString(forKey: "Social Activities", value: "")) {
                objIncomeVC.SideMenuSelectionMethod(SideMenuIndex: 5)
            }
            else if (aStrSideMenuOps == JMOLocalizedString(forKey: "About US", value: "")) {
                objIncomeVC.SideMenuSelectionMethod(SideMenuIndex: 6)
            }
            else if (aStrSideMenuOps == JMOLocalizedString(forKey: "Contact Us", value: "")) {
                Utility.sharedInstance.sendEmail(self, aStrToMailID: ["mocd.support@mocd.gov.ae"], aStrMailSubject: JMOLocalizedString(forKey: "MOCD- Edkhar- Contact us", value: ""), aStrMailBody: JMOLocalizedString(forKey: "Please type your message bellow then press on Send button.", value: ""))
            }
            else if (aStrSideMenuOps == JMOLocalizedString(forKey: "Share on Social media", value: "")) {
                Utility.sharedInstance.shareAppOnSocialMedia(self, aStrShareMSG: JMOLocalizedString(forKey: "Edkhar", value: ""))
            }
            else if (aStrSideMenuOps == JMOLocalizedString(forKey: "Backup to Dropbox", value: "")) {
                objIncomeVC.SideMenuSelectionMethod(SideMenuIndex: 7)
            }
            else if (aStrSideMenuOps == JMOLocalizedString(forKey: "Reminder", value: "")) {
                objIncomeVC.SideMenuSelectionMethod(SideMenuIndex: 8)
            }
            
            
        })

    }

}
