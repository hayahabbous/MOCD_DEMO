//
//  AddMedicinPlanVC.swift
//  SmartAgenda
//
//  Created by indianic on 25/01/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit


enum Frequency: String {
    case Once = "Once a day"
    case Twice = "Twice a day"
    case Thrice = "3 Times a day"
}

enum Frequency5: String {
    case Once = "Once a day"
    case Twice = "Twice a day"
    case Thrice = "3 Times a day"
    case Hours4 = "Once every 4 hours"
    case Hours6 = "Once every 6 hour"
    
}


class AddMedicinPlanVC: UIViewController, MMDatePickerDelegate,UITextFieldDelegate {
    
    //MARK: Variables
    var isBoolEdit: Bool?
    var isBoolUpdate: Bool?
    var intSwitch: Int?
    var medicinSelected: medicinePlanReminderModel?
    var medicinePlanObj: medicinePlan?
    var reminderObj = ReminderModel()
    
    var datePicker = MMDatePicker.getFromNib()
    var dateFormatter = DateFormatter()
    var timeFormatter = DateFormatter()
    var dateSelectedFormatter = DateFormatter()
    
    var aArrmutMedicineSchedule = [String]()
    var aRRWeekDay = [String]()
    var aRRMonth = [String]()
    var aRRmutFrequency = [String]()
    
    var selectedDateTime: Date?
    var selectedDateTime2: Date?
    var selectedDateTime3: Date?
    var selectedDateTime4: Date?
    var selectedDateTime5: Date?
    var selectedDateTime6: Date?
    
    var selectedDate: Date?
    var selectedDay: Int?
    
    var isBooltime = false
    
    var name = String()
    var dose = String()
    var medicineSchedule = String()
    var frequency = String()
    var startIntakeTime = String()
    var startIntakeTime2 = String()
    var startIntakeTime3 = String()
    var startIntakeTime4 = String()
    var startIntakeTime5 = String()
    var startIntakeTime6 = String()
    
    var strForCancelNotification: String?
    
    var intTagTime: Int = 0
    var isBoolEndDate = false
    
    var strInsertRecurring = String()
    var strinsertFrequency = String()
    //MARK: IBOutlets
    @IBOutlet var txtFieldName: UITextField!
    @IBOutlet var txtFieldDose: UITextField!
    @IBOutlet var txtFieldDate: UITextField!
    @IBOutlet var txtFieldMedicineSchedule: UITextField!
    @IBOutlet var txtFrequency: UITextField!
    @IBOutlet var txtStartIntakeTime: UITextField!
    @IBOutlet var txtStartIntakeTime2: UITextField!
    @IBOutlet var txtStartIntakeTime3: UITextField!
    @IBOutlet var txtStartIntakeTime4: UITextField!
    @IBOutlet var txtStartIntakeTime5: UITextField!
    @IBOutlet var txtStartIntakeTime6: UITextField!
    
    @IBOutlet var txtEndDate: UITextField!
    @IBOutlet var lblScreenTitle: UILabel!
    
    @IBOutlet var btnSaveUpdate: UIButton!
    
    
    @IBOutlet var switchReminder: UISwitch!
    
    @IBOutlet var height: NSLayoutConstraint!
    @IBOutlet var height2: NSLayoutConstraint!
    @IBOutlet var height3: NSLayoutConstraint!
    @IBOutlet var height4: NSLayoutConstraint!
    @IBOutlet var height6: NSLayoutConstraint!
    
    @IBOutlet var lblReminderStatic: UILabel!
    
    @IBOutlet var btnBackEN: UIButton!
    @IBOutlet var scrlview: TPKeyboardAvoidingScrollView!
    
    
    
    //MARK: ViewController Methods
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
        
        // Set Picker
        setupDatePicker()
        
        // Set textField left padding
        setPadding()
        
        // Array fill up
        aArrmutMedicineSchedule = [JMOLocalizedString(forKey: "Medicine Schedule", value: ""), JMOLocalizedString(forKey: Recurring.DailyRecurr.rawValue, value: ""), JMOLocalizedString(forKey: Recurring.WeeklyRecurr.rawValue, value: ""), JMOLocalizedString(forKey: Recurring.MonthlyRecurr.rawValue, value: "")]
        
        //        aRRmutFrequency = [JMOLocalizedString(forKey: "Frequency", value: ""), JMOLocalizedString(forKey: Frequency5.Once.rawValue, value: ""), JMOLocalizedString(forKey: Frequency5.Twice.rawValue, value: ""), JMOLocalizedString(forKey:Frequency5.Thrice.rawValue, value: "")]
        
        aRRmutFrequency = [JMOLocalizedString(forKey: "Frequency", value: ""), JMOLocalizedString(forKey: Frequency5.Once.rawValue, value: ""), JMOLocalizedString(forKey: Frequency5.Twice.rawValue, value: ""), JMOLocalizedString(forKey:Frequency5.Thrice.rawValue, value: ""), JMOLocalizedString(forKey:Frequency5.Hours4.rawValue, value: ""),JMOLocalizedString(forKey:Frequency5.Hours6.rawValue, value: "")]
        
        aRRWeekDay = [JMOLocalizedString(forKey: "Select Day", value: ""),
                      JMOLocalizedString(forKey: "Sunday", value: ""),
                      JMOLocalizedString(forKey: "Monday", value: ""),
                      JMOLocalizedString(forKey: "Tuesday", value: ""),
                      JMOLocalizedString(forKey: "Wednesday", value: ""),
                      JMOLocalizedString(forKey: "Thursday", value: ""),
                      JMOLocalizedString(forKey: "Friday", value: ""),
                      JMOLocalizedString(forKey: "Saturday", value: "")]
        
        aRRMonth = ["Select Day","1", "2", "3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18",
                    "19","20","21","22","23","24","25","26","27","28"]
        
        txtFieldName.delegate = self
        txtFieldDose.delegate = self
        
        self.setDateOnButton(dat: Date(), txtField: self.txtFieldDate)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.lblScreenTitle.text = JMOLocalizedString(forKey: kAddMedicinPlan, value: "")
        
        // UIView localize
        LanguageManager().localizeThingsInView(parentView: (self.view))
        
        
        customizeFonts(in: lblScreenTitle, aFontName: Medium, aFontSize: 0)
        customizeFonts(in: txtStartIntakeTime, aFontName: Medium, aFontSize: 0)
        customizeFonts(in: txtStartIntakeTime2, aFontName: Medium, aFontSize: 0)
        customizeFonts(in: txtFieldDate, aFontName: Medium, aFontSize: 0)
        customizeFonts(in: txtEndDate, aFontName: Medium, aFontSize: 0)
        customizeFonts(in: txtFieldDose, aFontName: Medium, aFontSize: 0)
        customizeFonts(in: txtFieldName, aFontName: Medium, aFontSize: 0)
        customizeFonts(in: txtFrequency, aFontName: Medium, aFontSize: 0)
        customizeFonts(in: txtStartIntakeTime3, aFontName: Medium, aFontSize: 0)
        customizeFonts(in: txtFieldMedicineSchedule, aFontName: Medium, aFontSize: 0)
        customizeFonts(in: btnSaveUpdate, aFontName: Bold, aFontSize: 0)
        customizeFonts(in: lblReminderStatic, aFontName: Medium, aFontSize: 0)
        customizeFonts(in: txtStartIntakeTime4, aFontName: Medium, aFontSize: 0)
        customizeFonts(in: txtStartIntakeTime5, aFontName: Medium, aFontSize: 0)
        customizeFonts(in: txtStartIntakeTime6, aFontName: Medium, aFontSize: 0)
        
        
        // Set data based on edit
        if isBoolEdit! {
            
            self.medicinAddOrUpdate()
            isBoolEdit = false
            isBoolUpdate = true
            self.lblScreenTitle.text = JMOLocalizedString(forKey: "EDIT MEDICINE PLAN", value: "")
            btnSaveUpdate.setTitle(JMOLocalizedString(forKey: "UPDATE", value: ""), for: .normal)
        }else{
            isBoolUpdate = false
            self.height.constant = 0
            self.height2.constant = 0
            self.height3.constant = 0
            self.height4.constant = 0
            self.height6.constant = 0
            btnSaveUpdate.setTitle(JMOLocalizedString(forKey: "ADD", value: ""), for: .normal)
        }
        
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
    
