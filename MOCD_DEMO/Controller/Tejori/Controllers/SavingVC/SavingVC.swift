//
//  SavingVC.swift
//  Edkhar
//
//  Created by indianic on 30/12/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit

class SavingVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tblHeaderView: UIView!
    @IBOutlet weak var lblHeaderTitle: UILabel!
    @IBOutlet weak var lblTotalSavingValue: UILabel!
    var arrTargetList = [TargetModel]()
    var arrSavingList = [SavingModel]()
    @IBOutlet weak var tblSaving: UITableView!
    @IBOutlet weak var btnAddNewTarget: UIButton!
    
    @IBOutlet weak var tblHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var totalSavingLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var btnAddTargetWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var btnAddSavingWidthConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblSaving.tableFooterView = UIView()
        
        let nib = UINib(nibName: "SavingHeaderView", bundle: nil)
        tblSaving.register(nib, forHeaderFooterViewReuseIdentifier: "SavingHeaderView")
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        if (ConstantsT.DeviceType.IS_IPAD) {
            Utility.sharedInstance.customizeFonts(in: self.lblTotalSavingValue, aFontName: Medium, aFontSize: 0)
        }
        else{
            Utility.sharedInstance.customizeFonts(in: self.lblTotalSavingValue, aFontName: Medium, aFontSize: 0)
        }
        
        if totalSavingLeadingConstraint != nil{
            if AppConstants.isArabic(){
                totalSavingLeadingConstraint.constant = 70
            }else{
                totalSavingLeadingConstraint.constant = 35
            }
        }
        
        
        if btnAddSavingWidthConstraint != nil && btnAddTargetWidthConstraint != nil{
            if ConstantsT.DeviceType.IS_IPHONE_5 || ConstantsT.DeviceType.IS_IPHONE_4_OR_LESS {
                btnAddTargetWidthConstraint.constant = 145
                btnAddSavingWidthConstraint.constant = 145
                btnAddNewTarget.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
            }
            else{
                btnAddTargetWidthConstraint.constant = 170
                btnAddSavingWidthConstraint.constant = 170
                btnAddNewTarget.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15)
            }
        }
        
        LanguageManager.sharedInstance.localizeThingsInView(parentView: self.view)
        
        self.GetSavingDetails()
        
    }
    func GetSavingDetails() -> Void {
        self.arrTargetList = userInfoManagerT.sharedInstance.GetAllTargetListTitle()
        
        self.arrSavingList = userInfoManagerT.sharedInstance.GetAllSavingListTitle()
        
        // Calculate for Total income.
        //        var aTotalSavingValue = Int()
        //        if self.arrSavingList.count > 0 {
        //            for i in 0...(self.arrSavingList.count - 1){
        //                let aSavingModle = self.arrSavingList[i]
        //                aTotalSavingValue += Int(aSavingModle.saving_value as String!)!
        //            }
        //        }
        //
        //        self.lblTotalSavingValue.text = String(aTotalSavingValue)
        self.displayTotalSavings()
        
        if (ConstantsT.DeviceType.IS_IPAD) {
            self.tblHeightConstraint.constant = 610
        }
        else if(ConstantsT.DeviceType.IS_IPHONE_5) {
            self.tblHeightConstraint.constant = 160
        }
        else{
            self.tblHeightConstraint.constant = 265
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            
            self.tblSaving.reloadData()
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
        
        self.tblSaving.reloadData()
        LanguageManager.sharedInstance.localizeThingsInView(parentView: self.view)
        LanguageManager.sharedInstance.localizeThingsInView(parentView: objCommanVC.view)
        LanguageManager.sharedInstance.localizeThingsInView(parentView: objTabbarVC.view)
        
        objTabbarVC.selectedViewController?.viewWillAppear(false)
        
        objCommanVC.reloadInputViews()
        objCommanVC.viewWillAppear(true)
        objTabbarVC.handleTabbarLocalization()
    }
    
    @IBAction func btnSavingQuestionAction(_ sender: UIButton) {
        
        let alertController = UIAlertController(title:  JMOLocalizedString(forKey: "What is Total Saving ?", value: ""), message: JMOLocalizedString(forKey: "if you have a previous savings add it here so it can be added to the new savings", value: ""), preferredStyle: .alert)
        let okAction = UIAlertAction(title: JMOLocalizedString(forKey: "OK", value: ""), style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func btnSideRightMenuAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        //appDelegate.mmDrawer?.open(.right, animated: true, completion: nil)
    }
    
    @IBAction func btnSideLeftMenuAction(_ sender: UIButton) {
        
        appDelegate.mmDrawer?.open(.left, animated: true, completion: nil)
    }
    
    @IBAction func btnAddSavingClick(_ sender: Any) {
        if self.arrTargetList.count > 0 {
            performSegue(withIdentifier: "segueAddSaving", sender: self)
        }
        else{
            let alertController = UIAlertController(title:  JMOLocalizedString(forKey: "Edkhar", value: ""), message: JMOLocalizedString(forKey: "You must have at least one target to be able to save, if you do not have a specific target, add 'General target' for example", value: ""), preferredStyle: .alert)
            let addNewTargetAction = UIAlertAction(title: JMOLocalizedString(forKey: "Add new Target Button", value: ""), style: .default, handler: { (addTargetAction) in
                let objAddNewTargetVC = self.storyboard?.instantiateViewController(withIdentifier: "AddNewTargetVC") as! AddNewTargetVC
                self.navigationController?.pushViewController(objAddNewTargetVC, animated: true)
            })
            let cancelAction = UIAlertAction(title: JMOLocalizedString(forKey: "Cancel", value: ""), style: .default, handler: { (addTargetAction) in
                
            })
            
            alertController.addAction(addNewTargetAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var totalCount = 0
        
        if section == 0 {
            if self.arrTargetList.count == 0{
                totalCount = 1
            }else{
                totalCount = self.arrTargetList.count
            }
        }
        else{
            if self.arrSavingList.count == 0{
                totalCount = 1
            }else{
                totalCount = self.arrSavingList.count
            }
        }
        
        return totalCount
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 80
        }
        else{
            return 68
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Dequeue with the reuse identifier
        let cell = self.tblSaving.dequeueReusableHeaderFooterView(withIdentifier: "SavingHeaderView") as! SavingHeaderView
        if section == 0 {
            cell.lblSavingHeaderTitle.text = JMOLocalizedString(forKey: "FINANCIAL TARGETS LIST", value: "")
            
        }
        else{
            cell.lblSavingHeaderTitle.text = JMOLocalizedString(forKey: "SAVING LIST", value: "")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func getTargetTitleFromTargetTable(_ targetID : Int) -> String {
        
        var targetTitleByTargetID = ""
        let arrFilterTargetID  = self.arrTargetList.filter { (objTargetModel : TargetModel) -> Bool in
            return objTargetModel.identifier == targetID
        }
        if arrFilterTargetID.count > 0 {
            targetTitleByTargetID = (arrFilterTargetID.first?.target_name!)!
        }
        
        return targetTitleByTargetID
    }
    
    func getTargetSavingFromSavingTable(_ targetID : Int) -> Int {
        
        var savingByTargetID = 0
        let arrFilterSavingbyID  = self.arrSavingList.filter { (objSavingModel : SavingModel) -> Bool in
            return objSavingModel.target_id == targetID
        }
        if arrFilterSavingbyID.count > 0 {
            for aDictSaving in arrFilterSavingbyID{
                savingByTargetID = savingByTargetID + Int((aDictSaving.saving_value!))!
            }
        }
        return savingByTargetID
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0 && self.arrTargetList.count > 0{
            return true
        }else if indexPath.section == 1 && self.arrSavingList.count > 0{
            return true
        }else{
            return false
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            
            Utility.sharedInstance.showAlertWithCompletion(controller: self, message: JMOLocalizedString(forKey: "Are you sure you want to delete?", value: ""), withCompletionBlock: { (status) in
                if status{
                    
                    if indexPath.section == 0 {
                        
                        // for target delete.
                        let objTargetModel = self.arrTargetList[indexPath.row] as! TargetModel
                        
                        var aTargetInfoDelete : Bool = false
                        
                        // income - delete query for database.
                        aTargetInfoDelete = userInfoManagerT.sharedInstance.DeleteTargetDetail(objTargetModel: objTargetModel)
                        
                        let aDBSucessMsg = "delete process done successfully"
                        
                        if aTargetInfoDelete == true {
                            
                            let alertController = UIAlertController(title:  JMOLocalizedString(forKey: "Edkhar", value: ""), message: JMOLocalizedString(forKey: aDBSucessMsg, value: ""), preferredStyle: .alert)
                            let okAction = UIAlertAction(title: JMOLocalizedString(forKey: "OK", value: ""), style: .default, handler: { (action) in
                                
                            })
                            alertController.addAction(okAction)
                            self.present(alertController, animated: true, completion: nil)
                            
                            self.GetSavingDetails()
                            self.handleLangaugeFlip()
                            
                        }
                    }
                    else{
                        // for saving delete.
                        let objSavingModel = self.arrSavingList[indexPath.row] as! SavingModel
                        
                        var aSavingInfoDelete : Bool = false
                        
                        // income - delete query for database.
                        aSavingInfoDelete = userInfoManagerT.sharedInstance.DeleteSavingDetail(objSavingModel: objSavingModel)
                        let aDBSucessMsg = "delete process done successfully"
                        
                        if aSavingInfoDelete == true {
                            
                            let alertController = UIAlertController(title:  JMOLocalizedString(forKey: "Edkhar", value: ""), message: JMOLocalizedString(forKey: aDBSucessMsg, value: ""), preferredStyle: .alert)
                            let okAction = UIAlertAction(title: JMOLocalizedString(forKey: "OK", value: ""), style: .default, handler: { (action) in
                                
                            })
                            alertController.addAction(okAction)
                            self.present(alertController, animated: true, completion: nil)
                            
                            self.GetSavingDetails()
                            
                            self.handleLangaugeFlip()
                            
                        }
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
        
        if indexPath.section == 0 {
            if self.arrTargetList.count == 0 {
                let aEmptyCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "EmptyCell")!
                aEmptyCell.textLabel?.text = JMOLocalizedString(forKey: "Tap on Add New Target to add your targets", value: "")
                return aEmptyCell
            }else{
                let aTargetCell = tableView.dequeueReusableCell(withIdentifier: "TargetCell") as! TargetCell
                aTargetCell.lblTargetCategory.text = self.arrTargetList[indexPath.row].target_name
                aTargetCell.lblTotalTargetAmount.text = self.arrTargetList[indexPath.row].target_final_amount
                
                let aTargetFinalAmount = Int(self.arrTargetList[indexPath.row].target_final_amount!)
                
                let aTargetSavedAmount = Int(self.arrTargetList[indexPath.row].target_saved_amount!)
                let aSavingValueFromTargetID = self.getTotalTargetSavingFromSavingTable(self.arrTargetList[indexPath.row].identifier)
                
                
                
                let aTotalTargetSaving = (aTargetSavedAmount! + aSavingValueFromTargetID)
                aTargetCell.lblTotalSavedAmount.text = String(aTotalTargetSaving)
                
                let aTotalTargetSavingPersentage = (Float(aTotalTargetSaving) / Float (aTargetFinalAmount!))
                aTargetCell.lblTargetPersentage.text = String(format: "%.1f %@", (aTotalTargetSavingPersentage * 100),"%")
                
                
                let transform : CGAffineTransform = CGAffineTransform(scaleX: 1,y: 2.5)
                aTargetCell.targetProgressbar.transform = transform
                aTargetCell.targetProgressbar.progress = (aTotalTargetSavingPersentage)
                
                Utility.sharedInstance.customizeFonts(in: (aTargetCell.lblTargetPersentage)!, aFontName: Medium, aFontSize: 0)
                Utility.sharedInstance.customizeFonts(in: (aTargetCell.lblTotalTargetAmount)!, aFontName: Medium, aFontSize: 0)
                Utility.sharedInstance.customizeFonts(in: (aTargetCell.lblTotalSavedAmount)!, aFontName: Medium, aFontSize: 0)

                
                return aTargetCell
            }
            
        }
        else{
            
            if self.arrSavingList.count == 0{
                let aEmptyCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "EmptyCell")!
                aEmptyCell.textLabel?.text = JMOLocalizedString(forKey: "Tap on Add Saving to add your Saving", value: "")
                return aEmptyCell
            }else{
                let aSavingCell = tableView.dequeueReusableCell(withIdentifier: "SavingCell") as! SavingCell
                let targetTitleByTargetID = self.getTargetTitleFromTargetTable(self.arrSavingList[indexPath.row].target_id!)
                aSavingCell.lblSavingTitle.text = targetTitleByTargetID
                aSavingCell.lblSavingValue.text = self.arrSavingList[indexPath.row].saving_value!
                
                Utility.sharedInstance.customizeFonts(in: (aSavingCell.lblSavingValue)!, aFontName: Medium, aFontSize: 0)
                
                return aSavingCell
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            if (self.arrTargetList.count > 0){
                // target update
                let objTargetModel = self.arrTargetList[indexPath.row] as TargetModel?
                let objAddNewTargetVC = self.storyboard?.instantiateViewController(withIdentifier: "AddNewTargetVC") as! AddNewTargetVC
                objAddNewTargetVC.aTargetModle = objTargetModel!
                self.navigationController?.pushViewController(objAddNewTargetVC, animated: true)
            }else{
                tableView.allowsSelection = false
            }
            
        }else{
            // saving update
            if (self.arrSavingList.count > 0){
                let objSavingModel = self.arrSavingList[indexPath.row] as SavingModel?
                let objAddSavingVC = self.storyboard?.instantiateViewController(withIdentifier: "AddSavingVC") as! AddSavingVC
                objAddSavingVC.aSavingModel = objSavingModel!
                self.navigationController?.pushViewController(objAddSavingVC, animated: true)
            }else{
                tableView.allowsSelection = false
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override internal func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        print("size = \(size)")
        if size.width < size.height {
            // portrait.
            if (ConstantsT.DeviceType.IS_IPAD) {
                if self.tblHeightConstraint != nil {
                    self.tblHeightConstraint.constant = 590
                }
                
            }
            else{
                if self.tblHeightConstraint != nil {
                    self.tblHeightConstraint.constant = 265}
            }
        }
        else{
            // landscape.
            if (ConstantsT.DeviceType.IS_IPAD) {
                if self.tblHeightConstraint != nil {
                    self.tblHeightConstraint?.constant = 335}
            }
            else{
                if self.tblHeightConstraint != nil {
                    self.tblHeightConstraint?.constant = 265}
            }
        }
    }
    
    

    func getTotalTargetSavingFromSavingTable(_ targetId: Int) -> Int {
        var savingByTargetID = 0
        let objSavingModel = SavingModel()
        objSavingModel.target_id = targetId
        let arrFilterSavingbyID  = userInfoManagerT.sharedInstance.GetSavingValByTarget(objSavingModel: objSavingModel)
        if arrFilterSavingbyID.count > 0 {
            for aDictSaving in arrFilterSavingbyID{
                savingByTargetID = savingByTargetID + Int((aDictSaving.saving_value!))!
            }
        }
        return savingByTargetID
    }
    
    func displayTotalSavings () -> Void {
        var aTotalTargetSaving = 0
        for aTarget in arrTargetList {
            let aTargetSavedAmount = Int(aTarget.target_saved_amount!)
            let aSavingValueFromTargetID = self.getTotalTargetSavingFromSavingTable(aTarget.identifier)
            aTotalTargetSaving = aTotalTargetSaving + (aTargetSavedAmount! + aSavingValueFromTargetID)
        }
        lblTotalSavingValue.text = String(aTotalTargetSaving)
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
