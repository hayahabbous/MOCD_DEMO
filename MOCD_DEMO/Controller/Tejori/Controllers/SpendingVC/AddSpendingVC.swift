//
//  AddIncomeVC.swift
//  Edkhar
//
//  Created by indianic on 03/01/17.
//  Copyright © 2017 demo. All rights reserved.
//

import UIKit
import SVProgressHUD

class AddSpendingVC: UIViewController ,UITextFieldDelegate{
    
    @IBOutlet weak var lblScreenTitle: UILabel!
    @IBOutlet weak var btnBackEN: UIButton!
    @IBOutlet weak var btnBackAR: UIButton!
    @IBOutlet weak var tfSpendingValue: UITextField!
    @IBOutlet weak var btnSpendingCategory: UIButton!
    @IBOutlet weak var btnSpendingType: UIButton!
    @IBOutlet weak var btnSpendingSubCategory: UIButton!
    @IBOutlet weak var switchRecurring: UISwitch!
    @IBOutlet weak var btnDate: UIButton!
    //    @IBOutlet weak var tfNote: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var topSwitchConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingSpendingCategoryConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingSubSpendingCategoryConstraint: NSLayoutConstraint!
    
    var aRecurring = Int()
    @IBOutlet weak var viewSubcategory: UIView!
    
    @IBOutlet weak var viewAddCategory: UIView!
    @IBOutlet weak var lblAddCategoryTitle: UILabel!
    @IBOutlet var tfAddCategoryValue: UITextField!
    
    @IBOutlet weak var btnCancelCategory: UIButton!
    @IBOutlet weak var btnAddCategory: UIButton!
    @IBOutlet weak var btnAddSpendingCategory: UIButton!
    @IBOutlet weak var btnAddSpendingSubCategory: UIButton!
    
    var isForCategory = Bool()
    
    var aSpendingModel = SpendingModel()
    
    var arrSpendingCategory = [SpendingTypeModel]()
    var arrSpendingTypeCategory = [String]()
    var arrSpendingSubTypeCategory = [String]()
    var objSelectedSpendingTypeCategory = SpendingTypeModel()
    var objSelectedSubSpendingTypeCategory = SpendingTypeModel()
    var arrTempSpendingCategory = [SpendingTypeModel]()
    var objSpendingSelectedTypeModel = SpendingTypeModel()
    var aSelectedCategoryTypeIndex = Int()
    
    var arrSpendingTypeList = [String]()
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        SVProgressHUD.show()
        self.navigationController?.isNavigationBarHidden = true
        
        self.lblScreenTitle.text = JMOLocalizedString(forKey: "Add Appointment", value: "")
        
        btnDate.setTitle(Utility.sharedInstance.getStringFromDate("yyyy-MM-dd", date: Date()), for: .normal)
        
        self.arrSpendingTypeList = [JMOLocalizedString(forKey: "Luxury", value: "") , JMOLocalizedString(forKey: "necessary", value: "") , JMOLocalizedString(forKey: "not defined", value: "")]
        let aSelectedCategory = self.arrSpendingTypeList.first
        self.btnSpendingType.setTitle(aSelectedCategory, for: .normal)
        
        if (ConstantsT.DeviceType.IS_IPAD) {
            Utility.sharedInstance.customizeFonts(in: contentView, aFontName: Medium, aFontSize: 0)
        }
        else{
            Utility.sharedInstance.customizeFonts(in: contentView, aFontName: Medium, aFontSize: 0)
        }

        
        
