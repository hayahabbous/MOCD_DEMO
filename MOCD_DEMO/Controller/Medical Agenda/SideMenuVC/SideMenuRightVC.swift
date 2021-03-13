//
//  SideMenuRightVC.swift
//  SwiftDatabase
//
//  Created by indianic on 31/12/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit
import MMDrawerController

class SideMenuRightVC: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var tblSidemenu: UITableView!
    @IBOutlet weak var footerView: UIView!

    var arrSidemenuList = [String]()
    var arrSidemenuIconList = [String]()
    var arrBottomBar = [String]()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tblSidemenu.tableFooterView = UIView()
        tblSidemenu.tableFooterView = footerView
        self.navigationController?.isNavigationBarHidden = true
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.arrSidemenuList = [
            JMOLocalizedString(forKey: "Appointment", value: ""),
            JMOLocalizedString(forKey: "Medicine plan", value: ""),
            JMOLocalizedString(forKey: "Social Activities", value: ""),
            JMOLocalizedString(forKey: "Independent daily activities", value: ""),
            JMOLocalizedString(forKey: "User Diseases", value: ""),
            JMOLocalizedString(forKey: "Notes", value: ""),
            JMOLocalizedString(forKey: "User profile", value: ""),
            JMOLocalizedString(forKey: "English/عربى", value: ""),
            JMOLocalizedString(forKey: "Backup to Dropbox", value: "")
            
            
            
            
            
            //            JMOLocalizedString(forKey: "Contact us", value: ""),
            //            JMOLocalizedString(forKey: "About us", value: ""),
            //            JMOLocalizedString(forKey: "Feedback", value: ""),
            //
            //            JMOLocalizedString(forKey: "Share on Social media", value: ""),
            //            JMOLocalizedString(forKey: "Settings", value: "")
        ]
        
        arrSidemenuIconList = ["sidemenu_06",
                               "sidemenu_10",
                               "sidemenu_12",
                               "sidemenu_14",
                               "sidemenu_16",
                               "sidemenu_18",
                               "sidemenu_20",
                               "sidemenu_22",
                               "Dropbox icon"]
    
        self.arrBottomBar = [
            JMOLocalizedString(forKey: "Setting", value: ""),
            JMOLocalizedString(forKey: "Contact us", value: ""),
            JMOLocalizedString(forKey: "About us", value: ""),
            JMOLocalizedString(forKey: "Feedback", value: ""),
        ]
        
        self.tblSidemenu.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrSidemenuList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sideMenuCell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell", for: indexPath) as! SideMenuCell
        sideMenuCell.lblSidemenuTitle.text = arrSidemenuList[indexPath.row]
        
        sideMenuCell.imgViewIcon.image = UIImage(named: arrSidemenuIconList[indexPath.row])

        if GeneralConstants.DeviceType.IS_IPAD {
            customizeFonts(in: sideMenuCell.lblSidemenuTitle, aFontName: Bold, aFontSize: 0)
        }else{
            customizeFonts(in: sideMenuCell.lblSidemenuTitle, aFontName: Bold, aFontSize: 0)
        }
        
        return sideMenuCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        appDelegate.mmDrawer?.closeDrawer(animated: false, completion: { (status) in
            
            let aStrSideMenuOps = self.arrSidemenuList[indexPath.row] as? String
            let arrNavigationArr = appDelegate.mmDrawer?.centerViewController as! UINavigationController
            var indexTabbar : Int = 1
            for objViewcontoller in arrNavigationArr.viewControllers {
                if objViewcontoller is TabbarVC {
                    indexTabbar = arrNavigationArr.viewControllers.index(of: objViewcontoller)!
                    break
                }
            }
            
            let objTabbarVC = arrNavigationArr.viewControllers[indexTabbar] as! TabbarVC
            objTabbarVC.handleTabbarLocalization()
            
            switch objTabbarVC.selectedIndex {
                
            case 0:
                let objCntrlCal = objTabbarVC.viewControllers?[0] as! CalenderVC
                self.sidepanelClickCalendar(aStrSideMenuOps: aStrSideMenuOps!, obj: objCntrlCal)
                
            case 1:
                let objCntrlChecklist = objTabbarVC.viewControllers?[1] as! ChecklistVC
                self.sidepanelClickChecklist(aStrSideMenuOps: aStrSideMenuOps!, obj: objCntrlChecklist)
                
            case 2:
                let objCntrlReportVC = objTabbarVC.viewControllers?[2] as! ReportVC
                self.sidepanelClickReport(aStrSideMenuOps: aStrSideMenuOps!, obj: objCntrlReportVC)
                
            default:
                print("Default")
                
            }
            
            
            /*
             Independent daily activities.
             Diseases
             Settings
             Language
             */
            
   
        })
    }
    
    private func sidepanelClickCalendar(aStrSideMenuOps: String, obj: CalenderVC) {
        
        if (aStrSideMenuOps == JMOLocalizedString(forKey: "English/عربى", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 1)
        }
        else if (aStrSideMenuOps == JMOLocalizedString(forKey: "Feedback", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 2)
        }
        else if (aStrSideMenuOps == JMOLocalizedString(forKey: "Appointment", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 3)
        }
        else if (aStrSideMenuOps == JMOLocalizedString(forKey: "Notes", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 4)
        }
        else if (aStrSideMenuOps == JMOLocalizedString(forKey: "Social Activities", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 5)
        }else if (aStrSideMenuOps == JMOLocalizedString(forKey: "Medicine plan", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 6)
        }else if (aStrSideMenuOps == JMOLocalizedString(forKey: "User Diseases", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 7)
        }else if (aStrSideMenuOps == JMOLocalizedString(forKey: "Independent daily activities", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 8)
        }else if (aStrSideMenuOps == JMOLocalizedString(forKey: "Backup to Dropbox", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 9)
        }else if (aStrSideMenuOps == JMOLocalizedString(forKey: "About us", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 10)
        }else if (aStrSideMenuOps == JMOLocalizedString(forKey: "User profile", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 11)
        }else if (aStrSideMenuOps == JMOLocalizedString(forKey: "Contact us", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 12)
        }else if (aStrSideMenuOps == JMOLocalizedString(forKey: "Share on Social media", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 13)
        }else if (aStrSideMenuOps == JMOLocalizedString(forKey: "Setting", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 14)
        }
    }
    
    private func sidepanelClickChecklist(aStrSideMenuOps: String, obj: ChecklistVC) {
        
        
        if (aStrSideMenuOps == JMOLocalizedString(forKey: "English/عربى", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 1)
        }
        else if (aStrSideMenuOps == JMOLocalizedString(forKey: "Feedback", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 2)
        }
        else if (aStrSideMenuOps == JMOLocalizedString(forKey: "Appointment", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 3)
        }
        else if (aStrSideMenuOps == JMOLocalizedString(forKey: "Notes", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 4)
        }
        else if (aStrSideMenuOps == JMOLocalizedString(forKey: "Social Activities", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 5)
        }else if (aStrSideMenuOps == JMOLocalizedString(forKey: "Medicine plan", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 6)
        }else if (aStrSideMenuOps == JMOLocalizedString(forKey: "User Diseases", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 7)
        }else if (aStrSideMenuOps == JMOLocalizedString(forKey: "Independent daily activities", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 8)
        }else if (aStrSideMenuOps == JMOLocalizedString(forKey: "Backup to Dropbox", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 9)
        }else if (aStrSideMenuOps == JMOLocalizedString(forKey: "About us", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 10)
        }else if (aStrSideMenuOps == JMOLocalizedString(forKey: "User profile", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 11)
        }else if (aStrSideMenuOps == JMOLocalizedString(forKey: "Contact us", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 12)
        }else if (aStrSideMenuOps == JMOLocalizedString(forKey: "Share on Social media", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 13)
        }else if (aStrSideMenuOps == JMOLocalizedString(forKey: "Setting", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 14)
        }
    }
    
    
    private func sidepanelClickReport(aStrSideMenuOps: String, obj: ReportVC) {
        
        
        if (aStrSideMenuOps == JMOLocalizedString(forKey: "English/عربى", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 1)
        }
        else if (aStrSideMenuOps == JMOLocalizedString(forKey: "Feedback", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 2)
        }
        else if (aStrSideMenuOps == JMOLocalizedString(forKey: "Appointment", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 3)
        }
        else if (aStrSideMenuOps == JMOLocalizedString(forKey: "Notes", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 4)
        }
        else if (aStrSideMenuOps == JMOLocalizedString(forKey: "Social Activities", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 5)
        }else if (aStrSideMenuOps == JMOLocalizedString(forKey: "Medicine plan", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 6)
        }else if (aStrSideMenuOps == JMOLocalizedString(forKey: "User Diseases", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 7)
        }else if (aStrSideMenuOps == JMOLocalizedString(forKey: "Independent daily activities", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 8)
        }else if (aStrSideMenuOps == JMOLocalizedString(forKey: "Backup to Dropbox", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 9)
        }else if (aStrSideMenuOps == JMOLocalizedString(forKey: "About us", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 10)
        }else if (aStrSideMenuOps == JMOLocalizedString(forKey: "User profile", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 11)
        }else if (aStrSideMenuOps == JMOLocalizedString(forKey: "Contact us", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 12)
        }else if (aStrSideMenuOps == JMOLocalizedString(forKey: "Share on Social media", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 13)
        }else if (aStrSideMenuOps == JMOLocalizedString(forKey: "Setting", value: "")) {
            obj.SideMenuSelectionMethod(SideMenuIndex: 14)
        }
    }
    
    
    
    @IBAction func btnSideMenuAction(_ sender: UIButton) {
        
        let aStrSideMenuOps = self.arrBottomBar[sender.tag] as String?
        let arrNavigationArr = appDelegate.mmDrawer?.centerViewController as! UINavigationController
        var indexTabbar : Int = 1
        for objViewcontoller in arrNavigationArr.viewControllers {
            if objViewcontoller is TabbarVC {
                indexTabbar = arrNavigationArr.viewControllers.index(of: objViewcontoller)!
                break
            }
        }
        let objTabbarVC = arrNavigationArr.viewControllers[indexTabbar] as! TabbarVC
        
        
        switch objTabbarVC.selectedIndex {
            
        case 0:
            let objCntrlCal = objTabbarVC.viewControllers?[0] as! CalenderVC
            self.sidepanelClickCalendar(aStrSideMenuOps: aStrSideMenuOps!, obj: objCntrlCal)
            
        case 1:
            let objCntrlChecklist = objTabbarVC.viewControllers?[1] as! ChecklistVC
            self.sidepanelClickChecklist(aStrSideMenuOps: aStrSideMenuOps!, obj: objCntrlChecklist)
            
        case 2:
            let objCntrlReportVC = objTabbarVC.viewControllers?[2] as! ReportVC
            self.sidepanelClickReport(aStrSideMenuOps: aStrSideMenuOps!, obj: objCntrlReportVC)
            
        default:
            print("Default")
            
        }
        
        
        if let m = mm_drawerController {
            if (m.rightDrawerViewController != nil) {
                m.toggle(MMDrawerSide.right, animated: true, completion: nil)
            }
        }
    }
    
}
