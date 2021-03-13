//
//  TabbarVC.swift
//  SwiftDatabase
//
//  Created by indianic on 31/12/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit

class TabbarVC: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        // Set tabbr tint / Background color
        self.tabBar.barTintColor = GeneralConstants.hexStringToUIColor(hex: GeneralConstants.ColorConstants.kTop)
        var aFontName = ""
        
        self.delegate = self
        
        
        if(AppConstants.isArabic())
        {
            aFontName = FontName.kGESSBold.rawValue
        }
        else{
            aFontName = FontName.kMyriadProSemibold.rawValue
        }
        
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedString.Key.font:(UIFont(name: aFontName, size: 12))!, NSAttributedString.Key.foregroundColor: UIColor.cyan]
        
        appearance.setTitleTextAttributes(attributes, for: .selected)
        
        let attributesNormal = [NSAttributedString.Key.font.rawValue:(UIFont(name: aFontName, size: 12))!, NSAttributedString.Key.foregroundColor.rawValue: UIColor.white]
        appearance.setTitleTextAttributes(attributes, for: .normal)
        
        //This code will hanble the tabbar fonts (End.)
        
        LanguageManager.sharedInstance.localizeThingsInView(parentView: self.view)
        
        self.handleTabbarLocalization()
    }

    
    func handleTabbarLocalization() -> Void {
        
        // Do any additional setup after loading the view.
        self.tabBar.items?[0].title = JMOLocalizedString(forKey: "CALENDAR", value: "")
        self.tabBar.items?[1].title = JMOLocalizedString(forKey: "CHECKLIST", value: "")
        self.tabBar.items?[2].title = JMOLocalizedString(forKey: "REPORT", value: "")
        
        
        
        
//        self.tabBar.items?[0].selectedImage = UIImage(named: "cal-sele")?.withRenderingMode(.alwaysOriginal)
        
        for item in self.tabBar.items! {
            
            let unselectedItem: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                NSAttributedString.Key.font: UIFont(name: FontName.kGESSBold.rawValue, size: 10)!]
            item.setTitleTextAttributes(unselectedItem as? [NSAttributedString.Key : Any] , for: .normal)
            
            let selectedItem: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                              NSAttributedString.Key.font: UIFont(name: FontName.kGESSBold.rawValue, size: 10)!]
            item.setTitleTextAttributes(selectedItem as? [NSAttributedString.Key : Any], for: .selected)
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnLeftSideMenu(_ sender: UIBarButtonItem) {
    
        appDelegate.mmDrawer?.open(.left, animated: true, completion: nil)
    }
    
    @IBAction func btnRightSideMenu(_ sender: UIBarButtonItem) {
    
        appDelegate.mmDrawer?.open(.right, animated: true, completion: nil)
    }
    
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        if viewController == ReportVC() {
//            viewController.viewDidLoad()
//        }
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
