//
//  LanguageSelectionVC.swift
//  Edkhar
//
//  Created by indianic on 02/01/17.
//  Copyright © 2017 demo. All rights reserved.
//

import UIKit

class LanguageSelectionVCT: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        UserDefaults.standard.set(true, forKey: "LangScreenShown")
        UserDefaults.standard.synchronize()
        self.navigationController?.navigationBar.isHidden = true
        
        if (ConstantsT.DeviceType.IS_IPAD) {
            Utility.sharedInstance.customizeFonts(in: self.view, aFontName: "Bold", aFontSize: 10)
        }
        else{
            Utility.sharedInstance.customizeFonts(in: self.view, aFontName: "Bold", aFontSize: 0)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnEnglishAction(_ sender: UIButton) {
        LanguageManager.sharedInstance.setLanguage("en")
        UserDefaults.standard.set("en", forKey: "Language")
        UserDefaults.standard.synchronize()
        self.performSegue(withIdentifier: "segueTutorial", sender: self)
    }
    @IBAction func btnArabicAction(_ sender: UIButton) {
        LanguageManager.sharedInstance.setLanguage("ar")
        UserDefaults.standard.set("ar", forKey: "Language")
        UserDefaults.standard.synchronize()
        self.performSegue(withIdentifier: "segueTutorial", sender: self)
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
