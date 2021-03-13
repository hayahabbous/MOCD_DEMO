//
//  FeedbackVC.swift
//  SwiftDatabase
//
//  Created by indianic on 03/01/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit
import MessageUI

class FeedbackVC: UIViewController,MFMailComposeViewControllerDelegate,UITextViewDelegate {
    
    @IBOutlet weak var btnBackEN: UIButton!
    
    @IBOutlet weak var lblScreenTitle: UILabel!
    
    @IBOutlet weak var btnExcellent: UIButton!
    @IBOutlet weak var btnGood: UIButton!
    @IBOutlet weak var btnOK: UIButton!
    @IBOutlet weak var btnNotGreat: UIButton!
    @IBOutlet weak var tfFeedbackNote: UITextField!
    @IBOutlet weak var txtFeedbackNote: UITextView!
    
    var aFeedbackStatus = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if AppConstants.isArabic(){
             btnBackEN.imageView?.transform = (btnBackEN.imageView?.transform.rotated(by: CGFloat(M_PI)))!
        }
        
        self.lblScreenTitle.text = JMOLocalizedString(forKey: "Feedback", value: "")
        
        self.txtFeedbackNote.scrollRangeToVisible(NSMakeRange(0, 0))
        txtFeedbackNote.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        LanguageManager.sharedInstance.localizeThingsInView(parentView: self.view)
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBackENAction(_ sender: UIButton) {
    
        _ = self.navigationController?.popViewController(animated: true)
    
    }
    
    
    
    @IBAction func btnExcellentAction(_ sender: UIButton) {
        if btnExcellent.isSelected{
            btnExcellent.isSelected = false
            aFeedbackStatus = ""
        }else{
            btnExcellent.isSelected = true
            btnGood.isSelected = false
            btnOK.isSelected = false
            btnNotGreat.isSelected = false
            
            aFeedbackStatus = JMOLocalizedString(forKey: "Very good", value: "")
        }
    }
    @IBAction func btnGoodAction(_ sender: UIButton) {
        if btnGood.isSelected{
            btnGood.isSelected = false
            aFeedbackStatus = ""
        }else{
            btnGood.isSelected = true
            btnExcellent.isSelected = false
            btnOK.isSelected = false
            btnNotGreat.isSelected = false
            
            aFeedbackStatus = JMOLocalizedString(forKey: "Good", value: "")
        }
    }
    @IBAction func btnOKAction(_ sender: UIButton) {
        if btnOK.isSelected{
            btnOK.isSelected = false
            aFeedbackStatus = ""
        }else{
            btnOK.isSelected = true
            btnGood.isSelected = false
            btnExcellent.isSelected = false
            btnNotGreat.isSelected = false
            
            aFeedbackStatus = JMOLocalizedString(forKey: "Fair", value: "")
        }
    }
    @IBAction func btnNotGreatAction(_ sender: UIButton) {
        if btnNotGreat.isSelected{
            btnNotGreat.isSelected = false
            aFeedbackStatus = ""
        }else{
            btnNotGreat.isSelected = true
            btnOK.isSelected = false
            btnGood.isSelected = false
            btnExcellent.isSelected = false
            
            aFeedbackStatus = JMOLocalizedString(forKey: "Poor", value: "")
        }
    }

    
    func setupUI(){
        if AppConstants.isArabic() {
            btnExcellent.contentHorizontalAlignment = .right
            btnGood.contentHorizontalAlignment = .right
            btnOK.contentHorizontalAlignment = .right
            btnNotGreat.contentHorizontalAlignment = .right
            
            btnExcellent.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
            btnGood.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
            btnOK.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
            btnNotGreat.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
        }
        else{
            btnExcellent.contentHorizontalAlignment = .left
            btnGood.contentHorizontalAlignment = .left
            btnOK.contentHorizontalAlignment = .left
            btnNotGreat.contentHorizontalAlignment = .left
            
            btnExcellent.titleEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
            btnGood.titleEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
            btnOK.titleEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
            btnNotGreat.titleEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        }
    }
    
    @IBAction func btnSubmitFeedbackAction(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        if self.validateForm() {
            
            let aMailBody = String.init(format: "%@ %@ \n %@", JMOLocalizedString(forKey: "Feedback of the application is", value: "") ,aFeedbackStatus,self.txtFeedbackNote.text!)
            self.sendEmail(self, aStrToMailID: ["mocd.support@mocd.gov.ae"], aStrMailSubject: JMOLocalizedString(forKey: "MOCD- Medical Agenda- Feedback", value: ""), aStrMailBody: aMailBody)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == JMOLocalizedString(forKey: "Note", value: "") {
            textView.text = ""
        }
    }
    func sendEmail(_ controller: UIViewController, aStrToMailID : [String] , aStrMailSubject : String, aStrMailBody : String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(aStrToMailID)
            mail.setSubject(aStrMailSubject)
            mail.setMessageBody(aStrMailBody, isHTML: false)
            controller.present(mail, animated: true, completion: nil)
        } else {
            // show failure alert
            UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey: "Email is not setup in settings , please setup email !", value: ""), completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    
    
    
    //MARK: Other Methods
    func validateForm() -> Bool{
        
//        if !validateBlank(strVal: self.tfFeedbackNote.text!) 
        if !validateBlank(strVal: self.txtFeedbackNote.text!) {
             UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey: "Please fill feedback note field", value: ""), completion: nil)
            return false
        }
        else if (self.txtFeedbackNote.text! == JMOLocalizedString(forKey: "Note", value: "")) {
            UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey: "Please fill feedback note field", value: ""), completion: nil)
            return false
        }
        else if(aFeedbackStatus == ""){
            UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey: "Please fill feedback status", value: ""), completion: nil)
            return false
        }
        else{
            return true
        }
    }
    
    
}