        if AppConstants.isArabic() {
            
            btnBackEN.isHidden = true
            btnSpendingCategory.contentHorizontalAlignment = .right
            btnSpendingCategory.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
            
            btnSpendingSubCategory.contentHorizontalAlignment = .right
            btnSpendingSubCategory.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
            
            
            btnDate.contentHorizontalAlignment = .right
            btnDate.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
            
            btnSpendingType.contentHorizontalAlignment = .right
            btnSpendingType.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
            
        }
        else{
            
            btnBackAR.isHidden = true
            btnSpendingCategory.contentHorizontalAlignment = .left
            btnSpendingCategory.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            
            btnSpendingSubCategory.contentHorizontalAlignment = .left
            btnSpendingSubCategory.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            
            btnDate.contentHorizontalAlignment = .left
            btnDate.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            
            btnSpendingType.contentHorizontalAlignment = .left
            btnSpendingType.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            
        }
        
        LanguageManager.sharedInstance.localizeThingsInView(parentView: self.view)
        
        self.topSwitchConstraint.constant = 16
        
        self.GetSpendingCategories()
        
        self.HandleUpdateSpending()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        Utility.sharedInstance.setPaddingAndShadowForUIComponents(parentView: contentView)
        Utility.sharedInstance.setShadowForView(view: btnSpendingCategory)
        Utility.sharedInstance.setShadowForView(view: btnSpendingSubCategory)
        Utility.sharedInstance.setShadowForView(view: btnDate)
        Utility.sharedInstance.setShadowForView(view: btnSpendingType)
        
        self.viewAddCategory.layer.borderWidth = 0.5
        self.viewAddCategory.layer.borderColor = UIColor.colorFromRGB(R: 0, G: 132, B: 61, Alpha: 1).cgColor
        