    //MARK: Actions Events
    
    
    /// Reminder switch button click
    ///
    /// - Parameter sender: reminder button reference
    @IBAction func switchReminderClick(_ sender: UISwitch) {
        
        if sender.isOn {
            intSwitch = 1
        }else{
            intSwitch = 0
        }
        
    }
    
    
    /// Back button click
    ///
    /// - Parameter sender: back button reference
    @IBAction func btnBackClick(_ sender: UIButton) {
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    /// Date button click
    ///
    /// - Parameter sender: date button click reference
    @IBAction func btnDateClick(_ sender: UIButton) {
        
        if GeneralConstants.DeviceType.IS_IPAD {
            // iPad
            
            self.view.endEditing(true)
            
//            var aDate: Date?
//            if !(txtEndDate.text?.isEmpty)! {
////                aDate = selectedDate
//                aDate = getDateFromString(yyyyMMdd, aStrDate: (medicinSelected?.reminderEndDate)!)
//            }else{
//                aDate = nil
//            }
            MMDatePickerPopover.appearOn(originView: sender, baseViewController: self, title: "DatePicker", dateMode: .date, initialDate: Date(), maxDate: dateFormatter.date(from: "3000-12-31"), timeFormat: nil, doneAction: { selectedDate in
                
                print("selectedDate \(selectedDate)")
                
                self.selectedDate = selectedDate
                
                self.setDateOnButton(dat: selectedDate, txtField: self.txtFieldDate)
                
            },
                                         cancelAction: {
                                            print("cancel")
            })
            
        }else{
            // iPhone
            
            isBooltime = false
            datePicker.config.dateMode = .date
            datePicker.config.minDate = Date()
            
            if !(txtEndDate.text?.isEmpty)! {
                datePicker.config.maxDate = selectedDate
            }
            datePicker.show(inVC: self)
            
        }
    }
    
    
    @IBAction func btnEndDateClick(_ sender: UIButton) {
        
        
        
        
        if GeneralConstants.DeviceType.IS_IPAD {
            // iPad
            
            self.view.endEditing(true)
            
//            var aDate: Date?
//            if !(txtEndDate.text?.isEmpty)! {
////                aDate = selectedDate
//            }else{
//                aDate = Date()
//            }
            
            MMDatePickerPopover.appearOn(originView: sender, baseViewController: self, title: "DatePicker", dateMode: .date, initialDate: Date(), maxDate: dateFormatter.date(from: "3000-12-31"), timeFormat: nil, doneAction: { selectedDate in
                
                print("selectedDate \(selectedDate)")
                
                self.selectedDate = selectedDate
                self.isBoolEndDate = true
                self.setDateOnButton(dat: selectedDate, txtField: self.txtEndDate)
                
            },
                                         cancelAction: {
                                            print("cancel")
            })
            
            
        }else{
            // iPhone
            self.isBoolEndDate = true
            isBooltime = false
            
            datePicker.config.maxDate = dateFormatter.date(from: "3000-12-31")
            
            datePicker.config.dateMode = .date
            datePicker.config.minDate = Date()
            
          //  if !(txtFieldDate.text?.isEmpty)! {
            //    datePicker.config.minDate = selectedDate
           // }
            
            datePicker.show(inVC: self)
            
            
            
        }
        
    }
    
    
    /// Insert or Update button click
    ///
    /// - Parameter sender: button reference
    @IBAction func btnAddAndUpdateClcik(_ sender: UIButton) {
        
        name = GeneralConstants.trimmingString(txtFieldName.text!)
        dose = GeneralConstants.trimmingString(txtFieldDose.text!)
        medicineSchedule =  GeneralConstants.trimmingString(JMOLocalizedString(forKey: txtFieldMedicineSchedule.text!, value: ""))
        frequency = GeneralConstants.trimmingString(txtFrequency.text!)
        startIntakeTime = GeneralConstants.trimmingString(txtStartIntakeTime.text!)
        startIntakeTime2 = GeneralConstants.trimmingString(txtStartIntakeTime2.text!)
        startIntakeTime3 = GeneralConstants.trimmingString(txtStartIntakeTime3.text!)
        
        // Check length for name
        
        if GeneralConstants.trimming(txtFieldName.text!) && GeneralConstants.checkLength(txtFieldName.text!, length: 256){
            // Check length for dose
            if GeneralConstants.trimming(txtFieldDose.text!) && GeneralConstants.checkLength(txtFieldDose.text!, length: 50) {
                // Medicine schedule
                if GeneralConstants.trimming(txtFieldMedicineSchedule.text!) {
                    if !(txtFrequency.text?.contains(aRRmutFrequency[0]))!{
                        if GeneralConstants.trimming(txtFieldDate.text!)  && GeneralConstants.trimming(txtEndDate.text!){
                            
                            if JMOLocalizedString(forKey: txtFieldMedicineSchedule.text!, value: "") == JMOLocalizedString(forKey: Recurring.WeeklyRecurr.rawValue, value: "") {
                                // Weekly
                                
                                if GeneralConstants.trimming(txtFrequency.text!) && GeneralConstants.trimming(txtStartIntakeTime.text!){
                                    switch JMOLocalizedString(forKey: txtFrequency.text!, value: "") {
                                        
                                    case JMOLocalizedString(forKey: aRRWeekDay[1], value: ""):
                                        self.selectedDay = WeekDay.Sunday.rawValue
                                    case JMOLocalizedString(forKey: aRRWeekDay[2], value: ""):
                                        self.selectedDay = WeekDay.Monday.rawValue
                                    case JMOLocalizedString(forKey: aRRWeekDay[3], value: ""):
                                        self.selectedDay = WeekDay.Tuesday.rawValue
                                    case JMOLocalizedString(forKey: aRRWeekDay[4], value: ""):
                                        self.selectedDay = WeekDay.Wednesday.rawValue
                                    case JMOLocalizedString(forKey: aRRWeekDay[5], value: ""):
                                        self.selectedDay = WeekDay.Thursday.rawValue
                                    case JMOLocalizedString(forKey: aRRWeekDay[6], value: ""):
                                        self.selectedDay = WeekDay.Friday.rawValue
                                    case JMOLocalizedString(forKey: aRRWeekDay[7], value: ""):
                                        self.selectedDay = WeekDay.Saturday.rawValue
                                    default :
                                        print("")
                                    }
                                    
                                    reminderCheck()
                                }else{
                                    showAlert(message: kReminderOn)
                                }
                                
                            }else if JMOLocalizedString(forKey: txtFieldMedicineSchedule.text!, value: "") == JMOLocalizedString(forKey: Recurring.MonthlyRecurr.rawValue, value: "") {
                                if GeneralConstants.trimming(txtFrequency.text!) && GeneralConstants.trimming(txtStartIntakeTime.text!){
                                    reminderCheck()
                                }else{
                                    showAlert(message: kReminderOn)
                                }
                            }else if JMOLocalizedString(forKey: txtFieldMedicineSchedule.text!, value: "") == JMOLocalizedString(forKey: Recurring.DailyRecurr.rawValue, value: ""){
                                
                                if JMOLocalizedString(forKey: txtFrequency.text!, value: "").lowercased() == JMOLocalizedString(forKey: Frequency5.Once.rawValue, value: "").lowercased() {
                                    
                                    if GeneralConstants.trimming(txtStartIntakeTime.text!) {
                                        reminderCheck()
                                    }else{
                                        showAlert(message: kReminderOn)
                                        
                                    }
                                    
                                }else if JMOLocalizedString(forKey: txtFrequency.text!, value: "").lowercased() == JMOLocalizedString(forKey: Frequency5.Twice.rawValue, value: "").lowercased() {
                                    
                                    if GeneralConstants.trimming(txtStartIntakeTime.text!) && GeneralConstants.trimming(txtStartIntakeTime2.text!) {
                                        reminderCheck()
                                        
                                    }else{
                                        showAlert(message: kReminderOn)
                                        
                                    }
                                    
                                }else if JMOLocalizedString(forKey: txtFrequency.text!, value: "").lowercased() == JMOLocalizedString(forKey: Frequency5.Thrice.rawValue, value: "").lowercased() {
                                    
                                    if GeneralConstants.trimming(txtStartIntakeTime.text!) && GeneralConstants.trimming(txtStartIntakeTime2.text!) && GeneralConstants.trimming(txtStartIntakeTime.text!) {
                                        reminderCheck()
                                        
                                    }else{
                                        showAlert(message: kReminderOn)
                                        
                                    }
                                    
                                    
                                }else if JMOLocalizedString(forKey: txtFrequency.text!, value: "").lowercased() == JMOLocalizedString(forKey: Frequency5.Hours6.rawValue, value: "").lowercased() {
                                    
                                    if GeneralConstants.trimming(txtStartIntakeTime.text!) && GeneralConstants.trimming(txtStartIntakeTime2.text!) && GeneralConstants.trimming(txtStartIntakeTime.text!) && GeneralConstants.trimming(txtStartIntakeTime4.text!) {
                                        reminderCheck()
                                        
                                    }else{
                                        showAlert(message: kReminderOn)
                                        
                                    }
                                    
                                }else if JMOLocalizedString(forKey: txtFrequency.text!, value: "").lowercased() == JMOLocalizedString(forKey: Frequency5.Hours4.rawValue, value: "").lowercased() {
                 
                                    if GeneralConstants.trimming(txtStartIntakeTime.text!) && GeneralConstants.trimming(txtStartIntakeTime2.text!) && GeneralConstants.trimming(txtStartIntakeTime.text!) && GeneralConstants.trimming(txtStartIntakeTime4.text!) && GeneralConstants.trimming(txtStartIntakeTime5.text!) && GeneralConstants.trimming(txtStartIntakeTime6.text!) {
                                        reminderCheck()
                                        
                                    }else{
                                        showAlert(message: kReminderOn)
                                        
                                    }
                                }else{
                                    showAlert(message: kReminderOn)
                                    
                                }
                                
                            }else{
                                showAlert(message: kReminderOn)
                                
                            }
                            
                        }else{
                            showAlert(message: kReminderOn)
                            
                        }
                    }else{
                        showAlert(message: kReminderOn)
                        
                    }
                    
                }else{
                    showAlert(message: kReminderOn)
                    
                }
            }else{
                showAlert(message: kReminderOn)
                
            }
        }else{
            showAlert(message: kReminderOn)
            
        }
        
        
        
        
    }
    
    
    /// Medicine schedule button click
    ///
    /// - Parameter sender: button reference
    @IBAction func btnMedicineScheduleClick(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        openPicker(array: aArrmutMedicineSchedule, sender: sender, textField: txtFieldMedicineSchedule) { (selectedObject , selectedIndex , isCancel) in
            
            print(selectedObject)
            
            self.txtFrequency.text = ""
            self.txtStartIntakeTime.text = ""
            self.txtStartIntakeTime2.text = ""
            self.txtStartIntakeTime3.text = ""
            self.txtStartIntakeTime4.text = ""
            self.txtStartIntakeTime5.text = ""
            self.txtStartIntakeTime6.text = ""
            //            self.txtEndDate.text = ""
            
            switch selectedIndex {
            case 1:
                self.strInsertRecurring  = Recurring.DailyRecurr.rawValue
            case 2:
                self.strInsertRecurring  = Recurring.WeeklyRecurr.rawValue
            case 3:
                self.strInsertRecurring  = Recurring.MonthlyRecurr.rawValue
            default:
                print("Deault")
            }
            
            self.txtFieldMedicineSchedule.text = selectedObject as? String
            
            
            self.height2.constant = 0
            self.height3.constant = 0
            self.height4.constant = 0
            self.height6.constant = 0
            if !isCancel {
                self.height.constant = 152
                self.txtFrequency.text = ""
                if (selectedObject as? String) == JMOLocalizedString(forKey: Recurring.DailyRecurr.rawValue, value: "") {
                    self.txtFrequency.placeholder = JMOLocalizedString(forKey: "Frequency*", value: "")
                }else if (selectedObject as? String) == JMOLocalizedString(forKey: Recurring.WeeklyRecurr.rawValue, value: "") {
                    self.txtFrequency.placeholder = JMOLocalizedString(forKey: "Select Day*", value: "")
                }else if (selectedObject as? String) == JMOLocalizedString(forKey: Recurring.MonthlyRecurr.rawValue, value: "") {
                    self.txtFrequency.placeholder = JMOLocalizedString(forKey: "Select Day*", value: "")
                }else{
                    self.txtFieldMedicineSchedule.placeholder = JMOLocalizedString(forKey: "Medicine Schedule*", value: "")
                    self.txtFieldMedicineSchedule.text = ""
                    self.height.constant = 0
                }
            }
        }
    }
    
    
    /// Frequency utton click
    ///
    /// - Parameter sender: buttokn reference
    @IBAction func btnFrequencyClick(_ sender: UIButton) {
        
        
        if JMOLocalizedString(forKey: txtFieldMedicineSchedule.text!, value: "") == JMOLocalizedString(forKey: Recurring.DailyRecurr.rawValue, value: "") {
            
            openPicker(array: aRRmutFrequency, sender: sender,textField:txtFrequency,  completion: { (selectedObject , selectedIndex , isCancel) in
                
                
                self.txtStartIntakeTime2.text = ""
                self.txtStartIntakeTime3.text = ""
                self.txtStartIntakeTime4.text = ""
                self.txtStartIntakeTime5.text = ""
                self.txtStartIntakeTime6.text = ""
                //                self.txtEndDate.text = ""
                
                if !isCancel {
                    self.txtFrequency.text = selectedObject as? String
                    
                    if JMOLocalizedString(forKey: self.txtFrequency.text!, value: "").lowercased() == JMOLocalizedString(forKey: Frequency5.Once.rawValue, value: "").lowercased() {
                        self.height2.constant = 0
                        self.height3.constant = 0
                        self.height4.constant = 0
                        self.height6.constant = 0
                        
                        self.timeCalculationWhenFirstTimeSelected()
                        
                    }else if JMOLocalizedString(forKey: self.txtFrequency.text!, value: "").lowercased() == JMOLocalizedString(forKey: Frequency5.Twice.rawValue, value: "").lowercased() {
                        self.height2.constant = 50
                        self.height3.constant = 0
                        self.height4.constant = 0
                        self.height6.constant = 0
                        
                        self.timeCalculationWhenFirstTimeSelected()
                        
                    }else if JMOLocalizedString(forKey: self.txtFrequency.text!, value: "").lowercased() == JMOLocalizedString(forKey: Frequency5.Thrice.rawValue, value: "").lowercased() {
                        self.height2.constant = 50
                        self.height3.constant = 50
                        self.height4.constant = 0
                        self.height6.constant = 0
                        
                        self.timeCalculationWhenFirstTimeSelected()
                        

                        
                    }else if JMOLocalizedString(forKey: self.txtFrequency.text!, value: "").lowercased() == JMOLocalizedString(forKey: Frequency5.Hours6.rawValue, value: "").lowercased() {
                        self.height2.constant = 50
                        self.height3.constant = 50
                        self.height4.constant = 50
                        self.height6.constant = 0
                        
                        self.timeCalculationWhenFirstTimeSelected()
                    }else if JMOLocalizedString(forKey: self.txtFrequency.text!, value: "").lowercased() == JMOLocalizedString(forKey: Frequency5.Hours4.rawValue, value: "").lowercased() {
                        

                        self.height2.constant = 50
                        self.height3.constant = 50
                        self.height4.constant = 50
                        self.height6.constant = 100
                        
                        self.timeCalculationWhenFirstTimeSelected()
                        
                    }else{
                        self.txtFrequency.text = ""
                        self.txtFrequency.placeholder = JMOLocalizedString(forKey: "Frequency*", value: "")
                        
                    }
                }
            })
        }else if JMOLocalizedString(forKey: txtFieldMedicineSchedule.text!, value: "") == (JMOLocalizedString(forKey: Recurring.WeeklyRecurr.rawValue, value: "")) {
            openPicker(array: aRRWeekDay, sender: sender, textField:txtFrequency, completion: { (selectedObject , selectedIndex , isCancel) in
                if !isCancel {
                    self.txtFrequency.text = selectedObject as? String
                    
                    switch selectedIndex {
                        
                    case 1:
                        self.selectedDay = WeekDay.Sunday.rawValue
                        self.strinsertFrequency = "Sunday"
                    case 2:
                        self.selectedDay = WeekDay.Monday.rawValue
                        self.strinsertFrequency = "Monday"
                    case 3:
                        self.selectedDay = WeekDay.Tuesday.rawValue
                        self.strinsertFrequency = "Tuesday"
                    case 4:
                        self.selectedDay = WeekDay.Wednesday.rawValue
                        self.strinsertFrequency = "Wednesday"
                    case 5:
                        self.selectedDay = WeekDay.Thursday.rawValue
                        self.strinsertFrequency = "Thursday"
                    case 6:
                        self.selectedDay = WeekDay.Friday.rawValue
                        self.strinsertFrequency = "Friday"
                    case 7:
                        self.selectedDay = WeekDay.Saturday.rawValue
                        self.strinsertFrequency = "Saturday"
                    default :
                        self.txtFrequency.text = ""
                        self.txtFrequency.placeholder = JMOLocalizedString(forKey: "Select Day*", value: "")
                        
                    }
                    
                    
                }
            })
        }else if JMOLocalizedString(forKey: txtFieldMedicineSchedule.text!, value: "") == (JMOLocalizedString(forKey: Recurring.MonthlyRecurr.rawValue, value: "")) {
            openPicker(array: aRRMonth, sender: sender , textField:txtFrequency , completion: { (selectedObject , selectedIndex , isCancel) in
                if !isCancel {
                    self.selectedDay = Int((selectedObject as? String)!)
                    self.txtFrequency.text = selectedObject as? String
                }
            })
        }else{
            self.txtFrequency.text = ""
            self.txtFrequency.placeholder = JMOLocalizedString(forKey: "Select Day*", value: "")
            
        }
        
    }
    
    
    /// StartIntake Time button click for all 3 startintake button
    ///
    /// - Parameter sender: button reference
    @IBAction func btnIntakeTimeClick(_ sender: UIButton) {
        
        intTagTime = sender.tag
        if GeneralConstants.DeviceType.IS_IPAD {
            // iPad
            
            self.view.endEditing(true)
            
            MMDatePickerPopover.appearOn(originView: sender, baseViewController: self, title: "TimePicker", dateMode: .time, initialDate: Date(), maxDate: nil, timeFormat: NSLocale(localeIdentifier: "en_GB"), doneAction: { selectedDate in
                
                print("selectedDate \(selectedDate)")
                self.selectedDateTime = selectedDate
                
                if sender.tag == 100 {
                    // 1st Startintake time
                    
                    self.setTimeOnButton(dat: selectedDate, txtField: self.txtStartIntakeTime)
                    
                    self.timeCalculationWhenFirstTimeSelected()
                    
                }else if sender.tag == 101 {
                    // 2nd Startintake time
                    
                    self.selectedDateTime2 = selectedDate
                    
                    self.setTimeOnButton(dat: selectedDate, txtField: self.txtStartIntakeTime2)
                }else if sender.tag == 102 {
                    // 3rd Startintake time
                    
                    self.selectedDateTime3 = selectedDate
                    
                    self.setTimeOnButton(dat: selectedDate, txtField: self.txtStartIntakeTime3)
                }else if sender.tag == 103 {
                    // 4th Startintake time
                    
                    self.selectedDateTime4 = selectedDate
                    
                    self.setTimeOnButton(dat: selectedDate, txtField: self.txtStartIntakeTime4)
                }else if sender.tag == 104 {
                    // 5th Startintake time
                    
                    self.selectedDateTime5 = selectedDate
                    
                    self.setTimeOnButton(dat: selectedDate, txtField: self.txtStartIntakeTime5)
                }else if sender.tag == 105 {
                    // 6th Startintake time
                    
                    self.selectedDateTime6 = selectedDate
                    
                    self.setTimeOnButton(dat: selectedDate, txtField: self.txtStartIntakeTime6)
                }
            },
                                         cancelAction: {
                                            print("cancel")
            })
            
        }else{
            // iPhone
            
            isBooltime = true
            datePicker.config.dateMode = .time
            datePicker.config.timeFormat = NSLocale(localeIdentifier: "en_GB")
            datePicker.show(inVC: self)
            
        }
        
        
        
    }
    
    
    //MARK: Custom Events
    
    /// Show alert
    ///
    /// - Parameter message: Message text
    fileprivate func showAlert(message: String) {
        UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey: message, value: ""), completion: { (Int, String) in
            
        })
    }
    
    /// Setup datepicker
    fileprivate func setupDatePicker() {
        
        datePicker.delegate = self
        dateFormatter.dateFormat = "yyyy-MM-dd"
        timeFormatter.dateFormat = "HH:mm"
        
        dateSelectedFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateSelectedFormatter.locale = Locale(identifier: "en_US_POSIX")
//        dateSelectedFormatter.timeZone = NSTimeZone(abbreviation: "IST") as TimeZone!
//        dateSelectedFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        dateSelectedFormatter.timeZone = NSTimeZone.local
        datePicker.config.minDate = dateFormatter.date(from: "2000-12-31")
        datePicker.config.maxDate = dateFormatter.date(from: "3000-12-31")
        datePicker.config.startDate = Date()
        
    }
    
    
    /// Set selected value on button
    ///
    /// - Parameters:
    ///   - dat: Selected date
    ///   - button: Button reference
    fileprivate func setDateOnButton(dat: Date, txtField: UITextField) {
        
        let aStrDate = dateFormatter.string(from: dat)
        txtField.text = aStrDate
        
    }
    
    /// Set selected time on button
    ///
    /// - Parameters:
    ///   - dat: Selected time
    ///   - button: Button reference
    fileprivate func setTimeOnButton(dat: Date, txtField: UITextField) {
        
        let aStrDate = timeFormatter.string(from: dat)
        txtField.text = aStrDate
        
    }
    
    /// Open picker common method
    typealias pickerComplition = (_ selectedObject: Any , _ objectIndex: Int , _ isCancel : Bool) -> Void
    
    fileprivate func openPicker(array:[String], sender: UIButton, textField: UITextField, completion:@escaping (pickerComplition)) {
        
        var kpPickerView : KPPickerView?
        kpPickerView = KPPickerView.getFromNib()
        
        kpPickerView!.show(self , sender: sender , data: array , defaultSelected: textField.text!) { (selectedObject , selectedIndex , isCancel) in
            
            print(selectedObject)
            
            if !isCancel {
                completion(selectedObject , selectedIndex , isCancel)
            }
        }
        
    }
    
    
    /// Set UITextField padding
    private func setPadding(){
        
        setTextFieldPadding(textfield: txtFieldName, padding: 5)
        setTextFieldPadding(textfield: txtFieldDose, padding: 5)
        setTextFieldPadding(textfield: txtFieldDate, padding: 5)
        setTextFieldPadding(textfield: txtFieldMedicineSchedule, padding: 5)
        setTextFieldPadding(textfield: txtFrequency, padding: 5)
        setTextFieldPadding(textfield: txtStartIntakeTime, padding: 5)
        setTextFieldPadding(textfield: txtStartIntakeTime2, padding: 5)
        setTextFieldPadding(textfield: txtStartIntakeTime3, padding: 5)
        setTextFieldPadding(textfield: txtStartIntakeTime4, padding: 5)
        setTextFieldPadding(textfield: txtStartIntakeTime5, padding: 5)
        setTextFieldPadding(textfield: txtStartIntakeTime6, padding: 5)
        setTextFieldPadding(textfield: txtEndDate, padding: 5)
    }
    
    
    /// Set data from edit
    private func medicinAddOrUpdate() {
        
        // Set anme , dose, switch notification, date
        name = (medicinSelected?.name)!
        strForCancelNotification = "\((medicinSelected?.identifier)!)"
        dose = (medicinSelected?.dose)!
        intSwitch = medicinSelected?.reminderWithNotification
        
        txtFieldName.text = name
        txtFieldDose.text = dose
        txtFieldDate.text = medicinSelected?.reminderDate
        
        txtEndDate.text = medicinSelected?.reminderEndDate
        
        // Notification switch
        if (intSwitch == 1) {
            switchReminder.isOn = true
        }else{
            switchReminder.isOn = false
        }
        
        // Set Medicine Schedule
        txtFieldMedicineSchedule.text = JMOLocalizedString(forKey: (medicinSelected?.reminderFrequency)!, value: "")
        
        self.strInsertRecurring = (medicinSelected?.reminderFrequency!)!
        
        if txtFieldMedicineSchedule.text == JMOLocalizedString(forKey: Recurring.DailyRecurr.rawValue, value: "") {
            
            height.constant = 152
            
            
            //Set frequency
            if medicinSelected?.dailyFrequency == 1 {
                // Once
                self.height2.constant = 0
                self.height3.constant = 0
                self.height4.constant = 0
                self.height6.constant = 0
                txtStartIntakeTime.text = medicinSelected?.time
                txtFrequency.text = JMOLocalizedString(forKey: Frequency5.Once.rawValue, value: "").capitalized
            }else if medicinSelected?.dailyFrequency == 2 {
                // Twice
                self.height2.constant = 50
                self.height3.constant = 0
                self.height4.constant = 0
                self.height6.constant = 0
                txtStartIntakeTime.text = medicinSelected?.time
                txtStartIntakeTime2.text = medicinSelected?.time2
                txtFrequency.text = JMOLocalizedString(forKey: Frequency5.Twice.rawValue, value: "").capitalized
                
                selectedDateTime2  =  dateSelectedFormatter.date(from: "2000-12-31 \(txtStartIntakeTime2.text!):00")
                
            }else if medicinSelected?.dailyFrequency == 3 {
                // Thrice
                self.height2.constant = 50
                self.height3.constant = 50
                self.height4.constant = 0
                self.height6.constant = 0
                txtStartIntakeTime.text = medicinSelected?.time
                txtStartIntakeTime2.text = medicinSelected?.time2
                txtStartIntakeTime3.text = medicinSelected?.time3
                
                txtFrequency.text = JMOLocalizedString(forKey: Frequency5.Thrice.rawValue, value: "").capitalized
                
                selectedDateTime2  =  dateSelectedFormatter.date(from: "2000-12-31 \(txtStartIntakeTime2.text!):00")
                selectedDateTime3  =  dateSelectedFormatter.date(from: "2000-12-31 \(txtStartIntakeTime3.text!):00")
            }else if medicinSelected?.dailyFrequency == 4 {
                // 4
                self.height2.constant = 50
                self.height3.constant = 50
                self.height4.constant = 50
                self.height6.constant = 0
                
                txtStartIntakeTime.text = medicinSelected?.time
                txtStartIntakeTime2.text = medicinSelected?.time2
                txtStartIntakeTime3.text = medicinSelected?.time3
                txtStartIntakeTime4.text = medicinSelected?.time4
                
                txtFrequency.text = JMOLocalizedString(forKey: Frequency5.Hours6.rawValue, value: "").capitalized
                
                selectedDateTime2  =  dateSelectedFormatter.date(from: "2000-12-31 \(txtStartIntakeTime2.text!):00")
                selectedDateTime3  =  dateSelectedFormatter.date(from: "2000-12-31 \(txtStartIntakeTime3.text!):00")
                selectedDateTime4  =  dateSelectedFormatter.date(from: "2000-12-31 \(txtStartIntakeTime4.text!):00")
                
            }else if medicinSelected?.dailyFrequency == 5 {
                // 6
                self.height2.constant = 50
                self.height3.constant = 50
                self.height4.constant = 50
                self.height6.constant = 100
                
                txtStartIntakeTime.text = medicinSelected?.time
                txtStartIntakeTime2.text = medicinSelected?.time2
                txtStartIntakeTime3.text = medicinSelected?.time3
                txtStartIntakeTime4.text = medicinSelected?.time4
                txtStartIntakeTime5.text = medicinSelected?.time5
                txtStartIntakeTime6.text = medicinSelected?.time6
                
                txtFrequency.text = JMOLocalizedString(forKey: Frequency5.Hours4.rawValue, value: "").capitalized
                
                selectedDateTime2  =  dateSelectedFormatter.date(from: "2000-12-31 \(txtStartIntakeTime2.text!):00")
                selectedDateTime3  =  dateSelectedFormatter.date(from: "2000-12-31 \(txtStartIntakeTime3.text!):00")
                selectedDateTime4  =  dateSelectedFormatter.date(from: "2000-12-31 \(txtStartIntakeTime4.text!):00")
                selectedDateTime5  =  dateSelectedFormatter.date(from: "2000-12-31 \(txtStartIntakeTime5.text!):00")
                selectedDateTime6  =  dateSelectedFormatter.date(from: "2000-12-31 \(txtStartIntakeTime6.text!):00")
                
            }else{
                self.height.constant = 0
                self.height2.constant = 0
                self.height3.constant = 0
                
                txtStartIntakeTime.text = medicinSelected?.time
            }
            
            
        }
        else if txtFieldMedicineSchedule.text == JMOLocalizedString(forKey: Recurring.WeeklyRecurr.rawValue, value: "") {
            
            if (AppConstants.isArabic()){
                txtFrequency.text = JMOLocalizedString(forKey: (medicinSelected?.reminderWeaklyDay)!, value: "")
            }else{
                
                if ((medicinSelected?.reminderWeaklyDay)! == "الأحد"){
                    self.txtFrequency.text = "Sunday"
                }else if ((medicinSelected?.reminderWeaklyDay)! == "الإثنين"){
                    self.txtFrequency.text = "Monday"
                }else if ((medicinSelected?.reminderWeaklyDay)! == "الثلاثاء"){
                    self.txtFrequency.text = "Tuesday"
                }else if ((medicinSelected?.reminderWeaklyDay)! == "الأربعاء"){
                    self.txtFrequency.text = "Wednesday"
                }else if ((medicinSelected?.reminderWeaklyDay)! == "الخميس"){
                    self.txtFrequency.text = "Thursday"
                }else if ((medicinSelected?.reminderWeaklyDay)! == "الجمعة"){
                    self.txtFrequency.text = "Friday"
                }else if ((medicinSelected?.reminderWeaklyDay)! == "السبت"){
                    self.txtFrequency.text = "Saturday"
                }else{
                    self.txtFrequency.text = JMOLocalizedString(forKey: (medicinSelected?.reminderWeaklyDay)!, value: "")
                }
                
            }
            
            
            height.constant = 152
            self.height2.constant = 0
            self.height3.constant = 0
            self.height4.constant = 0
            self.height6.constant = 0
            txtStartIntakeTime.text = medicinSelected?.time
            
            self.setDayForWeeklyReminder()
            
        }
        else if txtFieldMedicineSchedule.text == JMOLocalizedString(forKey: Recurring.MonthlyRecurr.rawValue, value: "") {
            
            txtFrequency.text = JMOLocalizedString(forKey: (medicinSelected?.reminderMonthlyDay)!, value: "")
            height.constant = 152
            self.height2.constant = 0
            self.height3.constant = 0
            self.height4.constant = 0
            self.height6.constant = 0
            txtStartIntakeTime.text = medicinSelected?.time
            self.selectedDay = Int((medicinSelected?.reminderMonthlyDay)!)
        }
        else{
            height.constant = 0
            self.height2.constant = 0
            self.height3.constant = 0
        }
        // Selected time
        selectedDateTime  =  dateSelectedFormatter.date(from: "2000-12-31 \(txtStartIntakeTime.text!):00")
        
    }
    
    
    /// Check reminder is on or off
    private func reminderCheck() {
        
        if isBoolUpdate! {
            deleteMedi()
        }
        
        // reminder is on
        if switchReminder.isOn {
            // Date is selected
            insertUpdateMedicineInDB()
            
        }else{
            // reimder is off
            insertUpdateMedicineInDB()
        }
    }
    
    private func deleteMedi() {
        //|| medicinSelected?.dailyFrequency == 0
        if medicinSelected?.dailyFrequency == FrequencyType.OnceType.rawValue {
            
            medicinePlan().deleteMedicine(deleteID: (medicinSelected?.identifier)!, complition: { (result: Bool) in
                
                medicinePlan().deleteMedicineReminder(deleteID: (medicinSelected?.identifier)!, complition: { (result: Bool) in
                    UserActivityModel().deleteActivity(type: (medicinSelected?.type)!, typeid: (medicinSelected?.typeID)!,  userActivityDate: "", reminderID: (medicinSelected?.reminderID!)!, complition: { (result: Bool) in
                        
                    })
                })
            })
            
        }else if medicinSelected?.dailyFrequency == FrequencyType.Twice.rawValue {
            
            medicinePlan().deleteMedicine(deleteID: (medicinSelected?.identifier)!, complition: { (result: Bool) in
                medicinePlan().deleteMedicineReminder(deleteID: (medicinSelected?.identifier)!, complition: { (result: Bool) in
                    UserActivityModel().deleteActivity(type: (medicinSelected?.type)!, typeid: (medicinSelected?.typeID)!,  userActivityDate: "", reminderID: (medicinSelected?.reminderID!)!, complition: { (result: Bool) in
                        
                    })
                    
                })
                
            })
            
        }else if medicinSelected?.dailyFrequency == FrequencyType.Thrice.rawValue {
            
            medicinePlan().deleteMedicine(deleteID: (medicinSelected?.identifier)!, complition: { (result: Bool) in
                medicinePlan().deleteMedicineReminder(deleteID: (medicinSelected?.identifier)!, complition: { (result: Bool) in
                    
                    UserActivityModel().deleteActivity(type: (medicinSelected?.type)!, typeid: (medicinSelected?.typeID)!,  userActivityDate: "", reminderID: (medicinSelected?.reminderID!)!, complition: { (result: Bool) in
                        
                    })
                })
            })
            
        }else if medicinSelected?.dailyFrequency == FrequencyType.Once4.rawValue{
            
            medicinePlan().deleteMedicine(deleteID: (medicinSelected?.identifier)!, complition: { (result: Bool) in
                medicinePlan().deleteMedicineReminder(deleteID: (medicinSelected?.identifier)!, complition: { (result: Bool) in
                    UserActivityModel().deleteActivity(type: (medicinSelected?.type)!, typeid: (medicinSelected?.typeID)!,  userActivityDate: "", reminderID: (medicinSelected?.reminderID!)!, complition: { (result: Bool) in
                        
                    })
                })
            })
            
        }else if medicinSelected?.dailyFrequency == FrequencyType.Once6.rawValue{
            
            medicinePlan().deleteMedicine(deleteID: (medicinSelected?.identifier)!, complition: { (result: Bool) in
                medicinePlan().deleteMedicineReminder(deleteID: (medicinSelected?.identifier)!, complition: { (result: Bool) in
                    UserActivityModel().deleteActivity(type: (medicinSelected?.type)!, typeid: (medicinSelected?.typeID)!,  userActivityDate: "", reminderID: (medicinSelected?.reminderID!)!, complition: { (result: Bool) in
                        
                    })
                })
            })
        }else{
            medicinePlan().deleteMedicine(deleteID: (medicinSelected?.identifier)!, complition: { (result: Bool) in
                
                medicinePlan().deleteMedicineReminder(deleteID: (medicinSelected?.identifier)!, complition: { (result: Bool) in
                    UserActivityModel().deleteActivity(type: (medicinSelected?.type)!, typeid: (medicinSelected?.typeID)!,  userActivityDate: "", reminderID: (medicinSelected?.reminderID!)!, complition: { (result: Bool) in
                        
                    })
                })
            })
        }
    }
    
    
    private func insertUpdateMedicineInDB() {
        
        medicinePlanObj = medicinePlan()
        
        medicinePlanObj?.name = name
        if (medicinePlanObj?.name.contains("'"))! {
            medicinePlanObj?.name.replace("'", with: "")
        }
        
        medicinePlanObj?.dose = dose
        medicinePlanObj?.time = startIntakeTime
        
        reminderObj.reminderDate = txtFieldDate.text
        reminderObj.reminderTxt = name
        if (reminderObj.reminderTxt.contains("'")) {
            reminderObj.reminderTxt.replace("'", with: "")
        }
        
        reminderObj.reminderFrequency = strInsertRecurring
        
        if txtEndDate.text?.count == 0 {
            reminderObj.reminderEndDate = dateFormatter.string(from: Date())
        }else{
            reminderObj.reminderEndDate = txtEndDate.text
        }
        
        
        reminderObj.reminderTime = startIntakeTime
        reminderObj.reminderWithNotification = intSwitch
        reminderObj.type = 3
        
        if isBoolUpdate! {
            medicinePlanObj?.identifier = medicinSelected?.identifier
        }
        
        if txtFieldMedicineSchedule.text! == JMOLocalizedString(forKey: Recurring.WeeklyRecurr.rawValue, value: "") {
            reminderObj.reminderWeaklyDay = strinsertFrequency
            medicinePlanObj?.dailyFrequency = 0
            
            insertQuery(completion: {
                cancelNotification(str: strForCancelNotification!, complition: { (Void) in
                    
                    insertIntoReminder(completion: {
                        if switchReminder.isOn {
                            
                            self.getMAxCount(complition: { (count: String) in
                                
                                let hour = getHMS(date: selectedDateTime!).0
                                let minutes = getHMS(date: selectedDateTime!).1
                                
                                setWeeklyMonthlyNotifications(identifire: count, strname: "\(name)", h: hour, m: minutes, s: 0, day: selectedDay!, type: NotificationType.Weekly)
                                
                            })
                        }
                        
                        if isBoolUpdate! {
                            UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey:JMOLocalizedString(forKey: modificationAlert, value: ""), value: ""), completion: { (Int, String) in
                                _ = self.navigationController?.popViewController(animated: true)
                            })
                            
                        }else{
                            UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey: "Addition process done successfully", value: ""), completion: { (Int, String) in
                                _ = self.navigationController?.popViewController(animated: true)
                            })
                        }
                    })
                })
            })
            
        }
        else if txtFieldMedicineSchedule.text! == JMOLocalizedString(forKey: Recurring.MonthlyRecurr.rawValue, value: "") {
            reminderObj.reminderMonthlyDay = txtFrequency.text
            medicinePlanObj?.dailyFrequency = 0
            
            insertQuery(completion: {
                cancelNotification(str: strForCancelNotification!, complition: { (Void) in
                    
                    insertIntoReminder(completion: {
                        if switchReminder.isOn {
                            
                            self.getMAxCount(complition: { (count: String) in
                                
                                let hour = getHMS(date: selectedDateTime!).0
                                let minutes = getHMS(date: selectedDateTime!).1
                                
                                setWeeklyMonthlyNotifications(identifire: count, strname: "\(name)", h: hour, m: minutes, s: 0, day: selectedDay!, type: NotificationType.Monthly)
                                
                            })
                        }
                        
                        if isBoolUpdate! {
                            UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey:JMOLocalizedString(forKey: modificationAlert, value: ""), value: ""), completion: { (Int, String) in
                                _ = self.navigationController?.popViewController(animated: true)
                            })
                            
                        }else{
                            UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey: "Addition process done successfully", value: ""), completion: { (Int, String) in
                                _ = self.navigationController?.popViewController(animated: true)
                            })
                        }
                    })
                })
            })
            
        }
        else if txtFieldMedicineSchedule.text! == JMOLocalizedString(forKey: Recurring.DailyRecurr.rawValue, value: "") {
            
            if JMOLocalizedString(forKey: txtFrequency.text!, value: "").lowercased() == JMOLocalizedString(forKey: Frequency5.Once.rawValue, value: "").lowercased()
            {
                // Once
                
                medicinePlanObj?.dailyFrequency = 1
                insertQuery(completion: {
                    cancelNotification(str: strForCancelNotification!, complition: { (Void) in
                        
                        insertIntoReminder(completion: {
                            if switchReminder.isOn {
                                
                                self.getMAxCount(complition: { (count: String) in
                                    //                                self.setNotificationDailyOnce(identifire: count)
                                    
//                                    let hour = getHMS(date: selectedDateTime!).0
//                                    let minutes = getHMS(date: selectedDateTime!).1
                                    self.dateSelectedFormatter.timeZone = NSTimeZone.local
                                    
                                    
                                    let hour = getHMS(date: self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime.text!):00")!).0
                                    
                                    let minutes = getHMS(date: self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime.text!):00")!).1
                                    
                                    
                                    setNotifications(identifire: count, strname: "\(name)", h: hour, m: minutes, s: 0, type: NotificationType.Daily)
                                    
                                    //                                LocalNotificationHelper.sharedInstance.createReminderNotification(identifire,"\(name)", "\(name)", weekDay: 0, monthDay: 0, hour: hour, minute:minutes , seconds:0 , notificationDate: Date(), NotificationType.OnceOnly)
                                    
                                })
                            }
                            
                            if isBoolUpdate! {
                                UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey:JMOLocalizedString(forKey: modificationAlert, value: ""), value: ""), completion: { (Int, String) in
                                    _ = self.navigationController?.popViewController(animated: true)
                                })
                                
                            }else{
                                UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey: "Addition process done successfully", value: ""), completion: { (Int, String) in
                                    _ = self.navigationController?.popViewController(animated: true)
                                })
                            }
                        })
                    })
                })
                
            }else if JMOLocalizedString(forKey: txtFrequency.text!, value: "").lowercased() == JMOLocalizedString(forKey: Frequency5.Twice.rawValue, value: "").lowercased()
            {
                // Twice
                
                medicinePlanObj?.dailyFrequency = 2
                
                
                insertQuery(completion: {
                    
                    
                    insertIntoReminder(completion: {
//                        strForCancelNotification
                        
                        cancelNotification(str:  "\(medicinSelected?.identifier!)", complition: { (Void) in
                            if switchReminder.isOn {
                                self.getMAxCount(complition: { (count: String) in
                                    //                                self.setNotificationDailyTwice1(identifire: count)
//                                    let hour = getHMS(date: selectedDateTime!).0
                                    let hour = getHMS(date: self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime.text!):00")!).0
                                    
                                    let minutes = getHMS(date: self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime.text!):00")!).1
                                    setNotifications(identifire: count, strname: "\(name)", h: hour, m: minutes, s: 0, type: NotificationType.Daily)
                                })
                            }
                        })
                    })
                    
                    medicinePlanObj?.time = startIntakeTime2
                    reminderObj.reminderTime = startIntakeTime2
                    medicinePlanObj?.identifier = medicinSelected?.identifier2
                    reminderObj.typeID = medicinSelected?.identifier2
                    
                    insertIntoReminder(completion: {
//                        strForCancelNotification
                        
                        cancelNotification(str: "\(medicinSelected?.identifier2)", complition: { (Void) in
                            
                            if switchReminder.isOn {
                                self.getMAxCount(complition: { (count: String) in
                                    //                                self.setNotificationDailyTwice2(identifire: count)
                                    
                                    let hour2 = getHMS(date: self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime2.text!):00")!).0
                                    let minutes2 = getHMS(date: self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime2.text!):00")!).1
                                    
                                    setNotifications(identifire: count, strname: "\(name)", h: hour2, m: minutes2, s: 0, type: NotificationType.Daily)
                                    
                                })
                                
                            }
                            if isBoolUpdate! {
                                UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey:JMOLocalizedString(forKey: modificationAlert, value: ""), value: ""), completion: { (Int, String) in
                                    _ = self.navigationController?.popViewController(animated: true)
                                })
                                
                            }else{
                                UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey: "Addition process done successfully", value: ""), completion: { (Int, String) in
                                    _ = self.navigationController?.popViewController(animated: true)
                                })
                            }
                        })
                    })
                })
                
            }else if JMOLocalizedString(forKey: txtFrequency.text!, value: "").lowercased() == JMOLocalizedString(forKey: Frequency5.Thrice.rawValue, value: "").lowercased()
            {
                // 3 tmes
                
                medicinePlanObj?.dailyFrequency = 3
                insertQuery(completion: {
                    
                    
                    insertIntoReminder(completion: {
                        cancelNotification(str: strForCancelNotification!, complition: { (Void) in
                            if switchReminder.isOn {
                                
                                self.getMAxCount(complition: { (count: String) in
                                    //                                self.setNotificationDailyThrice1(identifire: count)
                                    
//                                    let hour = getHMS(date: selectedDateTime!).0
//                                    let minutes = getHMS(date: selectedDateTime!).1
                                    let hour = getHMS(date: self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime.text!):00")!).0
                                    
                                    let minutes = getHMS(date: self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime.text!):00")!).1
                                    
                                    
                                    setNotifications(identifire: count, strname: "\(name)", h: hour, m: minutes, s: 0, type: NotificationType.Daily)
                                    
                                })
                            }
                        })
                        
                        medicinePlanObj?.time = startIntakeTime2
                        reminderObj.reminderTime = startIntakeTime2
                        medicinePlanObj?.identifier = medicinSelected?.identifier2
                        reminderObj.typeID = medicinSelected?.identifier2
                        
                        insertIntoReminder(completion: {
                            cancelNotification(str: strForCancelNotification!, complition: { (Void) in
                                if switchReminder.isOn {
                                    
                                    self.getMAxCount(complition: { (count: String) in
                                        //                                    self.setNotificationDailyThrice2(identifire: count)
                                        
//                                        let hour = getHMS(date: selectedDateTime2!).0
//                                        let minutes = getHMS(date: selectedDateTime2!).1
                                        
                                        let hour = getHMS(date: self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime2.text!):00")!).0
                                        
                                        let minutes = getHMS(date: self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime2.text!):00")!).1
                                        
                                        
                                        
                                        setNotifications(identifire: count, strname: "\(name)", h: hour, m: minutes, s: 0, type: NotificationType.Daily)
                                        
                                    })
                                }
                            })
                            medicinePlanObj?.time = startIntakeTime3
                            reminderObj.reminderTime = startIntakeTime3
                            medicinePlanObj?.identifier = medicinSelected?.identifier3
                            reminderObj.typeID = medicinSelected?.identifier3
                            
                            insertIntoReminder(completion: {
                                cancelNotification(str: strForCancelNotification!, complition: { (Void) in
                                    if switchReminder.isOn {
                                        
                                        self.getMAxCount(complition: { (count: String) in
                                            //                                        self.setNotificationDailyThrice3(identifire: count)
                                            
//                                            let hour3 = getHMS(date: selectedDateTime3!).0
//                                            let minutes3 = getHMS(date: selectedDateTime3!).1
                                            
                                            let hour3 = getHMS(date: self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime3.text!):00")!).0
                                            
                                            let minutes3 = getHMS(date: self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime3.text!):00")!).1
                                            
                                            setNotifications(identifire: count, strname: "\(name)", h: hour3, m: minutes3, s: 0, type: NotificationType.Daily)
                                            
                                            
                                        })
                                    }
                                    
                                    if isBoolUpdate! {
                                        UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey:JMOLocalizedString(forKey: modificationAlert, value: ""), value: ""), completion: { (Int, String) in
                                            _ = self.navigationController?.popViewController(animated: true)
                                        })
                                        
                                    }else{
                                        UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey: "Addition process done successfully", value: ""), completion: { (Int, String) in
                                            _ = self.navigationController?.popViewController(animated: true)
                                        })
                                    }
                                })
                            })
                        })
                        
                    })
                    
                    
                })
            }else if JMOLocalizedString(forKey: txtFrequency.text!, value: "").lowercased() == JMOLocalizedString(forKey: Frequency5.Hours6.rawValue, value: "").lowercased()
            {
                
                
                // 4
                
                medicinePlanObj?.dailyFrequency = 4
                insertQuery(completion: {
                    
                    
                    insertIntoReminder(completion: {
                        cancelNotification(str: strForCancelNotification!, complition: { (Void) in
                            if switchReminder.isOn {
                                
                                self.getMAxCount(complition: { (count: String) in
                                    //                                self.setNotificationDailyThrice1(identifire: count)
                                    
//                                    let hour = getHMS(date: selectedDateTime!).0
//                                    let minutes = getHMS(date: selectedDateTime!).1
                                    
                                    let hour = getHMS(date: self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime.text!):00")!).0
                                    
                                    let minutes = getHMS(date: self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime.text!):00")!).1
                                    
                                    
                                    setNotifications(identifire: count, strname: "\(name)", h: hour, m: minutes, s: 0, type: NotificationType.Daily)
                                    
                                })
                            }
                        })
                        
                        medicinePlanObj?.time = startIntakeTime2
                        reminderObj.reminderTime = startIntakeTime2
                        medicinePlanObj?.identifier = medicinSelected?.identifier2
                        reminderObj.typeID = medicinSelected?.identifier2
                        
                        insertIntoReminder(completion: {
                            cancelNotification(str: strForCancelNotification!, complition: { (Void) in
                                if switchReminder.isOn {
                                    
                                    self.getMAxCount(complition: { (count: String) in
                                        //                                    self.setNotificationDailyThrice2(identifire: count)
//                                        let hour = getHMS(date: selectedDateTime2!).0
//                                        let minutes = getHMS(date: selectedDateTime2!).1
                                        
                                        let hour = getHMS(date: self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime2.text!):00")!).0
                                        
                                        let minutes = getHMS(date: self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime2.text!):00")!).1
                                        
                                        
                                        setNotifications(identifire: count, strname: "\(name)", h: hour, m: minutes, s: 0, type: NotificationType.Daily)
                                        
                                    })
                                }
                                
                            })
                            
                            
                            medicinePlanObj?.time = startIntakeTime3
                            reminderObj.reminderTime = startIntakeTime3
                            medicinePlanObj?.identifier = medicinSelected?.identifier3
                            reminderObj.typeID = medicinSelected?.identifier3
                            
                            insertIntoReminder(completion: {
                                cancelNotification(str: strForCancelNotification!, complition: { (Void) in
                                    if switchReminder.isOn {
                                        
                                        self.getMAxCount(complition: { (count: String) in
                                            //                                        self.setNotificationDailyThrice3(identifire: count)
                                            
                                            
                                            
//                                            let hour3 = getHMS(date: selectedDateTime3!).0
//                                            let minutes3 = getHMS(date: selectedDateTime3!).1
                                            
                                            let hour3 = getHMS(date: self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime3.text!):00")!).0
                                            
                                            let minutes3 = getHMS(date: self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime3.text!):00")!).1
                                            
                                            setNotifications(identifire: count, strname: "\(name)", h: hour3, m: minutes3, s: 0, type: NotificationType.Daily)
                                            
                                        })
                                    }
                                })
                                
                                
                                medicinePlanObj?.time = self.txtStartIntakeTime4.text
                                reminderObj.reminderTime = self.txtStartIntakeTime4.text
                                medicinePlanObj?.identifier = medicinSelected?.identifier4
                                reminderObj.typeID = medicinSelected?.identifier4
                                
                                insertIntoReminder(completion: {
                                    cancelNotification(str: strForCancelNotification!, complition: { (Void) in
                                        if switchReminder.isOn {
                                            
                                            self.getMAxCount(complition: { (count: String) in
                                                //                                            self.setNotificationDailyThrice3(identifire: count)
//                                                let hour4 = getHMS(date: selectedDateTime4!).0
//                                                let minutes4 = getHMS(date: selectedDateTime4!).1
                                                
                                                let hour4 = getHMS(date: self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime4.text!):00")!).0
                                                
                                                let minutes4 = getHMS(date: self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime4.text!):00")!).1
                                                
                                                
                                                setNotifications(identifire: count, strname: "\(name)", h: hour4, m: minutes4, s: 0, type: NotificationType.Daily)
                                                
                                            })
                                        }
                                        
                                        if isBoolUpdate! {
                                            UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey:JMOLocalizedString(forKey: modificationAlert, value: ""), value: ""), completion: { (Int, String) in
                                                _ = self.navigationController?.popViewController(animated: true)
                                            })
                                            
                                        }else{
                                            UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey: "Addition process done successfully", value: ""), completion: { (Int, String) in
                                                _ = self.navigationController?.popViewController(animated: true)
                                            })
                                        }
                                    })
                                })
                                
                            })
                        })
                        
                    })
                })
                
                
                
            }else if JMOLocalizedString(forKey: txtFrequency.text!, value: "").lowercased() == JMOLocalizedString(forKey: Frequency5.Hours4.rawValue, value: "").lowercased()
            {
                
                //6
                
                medicinePlanObj?.dailyFrequency = 5
                insertQuery(completion: {
                    
                    
                    insertIntoReminder(completion: {
                        cancelNotification(str: strForCancelNotification!, complition: { (Void) in
                            if switchReminder.isOn {
                                
                                self.getMAxCount(complition: { (count: String) in
                                    //                                self.setNotificationDailyThrice1(identifire: count)
                                    
                                    
//                                    let hour = getHMS(date: selectedDateTime!).0
//                                    let minutes = getHMS(date: selectedDateTime!).1
                                    
                                    let hour = getHMS(date: self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime.text!):00")!).0
                                    
                                    let minutes = getHMS(date: self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime.text!):00")!).1
                                    
                                    
                                    setNotifications(identifire: count, strname: "\(name)", h: hour, m: minutes, s: 0, type: NotificationType.Daily)
                                    
                                    
                                    
                                })
                            }
                        })
                        
                        medicinePlanObj?.time = startIntakeTime2
                        reminderObj.reminderTime = startIntakeTime2
                        medicinePlanObj?.identifier = medicinSelected?.identifier2
                        reminderObj.typeID = medicinSelected?.identifier2
                        
                        insertIntoReminder(completion: {
                            cancelNotification(str: strForCancelNotification!, complition: { (Void) in
                                if switchReminder.isOn {
                                    
                                    self.getMAxCount(complition: { (count: String) in
                                        //                                    self.setNotificationDailyThrice2(identifire: count)
                                        
//                                        let hour = getHMS(date: selectedDateTime2!).0
//                                        let minutes = getHMS(date: selectedDateTime2!).1
                                        
                                        let hour = getHMS(date: self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime2.text!):00")!).0
                                        
                                        let minutes = getHMS(date: self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime2.text!):00")!).1
                                        
                                        setNotifications(identifire: count, strname: "\(name)", h: hour, m: minutes, s: 0, type: NotificationType.Daily)
                                        
                                    })
                                }
                                
                            })
                            
                            
                            medicinePlanObj?.time = startIntakeTime3
                            reminderObj.reminderTime = startIntakeTime3
                            medicinePlanObj?.identifier = medicinSelected?.identifier3
                            reminderObj.typeID = medicinSelected?.identifier3
                            
                            insertIntoReminder(completion: {
                                cancelNotification(str: strForCancelNotification!, complition: { (Void) in
                                    if switchReminder.isOn {
                                        
                                        self.getMAxCount(complition: { (count: String) in
                                            //                                        self.setNotificationDailyThrice3(identifire: count)
                                            
//                                            let hour3 = getHMS(date: selectedDateTime3!).0
//                                            let minutes3 = getHMS(date: selectedDateTime3!).1
                                            
                                            let hour3 = getHMS(date: self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime3.text!):00")!).0
                                            
                                            let minutes3 = getHMS(date: self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime3.text!):00")!).1
                                            
                                            
                                            setNotifications(identifire: count, strname: "\(name)", h: hour3, m: minutes3, s: 0, type: NotificationType.Daily)
                                            
                                        })
                                    }
                                })
                                
                                
                                medicinePlanObj?.time = self.txtStartIntakeTime4.text
                                reminderObj.reminderTime = self.txtStartIntakeTime4.text
                                medicinePlanObj?.identifier = medicinSelected?.identifier4
                                reminderObj.typeID = medicinSelected?.identifier4
                                
                                insertIntoReminder(completion: {
                                    cancelNotification(str: strForCancelNotification!, complition: { (Void) in
                                        if switchReminder.isOn {
                                            
                                            self.getMAxCount(complition: { (count: String) in
                                                //                                            self.setNotificationDailyThrice3(identifire: count)
                                                
//                                                let hour4 = getHMS(date: selectedDateTime4!).0
//                                                let minutes4 = getHMS(date: selectedDateTime4!).1
                                                
                                                let hour4 = getHMS(date: self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime4.text!):00")!).0
                                                
                                                let minutes4 = getHMS(date: self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime4.text!):00")!).1
                                                
                                                
                                                setNotifications(identifire: count, strname: "\(name)", h: hour4, m: minutes4, s: 0, type: NotificationType.Daily)
                                            })
                                        }
                                        
                                        medicinePlanObj?.time = self.txtStartIntakeTime5.text
                                        reminderObj.reminderTime = self.txtStartIntakeTime5.text
                                        medicinePlanObj?.identifier = medicinSelected?.identifier5
                                        reminderObj.typeID = medicinSelected?.identifier5
                                        insertIntoReminder(completion: {
                                            cancelNotification(str: strForCancelNotification!, complition: { (Void) in
                                                if switchReminder.isOn {
                                                    
                                                    self.getMAxCount(complition: { (count: String) in
                                                        //                                            self.setNotificationDailyThrice3(identifire: count)
                                                        
//                                                        let hour5 = getHMS(date: selectedDateTime5!).0
//                                                        let minutes5 = getHMS(date: selectedDateTime5!).1
                                                        
                                                        let hour5 = getHMS(date: self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime5.text!):00")!).0
                                                        
                                                        let minutes5 = getHMS(date: self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime5.text!):00")!).1
                                                
                                                        
                                                        
                                                        setNotifications(identifire: count, strname: "\(name)", h: hour5, m: minutes5, s: 0, type: NotificationType.Daily)
                                                    })
                                                }
                                                
                                                medicinePlanObj?.time = self.txtStartIntakeTime6.text
                                                reminderObj.reminderTime = self.txtStartIntakeTime6.text
                                                medicinePlanObj?.identifier = medicinSelected?.identifier6
                                                reminderObj.typeID = medicinSelected?.identifier6
                                                insertIntoReminder(completion: {
                                                    cancelNotification(str: strForCancelNotification!, complition: { (Void) in
                                                        if switchReminder.isOn {
                                                            
                                                            self.getMAxCount(complition: { (count: String) in
                                                                //                                            self.setNotificationDailyThrice3(identifire: count)
                                                                
//                                                                let hour6 = getHMS(date: selectedDateTime6!).0
//                                                                let minutes6 = getHMS(date: selectedDateTime6!).1
                                                                
                                                                let hour6 = getHMS(date: self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime6.text!):00")!).0
                                                                
                                                                let minutes6 = getHMS(date: self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime6.text!):00")!).1
                                                
                                                                
                                                                
                                                                setNotifications(identifire: count, strname: "\(name)", h: hour6, m: minutes6, s: 0, type: NotificationType.Daily)
                                                            })
                                                        }
                                                        
                                                        if isBoolUpdate! {
                                                            UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey:JMOLocalizedString(forKey: modificationAlert, value: ""), value: ""), completion: { (Int, String) in
                                                                _ = self.navigationController?.popViewController(animated: true)
                                                            })
                                                            
                                                        }else{
                                                            UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey: "Addition process done successfully", value: ""), completion: { (Int, String) in
                                                                _ = self.navigationController?.popViewController(animated: true)
                                                            })
                                                        }
                                                    })
                                                })
                                            })
                                        })
                                    })
                                })
                                
                            })
                        })
                        
                    })
                })
            }
        }
        
    }
    
    
    func insertIntoReminder(completion: (() -> Void)){
        
        if txtFieldMedicineSchedule.text! == JMOLocalizedString(forKey: Recurring.WeeklyRecurr.rawValue, value: "") {
            
            self.reminderObj.reminderWeaklyDay = txtFrequency.text
        }
        
        medicinePlan().inertIntoReminder(objMedicine: medicinePlanObj!, aObjReminder: reminderObj, flageUpdate: false) { (result: Bool) in
            print(result)
            
            if !isBoolUpdate! {
                strForCancelNotification = "0"
            }
            
            if switchReminder.isOn {
                
            }else{
                cancelNotification(str: strForCancelNotification!, complition: { (Void) in
                    
                })
            }
            completion()
        }
    }
    func insertQuery(completion: (() -> Void)) {
        if txtFieldMedicineSchedule.text! == JMOLocalizedString(forKey: Recurring.WeeklyRecurr.rawValue, value: "") {

                    self.reminderObj.reminderWeaklyDay = txtFrequency.text
        }

        
        medicinePlan().insertMedicine(objMedicine: medicinePlanObj!, aObjReminder: reminderObj, flageUpdate: false) { (result: Bool) in
            print(result)
            if !isBoolUpdate! {
                strForCancelNotification = "0"
            }
            completion()
        }
    }
    
    
    /// Get hours, minutes, seconds
    ///
    /// - Parameter date: Selected date
    /// - Returns: Hours, minutes, seconds
    func getHMS(date: Date) -> (Int, Int, Int) {
        
        let date = date
        let calendar = Calendar.current
        
        let h = calendar.component(.hour, from: date)
        let m = calendar.component(.minute, from: date)
        let s = calendar.component(.second, from: date)
        print("hours = \(h):\(m):\(s)")
        
        return (h, m, s)
    }
    
    
    /// Set local notifications
    
    
