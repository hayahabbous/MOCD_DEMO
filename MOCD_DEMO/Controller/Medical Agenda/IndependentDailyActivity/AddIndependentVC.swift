//
//  AddIndependentVC.swift
//  SmartAgenda
//
//  Created by indianic on 01/02/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit

class AddIndependentVC: UIViewController,UITextFieldDelegate {
    
    
    
    //MARK: Variables
    var independentSelected: indDailyReminderModel?
    var isBoolEdit: Bool?
    var isBoolUpdate: Bool? = false
    
    @IBOutlet var btnSaveDelete: UIButton!
    
    //MARK: IBOutlets
    
    @IBOutlet var lblScreenTitle: UILabel!
    @IBOutlet var txtActivityName: UITextField!
    
    @IBOutlet var btnBackEN: UIButton!
    
    
    //MARK: ViewControllers Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if AppConstants.isArabic()
        {
            btnBackEN.imageView?.transform = (btnBackEN.imageView?.transform.rotated(by: CGFloat(M_PI)))!
        }else{
            btnBackEN.imageView?.transform = (btnBackEN.imageView?.transform.rotated(by: CGFloat(M_PI*2)))!
        }
        txtActivityName.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //        if AppConstants.isArabic()
        //        {
        //            btnBackEN.imageView?.transform = (btnBackEN.imageView?.transform.rotated(by: CGFloat(M_PI)))!
        //        }else{
        //            btnBackEN.imageView?.transform = (btnBackEN.imageView?.transform.rotated(by: CGFloat(M_PI*2)))!
        //        }
        
        setPadding()
        
        if GeneralConstants.DeviceType.IS_IPAD {
            customizeFonts(in: lblScreenTitle, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtActivityName, aFontName: Medium, aFontSize: 0)
            
        }else{
            customizeFonts(in: lblScreenTitle, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtActivityName, aFontName: Medium, aFontSize: 0)
            
        }
        
        LanguageManager().localizeThingsInView(parentView: (self.view))
        
        self.lblScreenTitle.text = JMOLocalizedString(forKey: kAddIndependent, value: "")
        
        
        if isBoolEdit! {
            
            self.independentAddOrUpdate()
            isBoolEdit = false
            isBoolUpdate = true
            
            btnSaveDelete.setTitle(JMOLocalizedString(forKey: "UPDATE", value: ""), for: .normal)
        }else{
            btnSaveDelete.setTitle(JMOLocalizedString(forKey: "ADD", value: ""), for: .normal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: IBActions Events
    
    @IBAction func btnSaveClick(_ sender: UIButton) {
        
        if GeneralConstants.trimming(txtActivityName.text!) {
            
            if isBoolUpdate! {
                deleteInde()
            }
            
            
            insert()
            
        }else{
            showAlert(message: JMOLocalizedString(forKey: kReminderOn, value: ""))
            
        }
    }
    
    @IBAction func btnBackClick(_ sender: UIButton) {
        
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    //MARK: Custom Methods
    
    private func setPadding() {
        setTextFieldPadding(textfield: txtActivityName, padding: 5)
        
        
    }
    
    private func independentAddOrUpdate() {
        
        txtActivityName.text = independentSelected?.title
        
    }
    
    
    private func insert(){
        let aObjIndActivity = indDailyActivitiesModel()
        let aObjReminder = ReminderModel()
        
        aObjIndActivity.title = GeneralConstants.trimmingString(txtActivityName.text!)
        if aObjIndActivity.title.contains("'") {
            aObjIndActivity.title.replace("'", with: "")
        }
        
        aObjIndActivity.date = ""
        
        aObjReminder.reminderTxt = aObjIndActivity.title
        aObjReminder.type = 2
        
        
        if isBoolUpdate! {
            aObjIndActivity.identifier = independentSelected?.identifier
        }
        
        indDailyActivitiesModel().insertIndependent(objIndDailyActivitiesModel: aObjIndActivity, aObjReminder: aObjReminder, flageUpdate: false) { (result: Bool) in
            
            print(result)
            
            if isBoolUpdate! {
                UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey:JMOLocalizedString(forKey: modificationAlert, value: ""), value: ""), completion: { (Int, String) in
                    _ = self.navigationController?.popViewController(animated: true)
                })
                
            }else{
                UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey: "Addition process done successfully", value: ""), completion: { (Int, String) in
                    _ = self.navigationController?.popViewController(animated: true)
                })
            }
            
        }
        
    }
    
    
    private func deleteInde() {
        indDailyActivitiesModel().deleteIndpendent(deleteID: (independentSelected?.identifier)!) { (re: Bool) in
            
        }
    }
    
    
    /// Show alert
    ///
    /// - Parameter message: Message text
    fileprivate func showAlert(message: String) {
        UIAlertController.showAlertWithOkButton(self, aStrMessage: message, completion: { (Int, String) in
            
        })
    }
    
    //MARK: UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        if textField == txtActivityName{
            if (textField.text?.count)! <= kSetChar256  {
                let newLength = (textField.text?.count)! + string.count - range.length
                return newLength <= kSetChar256
            }else{
                return false
            }
        }
        return true
    }
}
