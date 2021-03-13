//
//  ReminderVC.swift
//  Edkhar
//
//  Created by indianic on 11/02/17.
//  Copyright © 2017 demo. All rights reserved.
//

import UIKit
import UserNotifications

class ReminderVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var lblScreenTitle: UILabel!
    @IBOutlet weak var btnBackEN: UIButton!
    @IBOutlet weak var btnBackAR: UIButton!
    @IBOutlet weak var lblNoReminder: UILabel!
    @IBOutlet weak var tblReminder: UITableView!
    
    var arrReminderList = [ReminderModelT]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if AppConstants.isArabic() {
            btnBackEN.isHidden = true
        }
        else{
            btnBackAR.isHidden = true
        }
        tblReminder.tableFooterView = UIView()
        LanguageManager.sharedInstance.localizeThingsInView(parentView: self.view)
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getAllReminderDetails()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return arrReminderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell") as! ReminderCell
        cell.lblReminderTitle.text = arrReminderList[indexPath.row].reminderMoneyGoalTitle
        if arrReminderList[indexPath.row].reminderNote! == ""{
            cell.lblReminderNote.text = ""
        }else{
            cell.lblReminderNote.text = "\(JMOLocalizedString(forKey: "Note", value: "")): \(arrReminderList[indexPath.row].reminderNote!)"
        }
        cell.lblReminderMoneyGoalAmount.text = arrReminderList[indexPath.row].reminderMoneyGoalAmount
        
        let reminderType = arrReminderList[indexPath.row].reminderType!

        if( reminderType == ReminderType.Daily.rawValue){
                cell.lblReminderType.text = JMOLocalizedString(forKey: "Daily", value: "")
        }else if( reminderType == ReminderType.Weekly.rawValue){
            cell.lblReminderType.text = JMOLocalizedString(forKey: "Weekly", value: "")
        }else if( reminderType == ReminderType.Monthly.rawValue){
            cell.lblReminderType.text = JMOLocalizedString(forKey: "Monthly", value: "")
        }
        

        
        if AppConstants.isArabic(){
            cell.lblReminderTitle.textAlignment = .right
            cell.lblReminderNote.textAlignment = .right
        }else{
            cell.lblReminderTitle.textAlignment = .left
            cell.lblReminderNote.textAlignment = .left
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objAddReminderVC = self.storyboard?.instantiateViewController(withIdentifier: "AddReminderVC") as! AddReminderVC
        let objReminderModel: ReminderModelT = self.arrReminderList[indexPath.row]
        objAddReminderVC.aReminderModel = objReminderModel
        self.navigationController?.pushViewController(objAddReminderVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            
            Utility.sharedInstance.showAlertWithCompletion(controller: self, message: JMOLocalizedString(forKey: "Are you sure you want to delete?", value: "") , withCompletionBlock: { (status) in
                if status{
                    
                    let objReminderModel: ReminderModelT = self.arrReminderList[indexPath.row]
                    print("objReminderModel = \(objReminderModel)")
                    
                    var aIncomeInfoDelete : Bool = false
                    
                    // income - delete query for database.
                    aIncomeInfoDelete = userInfoManagerT.sharedInstance.DeleteReminderDetail(objReminderModel: objReminderModel)
                    let aDBSucessMsg = "delete process done successfully"
                    
                    if aIncomeInfoDelete == true {
                        
                        self.deleteReminder(reminderId: "\(objReminderModel.identifier!)")
                        
                        let alertController = UIAlertController(title:  JMOLocalizedString(forKey: "Edkhar", value: ""), message: JMOLocalizedString(forKey: aDBSucessMsg, value: ""), preferredStyle: .alert)
                        let okAction = UIAlertAction(title: JMOLocalizedString(forKey: "OK", value: ""), style: .default, handler: { (action) in
                            
                        })
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                        
                        self.getAllReminderDetails()
                    }
                }else{
                    
                }
            }   )
        }
    }
    
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return JMOLocalizedString(forKey: "Delete", value: "")
    }
    
    func getAllReminderDetails() -> Void {
        arrReminderList = userInfoManagerT.sharedInstance.GetAllReminderList()
        if arrReminderList.count > 0 {
            self.lblNoReminder.isHidden = true
        }else{
            self.lblNoReminder.isHidden = false
            self.view.bringSubviewToFront(self.lblNoReminder)
        }
        tblReminder.reloadData()
    }
    
    func deleteReminder(reminderId: String) -> Void{
        LocalNotificationHelperT.sharedInstance.removeNotification([String(reminderId)]) { (status) in
        }
    }
    
}

