//
//  Utils.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 6/17/19.
//  Copyright © 2019 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import JGProgressHUD

class Utils: NSObject {
    
    
    class func handleParseError(_ error: NSError, inViewController viewController: UIViewController) {
        
        if (error.code ==  MOCD_ERROR.no_INTERNET_CONNECTION_1.rawValue || error.code == MOCD_ERROR.no_INTERNET_CONNECTION_2.rawValue || error.code ==  MOCD_ERROR.no_INTERNET_CONNECTION_4.rawValue || error.code ==  MOCD_ERROR.no_INTERNET_CONNECTION__1.rawValue || error.code ==  MOCD_ERROR.no_INTERNET_CONNECTION_100.rawValue || error.code ==  MOCD_ERROR.no_INTERNET_CONNECTION_124.rawValue) {
            self.showErrorMessage(NSLocalizedString("Please check your connection and try again", comment:""), withTitle: "", andInViewController: viewController)
        }
        else {
            
            if error.code ==  MOCD_ERROR.useremail_TAKEN.rawValue {
                self.showErrorMessage(NSLocalizedString("The email address you have entered is already registed", comment:""), withTitle: "", andInViewController: viewController)
            }
            
            if error.code == MOCD_ERROR.username_TAKEN.rawValue {
                self.showErrorMessage(NSLocalizedString("Someone already has that usernme , Try another", comment:""), withTitle: "", andInViewController: viewController)
            }
            
            if error.code == MOCD_ERROR.invlide_USERNAME_AND_PASSWORD.rawValue {
                self.showErrorMessage(NSLocalizedString("The username or password you entered is incorrect", comment:""), withTitle: "", andInViewController: viewController)
            }
            
            if error.code == MOCD_ERROR.no_EMAIL_FOUND.rawValue {
                self.showErrorMessage(NSLocalizedString("No user found with this email, please enter a valid email address", comment:""), withTitle: "", andInViewController: viewController)
            }
            
            if error.code == MOCD_ERROR.domin_ERROR.rawValue {
                self.showErrorMessage(NSLocalizedString("Error On Service Try Again Later.", comment:""), withTitle: "", andInViewController: viewController)
            }
            
            if error.code == MOCD_ERROR.invlide_EMAIL.rawValue {
                self.showErrorMessage(NSLocalizedString("Email address format is invalid.", comment:""), withTitle: "", andInViewController: viewController)
            }
            
        }
    }
    
    class func noInternetConnectionErrorInViewController(_ viewController: UIViewController) {
        self.showErrorMessage(NSLocalizedString("Please check your connection and try again", comment:""), withTitle: "", andInViewController: viewController)
    }
    class func showErrorMessage(_ errorMessage: String, withTitle title: String, andInViewController viewController: UIViewController) {
        
        let messageTitle = title.count <= 0 ? "MOCD" : title
        
        let alertController: UIAlertController = UIAlertController(title: messageTitle, message: errorMessage, preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction(title:NSLocalizedString("ok",comment:""), style: .default, handler: nil)
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    class func showIndicator(hud: JGProgressHUD ,view: UIView) {
        
        hud.textLabel.text = "Loading"
        hud.show(in: view)
        
    }
    class func dismissIndicator(hud: JGProgressHUD) {
        hud.dismiss()
    }
    
    static func showAlertWith(title: String, message: String, style: UIAlertController.Style = .alert ,viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        
        let action = UIAlertAction(title: "ok", style: .default) { (action) in
            //.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        viewController.present(alertController, animated: true) {
            
        }
    }
    class func checkDomains(month: String ) -> CHILD_AGES  {
        
        let numberOfMonths = Int32(month) ?? 0
        
        var child_age: CHILD_AGES = .none
        switch numberOfMonths {
        case 0...2:
            child_age = .two
        case 2...4:
            child_age = .four
        case 4...6:
            child_age = .six
        case 6...8:
            child_age = .eight
        case 8...10:
            child_age = .ten
        case 10...INT_MAX:
            child_age = .noNeedForTest
        default:
            child_age = .none
        }
        
        print(child_age)
        return child_age
    }
    
    
    class func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    class func isValidPassword(_ pass: String) -> Bool {
        //let emailRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        let emailRegEx = "^(?=.*[0-9])(?=.*[A-Z])(?=\\S+$).{8,16}$"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: pass)
    }
    
    class func validate(YourEMailAddress: String) -> Bool {
        let REGEX: String
        REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with: YourEMailAddress)
    }
}
