//
//  MedicinPlanListVC.swift
//  SmartAgenda
//
//  Created by indianic on 25/01/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit

enum FrequencyType: Int {
    case OnceType = 1
    case Twice = 2
    case Thrice = 3
    case Once4 = 4
    case Once6 = 5
}

class MedicinPlanListVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    
    //MARK: IBOutlets
    @IBOutlet var lblScreenTitle: UILabel!
    
    @IBOutlet var lblNoMedicines: UILabel!
    @IBOutlet var tblMidicinPlan: TPKeyboardAvoidingTableView!
    
    @IBOutlet var viewSearch: UIView!
    
    @IBOutlet var searchbar: UISearchBar!
    
    
    @IBOutlet var btnBackEN: UIButton!
    //MARK: Variables
    
    var medicinePlanObj = [medicinePlanReminderModel]()
    var medicinePlanObjTwice = [medicinePlanReminderModel]()
    var medicinePlanObjthrice = [medicinePlanReminderModel]()
    var medicinePlanObjFour = [medicinePlanReminderModel]()
    var medicinePlanObjSix = [medicinePlanReminderModel]()
    var medicinePlanSearchObj = [medicinePlanReminderModel]()
    var isSearch: Bool = false
    var isThrice: Bool = false
    var isFour: Bool = false
    var isFive: Bool = false
    var isSix: Bool = false
    
    //MARK: UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.isNavigationBarHidden = true
        
        if AppConstants.isArabic()
        {
            btnBackEN.imageView?.transform = (btnBackEN.imageView?.transform.rotated(by: CGFloat(M_PI)))!
        }else{
            btnBackEN.imageView?.transform = (btnBackEN.imageView?.transform.rotated(by: CGFloat(M_PI*2)))!
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isSearch = false
        
        self.medicinePlanObj.removeAll()
        self.medicinePlanObjTwice.removeAll()
        self.medicinePlanObjthrice.removeAll()
        self.medicinePlanObjFour.removeAll()
        self.medicinePlanObjSix.removeAll()
        
        self.lblScreenTitle.text = JMOLocalizedString(forKey: kMedicinPlan, value: "")
        
        LanguageManager().localizeThingsInView(parentView: (self.view))
        
        if (GeneralConstants.DeviceType.IS_IPAD) {
            customizeFonts(in: lblScreenTitle, aFontName: Medium, aFontSize: 0)
        }else{
            customizeFonts(in: lblScreenTitle, aFontName: Medium, aFontSize: 0)
        }

        getMedicinePlanList()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 //segueAppointment
 
         if segue.identifier == SegueIdentifiers.ksegueMedicalVC.rawValue {
         let aObjVC:AddMedicinPlanVC = segue.destination as! AddMedicinPlanVC
         
         let indexPath = self.tblMidicinPlan.indexPathForSelectedRow
         
         if isSearch {
         aObjVC.medicinSelected = medicinePlanSearchObj[(indexPath?.row)!]
         }else{
         aObjVC.medicinSelected = medicinePlanObj[(indexPath?.row)!]
         }
         
         aObjVC.isBoolEdit = true
         
         }else if segue.identifier == SegueIdentifiers.ksegueAddMedicine.rawValue {
         let aObjVC:AddMedicinPlanVC = segue.destination as! AddMedicinPlanVC
         
         aObjVC.isBoolEdit = false
 
 }
 
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }

 
    //MARK: IBActions Events
    @IBAction func btnBackClick(_ sender: UIButton) {
 
        _ = self.navigationController?.popViewController(animated: true)
 
    }
 
    @IBAction func btnSearchClick(_ sender: UIButton) {
        searchbar.text = ""

        self.viewSearch.isHidden = false
        
    }
    
    @IBAction func btnAddMedicinPlanClick(_ sender: UIButton) {
    }
    
    //MARK: Custom Own Methods
    
    
    func cancelNotification(str: String, complition: ((Void)-> Void)) {
        
//        LocalNotificationHelper.sharedInstance.removeNotification([str])
        
        LocalNotificationHelper.sharedInstance.removeNotification([str]) { (status) in
            
        }

    }
    
    
    private func getMedicinePlanList() {
        
        // To get medicin plan list from DB
       
        
        var objs: [medicinePlanReminderModel] = medicinePlan().getAllMedicinPlanList()
            
            for objMedicine in objs {
                
                if objMedicine.dailyFrequency == FrequencyType.OnceType.rawValue {
                    self.medicinePlanObj.append(objMedicine)
                    // Once
                }else if objMedicine.dailyFrequency == FrequencyType.Twice.rawValue {
                    
                    // Twice
                    
                    if objMedicine.name == self.medicinePlanObjTwice.last?.name {
                        print(objMedicine.name)
                        
                        self.medicinePlanObj.last?.time2 = objMedicine.reminderTime
                        
                        self.medicinePlanObj.last?.identifier2 = objMedicine.identifier
                    }else{
                        self.medicinePlanObjTwice.append(objMedicine)
                        self.medicinePlanObj.append(objMedicine)
                    }
                }else if objMedicine.dailyFrequency == FrequencyType.Thrice.rawValue {
                    
                    // Thrice
                    
                    if objMedicine.name == self.medicinePlanObjthrice.last?.name {
                        print(objMedicine.name)
                        
                        if isThrice {
                            self.medicinePlanObj.last?.time3 = objMedicine.reminderTime
                            self.medicinePlanObj.last?.identifier3 = objMedicine.identifier

                            isThrice = false
                        }else{
                            self.medicinePlanObj.last?.time2 = objMedicine.reminderTime
                            self.medicinePlanObj.last?.identifier2 = objMedicine.identifier
                            
                            isThrice = true
                            
                        }
                    }else{
                        self.medicinePlanObjthrice.append(objMedicine)
                        self.medicinePlanObj.append(objMedicine)
                    }

                }else if objMedicine.dailyFrequency == FrequencyType.Once4.rawValue {
                    
                    // 4
                    
                    if objMedicine.name == self.medicinePlanObjFour.last?.name {
                        print(objMedicine.name)
                        
                        if isThrice {
                            self.medicinePlanObj.last?.time3 = objMedicine.reminderTime
                            self.medicinePlanObj.last?.identifier3 = objMedicine.identifier
                            
                            isThrice = false
                            isFour = true
                        }else if isFour{
                            self.medicinePlanObj.last?.time4 = objMedicine.reminderTime
                            self.medicinePlanObj.last?.identifier4 = objMedicine.identifier
                            
                            isThrice = false
                            isFour = false
                        }
                        else{
                            self.medicinePlanObj.last?.time2 = objMedicine.reminderTime
                            self.medicinePlanObj.last?.identifier2 = objMedicine.identifier
                            
                            isThrice = true
                        }
                    }else{
                        self.medicinePlanObjFour.append(objMedicine)
                        self.medicinePlanObj.append(objMedicine)
                    }
                    
                }else if objMedicine.dailyFrequency == FrequencyType.Once6.rawValue {
                    
                    // 6
                    
                    if objMedicine.name == self.medicinePlanObjSix.last?.name {
                        print(objMedicine.name)
                        
                        if isThrice {
                            self.medicinePlanObj.last?.time3 = objMedicine.reminderTime
                            self.medicinePlanObj.last?.identifier3 = objMedicine.identifier
                            
                            isThrice = false
                            isFour = true
                        }else if isFour{
                            self.medicinePlanObj.last?.time4 = objMedicine.reminderTime
                            self.medicinePlanObj.last?.identifier4 = objMedicine.identifier
                            
                            isThrice = false
                            isFour = false
                            isFive = true
                        }else if isFive {
                            self.medicinePlanObj.last?.time5 = objMedicine.reminderTime
                            self.medicinePlanObj.last?.identifier5 = objMedicine.identifier
                            
                            isThrice = false
                            isFour = false
                            isFive = false
                            isSix = true
                        }else if isSix{
                            self.medicinePlanObj.last?.time6 = objMedicine.reminderTime
                            self.medicinePlanObj.last?.identifier6 = objMedicine.identifier
                            
                            isThrice = false
                            isFour = false
                            isFive = false
                            isSix = false
                        }
                        else{
                            self.medicinePlanObj.last?.time2 = objMedicine.reminderTime
                            self.medicinePlanObj.last?.identifier2 = objMedicine.identifier
                            
                            isThrice = true
                        }
                    }else{
                        self.medicinePlanObjSix.append(objMedicine)
                        self.medicinePlanObj.append(objMedicine)
                    }
                    
                }else {
                    self.medicinePlanObj.append(objMedicine)
                }
            }
            
            self.medicinePlanObj.reverse()
            
            if self.medicinePlanObj.count == 0 {
                lblNoMedicines.isHidden = false
            }else{
                lblNoMedicines.isHidden = true
            }
            
            self.tblMidicinPlan.reloadData()
            
//        }
        
    }

    //MARK: UITableViewDelegate and UITableViewDatasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearch {
            if medicinePlanSearchObj.count > 0{
                lblNoMedicines.isHidden = true
            }else{
                lblNoMedicines.isHidden = false
            }
            return medicinePlanSearchObj.count
        }else{
            if medicinePlanObj.count > 0{
                lblNoMedicines.isHidden = true
            }else{
                lblNoMedicines.isHidden = false
            }
            return medicinePlanObj.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let medicineCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifire.CellMedicinPlan.rawValue, for: indexPath) as! MedicinPlanCell
        
        var aObjMedicine = medicinePlanReminderModel()
        
        if isSearch {
            aObjMedicine =  medicinePlanSearchObj[indexPath.row]
          
            
        }else{
            aObjMedicine = medicinePlanObj[indexPath.row]
        }
        
        medicineCell.lblTitle.text = aObjMedicine.name.capitalized
        
        var aStrFre = String()
      
        if JMOLocalizedString(forKey: aObjMedicine.reminderFrequency!, value: "") == JMOLocalizedString(forKey: Recurring.DailyRecurr.rawValue, value: "") || JMOLocalizedString(forKey: aObjMedicine.reminderFrequency!, value: "") == JMOLocalizedString(forKey: Recurring.WeeklyRecurr.rawValue, value: "")  || JMOLocalizedString(forKey: aObjMedicine.reminderFrequency!, value: "") == JMOLocalizedString(forKey: Recurring.MonthlyRecurr.rawValue, value: ""){
            aStrFre = JMOLocalizedString(forKey: aObjMedicine.reminderFrequency!, value: "").capitalized
        }else {
            aStrFre = "--"
        }
    
        medicineCell.lblFrequency.text = "\(JMOLocalizedString(forKey: "Frequency", value: "")): \(aStrFre)"
        
        LanguageManager().localizeThingsInView(parentView: medicineCell)
        
        if (GeneralConstants.DeviceType.IS_IPAD) {
            customizeFonts(in: medicineCell.lblTitle, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: medicineCell.lblFrequency, aFontName: Medium, aFontSize: 0)
        }else{
            customizeFonts(in: medicineCell.lblTitle, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: medicineCell.lblFrequency, aFontName: Medium, aFontSize: 0)
        }
        return medicineCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: SegueIdentifiers.ksegueMedicalVC.rawValue, sender: nil)
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle
    {
        return .delete
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: JMOLocalizedString(forKey: "Delete", value: "")) {(action,index) in
            
            UIAlertController.showDeleteAlert(self, aStrMessage: JMOLocalizedString(forKey: "Are you sure that you want to delete?", value: ""), completion: { (index: Int, str: String) in

         if index == 0
         {
            
            //handle delete
            var aObjMedicine = medicinePlanReminderModel()
            if self.isSearch {
                aObjMedicine =  self.medicinePlanSearchObj[indexPath.row]
            }else{
                aObjMedicine = self.medicinePlanObj[indexPath.row]
            }
            
            ReminderModel().getAllFromReminderIDByMedicine_plans(typrID: String((aObjMedicine.typeID)!), completion: { (obj: [ReminderModel]) in
                
                let aDeleteReminderIDs = obj
                
                for objDeleteReminderID in aDeleteReminderIDs{
                    print("objDeleteReminderID = \(objDeleteReminderID)")
                    let aDeleteReminderID = String.init(format: "%d", objDeleteReminderID.reminderID)
                    self.cancelNotification(str: aDeleteReminderID, complition: { (Void) in
                        
                    })
                    
                }
                
            })
            
            //|| aObjMedicine.dailyFrequency == 0
            if aObjMedicine.dailyFrequency! == FrequencyType.OnceType.rawValue {
                
                medicinePlan().deleteMedicine(deleteID: (aObjMedicine.identifier)!, complition: { (result: Bool) in
                
                    medicinePlan().deleteMedicineReminder(deleteID: (aObjMedicine.identifier)!, complition: { (result: Bool) in
                        
                        UserActivityModel().deleteActivity(type: (aObjMedicine.type)!, typeid: (aObjMedicine.typeID)!,  userActivityDate: "", reminderID: (aObjMedicine.reminderID!), complition: { (result: Bool) in
                            self.delete(indexPath: indexPath, aObjMedicine: aObjMedicine)
                        })

                    })

                })
                
            }
            else if aObjMedicine.dailyFrequency! == FrequencyType.Twice.rawValue {
                
                ReminderModel().getAllFromReminderIDByMedicine_plans(typrID: String((aObjMedicine.typeID)!), completion: { (obj: [ReminderModel]) in
                    
                    let aDeleteReminderIDs = obj
                    
                    for objDeleteReminderID in aDeleteReminderIDs{
                        print("objDeleteReminderID = \(objDeleteReminderID)")
                        let aDeleteReminderID = String.init(format: "%d", objDeleteReminderID.reminderID)
                        self.cancelNotification(str: aDeleteReminderID, complition: { (Void) in
                            
                        })
                        
                    }
                    
                })
                

                
                medicinePlan().deleteMedicine(deleteID: (aObjMedicine.identifier)!, complition: { (result: Bool) in
                    
                    medicinePlan().deleteMedicineReminder(deleteID: (aObjMedicine.identifier)!, complition: { (result: Bool) in
                        UserActivityModel().deleteActivity(type: (aObjMedicine.type)!, typeid: (aObjMedicine.typeID)!,  userActivityDate: "", reminderID: (aObjMedicine.reminderID!), complition: { (result: Bool) in
                            self.delete(indexPath: indexPath, aObjMedicine: aObjMedicine)

                        })

                    })
                   
                })
                                
            }
            else if aObjMedicine.dailyFrequency! == FrequencyType.Thrice.rawValue {
                
                ReminderModel().getAllFromReminderIDByMedicine_plans(typrID: String((aObjMedicine.typeID)!), completion: { (obj: [ReminderModel]) in
                    
                    let aDeleteReminderIDs = obj
                    
                    for objDeleteReminderID in aDeleteReminderIDs{
                        print("objDeleteReminderID = \(objDeleteReminderID)")
                        let aDeleteReminderID = String.init(format: "%d", objDeleteReminderID.reminderID)
                        self.cancelNotification(str: aDeleteReminderID, complition: { (Void) in
                            
                        })
                        
                    }
                    
                })
                

                
                medicinePlan().deleteMedicine(deleteID: (aObjMedicine.identifier)!, complition: { (result: Bool) in
                    medicinePlan().deleteMedicineReminder(deleteID: (aObjMedicine.identifier)!, complition: { (result: Bool) in
                        
                        UserActivityModel().deleteActivity(type: (aObjMedicine.type)!, typeid: (aObjMedicine.typeID)!,  userActivityDate: "", reminderID: (aObjMedicine.reminderID!), complition: { (result: Bool) in
                            self.delete(indexPath: indexPath, aObjMedicine: aObjMedicine)
                            
                        })
                    })
                })
                
            }
            else if aObjMedicine.dailyFrequency! == FrequencyType.Once4.rawValue{
                
                
                ReminderModel().getAllFromReminderIDByMedicine_plans(typrID: String((aObjMedicine.typeID)!), completion: { (obj: [ReminderModel]) in
                    
                    let aDeleteReminderIDs = obj
                    
                    for objDeleteReminderID in aDeleteReminderIDs{
                        print("objDeleteReminderID = \(objDeleteReminderID)")
                        let aDeleteReminderID = String.init(format: "%d", objDeleteReminderID.reminderID)
                        self.cancelNotification(str: aDeleteReminderID, complition: { (Void) in
                            
                        })
                        
                    }
                    
                })
                
                
                medicinePlan().deleteMedicine(deleteID: (aObjMedicine.identifier)!, complition: { (result: Bool) in
                    
                    medicinePlan().deleteMedicineReminder(deleteID: (aObjMedicine.identifier)!, complition: { (result: Bool) in
                        
                        UserActivityModel().deleteActivity(type: (aObjMedicine.type)!, typeid: (aObjMedicine.typeID)!,  userActivityDate: "", reminderID: (aObjMedicine.reminderID!), complition: { (result: Bool) in
                            self.delete(indexPath: indexPath, aObjMedicine: aObjMedicine)
                            
                        })
                    })
                })
                
            }
            else if aObjMedicine.dailyFrequency! == FrequencyType.Once6.rawValue{
                
                
                ReminderModel().getAllFromReminderIDByMedicine_plans(typrID: String((aObjMedicine.typeID)!), completion: { (obj: [ReminderModel]) in
                    
                    let aDeleteReminderIDs = obj
                    
                    for objDeleteReminderID in aDeleteReminderIDs{
                        print("objDeleteReminderID = \(objDeleteReminderID)")
                        let aDeleteReminderID = String.init(format: "%d", objDeleteReminderID.reminderID)
                        self.cancelNotification(str: aDeleteReminderID, complition: { (Void) in
                            
                        })
                        
                    }
                    
                })
                
                
                
                medicinePlan().deleteMedicine(deleteID: (aObjMedicine.identifier)!, complition: { (result: Bool) in
                    
                    medicinePlan().deleteMedicineReminder(deleteID: (aObjMedicine.identifier)!, complition: { (result: Bool) in
                        
                        UserActivityModel().deleteActivity(type: (aObjMedicine.type)!, typeid: (aObjMedicine.typeID)!,  userActivityDate: "", reminderID: (aObjMedicine.reminderID!), complition: { (result: Bool) in
                            self.delete(indexPath: indexPath, aObjMedicine: aObjMedicine)
                            
                        })
                    })
                })
                
            }
            else{
                
                ReminderModel().getAllFromReminderIDByMedicine_plans(typrID: String((aObjMedicine.typeID)!), completion: { (obj: [ReminderModel]) in
                    
                    let aDeleteReminderIDs = obj
                    
                    for objDeleteReminderID in aDeleteReminderIDs{
                        print("objDeleteReminderID = \(objDeleteReminderID)")
                        let aDeleteReminderID = String.init(format: "%d", objDeleteReminderID.reminderID)
                        self.cancelNotification(str: aDeleteReminderID, complition: { (Void) in
                            
                        })
                        
                    }
                    
                })
                
                
                medicinePlan().deleteMedicine(deleteID: (aObjMedicine.identifier)!, complition: { (result: Bool) in
                    
                    medicinePlan().deleteMedicineReminder(deleteID: (aObjMedicine.identifier)!, complition: { (result: Bool) in
                        
                        UserActivityModel().deleteActivity(type: (aObjMedicine.type)!, typeid: (aObjMedicine.typeID)!,  userActivityDate: "", reminderID: (aObjMedicine.reminderID!), complition: { (result: Bool) in
                            self.delete(indexPath: indexPath, aObjMedicine: aObjMedicine)
                        })
                        
                    })
                    
                })
                
            }
            
            if self.medicinePlanObj.count == 0 {
                self.lblNoMedicines.isHidden = false
            }else{
                self.lblNoMedicines.isHidden = true
            }
                }
                
            })
        }
        
        return [deleteAction]
    }
    
    
    
    func delete(indexPath: IndexPath, aObjMedicine: medicinePlanReminderModel) {
        
        print("Delete Id = \(String(aObjMedicine.reminderID!))")
        
        self.cancelNotification(str: String(aObjMedicine.reminderID!), complition: { (Void) in
            
        })
        
        if self.isSearch {
            
            var aIntCount = 0
            for obj in self.medicinePlanObj {
                
                if obj.identifier == self.medicinePlanSearchObj[indexPath.row].identifier
                {
                    self.medicinePlanObj.remove(at: aIntCount)
                }
                
                aIntCount = aIntCount + 1
            }
            self.medicinePlanSearchObj.remove(at: indexPath.row)
            
        }else{
            self.medicinePlanObj.remove(at: indexPath.row)
        }
        
        self.tblMidicinPlan.reloadData()
    }
    
    //MARK: UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        isSearch = true
        
        searchMedicine(text: searchText)
        
        if searchBar.text == "" {
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.view.endEditing(true)
        
        isSearch = true
        if (searchBar.text?.count)! > 0 {
            
            searchMedicine(text: searchBar.text!)
        }else{
            
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.view.endEditing(true)
        isSearch = false
        
        UIView.animate(withDuration: 2.0) {
            self.viewSearch.isHidden = true
        }
        
        self.tblMidicinPlan.reloadData()
    }
    
    
    func searchMedicine(text: String) {
        
        if (text.count) > 0 {
            medicinePlanSearchObj.removeAll()
            
            medicinePlanSearchObj = medicinePlanObj.filter({ (obj: medicinePlanReminderModel) -> Bool in
                return obj.name.lowercased().contains(text.lowercased())
            })
            
            
            self.tblMidicinPlan.reloadData()
            
        }else{
            self.view.endEditing(true)
            isSearch = false
            
            UIView.animate(withDuration: 2.0) {
                self.viewSearch.isHidden = true
            }
            
            self.tblMidicinPlan.reloadData()
        }
        
    }
    
}
