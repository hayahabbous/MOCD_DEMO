//
//  AddNewTargetVC.swift
//  Edkhar
//
//  Created by indianic on 28/01/17.
//  Copyright © 2017 demo. All rights reserved.
//

import UIKit

class AddNewTargetVC: UIViewController ,UITextFieldDelegate{
    
    @IBOutlet weak var tfTargetName: UITextField!
    @IBOutlet weak var tfFinalAmount: UITextField!
    @IBOutlet weak var tfSavedAmount: UITextField!
    @IBOutlet weak var tfMonths: UITextField!
    @IBOutlet weak var tfMonthlyInstallment: UITextField!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var btnBackEN: UIButton!
    @IBOutlet weak var btnBackAR: UIButton!
    @IBOutlet weak var lblScreenTitle: UILabel!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    var aInstallmentMonth : Float = 1
    
    var targetModle = TargetModel()
    
    var aTargetModle = TargetModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        self.lblScreenTitle.text = JMOLocalizedString(forKey: "Add new Target", value: "")
        
        if (ConstantsT.DeviceType.IS_IPAD) {
            Utility.sharedInstance.customizeFonts(in: contentView, aFontName: Medium, aFontSize: 0)
        }
        else{
            Utility.sharedInstance.customizeFonts(in: contentView, aFontName: Medium, aFontSize: 0)
        }
        
        if AppConstants.isArabic() {
            btnBackEN.isHidden = true
        }
        else{
            btnBackAR.isHidden = true
        }
        
        LanguageManager.sharedInstance.localizeThingsInView(parentView: self.view)
        
        tfMonths.text = String(aInstallmentMonth)
        
        // Do any additional setup after loading the view.
        
