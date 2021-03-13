//
//  AddSavingVC.swift
//  Edkhar
//
//  Created by indianic on 28/01/17.
//  Copyright © 2017 demo. All rights reserved.
//

import UIKit
import SVProgressHUD

class AddSavingVC: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var lblScreenTitle: UILabel!
    @IBOutlet weak var btnBackEN: UIButton!
    @IBOutlet weak var btnBackAR: UIButton!
    @IBOutlet weak var tfSavingAmount: UITextField!
    @IBOutlet weak var btnDate: UIButton!
    @IBOutlet weak var btnSavingCategory: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    
    var arrSavingCategory = [String]()
    var aSelectedTargetIndex = Int()
    var arrSavingCategoryList = [TargetModel]()
    
    var aSavingModel = SavingModel()
    
    var aFinalTargetAmount = Int()
    var aTotalTargetSaving = Int()
    var aRemainTargetSaving = Int()
    
    
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show()
        
        if (ConstantsT.DeviceType.IS_IPAD) {
            Utility.sharedInstance.customizeFonts(in: contentView, aFontName: Medium, aFontSize: 0)
        }
        else{
            Utility.sharedInstance.customizeFonts(in: contentView, aFontName: Medium, aFontSize: 0)
        }
        
        btnDate.setTitle(Utility.sharedInstance.getStringFromDate("yyyy-MM-dd", date: Date()), for: .normal)
        self.lblScreenTitle.text = JMOLocalizedString(forKey: "ADD SAVING", value: "")
        
        if AppConstants.isArabic() {
            btnBackEN.isHidden = true
            btnSavingCategory.contentHorizontalAlignment = .right
            btnSavingCategory.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
            
            btnDate.contentHorizontalAlignment = .right
            btnDate.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
            
        }
        else{
            btnBackAR.isHidden = true
            btnSavingCategory.contentHorizontalAlignment = .left
            btnSavingCategory.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            
            btnDate.contentHorizontalAlignment = .left
            btnDate.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        }
        
        LanguageManager.sharedInstance.localizeThingsInView(parentView: self.view)
        LanguageManager.sharedInstance.localizeThingsInView(parentView: btnDate)
        
        
        self.arrSavingCategoryList = userInfoManagerT.sharedInstance.GetAllTargetListTitle()
        if self.arrSavingCategoryList.count > 0 {
            
            for objSavingTarget in self.arrSavingCategoryList{
                self.arrSavingCategory.append(objSavingTarget.target_name!)
            }
        }
        
        btnDate.setTitle(Utility.sharedInstance.getStringFromDate("yyyy-MM-dd", date: Date()), for: .normal)
        
        if aSavingModel.identifier != nil{
            tfSavingAmount.text = aSavingModel.saving_value
            btnDate.setTitle(aSavingModel.saving_date, for: .normal)
            btnSave.setTitle(JMOLocalizedString(forKey: "Update", value: ""), for: .normal)
            self.lblScreenTitle.text = JMOLocalizedString(forKey: "Edit Saving", value: "")
            var count: Int = 0
            for aDict in self.arrSavingCategoryList{
                if aDict.identifier == aSavingModel.target_id{
                    break
                }
                count = count + 1
            }
            self.aSelectedTargetIndex = count
            btnSavingCategory.setTitle(self.arrSavingCategory[self.aSelectedTargetIndex], for: .normal)
        }
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        Utility.sharedInstance.setPaddingAndShadowForUIComponents(parentView: contentView)
        Utility.sharedInstance.setShadowForView(view: btnDate)
        Utility.sharedInstance.setShadowForView(view: btnSavingCategory)
        
        SVProgressHUD.dismiss()
    }
    
    @IBAction func btnBackENAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnBackARAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnSavingCategoryAction(_ sender: UIButton) {
        self.view.endEditing(true)
        Utility.sharedInstance.addPicker(self, onTextFieldORButton: btnSavingCategory, typePicker: PickerType.SimplePicker.rawValue, pickerArray: self.arrSavingCategory,showMinDate: false) { (picker,buttonindex,firstindex) in
            if (picker != nil)
            {
                if self.arrSavingCategory.count > 0{
                    
                    self.btnSavingCategory.setTitle(self.arrSavingCategory[firstindex], for: .normal)
                    
                    self.aSelectedTargetIndex = firstindex
                }
            }
        }
    }
    
    @IBAction func btnDateAction(_ sender: Any) {
        self.view.endEditing(true)
        Utility.sharedInstance.addPicker(self, onTextFieldORButton: btnDate, typePicker: PickerType.DatePicker.rawValue, pickerArray: [],showMinDate: true) { (picker,buttonindex,firstindex) in
            if (picker != nil)
            {
                let datePicker = picker as! UIDatePicker
                let strTime = Utility.sharedInstance.getStringFromDate("yyyy-MM-dd", date: datePicker.date)
                self.btnDate.setTitle(strTime, for: .normal)
            }
        }
    }
    
    @IBAction func btnSaveAction(_ sender: Any) {
        
        if self.validateForm() {
            
            let objSavingModel = SavingModel()
            if aSavingModel.identifier != nil{
                objSavingModel.identifier = aSavingModel.identifier
            }
            objSavingModel.target_id = self.arrSavingCategoryList[self.aSelectedTargetIndex].identifier!
            objSavingModel.saving_note = ""
            objSavingModel.saving_value = Utility.sharedInstance.convertNumberToEnglish(aStr: self.tfSavingAmount.text!)
            objSavingModel.saving_date = btnDate.title(for: .normal)!
            
            var aIncomeInfoAdded : Bool = false
            var aDBSucessMsg = ""
            
            if aSavingModel.identifier != nil{
                // income update - update query for database.
                aIncomeInfoAdded = userInfoManagerT.sharedInstance.UpdateSavingDetail(objSavingModel: objSavingModel)
                aDBSucessMsg = "your modifications are saved successfully"
                
            }
            else{
                // user signup - insert query for database.
                aIncomeInfoAdded = userInfoManagerT.sharedInstance.InsertSavingDetail(objSavingModel: objSavingModel)
                aDBSucessMsg = JMOLocalizedString(forKey: "addition process done successfully", value: "")
                
            }
            
            if aIncomeInfoAdded == true {
                
                let alertController = UIAlertController(title:  JMOLocalizedString(forKey: "Edkhar", value: ""), message: JMOLocalizedString(forKey: aDBSucessMsg, value: ""), preferredStyle: .alert)
                let okAction = UIAlertAction(title: JMOLocalizedString(forKey: "OK", value: ""), style: .default, handler: { (action) in
                    
                    let finalTargetAmount = self.getTargetFinalAmount().0
                    let targetSavedAmount = self.getTargetFinalAmount().1
                    let targetName = self.getTargetFinalAmount().2
                    let totalTargetSavings = self.getTargetSavingFromSavingTable()
                    let totalSavings = targetSavedAmount + totalTargetSavings
                    if totalSavings >= finalTargetAmount {
                        let msg = JMOLocalizedString(forKey: "Congratulations, you have achieved the target", value: "")
                        let aObjAlertController = UIAlertController(title:  JMOLocalizedString(forKey: "Edkhar", value: ""), message: JMOLocalizedString(forKey: "\(msg) \(targetName)", value: ""), preferredStyle: .alert)
                        let aOkAction = UIAlertAction(title: JMOLocalizedString(forKey: "OK", value: ""), style: .default, handler: { (action) in
                            _ = self.navigationController?.popViewController(animated: true)
                        })
                        aObjAlertController.addAction(aOkAction)
                        self.present(aObjAlertController, animated: true, completion: nil)
                        
                    }else{
                        _ = self.navigationController?.popViewController(animated: true)
                    }
                })
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    
    
    
    func validateForm() -> Bool{
        
        if !Utility.sharedInstance.validateBlank(strVal: self.tfSavingAmount.text!) && (self.btnDate.title(for: .normal) == JMOLocalizedString(forKey: "Date", value: "")) && (self.btnSavingCategory.title(for: .normal) == JMOLocalizedString(forKey: "Financial Target *", value: "") || self.btnSavingCategory.title(for: .normal) == JMOLocalizedString(forKey: "Financial Target", value: "")){
            
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please fill all mandatory fields", value: ""))
            return false
        }
        else if !Utility.sharedInstance.validateBlank(strVal: self.tfSavingAmount.text!) {
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please fill Amount field", value: ""))
            return false
        }
        else if (self.btnDate.title(for: .normal) == JMOLocalizedString(forKey: "Date", value: "")) {
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please enter date value", value: ""))
            return false
        }
        else if !(self.tfSavingAmount.text!).isNumeric {
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please enter proper Amount value", value: ""))
            return false
        }
        else if Int(Utility.sharedInstance.convertNumberToEnglish(aStr: tfSavingAmount.text!))! <= 0{
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "please fill valid saved amount", value: ""))
            return false
        }
        else if (self.btnSavingCategory.title(for: .normal) == JMOLocalizedString(forKey: "Financial Target *", value: "") || self.btnSavingCategory.title(for: .normal) == JMOLocalizedString(forKey: "Financial Target", value: "")) {
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please Select financial target for saving", value: ""))
            return false
        }
        else{
            return true
            
            //            aFinalTargetAmount = self.getTargetFinalAmount()
            //            aTotalTargetSaving = self.getTargetSavingFromSavingTable()
            //
            //            if aSavingModel.identifier != nil{
            //                if aSavingModel.target_id == self.arrSavingCategoryList[self.aSelectedTargetIndex].identifier!{
            //                    aRemainTargetSaving = aFinalTargetAmount - aTotalTargetSaving + Int(aSavingModel.saving_value)!
            //                }
            //                else{
            //                    aRemainTargetSaving = aFinalTargetAmount - aTotalTargetSaving
            //                }
            //            }
            //            else{
            //                aRemainTargetSaving = aFinalTargetAmount - aTotalTargetSaving
            //            }
            //
            //            if Int(Utility.sharedInstance.convertNumberToEnglish(aStr: tfSavingAmount.text!))! > aRemainTargetSaving {
            //                Utility.sharedInstance.showAlert(self, message: "You have remain \(aRemainTargetSaving) savings for this target.")
            //                return false
            //            }else{
            //                return true
            //            }
        }
    }
    
    func getTargetSavingFromSavingTable() -> Int {
        var savingByTargetID = 0
        let objSavingModel = SavingModel()
        objSavingModel.target_id = self.arrSavingCategoryList[self.aSelectedTargetIndex].identifier!
        let arrFilterSavingbyID  = userInfoManagerT.sharedInstance.GetSavingValByTarget(objSavingModel: objSavingModel)
        if arrFilterSavingbyID.count > 0 {
            for aDictSaving in arrFilterSavingbyID{
                savingByTargetID = savingByTargetID + Int((aDictSaving.saving_value!))!
            }
        }
        return savingByTargetID
    }
    
    func getTargetFinalAmount() -> (Int, Int, String) {
        var targetFinalAmount = 0
        var targetSaving = 0
        var targetName: String = ""
        let arrFilterTargetbyID  = self.arrSavingCategoryList.filter { (aTargetModel : TargetModel) -> Bool in
            return aTargetModel.identifier == self.arrSavingCategoryList[self.aSelectedTargetIndex].identifier!
        }
        if arrFilterTargetbyID.count > 0 {
            let aTempTargetModel = arrFilterTargetbyID.first
            targetFinalAmount = Int((aTempTargetModel?.target_final_amount)!)!
            targetSaving = Int((aTempTargetModel?.target_saved_amount)!)!
            targetName = (aTempTargetModel?.target_name!)!
            
        }
        return (targetFinalAmount,targetSaving, targetName)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        
        if (string.isNumeric){
            let newLength = text.count + string.count - range.length
            
            if newLength > 7{
                return false
            }else{
                if let x = tfSavingAmount.text{
                    if (!AppConstants.isArabic() && !string.isEmpty){
                        let s:String  = x.appending(string);
                        tfSavingAmount.text = Utility.sharedInstance.convertNumberToEnglish(aStr: s)
                        return false;
                    }else{
                        return true;
                    }
                }
            }
            
        }else{
            return false
        }
        
        return true
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
