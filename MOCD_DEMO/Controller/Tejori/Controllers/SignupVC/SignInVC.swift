//
//  SignInVC.swift
//  Edkhar
//
//  Created by indianic on 27/01/17.
//  Copyright © 2017 demo. All rights reserved.
//

import UIKit

class SignInVC: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var viewPin: UIView!
    @IBOutlet weak var tfPinForSecurity: UITextField!
    var aStrSignUpPin : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        LanguageManager.sharedInstance.localizeThingsInView(parentView: self.view)
        
        // user signup - insert query for database.
        let userInfo : [userInfoModelT] = userInfoManagerT.sharedInstance.GetAllUserInfoList()
        if userInfo.count > 0 {
            // already signuped
            aStrSignUpPin = userInfo.first?.pinForSecurity as! String?
            
            print("aStrSignUpPin = \(aStrSignUpPin!)")
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        Utility.sharedInstance.setPaddingAndShadowForUIComponents(parentView: self.viewPin)
    }
    
    @IBAction func btnSignInAction(_ sender: Any) {
        
        self.view.endEditing(true)
        
        if (!Utility.sharedInstance.validateBlank(strVal: tfPinForSecurity.text!)){
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please enter security pin", value: ""))
            
        }else if ((tfPinForSecurity.text?.count != 4)){
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Pin for security must be 4 numbers", value: ""))
            
        }
        else{
            
            print("tfPinForSecurity.text! = \(tfPinForSecurity.text!)")
            
            var securityPin = Utility.sharedInstance.convertNumberToEnglish(aStr: self.tfPinForSecurity.text!)
            if securityPin == "0" {
                securityPin = "0000"
            }
            
            if (aStrSignUpPin != nil) && (securityPin == aStrSignUpPin!) {
                // Go to comman view contoller.
                self.performSegue(withIdentifier: "segueMainVC", sender: sender)
            }
            else{
                Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please enter correct security pin", value: ""))
            }
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        if textField == tfPinForSecurity{
            let newLength = text.count + string.count - range.length
            return newLength <= 4 // Bool
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.btnSignInAction(self)
        
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