        SVProgressHUD.dismiss()
    }
    
    
    func HandleUpdateSpending() -> Void {
        
        if aSpendingModel.identifier != nil{
            
            self.trailingSpendingCategoryConstraint.constant = 40;
            self.trailingSubSpendingCategoryConstraint.constant = 0;
            
            btnAddSpendingCategory.isHidden = true
            btnAddSpendingSubCategory.isHidden = true
            
            self.lblScreenTitle.text = JMOLocalizedString(forKey: "EDIT SPENDING", value: "")
            self.tfSpendingValue.text = aSpendingModel.spending_value
            
            if aSpendingModel.spending_option == 1 {
                self.btnSpendingType.setTitle(JMOLocalizedString(forKey: "Luxury", value: ""), for: .normal)
            }
            else if aSpendingModel.spending_option == 2 {
                self.btnSpendingType.setTitle(JMOLocalizedString(forKey: "necessary", value: ""), for: .normal)
            }else{
                self.btnSpendingType.setTitle(JMOLocalizedString(forKey: "not defined", value: ""), for: .normal)
            }
            
            self.btnDate.setTitle(aSpendingModel.spending_date, for: .normal)
            if aSpendingModel.spending_type_isrecurring == 1{
                self.switchRecurring.isOn = true
            }else{
                self.switchRecurring.isOn = false
            }
            switchRecurring.isOn ? (aRecurring = 1) : (aRecurring = 0)
            btnSave.setTitle(JMOLocalizedString(forKey: "Update", value: ""), for: .normal)
            
            //Check Spending Sub Category
            let objSpendingSubCategoryTypeModel = self.GetSpendingSubCategoryForUpdate(aSpendingModel)
            // It is category
            if objSpendingSubCategoryTypeModel.spending_type_super == 0{
                self.getSubcategoryForSelectedCategoryIndex(objSpendingSubCategoryTypeModel)
                if AppConstants.isArabic(){
                    btnSpendingCategory.setTitle(objSpendingSubCategoryTypeModel.spending_type_title_ar, for: .normal)
                }
                else{
                    btnSpendingCategory.setTitle(objSpendingSubCategoryTypeModel.spending_type_title, for: .normal)
                }
            }
            else{
                let objSpendingCategoryTypeModel = self.GetSpendingCategoryForUpdate(objSpendingSubCategoryTypeModel)
                if objSpendingCategoryTypeModel.spending_type_super == 0{
                    self.getSubcategoryForSelectedCategoryIndex(objSpendingCategoryTypeModel)
                    if AppConstants.isArabic(){
                        btnSpendingCategory.setTitle(objSpendingCategoryTypeModel.spending_type_title_ar, for: .normal)
                        btnSpendingSubCategory.setTitle(objSpendingSubCategoryTypeModel.spending_type_title_ar, for: .normal)
                    }
                    else{
                        btnSpendingCategory.setTitle(objSpendingCategoryTypeModel.spending_type_title, for: .normal)
                        btnSpendingSubCategory.setTitle(objSpendingSubCategoryTypeModel.spending_type_title, for: .normal)
                    }
                    self.objSelectedSubSpendingTypeCategory = objSpendingSubCategoryTypeModel
                }
            }
        }else{
            if self.trailingSpendingCategoryConstraint != nil {
                self.trailingSpendingCategoryConstraint.constant = 100;
            }
            if self.trailingSubSpendingCategoryConstraint != nil {
                self.trailingSubSpendingCategoryConstraint.constant = 60;
            }
            btnAddSpendingCategory.isHidden = false
            btnAddSpendingSubCategory.isHidden = false
        }
    }
    
    func GetSpendingSubCategoryForUpdate(_ aSpendingModel: SpendingModel) -> SpendingTypeModel{
        var objSpendingCategoryModel = SpendingTypeModel()
        var arrSpendingTempCategory = [SpendingTypeModel]()
        arrSpendingTempCategory = self.arrTempSpendingCategory.filter{ (objSpendingTypeModel: SpendingTypeModel) -> Bool in
            return objSpendingTypeModel.spending_type_id == aSpendingModel.spending_type_id
        }
        objSpendingCategoryModel = arrSpendingTempCategory.first!
        return objSpendingCategoryModel
    }
    
    func GetSpendingCategoryForUpdate(_ aSpendingTypeModel: SpendingTypeModel) -> SpendingTypeModel {
        var objSpendingCategoryModel = SpendingTypeModel()
        var arrSpendingTempCategory = [SpendingTypeModel]()
        arrSpendingTempCategory = self.arrTempSpendingCategory.filter{ (objSpendingTypeModel: SpendingTypeModel) -> Bool in
            return objSpendingTypeModel.spending_type_id == aSpendingTypeModel.spending_type_super
        }
        objSpendingCategoryModel = arrSpendingTempCategory.first!
        return objSpendingCategoryModel
    }
    
    func getSubcategoryForSelectedCategoryIndex(_ objSpendingCategoryTypeModel: SpendingTypeModel)->Void{
        self.viewSubcategory.isHidden = false
        self.topSwitchConstraint.constant = 77
        var aCount: Int = 0
        var firstIndex: Int = 0
        if AppConstants.isArabic(){
            for aStr in arrSpendingTypeCategory{
                if aStr == objSpendingCategoryTypeModel.spending_type_title_ar{
                    break
                }
                aCount = aCount + 1
            }
        }else{
            for aStr in arrSpendingTypeCategory{
                if aStr == objSpendingCategoryTypeModel.spending_type_title{
                    break
                }
                aCount = aCount + 1
            }
        }
        firstIndex = aCount
        self.aSelectedCategoryTypeIndex = firstIndex
        self.GetSpendingSubCategories(firstIndex)
    }
    
    
    @IBAction func btnBackENAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnBackARAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
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
            
            print("Spending Value : \(tfSpendingValue.text!)")
            print("Spending Category : \(btnSpendingCategory.title(for: .normal)!)")
            print("Spending Sub-Category : \(btnSpendingSubCategory.title(for: .normal)!)")
            print("Recurring : \(aRecurring)")
            print("Date : \(btnDate.title(for: .normal)!)")
            
            print("Spending option : \(btnSpendingType.title(for: .normal)!)")
            
            var aSpendingOptionValue = Int()
            
            if (btnSpendingType.title(for: .normal)! == JMOLocalizedString(forKey: "Luxury", value: "")) {
                aSpendingOptionValue = 1
            }else if (btnSpendingType.title(for: .normal)! == JMOLocalizedString(forKey: "necessary", value: "")) {
                aSpendingOptionValue = 2
            }else{
                aSpendingOptionValue = 3
            }
            
            let objSpendingModel = SpendingModel()
            
            if aSpendingModel.identifier != nil{
                objSpendingModel.identifier = aSpendingModel.identifier
            }
            
            if self.objSelectedSubSpendingTypeCategory.spending_type_id == nil{
                objSpendingModel.spending_type_id = self.arrSpendingCategory[self.aSelectedCategoryTypeIndex].spending_type_id!
            }else{
                objSpendingModel.spending_type_id = self.objSelectedSubSpendingTypeCategory.spending_type_id!
            }
            
            objSpendingModel.spending_note = ""
            objSpendingModel.spending_value =  Utility.sharedInstance.convertNumberToEnglish(aStr: tfSpendingValue.text!)
            objSpendingModel.spending_date = btnDate.title(for: .normal)!
            objSpendingModel.spending_type_isrecurring = aRecurring
            objSpendingModel.spending_option = aSpendingOptionValue
            
            var aSpendingInfoAdded : Bool = false
            var aDBSucessMsg = ""
            
            if aSpendingModel.identifier != nil {
                aSpendingInfoAdded = userInfoManagerT.sharedInstance.UpdateSpendingDetail(objSpendingModel: objSpendingModel)
                aDBSucessMsg = JMOLocalizedString(forKey: "your modifications are saved successfully", value: "")
            }else{
                aSpendingInfoAdded = userInfoManagerT.sharedInstance.InsertSpendingDetail(objSpendingModel: objSpendingModel)
                aDBSucessMsg = JMOLocalizedString(forKey: "addition process done successfully", value: "")
            }
            
            if aSpendingInfoAdded == true {
                let alertController = UIAlertController(title:  JMOLocalizedString(forKey: "Edkhar", value: ""), message:aDBSucessMsg , preferredStyle: .alert)
                let okAction = UIAlertAction(title: JMOLocalizedString(forKey: "OK", value: ""), style: .default, handler: { (action) in
                    _ = self.navigationController?.popViewController(animated: true)
                })
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    @IBAction func switchRecurringAction(_ sender: Any) {
        switchRecurring.isOn ? (aRecurring = 1) : (aRecurring = 0)
    }
    
    
    @IBAction func btnAddSpendingAction(_ sender: UIButton) {
        Utility.sharedInstance.removePickerView()
        isForCategory = true
        viewAddCategory.isHidden = false
        //        Category name
        self.lblAddCategoryTitle.text = JMOLocalizedString(forKey: "Add Category", value: "")
        self.tfAddCategoryValue.placeholder = JMOLocalizedString(forKey: "Category name", value: "")
        self.tfAddCategoryValue.text = ""
        
    }
    
    @IBAction func btnAddSpendingTypeAction(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        Utility.sharedInstance.addPicker(self, onTextFieldORButton: btnSpendingCategory, typePicker: PickerType.SimplePicker.rawValue, pickerArray: self.arrSpendingTypeList,showMinDate: false) { (picker,buttonindex,firstindex) in
            if (picker != nil)
            {
                let aSelectedCategory = self.arrSpendingTypeList[firstindex]
                self.btnSpendingType.setTitle(aSelectedCategory, for: .normal)
            }
        }
        
    }
    
    
    @IBAction func btnSpendingCategoryAction(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        Utility.sharedInstance.addPicker(self, onTextFieldORButton: btnSpendingCategory, typePicker: PickerType.SimplePicker.rawValue, pickerArray: arrSpendingTypeCategory,showMinDate: false) { (picker,buttonindex,firstindex) in
            if (picker != nil)
            {
                let aSelectedCategory = self.arrSpendingTypeCategory[firstindex]
                self.btnSpendingCategory.setTitle(aSelectedCategory, for: .normal)
                self.btnSpendingSubCategory.setTitle(JMOLocalizedString(forKey: "Spending Sub-Category", value: ""), for: .normal)
                self.viewSubcategory.isHidden = false
                self.topSwitchConstraint.constant = 77
                self.aSelectedCategoryTypeIndex = firstindex
                self.GetSpendingSubCategories(firstindex)
                self.objSelectedSubSpendingTypeCategory.spending_type_id = nil;
                
            }
        }
    }
    
    @IBAction func btnSpendingSubCategoryAction(_ sender: Any) {
        
        if self.arrSpendingSubTypeCategory.count > 0 {
            self.arrSpendingSubTypeCategory.removeAll()
        }
        self.GetSpendingSubCategories(self.aSelectedCategoryTypeIndex)
        
        //        self.objSpendingSelectedTypeModel = self.arrSpendingCategory[index] as SpendingTypeModel!
        
        self.view.endEditing(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            Utility.sharedInstance.addPicker(self, onTextFieldORButton: self.btnSpendingSubCategory, typePicker: PickerType.SimplePicker.rawValue, pickerArray: self.arrSpendingSubTypeCategory,showMinDate: false) { (picker,buttonindex,firstindex) in
                if (picker != nil)
                {
                    if self.arrSpendingSubTypeCategory.count > 0 &&  self.arrSpendingSubTypeCategory.count == 1{
                        self.btnSpendingSubCategory.setTitle(self.arrSpendingSubTypeCategory.first, for: .normal)
                    }else if self.arrSpendingSubTypeCategory.count > 0{
                        self.btnSpendingSubCategory.setTitle(self.arrSpendingSubTypeCategory[firstindex], for: .normal)
                    }
                    self.updateSelectedSubSpendingCategoryTypeId()
                }
            }
        }
        
    }
    
    func GetSpendingCategories() -> Void {
        
        if self.arrTempSpendingCategory.count > 0 {
            self.arrTempSpendingCategory.removeAll()
        }
        arrTempSpendingCategory = userInfoManagerT.sharedInstance.GetAllSpendingTypeListDetail()
        
        if  self.arrSpendingCategory.count > 0 {
            self.arrSpendingCategory.removeAll()
        }
        self.arrSpendingCategory =  self.arrTempSpendingCategory.filter { (objSpendingTypeModel : SpendingTypeModel) -> Bool in
            return objSpendingTypeModel.spending_type_super == 0
        }
        
        print("arrSpendingCategory = \(arrSpendingCategory)")
        if  self.arrSpendingTypeCategory.count > 0 {
            self.arrSpendingTypeCategory.removeAll()
        }
        
        if arrSpendingCategory.count > 0 {
            for i in 0...(arrSpendingCategory.count - 1)
            {
                let objSpendingTypeModel = arrSpendingCategory[i]
                if AppConstants.isArabic() {
                    arrSpendingTypeCategory.append(objSpendingTypeModel.spending_type_title_ar)
                }else{
                    arrSpendingTypeCategory.append(objSpendingTypeModel.spending_type_title)
                }
                
            }
            
        }
        
    }
    
    func GetSpendingSubCategories(_ index : Int) -> Void {
        
        self.objSpendingSelectedTypeModel = self.arrSpendingCategory[index] as! SpendingTypeModel
        
        var arrSpendingTempCategory = [SpendingTypeModel]()
        if arrSpendingTempCategory.count > 0{
            arrSpendingTempCategory.removeAll()
        }
        // Handle sub-categories.
        arrSpendingTempCategory =  self.arrTempSpendingCategory.filter { (objSpendingTypeModel : SpendingTypeModel) -> Bool in
            return objSpendingTypeModel.spending_type_super == self.objSpendingSelectedTypeModel.spending_type_id
        }
        
        if self.arrSpendingSubTypeCategory.count > 0{
            self.arrSpendingSubTypeCategory.removeAll()
        }
        
        if arrSpendingTempCategory.count > 0{
            for i in 0...(arrSpendingTempCategory.count - 1)
            {
                let objSpendingTypeModel = arrSpendingTempCategory[i]
                
                if AppConstants.isArabic() {
                    self.arrSpendingSubTypeCategory.append(objSpendingTypeModel.spending_type_title_ar)
                }else{
                    self.arrSpendingSubTypeCategory.append(objSpendingTypeModel.spending_type_title)
                }
                
            }
        }
    }
    
    
    @IBAction func btnAddCategoryCancelAction(_ sender: UIButton) {
        viewAddCategory.isHidden = true
        self.view.endEditing(true)
    }
    
    
    @IBAction func btnAddSubCategory(_ sender: UIButton) {
        Utility.sharedInstance.removePickerView()
        isForCategory = false
        viewAddCategory.isHidden = false
        self.lblAddCategoryTitle.text = JMOLocalizedString(forKey: "Add sub-category", value: "")
        self.tfAddCategoryValue.placeholder = JMOLocalizedString(forKey: "Sub-category name", value: "")
        self.tfAddCategoryValue.text = ""
    }
    
    
    @IBAction func btnAddCategoryAddActino(_ sender: UIButton) {
        self.view.endEditing(true)
        
        if isForCategory == true
        {
            if ((self.tfAddCategoryValue.text! != "")){
                // insert the category value on category table.
                let objSpendingTypeModel = SpendingTypeModel()
                objSpendingTypeModel.spending_type_title = self.tfAddCategoryValue.text!
                objSpendingTypeModel.spending_type_title_ar = self.tfAddCategoryValue.text!
                objSpendingTypeModel.spending_type_super = 0
                objSpendingTypeModel.spending_type_isbyuser = 1
                
                var aSpendingTypeExistStatus: Bool = false
                aSpendingTypeExistStatus = userInfoManagerT.sharedInstance.isSpendingCategoryExist(objSpendingTypeModel: objSpendingTypeModel)
                
                if aSpendingTypeExistStatus == true{
                    Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "This category is already exist", value: ""))
                }
                else{
                    viewAddCategory.isHidden = true
                    var aSpendingTypeInfoAdded : Bool = false
                    
                    // Category - insert query for database.
                    aSpendingTypeInfoAdded = userInfoManagerT.sharedInstance.InsertSpendingTypeDetail(objSpendingTypeModel: objSpendingTypeModel)
                    
                    if aSpendingTypeInfoAdded == true {
                        //sucess.
                        self.GetSpendingCategories()
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                        let aSelectedCategory = self.arrSpendingTypeCategory.last
                        self.btnSpendingCategory.setTitle(aSelectedCategory, for: .normal)
                        self.btnSpendingSubCategory.setTitle(JMOLocalizedString(forKey: "Spending Sub-Category", value: ""), for: .normal)
                        
                        self.viewSubcategory.isHidden = false
                        self.topSwitchConstraint.constant = 77
                        
                        self.aSelectedCategoryTypeIndex = self.arrSpendingTypeCategory.count - 1
                        self.GetSpendingSubCategories(self.arrSpendingTypeCategory.count - 1)
                    })
                    
                }
                
            }else{
                Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please fill the Category name", value: ""))
            }
        }
        else if (isForCategory == false) {
            if((self.tfAddCategoryValue.text! != "")){
                
                // insert the sub-category value on category table.
                let objSpendingTypeModel = SpendingTypeModel()
                objSpendingTypeModel.spending_type_title = self.tfAddCategoryValue.text!
                objSpendingTypeModel.spending_type_title_ar = self.tfAddCategoryValue.text!
                objSpendingTypeModel.spending_type_super = self.objSpendingSelectedTypeModel.spending_type_id
                objSpendingTypeModel.spending_type_isbyuser = 1
                
                var aSpendingTypeExistStatus: Bool = false
                aSpendingTypeExistStatus = userInfoManagerT.sharedInstance.isSpendingCategoryExist(objSpendingTypeModel: objSpendingTypeModel)
                if aSpendingTypeExistStatus == true{
                    Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "This sub-category is already exist", value: ""))
                }
                else{
                    viewAddCategory.isHidden = true
                    var aSpendingTypeInfoAdded : Bool = false
                    
                    // Sub-category - insert query for database.
                    aSpendingTypeInfoAdded = userInfoManagerT.sharedInstance.InsertSpendingTypeDetail(objSpendingTypeModel: objSpendingTypeModel)
                    
                    if aSpendingTypeInfoAdded == true {
                        //sucess.
                        self.GetSpendingCategories()
                        self.GetSpendingSubCategories(self.aSelectedCategoryTypeIndex)
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                        let aSelectedSubCategory = self.arrSpendingSubTypeCategory.last
                        self.btnSpendingSubCategory.setTitle(aSelectedSubCategory, for: .normal)
                        self.updateSelectedSubSpendingCategoryTypeId()
                    })
                    
                }
                
            }else{
                Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please fill the sub category name", value: ""))
            }
        }
        
    }
    
    
    
    func validateForm() -> Bool{
        
        if !Utility.sharedInstance.validateBlank(strVal: self.tfSpendingValue.text!) && btnSpendingCategory.title(for: .normal) == JMOLocalizedString(forKey: "Spending Category", value: "") {
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please fill all mandatory fields", value: ""))
            return false
        }
        else if !Utility.sharedInstance.validateBlank(strVal: self.tfSpendingValue.text!) {
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please fill Spending value field", value: ""))
            return false
        }
        else if !(self.tfSpendingValue.text!).isNumeric {
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please enter proper spending amount value", value: ""))
            return false
        }
        else if Int(Utility.sharedInstance.convertNumberToEnglish(aStr: tfSpendingValue.text!))! <= 0{
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "please fill valid spending value", value: ""))
            return false
        }
        else if btnSpendingCategory.title(for: .normal) == JMOLocalizedString(forKey: "Spending Category", value: ""){
            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please select spending category", value: ""))
            return false
        }
            //        else if btnSpendingSubCategory.title(for: .normal) == JMOLocalizedString(forKey: "Spending Sub-Category", value: ""){
            //            Utility.sharedInstance.showAlert(self, message: JMOLocalizedString(forKey: "Please select spending sub-category", value: ""))
            //            return false
            //        }
        else{
            return true
        }
    }
    
    func updateSelectedSubSpendingCategoryTypeId() -> Void{
        var objSpendingselectedTypeModile = [SpendingTypeModel]()
        objSpendingselectedTypeModile = self.arrTempSpendingCategory.filter({ (objSpendingTypeModel : SpendingTypeModel) -> Bool in
            
            if(AppConstants.isArabic()){
                return ((objSpendingTypeModel.spending_type_title_ar == self.btnSpendingSubCategory.title(for: .normal)) && (objSpendingTypeModel.spending_type_super == self.objSpendingSelectedTypeModel.spending_type_id))
            }
            else{
                return ((objSpendingTypeModel.spending_type_title == self.btnSpendingSubCategory.title(for: .normal)) && (objSpendingTypeModel.spending_type_super == self.objSpendingSelectedTypeModel.spending_type_id))
            }
            
        })
        
        if (objSpendingselectedTypeModile.count > 0){
            self.objSelectedSubSpendingTypeCategory = objSpendingselectedTypeModile.first!
            print("objSpendingSubFinal = \(self.objSelectedSubSpendingTypeCategory)")
            
        }
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        
        if textField == tfSpendingValue{
            if (string.isNumeric){
                let newLength = text.count + string.count - range.length
                
                if newLength > 7{
                    return false
                }else{
                    if let x = tfSpendingValue.text{
                        if (!AppConstants.isArabic() && !string.isEmpty){
                            let s:String  = x.appending(string);
                            tfSpendingValue.text = Utility.sharedInstance.convertNumberToEnglish(aStr: s)
                            return false;
                        }else{
                            return true;
                        }
                    }
                }
            }
            else{
                return false
            }
        }
        
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
