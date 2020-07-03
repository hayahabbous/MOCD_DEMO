//
//  AddIncomeVC.swift
//  Edkhar
//
//  Created by indianic on 03/01/17.
//  Copyright © 2017 demo. All rights reserved.
//

import UIKit
import SVProgressHUD

class AddIncomeVC: UIViewController ,UITextFieldDelegate{
    
    @IBOutlet weak var lblScreenTitle: UILabel!
    @IBOutlet weak var btnBackEN: UIButton!
    @IBOutlet weak var btnBackAR: UIButton!
    @IBOutlet weak var tfIncomeValue: UITextField!
    @IBOutlet weak var btnIncomeCategory: UIButton!
    @IBOutlet weak var switchRecurring: UISwitch!
    @IBOutlet weak var btnDate: UIButton!
    @IBOutlet weak var tfNote: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    
    @IBOutlet weak var contentView: UIView!
    var aIncomeModel = IncomeModel()
    
    var arrIncomeCategory = [IncomeTypeModel]()
    var arrIncomeTypeCategory = [String]()
    var objSelectedIncomeTypeCategory = IncomeTypeModel()
    var arrIncomeListType = [IncomeTypeModel]()
    var aRecurring = Int()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        SVProgressHUD.show()
        
        self.navigationController?.isNavigationBarHidden = true
        
        
        if (ConstantsT.DeviceType.IS_IPAD) {
            Utility.sharedInstance.customizeFonts(in: contentView, aFontName: Medium, aFontSize: 0)
        }
        else{
            Utility.sharedInstance.customizeFonts(in: contentView, aFontName: Medium, aFontSize: 0)
        }
        
        
        arrIncomeCategory = userInfoManagerT.sharedInstance.GetAllIncomeTypeListDetail()
        
        if arrIncomeCategory.count > 0 {
            if AppConstants.isArabic(){
                for i in 0...(arrIncomeCategory.count - 1)
                {
                    let objIncomeTypeModel = arrIncomeCategory[i]
                    arrIncomeTypeCategory.append(objIncomeTypeModel.income_type_title_ar)
                }
            }else{
                for i in 0...(arrIncomeCategory.count - 1)
                {
                    let objIncomeTypeModel = arrIncomeCategory[i]
                    arrIncomeTypeCategory.append(objIncomeTypeModel.income_type_title)
                }
            }
        }
        
        
        if AppConstants.isArabic() {
            btnBackEN.isHidden = true
            btnIncomeCategory.contentHorizontalAlignment = .right
            btnIncomeCategory.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
            
            btnDate.contentHorizontalAlignment = .right
            btnDate.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
            
        }
        else{
            btnBackAR.isHidden = true
            btnIncomeCategory.contentHorizontalAlignment = .left
            btnIncomeCategory.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            
            btnDate.contentHorizontalAlignment = .left
            btnDate.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        }
        
        LanguageManager.sharedInstance.localizeThingsInView(parentView: self.view)
        LanguageManager.sharedInstance.localizeThingsInView(parentView: btnDate)
        
        btnDate.setTitle(Utility.sharedInstance.getStringFromDate("yyyy-MM-dd", date: Date()), for: .normal)
        
        if aIncomeModel.identifier != nil{
            
            self.arrIncomeListType = userInfoManagerT.sharedInstance.GetAllIncomeTypeListDetail()
            
            let aArrIncomeListType =  self.arrIncomeListType.filter { (objIncomeTypeModel : IncomeTypeModel) -> Bool in
                return objIncomeTypeModel.income_type_id == aIncomeModel.income_type_id
            }
            
            print("aArrIncomeListType \(aArrIncomeListType)")
            var aSelectedIncomeTypeTitleAr = String()
            var aSelectedIncomeTypeTitle = String()
            
            aSelectedIncomeTypeTitleAr = (aArrIncomeListType.first?.income_type_title_ar!)!
            aSelectedIncomeTypeTitle = (aArrIncomeListType.first?.income_type_title!)!
            
            if AppConstants.isArabic() {
                btnIncomeCategory.setTitle(aSelectedIncomeTypeTitleAr, for: .normal)
            }
            else{
                btnIncomeCategory.setTitle(aSelectedIncomeTypeTitle, for: .normal)
            }
            
            tfIncomeValue.text = aIncomeModel.income_value
            tfNote.text = aIncomeModel.income_note
            btnDate.setTitle(aIncomeModel.income_date, for: .normal)
            
            if aIncomeModel.income_type_isrecurring == 1{
                switchRecurring.isOn = true
            }else{
                switchRecurring.isOn = false
            }
            self.objSelectedIncomeTypeCategory.income_type_id = aIncomeModel.income_type_id
            self.objSelectedIncomeTypeCategory.income_type_title = aSelectedIncomeTypeTitle
            self.objSelectedIncomeTypeCategory.income_type_title_ar = aSelectedIncomeTypeTitleAr
            switchRecurring.isOn ? (aRecurring = 1) : (aRecurring = 0)
            btnSave.setTitle(JMOLocalizedString(forKey: "Update", value: ""), for: .normal)
            self.lblScreenTitle.text = JMOLocalizedString(forKey: "EDIT INCOME", value: "")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        Utility.sharedInstance.setPaddingAndShadowForUIComponents(parentView: contentView)
        Utility.sharedInstance.setShadowForView(view: btnDate)
        Utility.sharedInstance.setShadowForView(view: btnIncomeCategory)
        
        SVProgressHUD.dismiss()
    }
    
