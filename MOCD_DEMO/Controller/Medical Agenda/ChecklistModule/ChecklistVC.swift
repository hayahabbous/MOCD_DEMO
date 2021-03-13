    //
    //  ChecklistVC.swift
    //  SwiftDatabase
    //
    //  Created by indianic on 30/12/16.
    //  Copyright © 2016 demo. All rights reserved.
    //
    
    import UIKit
    import ObjectiveC
    import SwiftyDropbox
    import MessageUI
    
    
    enum Section:  Int{
        case section0 = 0
        case section1 = 1
        case section2 = 2
        case section3 = 3
        case section4 = 4
    }
    
    extension ChecklistVC: UITextFieldDelegate {
        
        func addToolBar(textField: UITextField) {
            let toolBar = UIToolbar()
            toolBar.barStyle = .default
            toolBar.isTranslucent = true
            toolBar.tintColor = UIColor.black
            let doneButton = UIBarButtonItem(title: JMOLocalizedString(forKey: "Done", value: ""), style: .done, target: self, action: #selector(donePressed))
            
            let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            toolBar.setItems([spaceButton, doneButton], animated: false)
            
            
            toolBar.isUserInteractionEnabled = true
            toolBar.sizeToFit()
            
            textField.delegate = self
            textField.inputAccessoryView = toolBar
        }
        
        @objc func donePressed() {
            view.endEditing(true)
        }
        
        
    }
    
    class ChecklistVC: UIViewController ,UITableViewDelegate, UITableViewDataSource,MFMailComposeViewControllerDelegate{
        
        static let AssociationKey = UnsafePointer<Int>(bitPattern: 0)
        
        let defaults: UserDefaults = UserDefaults(suiteName: smartAgendaExtension)!
        
        @IBOutlet weak var btnLeftMenu: UIButton!
        @IBOutlet weak var lblScreenTitle: UILabel!
        @IBOutlet weak var lblChecklistDate: UILabel!
        @IBOutlet var tblChecklist: TPKeyboardAvoidingTableView!
        @IBOutlet var lblDay: UILabel!
        
        weak var textFieldDelegate: UITextFieldDelegate?
        
        var strTxtLow = String()
        var strTxtHigh = String()
        var strTxtSugar = String()
        
        var arrChecklistSectionTitle = [String]()
        var arrChecklistSectionImage = [String]()
        var aStrEventDate = ""
        
        var arrDiseaseModelList = [UserReminder]()
        var arrIndDailyActivitiesModelList = [UserReminder]()
        var arrMedicinePlanModelList = [UserReminder]()
        var arrAppoinetmentModelList = [UserReminder]()
        var arrSocialActivitiesModelList = [UserReminder]()
        
        var objDiseaseModel = DiseaseModel()
        
        var arrReminderModelList = [ReminderModel]()
        var arrFilterByCheckListCategory = [ReminderModel]()
        
        var formatterTime = DateFormatter()
        var dateFormatter = DateFormatter()
        var strDate = String()
        
        
        var arrMutUserActivity = [UserActivityModel]()
        
        private let dayWholeFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.locale = NSLocale(localeIdentifier: "en") as Locale?
            formatter.dateFormat = "MMMM dd, YYYY"
            return formatter
        }()
        
        private let dayWholeFormatterAR: DateFormatter = {
            let formatter = DateFormatter()
            formatter.locale = NSLocale(localeIdentifier: "ar") as Locale?
            formatter.dateFormat = "MMMM dd, YYYY"
            return formatter
        }()
        
        private let dayFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.locale = NSLocale(localeIdentifier: "en") as Locale?
            formatter.dateFormat = "EEEE"
            return formatter
        }()
        
        private let dayFormatterAR: DateFormatter = {
            let formatter = DateFormatter()
            formatter.locale = NSLocale(localeIdentifier: "ar") as Locale?
            formatter.dateFormat = "EEEE"
            return formatter
        }()
        
        
        override func viewDidLoad() {
            
            super.viewDidLoad()
            
            strTxtLow = ""
            strTxtHigh = ""
            strTxtSugar = ""
            
            formatterTime.dateFormat = "HH:mm"
            dateFormatter.dateFormat = "yyyy-MM-dd"
            self.navigationController?.navigationBar.isHidden = true
            
            textFieldDelegate = self
            
        }
        
        override func viewWillAppear(_ animated: Bool) {
            
            LanguageManager().localizeThingsInView(parentView: self.view)
            
//            arrChecklistSectionTitle = [JMOLocalizedString(forKey: "Medication plan:", value: ""),
//                                        JMOLocalizedString(forKey:"Independent daily activities:" , value: ""),
//                                        JMOLocalizedString(forKey:"Medication list:" , value: ""),
//                                        JMOLocalizedString(forKey:"Appointment:" , value: ""),
//                                        JMOLocalizedString(forKey:"Social Activates:" , value: "")]
            
            arrChecklistSectionTitle = ["Medication plan:",
                                        "Independent daily activities:",
                                        "Medication list:",
                                        "Appointment:",
                                        "Social Activates:"]
            
            arrChecklistSectionImage = ["checklist_03", "checklist_06", "checklist_08", "checklist_12", "checklist_14"]
            
            lblScreenTitle.text = JMOLocalizedString(forKey: "SMART AGENDA", value: "")
            
            if (aDateChecklist == nil) {
                
                // Set value of month and day
                
                
                if (AppConstants.isArabic()){
                    lblChecklistDate.text = dayWholeFormatterAR.string(from: Date())
                    lblDay.text = dayFormatterAR.string(from: Date())
                }else{
                    lblChecklistDate.text = dayWholeFormatter.string(from: Date())
                    lblDay.text = dayFormatter.string(from: Date())
                }
                
                
                strDate = dateFormatter.string(from: Date())
                aDateChecklistEvent = Date()
                
                // For check today day
                isBoolTodayDay = true
            }else{
                
                
                if (AppConstants.isArabic()){
                    lblChecklistDate.text = dayWholeFormatterAR.string(from: aDateChecklist!)
                    
                    lblDay.text = JMOLocalizedString(forKey:  dayOfTheWeek(aDateChecklist!)!, value: "")

                }else{
                    lblChecklistDate.text = dayWholeFormatter.string(from: aDateChecklist!)
                    
                    lblDay.text = JMOLocalizedString(forKey:  dayOfTheWeek(aDateChecklist!)!, value: "")
                }
                
               
                
                aStrEventDate = dayFormatter.string(from: aDateChecklistEvent!)
                
                strDate = dateFormatter.string(from: aDateChecklistEvent!)
                
                if strDate == dateFormatter.string(from: Date()) {isBoolTodayDay = true}else{isBoolTodayDay = false}
            }
            
            
            
            // Set custom fonts
            if GeneralConstants.DeviceType.IS_IPAD {
                
                customizeFonts(in: lblScreenTitle, aFontName: Medium, aFontSize: 0)
                customizeFonts(in: lblChecklistDate, aFontName: Light, aFontSize: 0)
                customizeFonts(in: lblDay, aFontName: Light, aFontSize: 0)
            }else{
                customizeFonts(in: lblScreenTitle, aFontName: Medium, aFontSize: 0)
                customizeFonts(in: lblDay, aFontName: Light, aFontSize: 0)
                customizeFonts(in: lblChecklistDate, aFontName: Light, aFontSize: 0)
            }
            
            
            self.FetchEventsForCalender(strDate)
            
            DispatchQueue.main.async {
                self.tblChecklist.reloadData()
            }
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            aDateChecklist = nil
        }
        
        func FetchEventsForCalender(_ aStrDateForEvent : String) -> Void {
            
            userInfoManager.sharedInstance.GetAllReminderCheckList(aDateChecklistEvent!, strStartEndDateOfMonth: strStartEndDateOfMonth, complete: { (aObjTempReminder: [ReminderModel]) in
                
                var aObjTempReminder = aObjTempReminder
                self.arrReminderModelList.removeAll()
                self.arrReminderModelList = aObjTempReminder
                
                for obj in arrReminderModelList {
                    
                    obj.isBoolSelected = 0
                    
                    aObjTempReminder.append(obj)
                }
                
                arrMutUserActivity = UserActivityModel().selectFromUserActivity(todate: strDate)
                
                var arrMain = [UserReminder]()
                
                for objReminder in arrReminderModelList {
                    
                    var boolEqual: Bool = true
                    
                    let aDictTemp = UserReminder()
                    
                    for objUser in arrMutUserActivity {
                        
                        if objReminder.reminderID == objUser.reminder_id && objReminder.type == objUser.type && objReminder.typeID == objUser.type_id && objUser.user_activity_date == strDate {
                            
                            aDictTemp.reminder_id = objReminder.reminderID
                            
                            aDictTemp.user_activity_id = objUser.user_activity_id
                            
                            aDictTemp.type = objReminder.type
                            
                            aDictTemp.typeID = objReminder.typeID
                            aDictTemp.reminderTime = objReminder.reminderTime
                            
                            aDictTemp.user_activity_time = objUser.user_activity_time
                            aDictTemp.user_activity_date = objUser.user_activity_date
                            aDictTemp.user_activity_value = objUser.user_activity_value
                            aDictTemp.user_activity_value_bool = objUser.user_activity_value_bool
                            
                            aDictTemp.reminderTxt = objReminder.reminderTxt
                            
                            arrMain.append(aDictTemp)
                            
                            boolEqual = false
                            break
                        }else{
                            boolEqual = true
                        }
                        
                    }
                    
                    if boolEqual {
                        aDictTemp.reminder_id = objReminder.reminderID
                        
                        aDictTemp.type = objReminder.type
                        
                        aDictTemp.typeID = objReminder.typeID
                        aDictTemp.reminderTime = objReminder.reminderTime
                        
                        aDictTemp.user_activity_time = ""
                        aDictTemp.user_activity_date = ""
                        aDictTemp.user_activity_value = ""
                        aDictTemp.user_activity_value_bool = 0
                        
                        aDictTemp.reminderTxt = objReminder.reminderTxt
                        
                        arrMain.append(aDictTemp)
                        
                    }
                }
                
                arrDiseaseModelList.removeAll()
                
                arrDiseaseModelList = arrMain.filter({ (obj: UserReminder) -> Bool in
                    return obj.type! == 1
                })
                
                arrIndDailyActivitiesModelList.removeAll()
                arrIndDailyActivitiesModelList = arrMain.filter { (obj: UserReminder) -> Bool in
                    return obj.type! == 2
                }
                
                arrMedicinePlanModelList.removeAll()
                arrMedicinePlanModelList = arrMain.filter { (obj: UserReminder) -> Bool in
                    return obj.type! == 3
                }
                
                arrAppoinetmentModelList.removeAll()
                arrAppoinetmentModelList = arrMain.filter { (obj: UserReminder) -> Bool in
                    return obj.type! == 4
                }
                
                arrSocialActivitiesModelList.removeAll()
                arrSocialActivitiesModelList = arrMain.filter { (obj: UserReminder) -> Bool in
                    return obj.type == 5
                }
                
                
                print(arrMain.count)
                
                
                tblChecklist.reloadData()
            })
            
            
        }
        
        
        @IBAction func btnSideLeftMenuAction(_ sender: UIButton) {
            
            if AppConstants.isArabic() {
                appDelegate.mmDrawer?.open(.right, animated: true, completion: nil)
            }else{
                appDelegate.mmDrawer?.open(.left, animated: true, completion: nil)
            }
        }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return arrChecklistSectionTitle.count
        }
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
        {
            return 40.0
        }
        
        
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
        {
            
            
            let  headerCell = tableView.dequeueReusableCell(withIdentifier: "ChecklistHeaderCell") as! ChecklistCell
            
            LanguageManager().localizeThingsInView(parentView: headerCell)
            
            headerCell.imgView.image = UIImage(named: arrChecklistSectionImage[section])
            
            
            
//            if AppConstants.isArabic() {
//                headerCell.lblCheckList.text = JMOLocalizedString(forKey: arrChecklistSectionTitle[section], value: "")
//            }else{
//                headerCell.lblCheckList.text = arrChecklistSectionTitle[section]
//            }
            
            headerCell.lblCheckList.text = JMOLocalizedString(forKey: arrChecklistSectionTitle[section], value: "")
            
            
            
            return headerCell
            
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            if section == 0 {
                return arrDiseaseModelList.count
            }
            else if section == 1 {
                return arrIndDailyActivitiesModelList.count
            }else if section == 2 {
                var medicineCount : Int = 1
                if arrMedicinePlanModelList.count > 0 {
                    medicineCount = arrMedicinePlanModelList.count
                }
                // return arrMedicinePlanModelList.count
                return medicineCount
            }else if section == 3 {
                var AppoinetmentCount : Int = 1
                if arrAppoinetmentModelList.count > 0 {
                    AppoinetmentCount = arrAppoinetmentModelList.count
                }
                // return arrAppoinetmentModelList.count
                return AppoinetmentCount
            }else if section == 4 {
                
                var SocialActivities : Int = 1
                if arrSocialActivitiesModelList.count > 0 {
                    SocialActivities = arrSocialActivitiesModelList.count
                }
                // return arrSocialActivitiesModelList.count
                return SocialActivities
                
                
            }
            return 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let aChecklistCell = tableView.dequeueReusableCell(withIdentifier: "ChecklistCell", for: indexPath) as! ChecklistCell
            let aNoChecklistCell = tableView.dequeueReusableCell(withIdentifier: "NoChecklistCell") as! NoChecklistCell
            
            aNoChecklistCell.isHidden = true
            aNoChecklistCell.lblNoCheckList.isHidden = true
            
            LanguageManager().localizeThingsInView(parentView: aChecklistCell)
            LanguageManager().localizeThingsInView(parentView: aNoChecklistCell)
            
            
            customizeFonts(in: aChecklistCell.txtFieldLow, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: aChecklistCell.txtFieldHigh, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: aChecklistCell.txtFieldSugar, aFontName: Medium, aFontSize: 0)
            
            customizeFonts(in: aChecklistCell.lblCheckList, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: aChecklistCell.lblCheckList1, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: aChecklistCell.lblCheckList2, aFontName: Medium, aFontSize: 0)
            
            customizeFonts(in: aChecklistCell.lblTime, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: aChecklistCell.lblTime1, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: aChecklistCell.lblTime2, aFontName: Medium, aFontSize: 0)
            
            aChecklistCell.txtFieldLow.delegate = textFieldDelegate
            aChecklistCell.txtFieldHigh.delegate = textFieldDelegate
            aChecklistCell.txtFieldSugar.delegate = textFieldDelegate
            
            addToolBar(textField: aChecklistCell.txtFieldLow)
            addToolBar(textField: aChecklistCell.txtFieldHigh)
            addToolBar(textField: aChecklistCell.txtFieldSugar)

            
            
            var aArrFilterByCheckListCategory = UserReminder()
            
            if indexPath.section == Section.section0.rawValue {
                // Medication plan
                aArrFilterByCheckListCategory =  arrDiseaseModelList[indexPath.row]
            }else if indexPath.section == Section.section1.rawValue {
                // Independent daily activity
                aArrFilterByCheckListCategory =   arrIndDailyActivitiesModelList[indexPath.row]
                
                
                
            }else if indexPath.section == Section.section2.rawValue {
                // Medication list
                if arrMedicinePlanModelList.count > 0 {
                    aChecklistCell.isHidden = false
                    aNoChecklistCell.isHidden =  true
                    aNoChecklistCell.lblNoCheckList.isHidden = true
                    aArrFilterByCheckListCategory =   arrMedicinePlanModelList[indexPath.row]
                    
                }else{
                    aChecklistCell.isHidden = true
                    aNoChecklistCell.isHidden =  false
                    aNoChecklistCell.lblNoCheckList.isHidden = false
                    aNoChecklistCell.lblNoCheckList.text = JMOLocalizedString(forKey: "No Medicines are added", value: "")
                }
            }else if indexPath.section == Section.section3.rawValue {
                
               
                
                // Appointment
                if arrAppoinetmentModelList.count > 0 {
                    
                    aChecklistCell.isHidden = false
                    aNoChecklistCell.isHidden =  true
                    aNoChecklistCell.lblNoCheckList.isHidden = true
                    aArrFilterByCheckListCategory =  arrAppoinetmentModelList[indexPath.row]
                    
                }else{
                    aChecklistCell.isHidden = true
                    aNoChecklistCell.isHidden =  false
                    aNoChecklistCell.lblNoCheckList.isHidden = false
                    aNoChecklistCell.lblNoCheckList.text = JMOLocalizedString(forKey: "No appointments are added", value: "")
                }
                
            }else if indexPath.section == Section.section4.rawValue {
                
                // Social activity
                if arrSocialActivitiesModelList.count > 0 {
                    
                    aChecklistCell.isHidden = false
                    aNoChecklistCell.isHidden =  true
                    aNoChecklistCell.lblNoCheckList.isHidden = true
                    aArrFilterByCheckListCategory =   arrSocialActivitiesModelList[indexPath.row]
                    
                }else{
                    aChecklistCell.isHidden = true
                    aNoChecklistCell.isHidden =  false
                    aNoChecklistCell.lblNoCheckList.isHidden = false
                    aNoChecklistCell.lblNoCheckList.text = JMOLocalizedString(forKey: "No activities are added", value: "")
                }
            }
            
            print(aArrFilterByCheckListCategory)
            
            //objc_setAssociatedObject(aChecklistCell.btnChecklist, ChecklistVC.AssociationKey!  , indexPath, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            aChecklistCell.btnChecklist.addTarget(self, action: #selector(btnSelectedClick(_:)), for: .touchUpInside)
            
            if (aArrFilterByCheckListCategory.type != nil) && (aArrFilterByCheckListCategory.typeID != nil) {
            
                if aArrFilterByCheckListCategory.user_activity_value_bool == 0 {
                    
                    aChecklistCell.view0.isHidden = false
                    aChecklistCell.view1.isHidden = true
                    aChecklistCell.view2.isHidden = true
                    
                    aChecklistCell.btnChecklist.setImage(UIImage(named: "ic_checkbox_unselected"), for: .normal)
                    
//                    if ((aArrFilterByCheckListCategory.reminder_id == 12) && ((aArrFilterByCheckListCategory.reminderTxt! == JMOLocalizedString(forKey: "Blood sugar", value: "")) || (aArrFilterByCheckListCategory.reminderTxt! == JMOLocalizedString(forKey: "BLOOD SUGAR", value: ""))))
                    if (aArrFilterByCheckListCategory.reminder_id == 12)
                    {
                    
                        aChecklistCell.lblCheckList.text = JMOLocalizedString(forKey: "Blood Sugar 'Fasting'", value: "")
                    }
                    else if (aArrFilterByCheckListCategory.reminder_id == 13)
                    {
                        
                        aChecklistCell.lblCheckList.text = JMOLocalizedString(forKey: "Blood Sugar 'After Eating'", value: "")
                    }
                    else{
                        aChecklistCell.lblCheckList.text = JMOLocalizedString(forKey: aArrFilterByCheckListCategory.reminderTxt!, value: "")
                    }
                    
                    
                    
                    if aArrFilterByCheckListCategory.type == 3 || aArrFilterByCheckListCategory.type == 4 ||  aArrFilterByCheckListCategory.type == 1 {
                        aChecklistCell.timeConstraint.constant = 37
                        if aArrFilterByCheckListCategory.reminderTime == "" {
                            aChecklistCell.lblTime.text = "NO"
                        }else{
                            aChecklistCell.lblTime.text = aArrFilterByCheckListCategory.reminderTime
                        }
                        
                        
                    }else{
                        aChecklistCell.timeConstraint.constant = 0
                        //                    aChecklistCell.lblTime.text = ""
                    }
                    
                    if JMOLocalizedString(forKey: aArrFilterByCheckListCategory.reminderTxt!, value: "") == JMOLocalizedString(forKey: "blood pressure", value: "") {
                        
//                        if isBoolTodayDay {
//                            defaults.set("", forKey: "DefaultBloodPressure")
//                        }
                        
                        let bloodPressureDate = defaults.value(forKey: "DefaultBPressureDate") as? Date
                        DispatchQueue.main.async {
                        
                            if (bloodPressureDate == nil){
                                self.defaults.set("", forKey: "DefaultBloodPressure")
                                self.defaults.set(Date(), forKey: "DefaultBPressureDate")
                                self.defaults.synchronize()
                            }
                        }
                        
                        
                    }else if JMOLocalizedString(forKey: aArrFilterByCheckListCategory.reminderTxt!, value: "") == JMOLocalizedString(forKey: "blood sugar", value: "") {
                        
//                        if isBoolTodayDay {
//                            defaults.set("", forKey: "DefaultBloodSugar")
//                        }
                        
                        let bloodSugerDate = defaults.value(forKey: "DefaultBSugarDate") as? Date
                        
                        DispatchQueue.main.async {
                            if (bloodSugerDate == nil){
                                self.defaults.set("", forKey: "DefaultBloodSugar")
                                self.defaults.set(Date(), forKey: "DefaultBSugarDate")
                                self.defaults.synchronize()
                            }
                        }
                        
                        
                    }
                    
                }
                else{
                    
                    aChecklistCell.btnChecklist.setImage(UIImage(named: "ic_checkbox_selected"), for: .normal)
                    
                    if JMOLocalizedString(forKey: aArrFilterByCheckListCategory.reminderTxt!, value: "") == JMOLocalizedString(forKey: "Blood pressure", value: "") {
                        
                        // Disease && Blood Pressure
                        aChecklistCell.view0.isHidden = true
                        aChecklistCell.view1.isHidden = true
                        aChecklistCell.view2.isHidden = false
                        
                        aChecklistCell.lblCheckList2.text = JMOLocalizedString(forKey: aArrFilterByCheckListCategory.reminderTxt!, value: "")
                        
                        var commaSep = aArrFilterByCheckListCategory.user_activity_value.components(separatedBy: ",")
                        if commaSep.count > 1 {
                            aChecklistCell.txtFieldLow?.text = commaSep[0]
                            aChecklistCell.txtFieldHigh?.text = commaSep[1]
                        }else{
                            aChecklistCell.txtFieldLow?.text = ""
                            aChecklistCell.txtFieldHigh?.text = ""
                        }
                        
                        if aArrFilterByCheckListCategory.reminderTime == "" {
                            aChecklistCell.lblTime2.text = "NO"
                        }else{
                            aChecklistCell.lblTime2.text = aArrFilterByCheckListCategory.reminderTime
                        }
                        //                aChecklistCell.txtFieldLow?.text = strTxtLow
                        //                aChecklistCell.txtFieldHigh?.text = strTxtHigh
                        
                    }else if indexPath.section == 0{   //aArrFilterByCheckListCategory.reminderTxt!.lowercased().contains("blood sugar"){
                        // Disease && Blood Sugar
                        aChecklistCell.view0.isHidden = true
                        aChecklistCell.view1.isHidden = false
                        aChecklistCell.view2.isHidden = true
                        
                        if (aArrFilterByCheckListCategory.reminder_id == 12)                        {
                            
                            aChecklistCell.lblCheckList1.text = JMOLocalizedString(forKey: "Blood Sugar 'Fasting'", value: "")
                        }
                        else if (aArrFilterByCheckListCategory.reminder_id == 13)
                        {
                            
                            aChecklistCell.lblCheckList1.text = JMOLocalizedString(forKey: "Blood Sugar 'After Eating'", value: "")
                            
                        }
                        else{
                            aChecklistCell.lblCheckList1.text = JMOLocalizedString(forKey: aArrFilterByCheckListCategory.reminderTxt!, value: "")
                        }
                        
                        
                        
                        aChecklistCell.txtFieldSugar?.text = aArrFilterByCheckListCategory.user_activity_value
                        if aArrFilterByCheckListCategory.reminderTime == "" {
                            aChecklistCell.lblTime1.text = "NO"
                        }else{
                            aChecklistCell.lblTime1.text = aArrFilterByCheckListCategory.reminderTime
                        }
                        
                        //                aChecklistCell.txtFieldSugar?.text = strTxtSugar
                    }
                    else {
                        aChecklistCell.view0.isHidden = false
                        aChecklistCell.view1.isHidden = true
                        aChecklistCell.view2.isHidden = true
                        
                        if aArrFilterByCheckListCategory.type == 3 || aArrFilterByCheckListCategory.type == 4 {
                            aChecklistCell.timeConstraint.constant = 37
                            aChecklistCell.lblTime.text = aArrFilterByCheckListCategory.reminderTime
                            
                        }else{
                            aChecklistCell.timeConstraint.constant = 0
                            //                    aChecklistCell.lblTime.text = ""
                        }
                        
                        aChecklistCell.lblCheckList.text = JMOLocalizedString(forKey: aArrFilterByCheckListCategory.reminderTxt!, value: "")
                    }
                    
                }
                
            }

            aChecklistCell.txtFieldLow.delegate = self
            aChecklistCell.txtFieldHigh.delegate = self
            aChecklistCell.txtFieldSugar.delegate = self
            
            
            if indexPath.section == Section.section2.rawValue {
                // Medication list
                if arrMedicinePlanModelList.count <= 0 {
                    return aNoChecklistCell
                }
            }else if indexPath.section == Section.section3.rawValue {
                // Appointment
                if arrAppoinetmentModelList.count <= 0 {
                    return aNoChecklistCell
                }
            }else if indexPath.section == Section.section4.rawValue {
                // Social activity
                if arrSocialActivitiesModelList.count <= 0 {
                    return aNoChecklistCell
                }
            }
            
//
            
            return aChecklistCell
        }
        
        
        @IBAction func btnSelectedClick(_ sender: UIButton) {
            
            strTxtLow = ""
            strTxtHigh = ""
            strTxtSugar = ""
            
            var indexPath: IndexPath = objc_getAssociatedObject(sender, ChecklistVC.AssociationKey!) as! IndexPath
            print(indexPath.section)
            print(indexPath.row)
            
            
            
            let aObjReminder = setSelectionBool(indexPath: indexPath)
            insertUpdateIntoUserActivity(obj: aObjReminder, indexPath: indexPath, isSelected: aObjReminder.user_activity_value_bool)
            
            if indexPath.section == 0 {
                self.tblChecklist.reloadRows(at: [indexPath], with: .none)
            }else if indexPath.section == 1{
                
                self.tblChecklist.reloadRows(at: [indexPath], with: .none)
                
            }
//            else if indexPath.section == 2{
//                
//                self.tblChecklist.reloadRows(at: [indexPath], with: .none)
//                
//            }else if indexPath.section == 3{
//                
//                self.tblChecklist.reloadRows(at: [indexPath], with: .none)
//                
//            }else if indexPath.section == 4{
//                
//                self.tblChecklist.reloadRows(at: [indexPath], with: .none)
//                
//            }
            else{
                self.tblChecklist.reloadData()
            }
            
            
        }
        
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print(indexPath.section)
            print(indexPath.row)
            
            
            //        let aObjReminder = setSelectionBool(indexPath: indexPath)
            //
            //        self.tblChecklist.reloadData()
            //
            //        insertUpdateIntoUserActivity(obj: aObjReminder, indexPath: indexPath, isSelected: aObjReminder.isBoolSelected!)
            
        }
        
        
        private func setSelectionBool(indexPath: IndexPath) -> UserReminder {
            // Get data on row
            var aArrFilterByCheckListCategory = UserReminder()
            
            if indexPath.section == Section.section0.rawValue {
                
                aArrFilterByCheckListCategory =  arrDiseaseModelList[indexPath.row]
                
            }else if indexPath.section == Section.section1.rawValue {
                
                aArrFilterByCheckListCategory =   arrIndDailyActivitiesModelList[indexPath.row]
                
            }else if indexPath.section == Section.section2.rawValue {
                
                aArrFilterByCheckListCategory =   arrMedicinePlanModelList[indexPath.row]
                
            }else if indexPath.section == Section.section3.rawValue {
                
                aArrFilterByCheckListCategory =   arrAppoinetmentModelList[indexPath.row]
                
            }else if indexPath.section == Section.section4.rawValue {
                
                aArrFilterByCheckListCategory =   arrSocialActivitiesModelList[indexPath.row]
                
            }
            
            // Set o/1
            if aArrFilterByCheckListCategory.user_activity_value_bool == 0 {
                aArrFilterByCheckListCategory.user_activity_value_bool = 1
            }else{
                aArrFilterByCheckListCategory.user_activity_value_bool = 0
                
            }
            aArrFilterByCheckListCategory.user_activity_value = "";
            // Set selected / unselected values
            if indexPath.section == Section.section0.rawValue {
                
                arrDiseaseModelList.remove(at: indexPath.row)
                arrDiseaseModelList.insert(aArrFilterByCheckListCategory, at: indexPath.row)
                
            }else if indexPath.section == Section.section1.rawValue {
                
                arrIndDailyActivitiesModelList.remove(at: indexPath.row)
                arrIndDailyActivitiesModelList.insert(aArrFilterByCheckListCategory, at: indexPath.row)
            }else if indexPath.section == Section.section2.rawValue {
                
                arrMedicinePlanModelList.remove(at: indexPath.row)
                arrMedicinePlanModelList.insert(aArrFilterByCheckListCategory, at: indexPath.row)
                
            }else if indexPath.section == Section.section3.rawValue {
                
                arrAppoinetmentModelList.remove(at: indexPath.row)
                arrAppoinetmentModelList.insert(aArrFilterByCheckListCategory, at: indexPath.row)
                
            }else if indexPath.section == Section.section4.rawValue {
                
                arrSocialActivitiesModelList.remove(at: indexPath.row)
                arrSocialActivitiesModelList.insert(aArrFilterByCheckListCategory, at: indexPath.row)
                
            }
            
            return aArrFilterByCheckListCategory
            
        }
        
        private func insertUpdate(obj: UserReminder, indexPath: IndexPath, isSelected: Int)
        {
            let aObjUserACty =  UserActivityModel()
            
            //dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.locale = NSLocale(localeIdentifier: "en") as Locale?
            formatterTime.locale = NSLocale(localeIdentifier: "en") as Locale?
            aObjUserACty.user_activity_date = dateFormatter.string(from: aDateChecklistEvent!)
            aObjUserACty.user_activity_time = formatterTime.string(from: Date())
            
            if isSelected == 1{
                // Insert
                aObjUserACty.user_activity_value_bool = 1
                
                UserActivityModel().insertIntoUserActivity(obj: obj, objUserActy: aObjUserACty, complition: { (result: Bool) in
                    
                })
                
            }else{
                //Delete
                aObjUserACty.user_activity_value_bool = 0
                aObjUserACty.user_activity_value = "";
                UserActivityModel().deletFromUserActivity(obj: obj, objUserActy: aObjUserACty, complition: { (result: Bool) in
                    
                })
            }
        }
        
        private func insertUpdateIntoUserActivity(obj: UserReminder, indexPath: IndexPath, isSelected: Int) {
            print(obj)
            
            
            //        let aObjCell: ChecklistCell = tblChecklist.cellForRow(at: indexPath) as! ChecklistCell
            //        aObjCell.txtFieldLow.text = ""
            //        aObjCell.txtFieldHigh.text = ""
            //        aObjCell.txtFieldSugar.text = ""
            
            //        if indexPath.section == Section.section0.rawValue {
            //
            //            if indexPath.row ==  0 {
            //                //Blood Presure
            //            }else if indexPath.row == 1 {
            //                // Blood Sugar(Fasting)
            //            }else if indexPath.row == 2 {
            //                // Blood Sugar(After Eating)
            //
            //            }
            //
            //        }else if indexPath.section == Section.section1.rawValue || indexPath.section == Section.section2.rawValue || indexPath.section == Section.section3.rawValue || indexPath.section == Section.section4.rawValue{
            
            insertUpdate(obj: obj, indexPath: indexPath, isSelected: isSelected)
            
            //        }
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destinationViewController.
         // Pass the selected object to the new view controller.
         }
         */
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
            
            let newString = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
            
            if newString != "" {
                var value = convertNumberToEnglish(aStr: newString);
                
                if  (!value.isEmpty && Int(value)! <= 9999) {
                    
                    return true
                }
            }else{
                return true
            }
            
            return false
        }
        
        func textFieldDidEndEditing(_ textField: UITextField){
            
            var indexPath = self.tblChecklist.indexPath(for: textField.superview?.superview?.superview as! ChecklistCell)
            
            let cell: ChecklistCell = self.tblChecklist.cellForRow(at: indexPath!) as! ChecklistCell
            
            let aObjUserACty =  UserActivityModel()
            
            aObjUserACty.user_activity_date = dateFormatter.string(from: aDateChecklistEvent!)
            aObjUserACty.user_activity_time = formatterTime.string(from: Date())
            aObjUserACty.user_activity_value_bool = 1
            
            var aStrText = String()
            
            // Set bolld pressure and blood sugar data for today extension
            
            
            //        if Int(textField.text!)! <= 200 {
            if textField == cell.txtFieldLow {
                // Textfield low
                
                aStrText = textField.text!
                strTxtHigh = cell.txtFieldHigh.text!
                print(aStrText)
                
                if (aStrText == ""){
                    aStrText = "0"
                }else if (strTxtHigh == ""){
                    strTxtHigh = "0"
                }
                
                
                let aStrEnTxtLow =  convertNumberToEnglish(aStr: aStrText)
                print("aStrEnTxtLow = \(aStrEnTxtLow)")
                strTxtLow = aStrText
                
                if strTxtHigh.count > 0 {
                    let aStrEnstrTxtLow =  convertNumberToEnglish(aStr: strTxtLow)
                    let aStrEnstrTxtHigh =  convertNumberToEnglish(aStr: strTxtHigh)
                    
                    aObjUserACty.user_activity_value = "\(aStrEnstrTxtLow)" + "," + "\(aStrEnstrTxtHigh)"
                    //aObjUserACty.user_activity_value = "\(strTxtLow)" + "," + "\(strTxtHigh)"
                }else if strTxtHigh == "" && strTxtLow == ""{
                    aObjUserACty.user_activity_value = "0,0"
                }
                else{
                    let aStrEnstrTxtLow =  convertNumberToEnglish(aStr: strTxtLow)
                    let aStrEnstrTxtHigh =  convertNumberToEnglish(aStr: strTxtHigh)
                    aObjUserACty.user_activity_value = "\(aStrEnstrTxtLow)" + "," + aStrEnstrTxtHigh
                    //aObjUserACty.user_activity_value = "\(strTxtLow)" + "," + "0"
                }
                
                
                let bloodPressureDate = defaults.value(forKey: "DefaultBPressureDate") as? Date
                DispatchQueue.main.async {
                    if (bloodPressureDate == nil){
                        self.defaults.set("\(self.strTxtLow)/\(self.strTxtHigh)", forKey: "DefaultBloodPressure")
                        self.defaults.set(Date(), forKey: "DefaultBPressureDate")
                        self.defaults.synchronize()
                    }else if ((bloodPressureDate != nil) && ((bloodPressureDate! == Date()) || (bloodPressureDate! < Date()))) {
                        self.defaults.set("\(self.strTxtLow)/\(self.strTxtHigh)", forKey: "DefaultBloodPressure")
                        self.defaults.set(Date(), forKey: "DefaultBPressureDate")
                        self.defaults.synchronize()
                    }
                }
                
                
                //                if isBoolTodayDay {
                //                    defaults.set("\(strTxtLow)/\(strTxtHigh)", forKey: "DefaultBloodPressure")
                //                }
                
            }else if textField == cell.txtFieldHigh {
                // Textfiled high
                
                aStrText = textField.text!
                strTxtHigh = aStrText
                
                print(aStrText)
                
                var widgetValue = String()
                if strTxtLow.count > 0 {
                    //aObjUserACty.user_activity_value = "\(strTxtLow)" + "," + "\(strTxtHigh)"
                
                    let aStrEnstrTxtLow =  convertNumberToEnglish(aStr: strTxtLow)
                    let aStrEnstrTxtHigh =  convertNumberToEnglish(aStr: strTxtHigh)
                    print("aStrEnstrTxtLow = \(aStrEnstrTxtLow)")
                    print("aStrEnstrTxtHigh = \(aStrEnstrTxtHigh)")
                    
                    aObjUserACty.user_activity_value = "\(aStrEnstrTxtLow)" + "," + "\(aStrEnstrTxtHigh)"
                    widgetValue = "\(strTxtLow)" + "/" + "\(strTxtHigh)"
                }else if strTxtHigh == "" && strTxtLow == ""{
                    aObjUserACty.user_activity_value = "0,0"
                }else{
                    let aStrEnstrTxtHigh =  convertNumberToEnglish(aStr: strTxtHigh)
                    //aObjUserACty.user_activity_value = "0" + "," + "\(strTxtHigh)"
                    aObjUserACty.user_activity_value = "0" + "," + "\(aStrEnstrTxtHigh)"
//                    widgetValue = "\(strTxtLow)"
                    widgetValue = "\(strTxtLow)" + "/" + "\(strTxtHigh)"
                }
                
                
//                if isBoolTodayDay {
//                    defaults.set(widgetValue, forKey: "DefaultBloodPressure")
//                }
                
                let bloodPressureDate = defaults.value(forKey: "DefaultBPressureDate") as? Date
                DispatchQueue.main.async {
                    if (bloodPressureDate == nil){
                        self.defaults.set("\(self.strTxtLow)" + "/" + "\(self.strTxtHigh)", forKey: "DefaultBloodPressure")
                        self.defaults.set(Date(), forKey: "DefaultBPressureDate")
                        self.defaults.synchronize()
                        
                    }else if ((bloodPressureDate != nil) && ((bloodPressureDate! == Date()) || (bloodPressureDate! < Date()))) {
                        self.defaults.set("\(self.strTxtLow)" + "/" + "\(self.strTxtHigh)", forKey: "DefaultBloodPressure")
                        self.defaults.set(Date(), forKey: "DefaultBPressureDate")
                        self.defaults.synchronize()
                    }
                }
                
            }else if textField == cell.txtFieldSugar {
                // Textfiled sugar
                
                aStrText = textField.text!
                print(aStrText)
                
                let aStrEnSuger =  convertNumberToEnglish(aStr: aStrText)
                print("aStrEnSuger = \(aStrEnSuger)")
                
                //aObjUserACty.user_activity_value = aStrText
                aObjUserACty.user_activity_value = aStrEnSuger
                
                
                //                if isBoolTodayDay {
                //                    defaults.set(aObjUserACty.user_activity_value, forKey: "DefaultBloodSugar")
                //                }
                DispatchQueue.main.async {
                    let bloodSugerDate = self.defaults.value(forKey: "DefaultBSugarDate") as? Date
                    
                    if (bloodSugerDate == nil){
                        self.defaults.set(aStrText, forKey: "DefaultBloodSugar")
                        self.defaults.set(Date(), forKey: "DefaultBSugarDate")
                        self.defaults.synchronize()
                    }else if ((bloodSugerDate != nil) && ((bloodSugerDate! == Date()) || (bloodSugerDate! < Date()))) {
                        self.defaults.set(aStrText, forKey: "DefaultBloodSugar")
                        self.defaults.set(Date(), forKey: "DefaultBSugarDate")
                        self.defaults.synchronize()
                    }
                }
                
            }
            
            defaults.synchronize()
            
            updateIntoUserActivity(arrDiseaseModelList: arrDiseaseModelList[(indexPath?.row)!], arrUser: aObjUserACty)
            
        }
        
        private func updateIntoUserActivity(arrDiseaseModelList: UserReminder, arrUser: UserActivityModel) {
            
            arrDiseaseModelList.user_activity_time = arrUser.user_activity_time
            arrDiseaseModelList.user_activity_date = arrUser.user_activity_date
            arrDiseaseModelList.user_activity_value = arrUser.user_activity_value
            arrDiseaseModelList.user_activity_value_bool = arrUser.user_activity_value_bool
            arrDiseaseModelList.user_activity_date = arrUser.user_activity_date
            
            let query = "UPDATE user_activity SET reminder_id='\(arrDiseaseModelList.reminder_id)', type='\(arrDiseaseModelList.type!)', type_id='\(arrDiseaseModelList.typeID!)', user_activity_time='\(arrUser.user_activity_time)', user_activity_date='\(arrUser.user_activity_date)', user_activity_value='\(arrUser.user_activity_value)', user_activity_value_bool='\(arrUser.user_activity_value_bool)' WHERE reminder_id='\(arrDiseaseModelList.reminder_id)' and type='\(arrDiseaseModelList.type!)' and type_id='\(arrDiseaseModelList.typeID!)' and user_activity_date='\(arrUser.user_activity_date)'"
            print(query)
            Database().update(query: query, success: {
                print("Update Success")
                
//                self.tblChecklist.reloadData()
            }) {
                print("Update Failure")
            }
            
        }
        
        func SideMenuSelectionMethod(SideMenuIndex indexSideMenu : Int) -> Void {
            
            switch (indexSideMenu) {
                
            case 1:
                
                // Language selection option.
                let alertController = UIAlertController.init(title: "", message: JMOLocalizedString(forKey: "Choose your language", value: ""), preferredStyle: UIAlertController.Style.alert)
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
                // Feedback selection option.
                //            self.performSegue(withIdentifier: SegueIdentifiers.ksegueFeedback.rawValue, sender: nil)
                let obj = self.storyboard?.instantiateViewController(withIdentifier: "FeedbackVC") as? FeedbackVC
                self.navigationController?.pushViewController(obj!, animated: true)
                break
                
            case 3:
                // Appoinements selection option.
                //            self.performSegue(withIdentifier: SegueIdentifiers.kSegueAppointment.rawValue, sender: nil)
                let obj = self.storyboard?.instantiateViewController(withIdentifier: "AppointmentVC") as? AppointmentVC
                self.navigationController?.pushViewController(obj!, animated: true)
                
                break
                
            case 4:
                // Notes selection option.
                //            self.performSegue(withIdentifier: SegueIdentifiers.ksegueNotes.rawValue, sender: nil)
                let obj = self.storyboard?.instantiateViewController(withIdentifier: "NotesVC") as? NotesVC
                self.navigationController?.pushViewController(obj!, animated: true)
                break
                
            case 5:
                // Social Activities selection option.
                //            self.performSegue(withIdentifier: SegueIdentifiers.ksegueSocialActivities.rawValue, sender: nil)
                let obj = self.storyboard?.instantiateViewController(withIdentifier: "SocialActivitiesVC") as? SocialActivitiesVC
                self.navigationController?.pushViewController(obj!, animated: true)
                break
                
            case 6:
                // Medicines selection option.
                //            self.performSegue(withIdentifier: SegueIdentifiers.ksegueMedical.rawValue, sender: nil)
                let obj = self.storyboard?.instantiateViewController(withIdentifier: "MedicinPlanListVC") as? MedicinPlanListVC
                self.navigationController?.pushViewController(obj!, animated: true)
                break
            case 7:
                // Disease selection option.
                //            self.performSegue(withIdentifier: SegueIdentifiers.ksegueDisease.rawValue, sender: nil)
                let obj = self.storyboard?.instantiateViewController(withIdentifier: "DiseaseListVC") as? DiseaseListVC
                self.navigationController?.pushViewController(obj!, animated: true)
                break
            case 8:
                // Independent selection option.
                //            self.performSegue(withIdentifier: SegueIdentifiers.ksegueIndependent.rawValue, sender: nil)
                let obj = self.storyboard?.instantiateViewController(withIdentifier: "IndependentListVC") as? IndependentListVC
                self.navigationController?.pushViewController(obj!, animated: true)
                break
            case 9:
                // Dropbox
                //            self.performSegue(withIdentifier: SegueIdentifiers.ksegueIndependent.rawValue, sender: nil)
                DropboxClientsManager.authorizeFromController(UIApplication.shared,
                                                              controller: self,
                                                              openURL: { (url: URL) -> Void in
                                                                if #available(iOS 10.0, *){
                
                                                                    UIApplication.shared.open(url, options: [:], completionHandler: { (status : Bool) in
                                                                        DropboxClientsManager.handleRedirectURL(url) { (authResult) in
                                                                            switch authResult {
                                                                            case .success:
                                                                                print("Success! User is logged into DropboxClientsManager.")
                                                                                currentViewContoller = self
                                                                            case .cancel:
                                                                                print("Authorization flow was manually canceled by user!")
                                                                            case .error(_, let description):
                                                                                print("Error: \(description)")
                                                                            case .none:
                                                                                print("Error:")
                                                                            }
                                                                        }
                                                                        
                                                                        
                                                                    })

                                                                }else{
                                                                    
                                                                    let status = UIApplication.shared.openURL(url)
                                                                    DropboxClientsManager.handleRedirectURL(url) { (authResult) in
                                                                        switch authResult {
                                                                        case .success:
                                                                            print("Success! User is logged into DropboxClientsManager.")
                                                                            currentViewContoller = self
                                                                        case .cancel:
                                                                            print("Authorization flow was manually canceled by user!")
                                                                        case .error(_, let description):
                                                                            print("Error: \(description)")
                                                                        case .none:
                                                                            print("Error:")
                                                                        }
                                                                    }
                                                                   
                                                                }
                                                                
                })
                break
                
            case 10:
                // About us
                //            self.performSegue(withIdentifier: SegueIdentifiers.ksegueIndependent.rawValue, sender: nil)
                let obj = self.storyboard?.instantiateViewController(withIdentifier: "AboutUsVC") as? AboutUsVC
                self.navigationController?.pushViewController(obj!, animated: true)
                break
            case 11:
                // User Profile
                let obj = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as? SignUpVC
                obj?.isUpdateProfile = true
                self.navigationController?.pushViewController(obj!, animated: true)
                break
            case 12:
                // Contact us
                GeneralConstants().sendEmail(setData: { (result: Bool, mail: MFMailComposeViewController) in
                    if result {
                        
                        mail.mailComposeDelegate = self
                        
                        present(mail, animated: true, completion: {
                            
                        })
                        
                    }else{
                        // Alert
                        UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey: "Email is not setup in settings , please setup email !", value: ""), completion: nil)
                        
                    }
                })
                break
            case 13:
                // Share on  Social media
                self.shareOnSocialMedia()
                break
            case 14:
                // Settings Screen
                
                let obj = self.storyboard?.instantiateViewController(withIdentifier: "SettingsVC") as? SettingsVC
                self.navigationController?.pushViewController(obj!, animated: true)
                break
                
            default:
                // Feedback selection option.
                break
            }
        }
        
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true)
        }
        
        func shareOnSocialMedia() {
            let textToShare = "Smart Agenda App !"
            if let myWebsite = NSURL(string: shareURL) {
                let objectsToShare = [textToShare, myWebsite] as [Any]
                let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                
                activityVC.popoverPresentationController?.sourceView = self.view
                self.present(activityVC, animated: true, completion: nil)
            }
        }
        
        fileprivate func LanguageSelectionMethod() -> Void {
            
            self.lblScreenTitle.text = JMOLocalizedString(forKey: "SMART AGENDA", value: "")
            
            self.tabBarController?.tabBar.items?[0].title = JMOLocalizedString(forKey: "CALENDAR", value: "")
            self.tabBarController?.tabBar.items?[1].title = JMOLocalizedString(forKey: "CHECKLIST", value: "")
            self.tabBarController?.tabBar.items?[2].title = JMOLocalizedString(forKey: "REPORT", value: "")
            
            
            //        var aChecklistVC  : ChecklistVC = self.tabBarController?.childViewControllers[1] as! ChecklistVC
            //        aChecklistVC.lblScreenTitle.text = JMOLocalizedString(forKey: "SMART AGENDA", value: "")
            
            LanguageManager().localizeThingsInView(parentView: (self.view))
            LanguageManager().localizeThingsInView(parentView: (self.tblChecklist))
            LanguageManager().localizeThingsInView(parentView: (self.tabBarController?.view)!)
            
            tblChecklist.reloadData()
        }
        
        func LanguageChangeMethod() -> Void {
            
            if AppConstants.isArabic()
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
            
            self.LanguageSelectionMethod()
            
            if aDateChecklist == nil {
                
                // Set value of month and day
                if (AppConstants.isArabic()){
                    lblChecklistDate.text = dayWholeFormatterAR.string(from: Date())
                    lblDay.text = dayFormatterAR.string(from: Date())
                }else{
                    lblChecklistDate.text = dayWholeFormatter.string(from: Date())
                    lblDay.text = dayFormatter.string(from: Date())
                }
               
            }else{
                
                if (AppConstants.isArabic()){
                    lblChecklistDate.text = dayWholeFormatterAR.string(from: aDateChecklist!)
                    lblDay.text = JMOLocalizedString(forKey: aStrEventDate, value: "")
                }else{
                    lblChecklistDate.text = dayWholeFormatter.string(from: aDateChecklist!)
                    lblDay.text = aStrEventDate
                }
            }
            
            DispatchQueue.main.async {
                self.tblChecklist.reloadData()
            }
            
        }
        
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            self.view.endEditing(true)
            
            
            //            if scrollView == feedTableView {
//                let contentOffset = scrollView.contentOffset.y
//                print("contentOffset: ", contentOffset)
//                if (contentOffset > self.lastKnowContentOfsset) {
//                    print("scrolling Down")
//                    print("dragging Up")
//                } else {
//                    print("scrolling Up")
//                    print("dragging Down")
//                }
//            }
        }
        
    }

    
