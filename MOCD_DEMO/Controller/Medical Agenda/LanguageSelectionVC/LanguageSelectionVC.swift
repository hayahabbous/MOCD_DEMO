//
//  LanguageSelectionVC.swift
//  SwiftDatabase
//
//  Created by indianic on 02/01/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit

class LanguageSelectionVC: UIViewController {


    
    @IBOutlet var btnEnglish: [UIButton]!
    
    //MARK: ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()

//        LanguageManager.sharedInstance.localizeThingsInView(parentView: self.view)
        // Set Font
        for btn in btnEnglish {
            // Set fonts
            if GeneralConstants.DeviceType.IS_IPAD {
                customizeFonts(in: btn, aFontName: Bold, aFontSize: 0)
            }else{
                customizeFonts(in: btn, aFontName: Bold, aFontSize: 0)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
                
        UserDefaults.standard.set(true, forKey: "LangScreenShown")
        UserDefaults.standard.synchronize()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Actions
    @IBAction func btnEnglishAction(_ sender: UIButton) {
        LanguageManager.sharedInstance.setLanguage("en")
        UserDefaults.standard.set("en", forKey: "Language")
        UserDefaults.standard.synchronize()
        self.performSegue(withIdentifier: kSegueTutorial, sender: self) //kSegueMainTab
    }
    
    @IBAction func btnArabicAction(_ sender: UIButton) {
        LanguageManager.sharedInstance.setLanguage("ar")
        UserDefaults.standard.set("ar", forKey: "Language")
        UserDefaults.standard.synchronize()
        self.performSegue(withIdentifier: kSegueTutorial, sender: self) //kSegueMainTab
        
    }

}
