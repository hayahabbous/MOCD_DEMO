//
//  SpendingVC.swift
//  Edkhar
//
//  Created by indianic on 30/12/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit
import SVProgressHUD

class SpendingVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tblSpending: UITableView!
    
    @IBOutlet weak var lblTotalSpending: UILabel!
    @IBOutlet weak var lblTotalSpendingValue: UILabel!
    @IBOutlet weak var lblNoSpending: UILabel!
    var arrSpendingAllDBTypeList = [SpendingTypeModel]()
    var arrSpendingList = [SpendingModel]()
    var arrSpendingListTitle = [SpendingTypeModel]()
    
    @IBOutlet weak var btnAddSpending: UIButton!
    @IBOutlet weak var tblSpendingHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var totalSpendingLeadingConstraint: NSLayoutConstraint!

    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        SVProgressHUD.show()
        
        self.navigationController?.navigationBar.isHidden = true
        
        tblSpending.tableFooterView = UIView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if totalSpendingLeadingConstraint != nil{
            if AppConstants.isArabic(){
                totalSpendingLeadingConstraint.constant = 70
            }else{
                totalSpendingLeadingConstraint.constant = 35
            }            
        }
        LanguageManager.sharedInstance.localizeThingsInView(parentView: self.view)
        LanguageManager.sharedInstance.localizeThingsInView(parentView: self.lblNoSpending)
        
        self.GetSpendingDetails()
        
        if (ConstantsT.DeviceType.IS_IPAD) {
            Utility.sharedInstance.customizeFonts(in: lblTotalSpending, aFontName: Medium, aFontSize: 0)
            Utility.sharedInstance.customizeFonts(in: lblTotalSpendingValue, aFontName: Bold, aFontSize: 0)
            Utility.sharedInstance.customizeFonts(in: btnAddSpending, aFontName: Light, aFontSize: 0)
            self.tblSpendingHeightConstraint.constant = 603
        }
        else{
            Utility.sharedInstance.customizeFonts(in: lblTotalSpending, aFontName: Medium, aFontSize: 0)
            Utility.sharedInstance.customizeFonts(in: lblTotalSpendingValue, aFontName: Bold, aFontSize: 0)
            Utility.sharedInstance.customizeFonts(in: btnAddSpending, aFontName: Light, aFontSize: 0)
            
            
            if (ConstantsT.DeviceType.IS_IPHONE_5){
                self.tblSpendingHeightConstraint.constant = 178
            }else{
                self.tblSpendingHeightConstraint.constant = 278
            }
        }
    }
    
    func handleLangaugeFlip() -> Void {
        
        let arrNavigationArr = appDelegate.mmDrawer?.centerViewController as! UINavigationController
        var indexComman : Int = 0
        for objViewcontoller in arrNavigationArr.viewControllers {
            if objViewcontoller is CommanVC {
                indexComman = arrNavigationArr.viewControllers.index(of: objViewcontoller)!
                break
            }
        }
        
        let objCommanVC = arrNavigationArr.viewControllers[indexComman] as! CommanVC
        objCommanVC.viewQuote.isHidden = false
        let objTabbarVC = objCommanVC.children.first as! TabbarVCT
        /*
        if AppConstants.isArabic() {
            objCommanVC.btnLeftMenu.isHidden = true
            objCommanVC.btnRightMenu.isHidden = false
        }
        else{
            objCommanVC.btnLeftMenu.isHidden = false
            objCommanVC.btnRightMenu.isHidden = true
        }*/
        
        self.tblSpending.reloadData()
        LanguageManager.sharedInstance.localizeThingsInView(parentView: self.view)
        LanguageManager.sharedInstance.localizeThingsInView(parentView: objCommanVC.view)
        LanguageManager.sharedInstance.localizeThingsInView(parentView: objTabbarVC.view)
        
        objTabbarVC.selectedViewController?.viewWillAppear(false)
        
        objCommanVC.reloadInputViews()
        objCommanVC.viewWillAppear(true)
        objTabbarVC.handleTabbarLocalization()
    }
    
    func GetSpendingDetails() -> Void {
        
        self.arrSpendingList.removeAll()
        self.arrSpendingAllDBTypeList = userInfoManagerT.sharedInstance.GetAllSpendingTypeListDetail()
        self.arrSpendingList = userInfoManagerT.sharedInstance.GetAllSpendingList()
        self.arrSpendingListTitle = userInfoManagerT.sharedInstance.GetAllSpendingListTitle()
        tblSpending.reloadData()
        if self.arrSpendingList.count > 0 {            
            self.lblNoSpending.isHidden = true
        }
        else{
            self.lblNoSpending.isHidden = false
        }
        
        // Calculate for Total income.
        var aTotalSpendingValue = Int()
        if self.arrSpendingList.count > 0 {
            for i in 0...(self.arrSpendingList.count - 1){
                let aSpendingModel = self.arrSpendingList[i]
                aTotalSpendingValue += Int(aSpendingModel.spending_value as! String)!
            }
        }
        
        self.lblTotalSpendingValue.text = String(aTotalSpendingValue)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            SVProgressHUD.dismiss()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrSpendingList.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            
            Utility.sharedInstance.showAlertWithCompletion(controller: self, message: JMOLocalizedString(forKey: "Are you sure you want to delete?", value: ""), withCompletionBlock: { (status) in
                if status{
                    
                    let objSpendingModel = self.arrSpendingList[indexPath.row]
                    print("objSpendingModel = \(objSpendingModel)")
                    
                    var aDeleteInfoDelete : Bool = false
                    
                    // income - delete query for database.
                    aDeleteInfoDelete = userInfoManagerT.sharedInstance.DeleteSpendingDetail(objSpendingModel: objSpendingModel)
                    let aDBSucessMsg = "delete process done successfully"
                    
                    if aDeleteInfoDelete == true {
                        
                        let alertController = UIAlertController(title:  JMOLocalizedString(forKey: "Edkhar", value: ""), message: JMOLocalizedString(forKey: aDBSucessMsg, value: ""), preferredStyle: .alert)
                        let okAction = UIAlertAction(title: JMOLocalizedString(forKey: "OK", value: ""), style: .default, handler: { (action) in
                            
                        })
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                        
                        self.arrSpendingList.remove(at: indexPath.row)
                        self.tblSpending.reloadData()
                        
                        self.GetSpendingDetails()
                        
                        self.handleLangaugeFlip()
                        
                    }
                }else{
                    
                }
            })
        }
    }
    
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return JMOLocalizedString(forKey: "Delete", value: "")
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let spendingCell = tableView.dequeueReusableCell(withIdentifier: "SpendingCell", for: indexPath) as! SpendingCell
        
        let aObjSpendingTypeId = self.arrSpendingList[indexPath.row].spending_type_id
        
        let arrSpendingCategory =  self.arrSpendingAllDBTypeList.filter { (objSpendingTypeModel : SpendingTypeModel) -> Bool in
            
            return objSpendingTypeModel.spending_type_id == aObjSpendingTypeId
        }
        
        if arrSpendingCategory.first?.spending_type_super == 0 {
            if AppConstants.isArabic() {
                spendingCell.lblSpendingCategory.text = arrSpendingCategory.first?.spending_type_title_ar
            }else{
                spendingCell.lblSpendingCategory.text = arrSpendingCategory.first?.spending_type_title
            }
        }else{
            let subCategoryModel = arrSpendingCategory.first
            
            let arrSubSpendingCategory =  self.arrSpendingAllDBTypeList.filter { (objSpendingTypeModel : SpendingTypeModel) -> Bool in
                
                return objSpendingTypeModel.spending_type_id == subCategoryModel?.spending_type_super
            }
            
            if arrSubSpendingCategory.first?.spending_type_super == 0 {
                if AppConstants.isArabic() {
                    let aStrSpendingName = String(format: "%@ / %@",(arrSubSpendingCategory.first?.spending_type_title_ar)!, (arrSpendingCategory.first?.spending_type_title_ar)!)
                    spendingCell.lblSpendingCategory.text = aStrSpendingName
                }
                else{
                    let aStrSpendingName = String(format: "%@ / %@",(arrSubSpendingCategory.first?.spending_type_title)!, (arrSpendingCategory.first?.spending_type_title)!)
                    spendingCell.lblSpendingCategory.text = aStrSpendingName
                }
                
            }
        }
        
        Utility.sharedInstance.customizeFonts(in: spendingCell.lblSpendingCategory, aFontName: Medium, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: spendingCell.lblSpendingValue, aFontName: Bold, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: spendingCell.lblSpendingNote, aFontName: Medium, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: spendingCell.lblRecurring, aFontName: Medium, aFontSize: 0)
        
        
        spendingCell.lblSpendingValue.text = self.arrSpendingList[indexPath.row].spending_value
        spendingCell.lblSpendingNote.text = self.arrSpendingList[indexPath.row].spending_note
        
        if (self.arrSpendingList[indexPath.row].spending_type_isrecurring == 0){
            spendingCell.viewSpendingRecurringStatus.backgroundColor = UIColor.colorFromRGB(R: 91, G: 91, B: 91, Alpha: 1)
        }
        else{
            spendingCell.viewSpendingRecurringStatus.backgroundColor = UIColor.colorFromRGB(R: 0, G: 132, B: 61, Alpha: 1)
        }
        
        if indexPath.row == 0 {
            spendingCell.lblRecurring.isHidden = false
        }
        else{
            spendingCell.lblRecurring.isHidden = true
        }
        
        spendingCell.imgSpendingCategory.image = UIImage(named: "ic_income_per_item")
        
        LanguageManager.sharedInstance.localizeThingsInView(parentView: spendingCell)
        
        return spendingCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objSpendingModel: SpendingModel = self.arrSpendingList[indexPath.row]
        let objAddSpendingVC = self.storyboard?.instantiateViewController(withIdentifier: "AddSpendingVC") as! AddSpendingVC
        objAddSpendingVC.aSpendingModel = objSpendingModel
        self.navigationController?.pushViewController(objAddSpendingVC, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        print("size = \(size)")
        if size.width < size.height {
            // portrait.
            if (ConstantsT.DeviceType.IS_IPAD) {
                self.tblSpendingHeightConstraint?.constant = 634
            }
            else{
                self.tblSpendingHeightConstraint?.constant = 277
            }
        }
        else{
            // landscape.
            if (ConstantsT.DeviceType.IS_IPAD) {
                self.tblSpendingHeightConstraint?.constant = 377
            }
            else{
                self.tblSpendingHeightConstraint?.constant = 277
            }
        }
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