        if aTargetModle.identifier != nil{
            
            tfTargetName.text = aTargetModle.target_name!
            tfFinalAmount.text = aTargetModle.target_final_amount
            tfSavedAmount.text = aTargetModle.target_saved_amount
            tfMonths.text = aTargetModle.target_final_date
            aInstallmentMonth = Float(aTargetModle.target_final_date)!
            tfMonthlyInstallment.text = aTargetModle.target_monthly_installment
            self.lblScreenTitle.text = JMOLocalizedString(forKey: "Edit Target", value: "")
            btnSave.setTitle(JMOLocalizedString(forKey: "Update", value: ""), for: .normal)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Utility.sharedInstance.setPaddingAndShadowForUIComponents(parentView: contentView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnMinusAction(_ sender: Any) {
        self.view.endEditing(true)
        if aInstallmentMonth != 1 && aInstallmentMonth > 1{
            aInstallmentMonth -= 1
            tfMonths.text = String(aInstallmentMonth)
        }else{
            aInstallmentMonth = 1
            tfMonths.text = String(aInstallmentMonth)
        }
        
        if(!Utility.sharedInstance.validateBlank(strVal: self.tfFinalAmount.text!)){
//            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please fill the final amount field", value: ""))
        }
        else{
            self.calculateResult(self.tfFinalAmount.text!, self.tfSavedAmount.text!, String(aInstallmentMonth), self.tfMonthlyInstallment.text!, false)
        }
    }
    
    @IBAction func btnPlusAction(_ sender: Any) {
        self.view.endEditing(true)
        if aInstallmentMonth < 999{
            aInstallmentMonth += 1
            tfMonths.text = String(aInstallmentMonth)
        }
        if(!Utility.sharedInstance.validateBlank(strVal: self.tfFinalAmount.text!)){
//            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please fill the final amount field", value: ""))
        }
        else{
            self.calculateResult(self.tfFinalAmount.text!, self.tfSavedAmount.text!, String(aInstallmentMonth), self.tfMonthlyInstallment.text!, false)
            
        }
    }
    
    func calculateMonthlyInstallment(_targetMonths : Int) -> Float {
        
        let aFinalAmount = Int(Utility.sharedInstance.convertNumberToEnglish(aStr: self.tfFinalAmount.text!))
        let aSavedAmount = Int(Utility.sharedInstance.convertNumberToEnglish(aStr: self.tfSavedAmount.text!))
        let aMonths = Int(self.tfMonths.text!)
        
        //        let aMontlyInstallments = ((aFinalAmount! - aSavedAmount!) / aMonths!)
        let aMontlyInstallments = (Float((aFinalAmount! - aSavedAmount!)) / Float (aMonths!))
        
        print("aMontlyInstallments = \(aMontlyInstallments)")
        
        return aMontlyInstallments
        
    }
    
    @IBAction func btnSaveAction(_ sender: Any) {
        
        self.view.endEditing(true)
        
        if self.validateForm() {
            
            print("target name = \(self.tfTargetName.text!)")
            print("tfFinalAmount = \(self.tfFinalAmount.text!)")
            print("tfSavedAmount = \(self.tfSavedAmount.text!)")
            print("tfMonths = \(self.tfMonths.text!)")
            print("tfMonthlyInstallment = \(self.tfMonthlyInstallment.text!)")
            
            if aTargetModle.identifier != nil{
                targetModle.identifier = aTargetModle.identifier
            }
            
            targetModle.target_name = self.tfTargetName.text!
            targetModle.target_final_amount = Utility.sharedInstance.convertNumberToEnglish(aStr: self.tfFinalAmount.text!)
            if self.validateSavedAmount(){
                if Utility.sharedInstance.validateBlank(strVal: self.tfSavedAmount.text!) {
                    targetModle.target_saved_amount = Utility.sharedInstance.convertNumberToEnglish(aStr: self.tfSavedAmount.text!)
                }else{
                    targetModle.target_saved_amount = "0"
                }
                targetModle.target_final_date = Utility.sharedInstance.convertNumberToEnglish(aStr: self.tfMonths.text!)
                targetModle.target_monthly_installment = Utility.sharedInstance.convertNumberToEnglish(aStr: self.tfMonthlyInstallment.text!)
                
                var aUserInfoAdded : Bool = false
                var aDBSucessMsg : String
                if aTargetModle.identifier != nil{
                    // target update - update query for database.
                    
                    aUserInfoAdded = userInfoManagerT.sharedInstance.UpdateTargetDetail(objTargetModel: targetModle)
                    aDBSucessMsg = JMOLocalizedString(forKey: "your modifications are saved successfully", value: "")
                    
                }
                else{
                    
                    // target - insert query for database.
                    aUserInfoAdded = userInfoManagerT.sharedInstance.InsertTargetDetail(objTargetModel: targetModle)
                    aDBSucessMsg = JMOLocalizedString(forKey: "addition process done successfully", value: "")
                    
                }
                
                
                if aUserInfoAdded == true {
                    
                    let alertController = UIAlertController(title:  JMOLocalizedString(forKey: "Edkhar", value: ""), message: JMOLocalizedString(forKey: aDBSucessMsg, value: ""), preferredStyle: .alert)
                    let okAction = UIAlertAction(title: JMOLocalizedString(forKey: "OK", value: ""), style: .default, handler: { (action) in
                        _ = self.navigationController?.popViewController(animated: true)
                    })
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func btnBackENAction(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func btnBackARAction(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    //MARK: Other Methods
    func validateForm() -> Bool{
        
        
        if !Utility.sharedInstance.validateBlank(strVal: self.tfTargetName.text!) && !Utility.sharedInstance.validateBlank(strVal: self.tfFinalAmount.text!) && !Utility.sharedInstance.validateBlank(strVal: self.tfSavedAmount.text!) && (self.tfMonths.text! == "0"){
            
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please fill all mandatory fields", value: ""))
            return false
        }
        else if !Utility.sharedInstance.validateBlank(strVal: self.tfTargetName.text!) {
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please fill Target name field", value: ""))
            return false
        }
        else if(!Utility.sharedInstance.validateBlank(strVal: self.tfFinalAmount.text!)){
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please fill Final amount field", value: ""))
            return false
        }
        else if !(self.tfFinalAmount.text!).isNumeric {
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please enter proper Final amount value", value: ""))
            return false
        }
        else if Int(Utility.sharedInstance.convertNumberToEnglish(aStr: self.tfFinalAmount.text!)) == 0{
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please fill valid final amount", value: ""))
            return false
        }
        else if(!Utility.sharedInstance.validateBlank(strVal: self.tfMonths.text!)){
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please fill Final target date field", value: ""))
            return false
        }
        else if(self.tfMonths.text! == "0"){
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please fill Final target date field", value: ""))
            return false
        }
        else{
            return true
        }
    }
    
    
    //MARK: Other Methods
    
    func validateSavedAmount() -> Bool{
        if (Utility.sharedInstance.validateBlank(strVal: self.tfSavedAmount.text!) && !(self.tfSavedAmount.text!).isNumeric){
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please enter proper Saved amount value", value: ""))
            return false
        }
        else if Utility.sharedInstance.validateBlank(strVal: self.tfSavedAmount.text!) && (Int(Utility.sharedInstance.convertNumberToEnglish(aStr: self.tfFinalAmount.text!))! < Int(Utility.sharedInstance.convertNumberToEnglish(aStr: self.tfSavedAmount.text!))!){
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Final amount must be greater than saved amount", value: ""))
            return false
        }
        else{
            return true
        }
    }
    
   
    //MARK:- TextField Delegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let textFieldText: NSString = (textField.text ?? "") as NSString
        
        let txtAfterUpdate = textFieldText.replacingCharacters(in: range, with: string)
        
        if textField == tfFinalAmount{
            
            if (string.isNumeric){
                self.calculateResult(Utility.sharedInstance.convertNumberToEnglish(aStr: txtAfterUpdate), Utility.sharedInstance.convertNumberToEnglish(aStr: self.tfSavedAmount.text!), String(aInstallmentMonth), Utility.sharedInstance.convertNumberToEnglish(aStr: self.tfMonthlyInstallment.text!), false)
                let newLength = text.count + string.count - range.length
                if newLength == 0 {
                    self.tfMonthlyInstallment.text = ""
                }
                
                if newLength > 7{
                    return false
                }else{
                    if let x = tfFinalAmount.text{
                        if (!AppConstants.isArabic() && !string.isEmpty){
                            let s:String  = x.appending(string);
                            tfFinalAmount.text = Utility.sharedInstance.convertNumberToEnglish(aStr: s)
                            return false;
                        }else{
                            return true;
                        }
                    }
                }
            }else{
                return false
            }
        }
        else if textField == tfSavedAmount{
            let textFieldText: NSString = (textField.text ?? "") as NSString
            let txtAfterUpdate = textFieldText.replacingCharacters(in: range, with: string)
            if txtAfterUpdate.count > 0 {
                if self.tfFinalAmount.text != "" && self.tfSavedAmount.text != "" {
                    if (string.isNumeric){
                        if Int(Utility.sharedInstance.convertNumberToEnglish(aStr: txtAfterUpdate))! > Int(Utility.sharedInstance.convertNumberToEnglish(aStr: self.tfFinalAmount.text!))!{
                            //                    Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Final amount must be greater than saved amount", value: ""))
                            let newLength = text.count + string.count - range.length
                            if newLength > 7{
                                return false
                            }else{
                                if let x = tfSavedAmount.text{
                                    if (!AppConstants.isArabic() && !string.isEmpty){
                                        let s:String  = x.appending(string);
                                        tfSavedAmount.text = Utility.sharedInstance.convertNumberToEnglish(aStr: s)
                                        return false;
                                    }else{
                                        return true;
                                    }
                                }
                            }

                        }else{
                            self.calculateResult(Utility.sharedInstance.convertNumberToEnglish(aStr: self.tfFinalAmount.text!), Utility.sharedInstance.convertNumberToEnglish(aStr: txtAfterUpdate), String(aInstallmentMonth), Utility.sharedInstance.convertNumberToEnglish(aStr: self.tfMonthlyInstallment.text!), false)
                            let newLength = text.count + string.count - range.length
                            if newLength > 7{
                                return false
                            }else{
                                if let x = tfSavedAmount.text{
                                    if (!AppConstants.isArabic() && !string.isEmpty){
                                        let s:String  = x.appending(string);
                                        tfSavedAmount.text = Utility.sharedInstance.convertNumberToEnglish(aStr: s)
                                        return false;
                                    }else{
                                        return true;
                                    }
                                }
                            }
                        }
                    }else{
                        return false
                    }
                }
                else{
                    self.tfMonthlyInstallment.text = ""
                    if (string.isNumeric){
                        if let x = tfSavedAmount.text{
                            if (!AppConstants.isArabic() && !string.isEmpty){
                                let s:String  = x.appending(string);
                                tfSavedAmount.text = Utility.sharedInstance.convertNumberToEnglish(aStr: s)
                                return false;
                            }else{
                                return true;
                            }
                        }
                    }else{
                        return false
                    }
                }
                
            }
            return true
        }else if textField == tfMonths{
            let newLength = text.count + string.count - range.length
            if txtAfterUpdate != "" {
                if (string.isNumeric){
                    if newLength <= 5 {
                        if Float(Utility.sharedInstance.convertNumberToEnglish(aStr: txtAfterUpdate))! <= 999.0 {
                            self.calculateResult(Utility.sharedInstance.convertNumberToEnglish(aStr: self.tfFinalAmount.text!), Utility.sharedInstance.convertNumberToEnglish(aStr: self.tfSavedAmount.text!), Utility.sharedInstance.convertNumberToEnglish(aStr: txtAfterUpdate), Utility.sharedInstance.convertNumberToEnglish(aStr: self.tfMonthlyInstallment.text!), false)
                        }else{
                            return false
                        }
                    }
                    if newLength > 5{
                        return false
                    }else{
                        if let x = tfMonths.text{
                            if (!AppConstants.isArabic() && !string.isEmpty){
                                let s:String  = x.appending(string);
                                tfMonths.text = Utility.sharedInstance.convertNumberToEnglish(aStr: s)
                                return false;
                            }else{
                                return true;
                            }
                        }
                    }
                }else{
                    if (string.isNumeric){
                        return true
                    }else{
                        return false
                    }
                }
            }
            else{
                aInstallmentMonth = 0
                self.tfMonthlyInstallment.text = ""
                return true
            }
        }else if textField == tfMonthlyInstallment{
            let newLength = text.count + string.count - range.length
            if (string.isNumeric){
                if newLength <= 7 {
                    self.calculateResult(Utility.sharedInstance.convertNumberToEnglish(aStr: self.tfFinalAmount.text!), Utility.sharedInstance.convertNumberToEnglish(aStr: self.tfSavedAmount.text!), String(aInstallmentMonth), Utility.sharedInstance.convertNumberToEnglish(aStr: txtAfterUpdate), true)
                }
                if newLength > 7{
                    return false
                }else{
                    if let x = tfMonthlyInstallment.text{
                        if (!AppConstants.isArabic() && !string.isEmpty){
                            let s:String  = x.appending(string);
                            tfMonthlyInstallment.text = Utility.sharedInstance.convertNumberToEnglish(aStr: s)
                            return false;
                        }else{
                            return true;
                        }
                    }
                }
            }else{
                return false
            }
        }
        
        return true
    }
    
    
    func calculateResult(_ aStrFinalAmount: String, _ aStrSavedAmount: String, _ aStrMonths: String, _ aStrMonthlyInstallment: String, _ isInstallmentUpdated: Bool)->Void{
        var aFinalAmount: Int = 0
        var aSavedAmount: Int = 0
        var aMonths: Float = 0
        var aMonthlyInstallment: Float = 0
        
        if (!Utility.sharedInstance.validateBlank(strVal: aStrFinalAmount)){
            aFinalAmount = 0
        }else{
            if (aStrFinalAmount).isNumeric{
                aFinalAmount = Int(Utility.sharedInstance.convertNumberToEnglish(aStr: aStrFinalAmount))!
            }
            else{
                aFinalAmount = 0
            }
        }
        
        if (!Utility.sharedInstance.validateBlank(strVal: aStrSavedAmount)){
            aSavedAmount = 0
        }else{
            if (aStrSavedAmount).isNumeric{
                aSavedAmount = Int(Utility.sharedInstance.convertNumberToEnglish(aStr: aStrSavedAmount))!
            }else{
                aSavedAmount = 0
            }
        }
        
        if (!Utility.sharedInstance.validateBlank(strVal: aStrMonths)){
            aMonths = 0
        }else{
            if let mFloat = Float(Utility.sharedInstance.convertNumberToEnglish(aStr: aStrMonths)){
                aMonths = mFloat
            }else{
                aMonths = 0
            }
        }
        
        if (!Utility.sharedInstance.validateBlank(strVal: aStrMonthlyInstallment)){
            aMonthlyInstallment = 0
        }else{
            if let mFloat = Float(Utility.sharedInstance.convertNumberToEnglish(aStr: aStrMonthlyInstallment)){
                aMonthlyInstallment = mFloat
            }else{
                aMonthlyInstallment = 0
            }
        }
        
        //        let aMontlyInstallments = ((aFinalAmount! - aSavedAmount!) / aMonths!)
        if isInstallmentUpdated{
            if Float (aMonthlyInstallment) < 1{
                aMonthlyInstallment = 0
                aInstallmentMonth = 0
                self.tfMonthlyInstallment.text = String.init(format: "") //String(aMontlyInstallments)
                self.tfMonths.text = String.init(format: "")
            }else{
                let aMontlyInstallments = (Float((aFinalAmount - aSavedAmount)) / Float (aMonthlyInstallment))
                self.tfMonths.text =  String.init(format: "%.1f", aMontlyInstallments) //String(aMontlyInstallments)
                aInstallmentMonth = Float(self.tfMonths.text!)!
            }
        }else{
            aInstallmentMonth = aMonths
            if aInstallmentMonth < 1 {
                aInstallmentMonth = 0
                self.tfMonthlyInstallment.text = String.init(format: "")
            }else{
                let aMontlyInstallments = (Float((aFinalAmount - aSavedAmount)) / aInstallmentMonth)
                self.tfMonthlyInstallment.text = String.init(format: "%.1f", aMontlyInstallments) //String(aMontlyInstallments)
            }
      
        }
    }
}
