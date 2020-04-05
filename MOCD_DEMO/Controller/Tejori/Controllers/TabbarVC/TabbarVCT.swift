//
//  TabbarVC.swift
//  Edkhar
//
//  Created by indianic on 31/12/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit

class TabbarVCT: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //This code will hanble the tabbar fonts (Start.)
        var aFontName = ""
        
        if(AppConstants.isArabic())
        {
            aFontName = AppFonts.kGESSBold.rawValue
        }
        else{
            aFontName = AppFonts.kMyriadProSemibold.rawValue
        }
        
        let appearance = UITabBarItem.appearance()
        
        /*
        if (ConstantsT.DeviceType.IS_IPAD) {
            
            let attributes = [NSAttributedString.Key.font.rawValue:(UIFont(name: aFontName, size: 15))!, NSAttributedString.Key.foregroundColor.rawValue: UIColor.white]
            
            appearance.setTitleTextAttributes(attributes, for: .selected)
            
            let attributesNormal = [NSAttributedString.Key.font.rawValue:(UIFont(name: aFontName, size: 15))!, NSAttributedString.Key.foregroundColor: UIColor.colorFromRGB(R: 162, G: 190, B: 172, Alpha: 1.0)]
            appearance.setTitleTextAttributes(attributesNormal as! [NSAttributedString.Key : Any], for: .normal)
            
        }
        else{
            let attributes: [String: AnyObject] = [NSFontAttributeName:(UIFont(name: aFontName, size: 12))!, NSForegroundColorAttributeName: UIColor.white]
            appearance.setTitleTextAttributes(attributes, for: .selected)
            
            let attributesNormal : [String: AnyObject] = [NSFontAttributeName:(UIFont(name: aFontName, size: 12))!, NSForegroundColorAttributeName: UIColor.colorFromRGB(R: 162, G: 190, B: 172, Alpha: 1.0)]
            appearance.setTitleTextAttributes(attributesNormal, for: .normal)
            
        }
        */
        
        //This code will hanble the tabbar fonts (End.)
        
        LanguageManager.sharedInstance.localizeThingsInView(parentView: self.view)
        
        self.handleTabbarLocalization()
        
        
    }
    func handleTabbarLocalization() -> Void {
        // Do any additional setup after loading the view.
        self.tabBar.items?[0].title = JMOLocalizedString(forKey: "INCOME", value: "")
        self.tabBar.items?[1].title = JMOLocalizedString(forKey: "SPENDING", value: "")
        self.tabBar.items?[2].title = JMOLocalizedString(forKey: "SAVING", value: "")
        self.tabBar.items?[3].title = JMOLocalizedString(forKey: "REPORTS", value: "")

    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        //This method will be called when user changes tab.
        
        let arrNavigationArr = appDelegate.mmDrawer?.centerViewController as! UINavigationController
        var indexComman : Int = 0
        for objViewcontoller in arrNavigationArr.viewControllers {
            if objViewcontoller is CommanVC {
                indexComman = arrNavigationArr.viewControllers.index(of: objViewcontoller)!
                break
            }
        }
        
        let objCommanVC = arrNavigationArr.viewControllers[indexComman] as! CommanVC
        
        if item.tag == 4 {
            // Report Graph.
            objCommanVC.viewQuote.isHidden = true
        }
        else{
            // income , spenidng , saving
            objCommanVC.viewQuote.isHidden = false
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
