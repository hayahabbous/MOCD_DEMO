//
//  IncomeVC.swift
//  Edkhar
//
//  Created by indianic on 30/12/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit
import SVProgressHUD
import UserNotifications
import SwiftyDropbox

class IncomeVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tblIncome: UITableView!
    
    var arrIncomeList = [IncomeModel]()
    var arrIncomeListType = [IncomeTypeModel]()
    
    
    @IBOutlet weak var lblTotalIncome: UILabel!
    @IBOutlet weak var lblTotalIncomeValue: UILabel!
    @IBOutlet weak var lblNoIncome: UILabel!
    @IBOutlet weak var viewIncome: UIView!
    @IBOutlet weak var btnAddIncome: UIButton!
    @IBOutlet weak var tblIncomeHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var totalIncomeLeadingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        SVProgressHUD.show()
        
        tblIncome.tableFooterView = UIView()
        
        self.handleLangaugeFlip()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        
        if AppConstants.isArabic(){
            totalIncomeLeadingConstraint.constant = 70
        }else{
            totalIncomeLeadingConstraint.constant = 35
        }
        
        if (ConstantsT.DeviceType.IS_IPAD) {
            Utility.sharedInstance.customizeFonts(in: lblTotalIncome, aFontName: Medium, aFontSize: 0)
            Utility.sharedInstance.customizeFonts(in: lblTotalIncomeValue, aFontName: Bold, aFontSize: 0)
            Utility.sharedInstance.customizeFonts(in: btnAddIncome, aFontName: Light, aFontSize: 0)
            
            self.tblIncomeHeightConstraint.constant = 603
        }
        else{
            Utility.sharedInstance.customizeFonts(in: lblTotalIncome, aFontName: Medium, aFontSize: 0)
            Utility.sharedInstance.customizeFonts(in: lblTotalIncomeValue, aFontName: Bold, aFontSize: 0)
            Utility.sharedInstance.customizeFonts(in: btnAddIncome, aFontName: Light, aFontSize: 0)
            
            if (ConstantsT.DeviceType.IS_IPHONE_5){
                self.tblIncomeHeightConstraint.constant = 178
            }else{
                self.tblIncomeHeightConstraint.constant = 278
            }
            
        }
        
        self.GetIncomeDetails()
        
        self.tblIncome.reloadData()
    }

    func GetIncomeDetails() -> Void {
        
        self.arrIncomeList = userInfoManagerT.sharedInstance.GetAllIncomeList()
        self.arrIncomeListType = userInfoManagerT.sharedInstance.GetAllIncomeTypeListDetail()
        
        if self.arrIncomeList.count > 0 {
            self.lblNoIncome.isHidden = true
        }
        else{
            self.lblNoIncome.isHidden = false
        }
        
        self.tblIncome.reloadData()
        
        // Calculate for Total income.
        var aTotalIncomeValue = Double()
        if self.arrIncomeList.count > 0 {
            for i in 0...(self.arrIncomeList.count - 1){
                let aIncomeModel = self.arrIncomeList[i]
                if aIncomeModel.income_value != "" {
                    aTotalIncomeValue += Double(aIncomeModel.income_value as! String)!
                }
            }
        }
        
        self.lblTotalIncomeValue.text = Utility.sharedInstance.convertDoubleToString(aStr: String(aTotalIncomeValue))
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            SVProgressHUD.dismiss()
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
        
        self.tblIncome.reloadData()
        LanguageManager.sharedInstance.localizeThingsInView(parentView: self.view)
        LanguageManager.sharedInstance.localizeThingsInView(parentView: objCommanVC.view)
        LanguageManager.sharedInstance.localizeThingsInView(parentView: objTabbarVC.view)
        
        objTabbarVC.selectedViewController?.viewWillAppear(false)
        
        objCommanVC.reloadInputViews()
        objCommanVC.viewWillAppear(true)
        objTabbarVC.handleTabbarLocalization()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrIncomeList.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{

            Utility.sharedInstance.showAlertWithCompletion(controller: self, message: JMOLocalizedString(forKey: "Are you sure you want to delete?", value: "") , withCompletionBlock: { (status) in
                if status{
                    
                    let objIncomeModel = self.arrIncomeList[indexPath.row] as! IncomeModel
                    print("aIncomeID = \(objIncomeModel)")
                    
                    var aIncomeInfoDelete : Bool = false
                    
                    // income - delete query for database.
                    aIncomeInfoDelete = userInfoManagerT.sharedInstance.DeleteIncomeDetail(objIncomeModel: objIncomeModel)
                    let aDBSucessMsg = "delete process done successfully"
                    
                    if aIncomeInfoDelete == true {
                        
                        let alertController = UIAlertController(title:  JMOLocalizedString(forKey: "Edkhar", value: ""), message: JMOLocalizedString(forKey: aDBSucessMsg, value: ""), preferredStyle: .alert)
                        let okAction = UIAlertAction(title: JMOLocalizedString(forKey: "OK", value: ""), style: .default, handler: { (action) in
                            
                        })
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                        
                        self.GetIncomeDetails()
                        
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
        
        let incomeCell = tableView.dequeueReusableCell(withIdentifier: "IncomeCell", for: indexPath) as! IncomeCell
        
        let aCurrentIncomeModel =  self.arrIncomeList[indexPath.row] as! IncomeModel
        
        let aArrIncomeListType =  self.arrIncomeListType.filter { (objIncomeTypeModel : IncomeTypeModel) -> Bool in
            
            return objIncomeTypeModel.income_type_id == aCurrentIncomeModel.income_type_id
        }
        
        print("aArrIncomeListType \(aArrIncomeListType)")
        
        if AppConstants.isArabic() {
            incomeCell.lblIncomeCategory.text = aArrIncomeListType.first?.income_type_title_ar!
        }
        else{
            incomeCell.lblIncomeCategory.text = aArrIncomeListType.first?.income_type_title!
        }
        
        
        
        incomeCell.lblIncomeValue.text = self.arrIncomeList[indexPath.row].income_value
        incomeCell.lblincomeNote.text = self.arrIncomeList[indexPath.row].income_note
        
        Utility.sharedInstance.customizeFonts(in: incomeCell.lblIncomeCategory, aFontName: Medium, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: incomeCell.lblIncomeValue, aFontName: Bold, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: incomeCell.lblincomeNote, aFontName: Medium, aFontSize: 0)
        Utility.sharedInstance.customizeFonts(in: incomeCell.lblRecurring, aFontName: Medium, aFontSize: 0)
        
        if (self.arrIncomeList[indexPath.row].income_type_isrecurring == 0){
            incomeCell.viewIncomeRecurringStatus.backgroundColor = UIColor.colorFromRGB(R: 91, G: 91, B: 91, Alpha: 1)
        }
        else{
            incomeCell.viewIncomeRecurringStatus.backgroundColor = UIColor.colorFromRGB(R: 0, G: 132, B: 61, Alpha: 1)
        }
        
        if indexPath.row == 0 {
            incomeCell.lblRecurring.isHidden = false
        }
        else{
            incomeCell.lblRecurring.isHidden = true
        }
        
        if (aArrIncomeListType.first?.income_type_id == 1){
            
            incomeCell.imgIncomeType.image = UIImage(named: "ic_salary_per_item")
        }
        else{
            incomeCell.imgIncomeType.image = UIImage(named: "ic_income_per_item")
        }
        
        
        
        LanguageManager.sharedInstance.localizeThingsInView(parentView: incomeCell)
        
        return incomeCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objIncomeModel: IncomeModel = self.arrIncomeList[indexPath.row]
        let objAddIncomeVC = self.storyboard?.instantiateViewController(withIdentifier: "AddIncomeVC") as! AddIncomeVC
        objAddIncomeVC.aIncomeModel = objIncomeModel
        self.navigationController?.pushViewController(objAddIncomeVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func LanguageChangeMethod() -> Void {
        
        if(AppConstants.isArabic())
        {
            LanguageManager.sharedInstance.setLanguage("en")
            UserDefaults.standard.setValue("en", forKey: "Language")
            UserDefaults.standard.synchronize()
        }
        else{
            
            LanguageManager.sharedInstance.setLanguage("ar")
            UserDefaults.standard.setValue("ar", forKey: "Language")
            UserDefaults.standard.synchronize()
        }
        
        self.handleLangaugeFlip()
    }
    
    func SideMenuSelectionMethod(SideMenuIndex indexSideMenu : Int) -> Void {
        
        switch (indexSideMenu) {
            
        case 1:
            
            // Language selection option.
            let alertController = UIAlertController.init(title: JMOLocalizedString(forKey: "Alert", value: ""), message: JMOLocalizedString(forKey: "Choose your language", value: ""), preferredStyle: UIAlertController.Style.alert)
            let alertActionCancel = UIAlertAction.init(title: JMOLocalizedString(forKey: "Cancel", value: ""), style: UIAlertAction.Style.cancel, handler: nil)
            let alertActionLanguage = UIAlertAction.init(title: AppConstants.isArabic() ? "English" : "العربية", style: UIAlertAction.Style.default, handler: { (action) in
                
                self.LanguageChangeMethod()
            })
            
            alertController.addAction(alertActionCancel)
            alertController.addAction(alertActionLanguage)
            
            //show window
            
            
            appDelegate.window?.rootViewController?.present(alertController, animated: true, completion: nil)
            break
            
        case 2:
            // Signup/user-profile selection option.
            self.performSegue(withIdentifier: "segueSignup", sender: nil)
            break
        
        case 3:
            // feedback selection option.
            self.performSegue(withIdentifier: "segueFeedback", sender: nil)
            break
        
        case 4:
            // Notes selection option.
            self.performSegue(withIdentifier: "segueNotes", sender: nil)
            break
            
        case 5:
            // Social Activities selection option.
            self.performSegue(withIdentifier: "segueSocialActivities", sender: nil)
            break
            
        case 6:
            // About Us Selection Option
            self.performSegue(withIdentifier: "segueAboutUs", sender: nil)
            break
        
        case 7:
            currentViewContoller = self
            
            if #available(iOS 10.0, *) {
                
                // Backup to dropbox Option
                DropboxClientsManager.authorizeFromController(UIApplication.shared,
                                                              controller: self,
                                                              openURL: { (url: URL) -> Void in
                                                                UIApplication.shared.open(url, options: [:], completionHandler: nil)})
            }else{
                
                DropboxClientsManager.authorizeFromController(UIApplication.shared, controller: self, openURL: { (url: URL) in
                    UIApplication.shared.openURL(url)
                })
            }
            
            break
        case 8:
            // Reminder Selection Option
            self.performSegue(withIdentifier: "segueReminder", sender: nil)
            break
            
            
        default:
        // Feedback selection option.
        
            break
        }
        
        
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "segueSignup"){
            let objSignupVC  = (segue.destination as! SignupVC)
            objSignupVC.strScreenTitle = JMOLocalizedString(forKey: "User Profile", value: "")
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        print("size = \(size)")
        if size.width < size.height {
            // portrait.
            if (ConstantsT.DeviceType.IS_IPAD) {
                self.tblIncomeHeightConstraint?.constant = 634
            }
            else{
                self.tblIncomeHeightConstraint?.constant = 278
            }
        }
        else{
            // landscape.
            if (ConstantsT.DeviceType.IS_IPAD) {
                self.tblIncomeHeightConstraint?.constant = 377
            }
            else{
                self.tblIncomeHeightConstraint?.constant = 278
            }
        }
    }
    
}