    @IBAction func btnBackENAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnBackARAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnIncomeCategoryAction(_ sender: UIButton) {
        self.view.endEditing(true)
        Utility.sharedInstance.addPicker(self, onTextFieldORButton: btnIncomeCategory, typePicker: PickerType.SimplePicker.rawValue, pickerArray: arrIncomeTypeCategory,showMinDate: false) { (picker,buttonindex,firstindex) in
            if (picker != nil)
            {
                if self.arrIncomeTypeCategory.count > 0{
                    
                    self.btnIncomeCategory.setTitle(self.arrIncomeTypeCategory[firstindex], for: .normal)
                    self.objSelectedIncomeTypeCategory = self.arrIncomeCategory[firstindex]
                    print("Selected Income model = \(self.objSelectedIncomeTypeCategory)")
                }
            }
        }
    }
    
    @IBAction func switchRecurringAction(_ sender: Any) {
        switchRecurring.isOn ? (aRecurring = 1) : (aRecurring = 0)
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
            
            let objIncomeModel = IncomeModel()
            
            if aIncomeModel.identifier != nil{
                objIncomeModel.identifier = aIncomeModel.identifier
            }
            objIncomeModel.income_value = Utility.sharedInstance.convertNumberToEnglish(aStr: tfIncomeValue.text!)
            objIncomeModel.income_type_id = self.objSelectedIncomeTypeCategory.income_type_id
            objIncomeModel.income_type_isrecurring = aRecurring
            objIncomeModel.income_date = btnDate.title(for: .normal)!
            objIncomeModel.income_note = tfNote.text!
            var aIncomeInfoAdded : Bool = false
            var aDBSucessMsg = ""
            
            if aIncomeModel.identifier != nil{
                // income update - update query for database.
                aIncomeInfoAdded = userInfoManagerT.sharedInstance.UpdateIncomeDetail(objIncomeModel: objIncomeModel)
                aDBSucessMsg = "your modifications are saved successfully"
                
                if aIncomeInfoAdded == true {
                    
                    let alertController = UIAlertController(title:  JMOLocalizedString(forKey: "Edkhar", value: ""), message: JMOLocalizedString(forKey: aDBSucessMsg, value: ""), preferredStyle: .alert)
                    let okAction = UIAlertAction(title: JMOLocalizedString(forKey: "OK", value: ""), style: .default, handler: { (action) in
                        _ = self.navigationController?.popViewController(animated: true)
                    })
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
            else{
                // user signup - insert query for database.
                aIncomeInfoAdded = userInfoManagerT.sharedInstance.InsertIncomeDetail(objIncomeModel: objIncomeModel)
                aDBSucessMsg = "addition process done successfully"
                
                if aIncomeInfoAdded == true {
                    
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
    
    func validateForm() -> Bool{
        
        if !Utility.sharedInstance.validateBlank(strVal: self.tfIncomeValue.text!) && !Utility.sharedInstance.validateBlank(strVal: self.tfNote.text!) && btnIncomeCategory.title(for: .normal) == JMOLocalizedString(forKey: "Income Category", value: ""){
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please fill all mandatory fields", value: ""))
            return false
        }
        else if !Utility.sharedInstance.validateBlank(strVal: self.tfIncomeValue.text!) {
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please enter income value", value: ""))
            return false
        }
        else if !(self.tfIncomeValue.text!).isNumeric {
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please enter proper income value", value: ""))
            return false
        }
        else if Int(Utility.sharedInstance.convertNumberToEnglish(aStr: tfIncomeValue.text!))! <= 0{
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "please fill valid income value", value: ""))
            return false
        }
        else if btnIncomeCategory.title(for: .normal) == JMOLocalizedString(forKey: "Income Category", value: ""){
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please select income category", value: ""))
            return false
        }
        else{
            return true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        if textField == tfIncomeValue{
            if (string.isNumeric){
                let newLength = text.count + string.count - range.length
                
                if newLength > 7{
                    return false
                }else{
                    if let x = tfIncomeValue.text{
                        if (!AppConstants.isArabic() && !string.isEmpty){
                            let s:String  = x.appending(string);
                            tfIncomeValue.text = Utility.sharedInstance.convertNumberToEnglish(aStr: s)
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
    
}

