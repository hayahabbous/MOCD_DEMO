//
//  LanguageManager.swift
//  Edkhar
//
//  Created by indianic on 02/01/17.
//  Copyright © 2017 demo. All rights reserved.
//

import UIKit


// Gets the current localized string as in NSLocalizedString.
// JMOLocalizedString(@"Text to localize",@"Alternative text, in case hte other is not find");
func JMOLocalizedString(forKey key: String, value comment: String) -> String {
    if (LanguageManager.sharedInstance.bundle == nil) {
        let defaultLanguage = LanguageManager.sharedInstance.getDefaultLanguage()
        
        LanguageManager.sharedInstance.setLanguage(defaultLanguage)
    }
    return LanguageManager.sharedInstance.bundle.localizedString(forKey: key, value: comment, table: nil)
}

class LanguageManager: NSObject {

    var bundle = Bundle.main
    var currentLanguage = ""
    var isNotificationActivated = false
    let LanguagesManagerLanguageDidChangeNotification = "LanguagesManagerLanguageDidChangeNotification"
    
    
    class var sharedInstance: LanguageManager {
        struct Static {
            static var instance = LanguageManager()
        }
        return Static.instance
    }
    
    // We can still have a regular init method, that will get called the first time the Singleton is used.
    // We can still have a regular init method, that will get called the first time the Singleton is used.
    override init() {
        super.init()
        
        self.currentLanguage = self.getDefaultLanguage()
        
        var aLangauage = self.currentLanguage.components(separatedBy: CharacterSet(charactersIn: "-"))
        
        self.currentLanguage = aLangauage[0]
        let path = Bundle.main.path(forResource: self.currentLanguage, ofType: "lproj")!
        self.bundle = Bundle(path: path)!
    }
    
    
    func setNotificationEnable(_ enable: Bool) {
        self.isNotificationActivated = enable
    }
    
    func setBundle(bundle : Bundle) -> Void {
        if !self.bundle.isEqual(bundle) {
            self.bundle = bundle
            if (self.isNotificationActivated) {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LanguagesManagerLanguageDidChangeNotification"), object: nil)
            }
        }
    }
    
    
   
    
    
    // Sets the desired language of the ones you have.
    // [self setLanguage:@"fr"];
    func setLanguage(_ language: String) {
        //    JMOLog("preferredLang: %@", language)
        if self.isAnAvailableLanguage(language) {
            let path = Bundle.main.path(forResource: language, ofType: "lproj")!
            self.bundle = Bundle(path: path)!
        }
        else {
            //        JMOLog("%s unsupported language : %@", #function, language)
        }
    }
    
    func isAnAvailableLanguage(_ language: String) -> Bool {
        let path = Bundle.main.path(forResource: language, ofType: "lproj")
        if (path == nil) {
            return false
        }
        else {
            return true
        }
    }
    
    // Just gets the current setted up language.
    func getDefaultLanguage() -> String {
        var languages = UserDefaults.standard.object(forKey: "AppleLanguages") as! Array<Any>
        let preferredLang = languages[0]
        return preferredLang as! String
    }
    
    
    // Resets the localization system, so it uses the OS default language.
    func setSupportedLanguages(_ arrayOfLanguages: [Any]) {
        self.setLanguage(arrayOfLanguages[0] as! String)
        UserDefaults.standard.setValue(["en", "ar"], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        
        
    }
    
    func localizeThingsInView(parentView: UIView) -> Void {
        for view in parentView.subviews{
            if self.isRTL() {
                if #available(iOS 9.0, *) {
                    view.semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft
                } else {
                    // Fallback on earlier versions
                }
            }
            else{
                if #available(iOS 9.0, *) {
                    view.semanticContentAttribute = UISemanticContentAttribute.forceLeftToRight
                } else {
                    // Fallback on earlier versions
                }
            }
            if  view is UITextField {
                let txtF: UITextField = view as! UITextField
                if txtF.accessibilityLabel != nil {
                    txtF.placeholder = JMOLocalizedString(forKey: txtF.accessibilityLabel!, value: "")
                }
                if self.isRTL() {
                    txtF.textAlignment = .right
                }
                else{
                    txtF.textAlignment = .left
                }
            }
            else if view is UITextView{
                let txtView: UITextView = view as! UITextView
                if txtView.accessibilityLabel != nil {
                    txtView.text = JMOLocalizedString(forKey: txtView.accessibilityLabel!, value: "")
                    
                }
            }
            else if view is UILabel{
                let lbl: UILabel = view as! UILabel
                if lbl.accessibilityLabel != nil {
                    lbl.text = JMOLocalizedString(forKey: lbl.accessibilityLabel!, value: "")
                }
            }
            else if view is UIButton{
                let btn : UIButton = view as! UIButton
                if (btn.accessibilityLabel != nil) {
                    
                    btn.setTitle(JMOLocalizedString(forKey: btn.accessibilityLabel!, value: ""), for: .normal)
                }
            }
            
            if view.subviews.count > 0 {
                self.localizeThingsInView(parentView: view)
            }
        }
    }
    
    func isRTL() -> Bool {
        return IS_ARABIC()
//        return Locale.characterDirection(forLanguage: self.getDefaultLanguage()!) == Locale.LanguageDirection.rightToLeft
    }
}
