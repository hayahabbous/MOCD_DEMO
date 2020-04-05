//
//  FeedbackVC.swift
//  Edkhar
//
//  Created by indianic on 03/01/17.
//  Copyright © 2017 demo. All rights reserved.
//

import UIKit

class FeedbackVCT: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var btnBackEN: UIButton!
    @IBOutlet weak var btnBackAR: UIButton!
    
    @IBOutlet weak var lblScreenTitle: UILabel!
    
    @IBOutlet weak var btnExcellent: UIButton!
    @IBOutlet weak var btnGood: UIButton!
    @IBOutlet weak var btnOK: UIButton!
    @IBOutlet weak var btnNotGreat: UIButton!
    @IBOutlet weak var btnBad: UIButton!
    @IBOutlet weak var tfFeedbackNote: UITextField!
    
    var aFeedbackStatus = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if AppConstants.isArabic(){
            self.btnBackEN.isHidden = true
        }
        else{
            self.btnBackAR.isHidden = true
        }
        
        self.lblScreenTitle.text = JMOLocalizedString(forKey: "Feedback", value: "")
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
    
    @IBAction func btnBackARAction(_ sender: UIButton) {
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
            btnBad.isSelected = false
            aFeedbackStatus = JMOLocalizedString(forKey: "Excellent", value: "")
            
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
            btnBad.isSelected = false
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
            btnBad.isSelected = false
            aFeedbackStatus = JMOLocalizedString(forKey: "Ok", value: "")
            
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
            btnBad.isSelected = false
            aFeedbackStatus = JMOLocalizedString(forKey: "Not Great", value: "")
            
        }
    }
    @IBAction func btnBadAction(_ sender: UIButton) {
        if btnBad.isSelected{
            btnBad.isSelected = false
            aFeedbackStatus = ""
        }else{
            btnBad.isSelected = true
            btnNotGreat.isSelected = false
            btnOK.isSelected = false
            btnGood.isSelected = false
            btnExcellent.isSelected = false
            aFeedbackStatus = JMOLocalizedString(forKey: "Bad", value: "")
            
        }
    }
    
    func setupUI(){
        if AppConstants.isArabic() {
            btnExcellent.contentHorizontalAlignment = .right
            btnGood.contentHorizontalAlignment = .right
            btnOK.contentHorizontalAlignment = .right
            btnNotGreat.contentHorizontalAlignment = .right
            btnBad.contentHorizontalAlignment = .right
            
            btnExcellent.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
            btnGood.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
            btnOK.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
            btnNotGreat.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
            btnBad.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
        }
        else{
            btnExcellent.contentHorizontalAlignment = .left
            btnGood.contentHorizontalAlignment = .left
            btnOK.contentHorizontalAlignment = .left
            btnNotGreat.contentHorizontalAlignment = .left
            btnBad.contentHorizontalAlignment = .left
            
            btnExcellent.titleEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
            btnGood.titleEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
            btnOK.titleEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
            btnNotGreat.titleEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
            btnBad.titleEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        }
    }
    
    @IBAction func btnSubmitFeedbackAction(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        if self.validateForm() {
            
            let aMailBody = String.init(format: "%@%@ \n %@", JMOLocalizedString(forKey: "Feedback of the application is ", value: ""),aFeedbackStatus,self.tfFeedbackNote.text!)
            Utility.sharedInstance.sendEmail(self, aStrToMailID: ["mocd.support@mocd.gov.ae"], aStrMailSubject: JMOLocalizedString(forKey: "MOCD- Edkhar- Feedback", value: ""), aStrMailBody: aMailBody)
            
            
        }
    }
    
    //MARK: Other Methods
    func validateForm() -> Bool{
        
        if(aFeedbackStatus == ""){
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please answer the question", value: ""))
            return false
        }
        else if !Utility.sharedInstance.validateBlank(strVal: self.tfFeedbackNote.text!) {
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please fill feedback note field", value: ""))
            return false
        }
        else{
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