//    private func setNotificationDailyOnce(identifire: String) {
//        
//        if AppDelegate().appDelegateShared().isReminderOn {
//            let hour = getHMS(date: selectedDateTime!).0
//            let minutes = getHMS(date: selectedDateTime!).1
//            print("set notification = \(identifire)")
//            
//            LocalNotificationHelper.sharedInstance.createReminderNotification(identifire,"\(name)", "\(name)", weekDay: 0, monthDay: 0, hour: hour, minute:minutes , seconds:0 , notificationDate: Date(), NotificationType.Hourly)
//        }
//    }
    
    func setNotifications(identifire: String, strname: String, h:Int, m: Int, s: Int, type: NotificationType) {
        
        print("identifire ==\(identifire)")
        
//        if AppDelegate().appDelegateShared().isReminderOn {
            if appDelegate.isReminderOn {
            LocalNotificationHelper.sharedInstance.createReminderNotification(identifire,"\(strname)", "\(strname)", weekDay: 0, monthDay: 0, hour: h, minute:m, seconds: s, notificationDate: Date(), NotificationType(rawValue: type.rawValue)!)
        }
        
    }
    
    
    func setWeeklyMonthlyNotifications(identifire: String, strname: String, h:Int, m: Int, s: Int,day: Int, type: NotificationType) -> Void {
        print("identifire ==\(identifire)")
        
        if AppDelegate().appDelegateShared().isReminderOn {
            if type.rawValue == NotificationType.Weekly.rawValue {
                LocalNotificationHelper.sharedInstance.createReminderNotification(identifire,"\(strname)", "\(strname)", weekDay: day, monthDay: 0, hour: h, minute:m, seconds: s, notificationDate: Date(), NotificationType(rawValue: type.rawValue)!)
            }else if type.rawValue == NotificationType.Monthly.rawValue {
                LocalNotificationHelper.sharedInstance.createReminderNotification(identifire,"\(strname)", "\(strname)", weekDay: 0, monthDay: day, hour: h, minute:m, seconds: s, notificationDate: Date(), NotificationType(rawValue: type.rawValue)!)
            }
        }
    }
    
    //    private func setNotificationDailyThrice1(identifire: String) {
    //        let hour = getHMS(date: selectedDateTime!).0
    //        let minutes = getHMS(date: selectedDateTime!).1
    //
    //        print("set notification = \(identifire)")
    //        LocalNotificationHelper.sharedInstance.createReminderNotification(identifire,"\(name)", "\(name)", weekDay: 0, monthDay: 0, hour: hour, minute:minutes, seconds: 0, notificationDate: Date(), NotificationType.Hourly)
    //
    //
    //    }
    
    //    private func setNotificationDailyThrice2(identifire: String) {
    //        let hour = getHMS(date: selectedDateTime2!).0
    //        let minutes = getHMS(date: selectedDateTime2!).1
    //        print("set notification = \(identifire)")
    //        LocalNotificationHelper.sharedInstance.createReminderNotification(identifire,"\(name)", "\(name)" , weekDay: 0, monthDay: 0, hour: hour, minute: minutes, seconds: 0, notificationDate: Date(), NotificationType.Hourly)
    //
    //    }
    
    //    private func setNotificationDailyThrice3(identifire: String) {
    //        let hour3 = getHMS(date: selectedDateTime3!).0
    //        let minutes3 = getHMS(date: selectedDateTime3!).1
    //        print("set notification = \(identifire)")
    //        LocalNotificationHelper.sharedInstance.createReminderNotification(identifire,"\(name)", "\(name)", weekDay: 0, monthDay: 0, hour: hour3, minute:minutes3, seconds: 0, notificationDate: Date(), NotificationType.Hourly)
    //    }
    
    //    private func setNotificationDailyWeekly(identifire: String) {
    //        let hour = getHMS(date: selectedDateTime!).0
    //        let minutes = getHMS(date: selectedDateTime!).1
    //        let seconds = getHMS(date: selectedDateTime!).2
    //        print("set notification = \(identifire)")
    //        LocalNotificationHelper.sharedInstance.createReminderNotification(identifire,"\(name)", "\(name)", weekDay: selectedDay!, monthDay: 0, hour: hour, minute: minutes, seconds: seconds, notificationDate: Date(), NotificationType.Weekly)
    //    }
    //
    //    private func setNotificationDailyMonthly(identifire: String) {
    //
    //        let hour = getHMS(date: selectedDateTime!).0
    //        let minutes = getHMS(date: selectedDateTime!).1
    //        let seconds = getHMS(date: selectedDateTime!).2
    //        print("set notification = \(identifire)")
    //        LocalNotificationHelper.sharedInstance.createReminderNotification(identifire,"\(name)", "\(name)", weekDay: 0, monthDay: selectedDay!, hour: hour, minute: minutes, seconds: seconds, notificationDate: Date(), NotificationType.Monthly)
    //    }
    //
    //    private func setNotificationNormal(identifire: String) {
    //        let hour = getHMS(date: selectedDateTime!).0
    //        let minutes = getHMS(date: selectedDateTime!).1
    //        print("set notification = \(identifire)")
    //        LocalNotificationHelper.sharedInstance.createReminderNotification(identifire,"\(name)", "\(name)", weekDay: 0, monthDay: 0, hour: hour, minute: minutes, seconds: 0, notificationDate:Date(), NotificationType.OnceOnly)
    //    }
    //
    //    private func setNotificationDailyHours4(identifire: String) {
    //        let hour = getHMS(date: selectedDateTime!).0
    //        let minutes = getHMS(date: selectedDateTime!).1
    //        print("set notification = \(identifire)")
    //
    //        LocalNotificationHelper.sharedInstance.createReminderNotification(identifire,"\(name)", "\(name)", weekDay: 0, monthDay: 0, hour: hour, minute:minutes, seconds: 0, notificationDate: Date(), NotificationType.Hourly)
    //    }
    //
    //    private func setNotificationDailyHours6(identifire: String) {
    //        let hour = getHMS(date: selectedDateTime!).0
    //        let minutes = getHMS(date: selectedDateTime!).1
    //        print("set notification = \(identifire)")
    //
    //        LocalNotificationHelper.sharedInstance.createReminderNotification(identifire,"\(name)", "\(name)", weekDay: 0, monthDay: 0, hour: hour, minute:minutes, seconds: 0, notificationDate: Date(), NotificationType.Hourly)
    //    }
    private func getMAxCount(complition: ((String)  -> Void)) {
        medicinePlan().getMaxCount(complitionCount: { (count: String) in
            
            complition(count)
        })
    }
    
    /// Cacel local notification using task name
    ///
    /// - Parameters:
    ///   - str: Notification task name
    ///   - complition: complition call after remove local notification
    func cancelNotification(str: String, complition: ((Void)-> Void)) {
        print("Cancel notification - \(str)")
        //        LocalNotificationHelper.sharedInstance.removeNotification([str])
        if (str != nil) || (str != "nil"){
        
            LocalNotificationHelper.sharedInstance.removeNotification([str]) { (status) in
                
            }
        }

    }
    
    
    
    private func timeCalculation(howManyTimes: Int) -> [String]{
        
        var starttime  = Date();
        
        if intTagTime == 100 {
            starttime = selectedDateTime!
        }
        
        let howManyTime  = howManyTimes;
        //        var listOfTime = Array<Date>();
        var listOfTime = [String]();
        listOfTime.append(timeFormatter.string(from: starttime))
        
        var index = 1;
        
        while (index < howManyTime)
        {
            let numberOfHours = 24/howManyTime;
            print(numberOfHours)
            let x:Double = 60.0*60.0*Double(numberOfHours)
            starttime.addTimeInterval(x)
            listOfTime.append(timeFormatter.string(from: starttime))
            index = index + 1
            print(starttime)
            print(listOfTime)
        }
        
        return listOfTime
    }
    
    
    func timeCalculationWhenFirstTimeSelected() {
        
        if JMOLocalizedString(forKey: self.txtFrequency.text!, value: "").lowercased() == JMOLocalizedString(forKey: Frequency5.Once.rawValue, value: "").lowercased() {
            
            var timeCalculation = self.timeCalculation(howManyTimes: 1)
            self.txtStartIntakeTime.text = timeCalculation[0]
            self.selectedDateTime  =  self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime.text!):00")
            
        }else if JMOLocalizedString(forKey: self.txtFrequency.text!, value: "").lowercased() == JMOLocalizedString(forKey: Frequency5.Twice.rawValue, value: "").lowercased() {
            
            var timeCalculation1 = self.timeCalculation(howManyTimes: 2)
            self.txtStartIntakeTime.text = timeCalculation1[0]
            self.txtStartIntakeTime2.text = timeCalculation1[1]
            
            self.selectedDateTime  =  self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime.text!):00")
            self.selectedDateTime2  =  self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime2.text!):00")
            
        }else if JMOLocalizedString(forKey: self.txtFrequency.text!, value: "").lowercased() == JMOLocalizedString(forKey: Frequency5.Thrice.rawValue, value: "").lowercased() {
            
            var timeCalculation3 = self.timeCalculation(howManyTimes: 3)
            self.txtStartIntakeTime.text = timeCalculation3[0]
            self.txtStartIntakeTime2.text = timeCalculation3[1]
            self.txtStartIntakeTime3.text = timeCalculation3[2]
            
            self.selectedDateTime  =  self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime.text!):00")
            self.selectedDateTime2  =  self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime2.text!):00")
            self.selectedDateTime3  =  self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime3.text!):00")
            
            
        }else if JMOLocalizedString(forKey: self.txtFrequency.text!, value: "").lowercased() == JMOLocalizedString(forKey: Frequency5.Hours6.rawValue, value: "").lowercased() {
            var timeCalculation4 = self.timeCalculation(howManyTimes: 4)
            self.txtStartIntakeTime.text = timeCalculation4[0]
            self.txtStartIntakeTime2.text = timeCalculation4[1]
            self.txtStartIntakeTime3.text = timeCalculation4[2]
            self.txtStartIntakeTime4.text = timeCalculation4[3]
            
            self.selectedDateTime  =  self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime.text!):00")
            self.selectedDateTime2  =  self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime2.text!):00")
            self.selectedDateTime3  =  self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime3.text!):00")
            self.selectedDateTime4  =  self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime4.text!):00")
            
        }else if JMOLocalizedString(forKey: self.txtFrequency.text!, value: "").lowercased() == JMOLocalizedString(forKey: Frequency5.Hours4.rawValue, value: "").lowercased() {
            
            var timeCalculation4 = self.timeCalculation(howManyTimes: 6)
            self.txtStartIntakeTime.text = timeCalculation4[0]
            self.txtStartIntakeTime2.text = timeCalculation4[1]
            self.txtStartIntakeTime3.text = timeCalculation4[2]
            self.txtStartIntakeTime4.text = timeCalculation4[3]
            self.txtStartIntakeTime5.text = timeCalculation4[4]
            self.txtStartIntakeTime6.text = timeCalculation4[5]
            
            self.selectedDateTime  =  self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime.text!):00")
            self.selectedDateTime2  =  self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime2.text!):00")
            self.selectedDateTime3  =  self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime3.text!):00")
            self.selectedDateTime4  =  self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime4.text!):00")
            self.selectedDateTime5  =  self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime5.text!):00")
            self.selectedDateTime6  =  self.dateSelectedFormatter.date(from: "2000-12-31 \(self.txtStartIntakeTime6.text!):00")
        }
        
    }
    
    //MARK: MMDatePickerDelegate
    
    /// Date picker delegate Done event
    ///
    /// - Parameters:
    ///   - amDatePicker: Picker object
    ///   - date: Selected date
    func mmDatePicker(_ amDatePicker: MMDatePicker, didSelect date: Date) {
        
        selectedDate = date
        
        if isBooltime {
            
            if intTagTime == 100 {
                self.selectedDateTime = date
                
                self.setTimeOnButton(dat: date, txtField: self.txtStartIntakeTime)
                
                timeCalculationWhenFirstTimeSelected()
                
            }else if intTagTime == 101 {
                
                self.selectedDateTime2 = date
                
                self.setTimeOnButton(dat: date, txtField: self.txtStartIntakeTime2)
                
                //                timeCalculationWhenFirstTimeSelected()
                
            }else if intTagTime == 102 {
                
                //                self.selectedDateTime2 = date
                self.selectedDateTime3 = date
                self.setTimeOnButton(dat: date, txtField: self.txtStartIntakeTime3)
                
                //                timeCalculationWhenFirstTimeSelected()
                
            }else if intTagTime == 103 {
                // 4th Startintake time
                
                self.selectedDateTime4 = selectedDate
                
                self.setTimeOnButton(dat:date, txtField: self.txtStartIntakeTime4)
                
                //                timeCalculationWhenFirstTimeSelected()
                
            }else if intTagTime == 104 {
                // 5th Startintake time
                
                self.selectedDateTime5 = selectedDate
                
                self.setTimeOnButton(dat: date, txtField: self.txtStartIntakeTime5)
                
                //                timeCalculationWhenFirstTimeSelected()
                
            }else if intTagTime == 105 {
                // 6th Startintake time
                
                self.selectedDateTime6 = selectedDate
                
                self.setTimeOnButton(dat: date, txtField: self.txtStartIntakeTime6)
                
                //                timeCalculationWhenFirstTimeSelected()
                
            }
        }else{
            
            if isBoolEndDate {
                isBoolEndDate = false
                setDateOnButton(dat: date, txtField: txtEndDate)
            }else{
                setDateOnButton(dat: date, txtField: txtFieldDate)
            }
            
        }
    }
    
    
    /// Date picker cancel delegate
    ///
    /// - Parameter amDatePicker: Picker object
    func mmDatePickerDidCancelSelection(_ amDatePicker: MMDatePicker) {
        // NOP
        
        isBoolEndDate = false
    }
    
    //MARK: UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        if textField == txtFieldName {
            if (textField.text?.count)! <= kSetChar256  {
                let newLength = (textField.text?.count)! + string.count - range.length
                return newLength <= kSetChar256
            }
        }else if textField == txtFieldDose {
            if (textField.text?.count)! <= kSetChar128  {
                let newLength = (textField.text?.count)! + string.count - range.length
                return newLength <= kSetChar128
            }
        }else{
            return false
        }
        return true
    }
    
    func setDayForWeeklyReminder () {
        switch JMOLocalizedString(forKey: txtFrequency.text!, value: "") {
        case JMOLocalizedString(forKey: aRRWeekDay[1], value: ""):
            self.selectedDay = WeekDay.Sunday.rawValue
        case JMOLocalizedString(forKey: aRRWeekDay[2], value: ""):
            self.selectedDay = WeekDay.Monday.rawValue
        case JMOLocalizedString(forKey: aRRWeekDay[3], value: ""):
            self.selectedDay = WeekDay.Tuesday.rawValue
        case JMOLocalizedString(forKey: aRRWeekDay[4], value: ""):
            self.selectedDay = WeekDay.Wednesday.rawValue
        case JMOLocalizedString(forKey: aRRWeekDay[5], value: ""):
            self.selectedDay = WeekDay.Thursday.rawValue
        case JMOLocalizedString(forKey: aRRWeekDay[6], value: ""):
            self.selectedDay = WeekDay.Friday.rawValue
        case JMOLocalizedString(forKey: aRRWeekDay[7], value: ""):
            self.selectedDay = WeekDay.Saturday.rawValue
        default :
            print("")
        }
    }
}

