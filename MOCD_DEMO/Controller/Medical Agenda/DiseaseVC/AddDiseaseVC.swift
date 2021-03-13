//
//  AddDiseaseVC.swift
//  SmartAgenda
//
//  Created by indianic on 30/01/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit

class AddDiseaseVC: UIViewController, MMDatePickerDelegate,UITextFieldDelegate {
    
    // Variables
    var diseaseSelected: DiseasesReminderModel?
    var isBoolEdit: Bool?
    var aRRmutFrequency = [String]()
    var objDisease = DiseaseModel()
    var reminderObj = ReminderModel()
    var name = String()
    var intSwitch: Int?
    var isBoolUpdate: Bool?
    var strForCancelNotification: String?
    var intTagTime: Int!
    var timeFormatter = DateFormatter()
    var datePicker = MMDatePicker.getFromNib()
    var dateSelectedFormatter = DateFormatter()
    var selectedDateTime: Date?
    var selectedDateTime2: Date?
    var selectedDateTime3: Date?
    
    @IBOutlet var lblScreenTitle: UILabel!
    
    
    //MARK: IBOutlets
    
    @IBOutlet var btnSave: UIButton!
    
    @IBOutlet var txtDiseaseName: UITextField!
    @IBOutlet var txtFrequency: UITextField!
    @IBOutlet var txtTime1: UITextField!
    @IBOutlet var txtTime2: UITextField!
    @IBOutlet var txtTime3: UITextField!
    
    @IBOutlet var lblReminder: UILabel!
    
    @IBOutlet var btnBackEN: UIButton!
    @IBOutlet var switchReminder: UISwitch!
    
    @IBOutlet var scrlView: TPKeyboardAvoidingScrollView!
    
    @IBOutlet var heightConstraints: [NSLayoutConstraint]!
    
    private let dayFormatterYYYYDDMM: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    //MARK: ViewController Methods
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        aRRmutFrequency = [JMOLocalizedString(forKey: "Frequency", value: ""), JMOLocalizedString(forKey: "Once a day", value: ""), JMOLocalizedString(forKey: "Twice a day", value: ""), JMOLocalizedString(forKey: "3 Times a day", value: "")]
        
//        aRRmutFrequency = [JMOLocalizedString(forKey: "Once a day", value: ""), JMOLocalizedString(forKey: "Twice a day", value: ""), JMOLocalizedString(forKey: "3 Times a day", value: "")]
        
        
        if AppConstants.isArabic()
        {
            btnBackEN.imageView?.transform = (btnBackEN.imageView?.transform.rotated(by: CGFloat(M_PI)))!
        }else{
            btnBackEN.imageView?.transform = (btnBackEN.imageView?.transform.rotated(by: CGFloat(M_PI*2)))!
        }
        
        txtDiseaseName.delegate = self
        self.txtFrequency.placeholder = JMOLocalizedString(forKey: "Frequency*", value: "")
        setupDatePicker()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // To set UI according to language selection
        LanguageManager().localizeThingsInView(parentView: self.view)
        
        if GeneralConstants.DeviceType.IS_IPAD {
            customizeFonts(in: txtDiseaseName, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtFrequency, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtTime1, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtTime2, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtTime3, aFontName: Medium, aFontSize: 0)
            
        }else{
            customizeFonts(in: txtDiseaseName, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtFrequency, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtTime1, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtTime2, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtTime3, aFontName: Medium, aFontSize: 0)
        }
        
        
        
        // Set intitial height constraints to 0
        for const in heightConstraints {
            const.constant = 0
        }
        
        setDataForEdit()
        
        setPadding()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: IBActions Events
    
    @IBAction func btnBackClick(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func btnFrequencyClick(_ sender: UIButton) {
        
        openPicker(array: aRRmutFrequency, sender: sender, completion: { (selectedObject , selectedIndex , isCancel) in
            
            self.txtTime1.text = ""
            self.txtTime2.text = ""
            self.txtTime3.text = ""
            
            if !isCancel {
                self.txtFrequency.text = selectedObject as? String
                
                if ((selectedObject as? String) == JMOLocalizedString(forKey: "Frequency", value: "")){
                    self.txtFrequency.text = ""
                self.txtFrequency.placeholder = JMOLocalizedString(forKey: "Frequency*", value: "")
                }
                
                if JMOLocalizedString(forKey: self.txtFrequency.text!, value: "").lowercased() == JMOLocalizedString(forKey: Frequency.Once.rawValue, value: "").lowercased() {
                    
                    self.setHeightConstraints(const: self.heightConstraints[0], height: 50)
                    self.setHeightConstraints(const: self.heightConstraints[1], height: 0)
                    self.setHeightConstraints(const: self.heightConstraints[2], height: 0)
                    
                    self.txtTime2.text = ""
                    self.txtTime3.text = ""
                    
                }else if JMOLocalizedString(forKey: self.txtFrequency.text!, value: "").lowercased() == JMOLocalizedString(forKey: Frequency.Twice.rawValue, value: "").lowercased() {
                    
                    self.txtTime3.text = ""
                    
                    self.setHeightConstraints(const: self.heightConstraints[0], height: 50)
                    self.setHeightConstraints(const: self.heightConstraints[1], height: 50)
                    self.setHeightConstraints(const: self.heightConstraints[2], height: 0)
                    
                    
                }else if JMOLocalizedString(forKey: self.txtFrequency.text!, value: "").lowercased() == JMOLocalizedString(forKey: Frequency.Thrice.rawValue, value: "").lowercased() {
                    
                    self.setHeightConstraints(const: self.heightConstraints[0], height: 50)
                    self.setHeightConstraints(const: self.heightConstraints[1], height: 50)
                    self.setHeightConstraints(const: self.heightConstraints[2], height: 50)
                    
                }
            }
        })
    }
    
    @IBAction func btnSaveAndUpdate(_ sender: UIButton) {
        
        
        name = GeneralConstants.trimmingString(txtDiseaseName.text!)
        objDisease.disease_isbyuser = 0
        objDisease.disease_title = name
        if objDisease.disease_title.contains("'") {
            objDisease.disease_title.replace("'", with: "")
        }
        
//        reminderObj.reminderDate = ""
        
        reminderObj.reminderTxt = name
        if reminderObj.reminderTxt.contains("'") {
            reminderObj.reminderTxt.replace("'", with: "")
        }
        reminderObj.reminderFrequency = ""
        reminderObj.reminderTime = ""
        
        if switchReminder.isOn {
            reminderObj.reminderWithNotification = 1
        }else{
            reminderObj.reminderWithNotification = 0
        }
        
        reminderObj.reminderWeaklyDay = ""
        reminderObj.reminderMonthlyDay = ""
        reminderObj.reminderEndDate = ""
        reminderObj.type = 1
        reminderObj.reminderFrequency = "Daily"
        
        
        //if isBoolUpdate! {
          //  deleteDisease()
        //}

        
        // Check length for name
        if GeneralConstants.trimming(name) {
            
            if switchReminder.isOn {
                
                if txtFrequency.text != "" {
                    
                    checkTimeAndFrequency { aStatus in
                        if aStatus == false{
                            showAlert(message: JMOLocalizedString(forKey: kReminderOn, value: ""))
                        }
                        
                    }
                    
                }else{
                    showAlert(message: JMOLocalizedString(forKey: kReminderOn, value: ""))
                }
                
            }else{
                
                if txtFrequency.text != "" {
                
                    // None
                    checkTimeAndFrequency { aStatus in
                        
                        objDisease.disease_schedule = "0"
                        
                        if (aStatus == true){
                            if isBoolUpdate! {
                                deleteDisease()
                            }
                            
                            insert(completion: {
                                self.popViewCnrtl()
                            })
                        }
                        
                    }
                }else{
                    showAlert(message: JMOLocalizedString(forKey: kReminderOn, value: ""))
                }
                
            }
        }
        else{
            // name is incorrect
            showAlert(message: JMOLocalizedString(forKey: kReminderOn, value: ""))
        }
        
        
    }
    
    
    private func checkTimeWhenSwitchOn() -> (Bool, Bool, Bool)
    {
        if JMOLocalizedString(forKey: txtFrequency.text!, value: "").lowercased() == JMOLocalizedString(forKey: Frequency.Once.rawValue, value: "").lowercased() {
            // Once
            
            if (txtTime1.text?.count)! > 0 {
                return(true, false, false)
            }else{
                return(false, false, false)
            }
            
        }else if JMOLocalizedString(forKey: txtFrequency.text!, value: "").lowercased() == JMOLocalizedString(forKey: Frequency.Twice.rawValue, value: "").lowercased() {
            // Twice
            
            
            if (txtTime1.text?.count)! > 0 {
                if (txtTime2.text?.count)! > 0 {
                    return(false, true, false)
                }else{
                    return(false, false, false)
                }
            }else{
                return(false, false, false)
            }
            
            
        }else if JMOLocalizedString(forKey: txtFrequency.text!, value: "").lowercased() == JMOLocalizedString(forKey: Frequency.Thrice.rawValue, value: "").lowercased() {
            // 3 tmes
            
            if (txtTime1.text?.count)! > 0 {
                if (txtTime2.text?.count)! > 0 {
                    if (txtTime1.text?.count)! > 0 {
                        return(false, false, true)
                    }else{
                        return(false, false, false)
                    }
                }else{
                    return(false, false, false)
                }
            }else{
                return(false, false, false)
            }
            
        }
        return(false, false, false)
    }
    
    
    @IBAction func btnTimeClick(_ sender: UIButton) {
        
        intTagTime = sender.tag
        if GeneralConstants.DeviceType.IS_IPAD {
            // iPad
            
            self.view.endEditing(true)
            
            MMDatePickerPopover.appearOn(originView: sender, baseViewController: self, title: "TimePicker", dateMode: .time, initialDate: Date(), maxDate: nil, timeFormat: NSLocale(localeIdentifier: "en_GB"), doneAction: { selectedDate in
                
                print("selectedDate \(selectedDate)")
                
                if sender.tag == 100 {
                    // 1st  time
                    
                    self.selectedDateTime = selectedDate
                    self.setTimeOnButton(dat: selectedDate, txtField: self.txtTime1)
                }else if sender.tag == 101 {
                    // 2nd  time
                    
                    
                    self.selectedDateTime2 = selectedDate
                    self.setTimeOnButton(dat: selectedDate, txtField: self.txtTime2)
                }else if sender.tag == 102 {
                    // 3rd  time
                    
                    self.selectedDateTime3 = selectedDate
                    self.setTimeOnButton(dat: selectedDate, txtField: self.txtTime3)
                }
            },
                                         cancelAction: {
                                            print("cancel")
            })
            
        }else{
            // iPhone
            
            datePicker.config.dateMode = .time
            datePicker.config.timeFormat = NSLocale(localeIdentifier: "en_GB")
            datePicker.show(inVC: self)
            
        }
        
    }
    
    
    @IBAction func switchClick(_ sender: UISwitch) {
        
        
        if sender.isOn {
            intSwitch = 1
        }else{
            intSwitch = 0
        }
    }
    
    
    //MARK: Custom Methods
    
    private func checkTimeAndFrequency(complitionNone: ((_ aStatus : Bool) -> Void))
    {
        var aCheckTimeFrequency : Bool = false
        
        if !isBoolUpdate! {
            strForCancelNotification = "0"
        }
        
        reminderObj.reminderDate =  dayFormatterYYYYDDMM.string(from: Date())
        
        if checkTimeWhenSwitchOn().0 {
            //Once
            
            objDisease.disease_schedule = "1"
            
            
            if GeneralConstants.trimming(txtTime1.text!){
                
                reminderObj.reminderTime = txtTime1.text!
                
                aCheckTimeFrequency = true
                
                insert(completion: {
                    
                    cancelNotification(str: strForCancelNotification!, complition: { (Void) in
                        
                        if isBoolUpdate! {
                            deleteDisease()
                        }
                        
                        insertInToReminderForDisease {
                            if switchReminder.isOn {
                                self.getMAxCount(complition: { (count: String) in
                                    
                                    if JMOLocalizedString(forKey: "Blood pressure", value: "") != txtDiseaseName.text! &&  JMOLocalizedString(forKey: "Blood sugar", value: "") != txtDiseaseName.text!{
                                        self.setNotificationOnce(identifire: count)
                                    }
                                })
                            }
                            self.popViewCnrtl()
                        }
                    })
                })
            }else{
                
                showAlert(message: JMOLocalizedString(forKey: kRequireFields, value: ""))
            }
            
            
        }
        else if checkTimeWhenSwitchOn().1 {
            // Twice
            
            
            if GeneralConstants.trimming(txtTime1.text!) && GeneralConstants.trimming(txtTime2.text!){
            
                aCheckTimeFrequency = true
                
                reminderObj.reminderTime = txtTime1.text!
                objDisease.disease_schedule = "2"
                insert(completion: {
                    
                    cancelNotification(str: strForCancelNotification!, complition: { (Void) in
                        
                        if isBoolUpdate! {
                            deleteDisease()
                        }
                        
                        
                        insertInToReminderForDisease {
                            if switchReminder.isOn {
                                self.getMAxCount(complition: { (count: String) in
                                    if JMOLocalizedString(forKey: "Blood pressure", value: "") != txtDiseaseName.text! &&  JMOLocalizedString(forKey: "Blood sugar", value: "") != txtDiseaseName.text!{
                                        self.setNotificationTwiceOne(identifire: count)
                                    }
                                })
                            }
                        }
                    })
                    
                    
                    reminderObj.reminderTime = txtTime2.text
                    objDisease.disease_id = diseaseSelected?.disease_id2
                    reminderObj.typeID = diseaseSelected?.disease_id2
                    cancelNotification(str: strForCancelNotification!, complition: { (Void) in
                        
                        if isBoolUpdate! {
                            deleteDisease()
                        }
                        
                        insertInToReminderForDisease {
                            if switchReminder.isOn {
                                
                                self.getMAxCount(complition: { (count: String) in
                                    if JMOLocalizedString(forKey: "Blood pressure", value: "") != txtDiseaseName.text! &&  JMOLocalizedString(forKey: "Blood sugar", value: "") != txtDiseaseName.text!{
                                        self.setNotificationTwiceSecond(identifire: count)
                                    }
                                })
                            }
                            self.popViewCnrtl()
                        }
                    })
                    
                    
                })
            }
            else{
                aCheckTimeFrequency = false
            }
            
            
            
        }
        else if checkTimeWhenSwitchOn().2 {
            // Thrice
            
            
            if GeneralConstants.trimming(txtTime1.text!) && GeneralConstants.trimming(txtTime2.text!) && GeneralConstants.trimming(txtTime3.text!){
                
                aCheckTimeFrequency = true
                
                objDisease.disease_schedule = "3"
                reminderObj.reminderTime = txtTime1.text!
                
                insert(completion: {
                    cancelNotification(str: strForCancelNotification!, complition: { (Void) in
                        if isBoolUpdate! {
                            deleteDisease()
                        }
                        
                        insertInToReminderForDisease {
                            if switchReminder.isOn {
                                self.getMAxCount(complition: { (count: String) in
                                    if JMOLocalizedString(forKey: "Blood pressure", value: "") != txtDiseaseName.text! &&  JMOLocalizedString(forKey: "Blood sugar", value: "") != txtDiseaseName.text!{
                                        self.setNotificationThriceOne(identifire: count)
                                    }
                                })
                            }
                        }
                    })
                    
                    reminderObj.reminderTime = txtTime2.text
                    objDisease.disease_id = diseaseSelected?.disease_id2
                    reminderObj.typeID = diseaseSelected?.disease_id2
                    cancelNotification(str: strForCancelNotification!, complition: { (Void) in
                        if isBoolUpdate! {
                            deleteDisease()
                        }
                        
                        
                        insertInToReminderForDisease {
                            if switchReminder.isOn {
                                self.getMAxCount(complition: { (count: String) in
                                    if JMOLocalizedString(forKey: "Blood pressure", value: "") != txtDiseaseName.text! &&  JMOLocalizedString(forKey: "Blood sugar", value: "") != txtDiseaseName.text!{
                                        self.setNotificationThriceSecond(identifire: count)
                                    }
                                })
                            }
                            
                            reminderObj.reminderTime = txtTime3.text
                            objDisease.disease_id = diseaseSelected?.disease_id3
                            reminderObj.typeID = diseaseSelected?.disease_id3
                            
                            
                            cancelNotification(str: strForCancelNotification!, complition: { (Void) in
                                if isBoolUpdate! {
                                    deleteDisease()
                                }
                                
                                
                                insertInToReminderForDisease {
                                    if switchReminder.isOn {
                                        self.getMAxCount(complition: { (count: String) in
                                            if JMOLocalizedString(forKey: "Blood pressure", value: "") != txtDiseaseName.text! &&  JMOLocalizedString(forKey: "Blood sugar", value: "") != txtDiseaseName.text!{
                                                self.setNotificationThriceThird(identifire: count)
                                            }
                                        })
                                    }
                                    self.popViewCnrtl()
                                }
                            })
                            
                            
                        }
                    })
                    
                })
                
            }
            else{
                showAlert(message: JMOLocalizedString(forKey: kRequireFields, value: ""))
                
                aCheckTimeFrequency = false
            }
            
            
        }else{
            showAlert(message: JMOLocalizedString(forKey: kRequireFields, value: ""))
            complitionNone(aCheckTimeFrequency)
        }
        
    }
    
    /// Setup datepicker
    fileprivate func setupDatePicker() {
        
        datePicker.delegate = self
        timeFormatter.dateFormat = "HH:mm"
        
        dateSelectedFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateSelectedFormatter.locale = Locale(identifier: "en_US_POSIX")
//        dateSelectedFormatter.timeZone = NSTimeZone(abbreviation: "IST") as TimeZone!
        dateSelectedFormatter.timeZone = NSTimeZone.local
        
        datePicker.config.startDate = Date()
        
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
    
    
    /// Set data which will comes from disease list
    private func setDataForEdit() {
        
        // Set data based on edit
        if isBoolEdit! {
            
            setEditData()
            isBoolEdit = false
            isBoolUpdate = true
            self.lblScreenTitle.text = JMOLocalizedString(forKey: "EDIT DISEASE", value: "")
            btnSave.setTitle(JMOLocalizedString(forKey: "UPDATE", value: ""), for: .normal)
        }else{
            
            isBoolUpdate = false
            
            
            btnSave.setTitle(JMOLocalizedString(forKey: "ADD", value: ""), for: .normal)
        }
    }
    
    
    private func setEditData() {
        
        objDisease.disease_id = diseaseSelected?.disease_id!
        txtDiseaseName.text = diseaseSelected?.disease_title!
        strForCancelNotification = "\(diseaseSelected?.disease_id!)"
        
        if diseaseSelected?.reminderWithNotification == 1 {
            switchReminder.isOn = true
        }else{
            switchReminder.isOn = false
        }
        
        var aStrSchedule: String!
        
        if diseaseSelected?.disease_schedule != nil{
            
            if Int((diseaseSelected?.disease_schedule!)!)! == FrequencyType.OnceType.rawValue {
                // Once
                aStrSchedule = JMOLocalizedString(forKey: Frequency.Once.rawValue, value: "")
                
                setHeightConstraints(const: heightConstraints[0], height: 50)
                
                txtTime1.text = diseaseSelected?.reminderTime
            }else if Int((diseaseSelected?.disease_schedule!)!)! == FrequencyType.Twice.rawValue {
                // Twice
                
                
                txtTime1.text = diseaseSelected?.reminderTime
                txtTime2.text = diseaseSelected?.time2
                
                selectedDateTime2  =  dateSelectedFormatter.date(from: "2000-12-31 \(txtTime2.text!):00")
                
                aStrSchedule = JMOLocalizedString(forKey: Frequency.Twice.rawValue, value: "")
                setHeightConstraints(const: heightConstraints[0], height: 50)
                setHeightConstraints(const: heightConstraints[1], height: 50)
            }else if Int((diseaseSelected?.disease_schedule!)!)! == FrequencyType.Thrice.rawValue {
                // Thrice
                
                txtTime1.text = diseaseSelected?.reminderTime
                txtTime2.text = diseaseSelected?.time2
                txtTime3.text = diseaseSelected?.time3
                
                selectedDateTime2  =  dateSelectedFormatter.date(from: "2000-12-31 \(txtTime2.text!):00")
                selectedDateTime3  =  dateSelectedFormatter.date(from: "2000-12-31 \(txtTime3.text!):00")
                
                
                aStrSchedule = JMOLocalizedString(forKey: Frequency.Thrice.rawValue, value: "")
                setHeightConstraints(const: heightConstraints[0], height: 50)
                setHeightConstraints(const: heightConstraints[1], height: 50)
                setHeightConstraints(const: heightConstraints[2], height: 50)
            }else{
                // None
                aStrSchedule = ""
            }
        }
        
        
        selectedDateTime  =  dateSelectedFormatter.date(from: "2000-12-31 \(txtTime1.text!):00")
        
        
        txtFrequency.text = aStrSchedule
        
        
        
    }
    
    private func setHeightConstraints(const: NSLayoutConstraint, height: CGFloat) {
        const.constant = height
    }
    
    /// Open picker common method
    typealias pickerComplition = (_ selectedObject: Any , _ objectIndex: Int , _ isCancel : Bool) -> Void
    
    fileprivate func openPicker(array:[String], sender: UIButton, completion:@escaping (pickerComplition)) {
        
        var kpPickerView : KPPickerView?
        kpPickerView = KPPickerView.getFromNib()
        
        kpPickerView!.show(self , sender: sender , data: array , defaultSelected: sender.titleLabel?.text) { (selectedObject , selectedIndex , isCancel) in
            
            print(selectedObject)
            
            if !isCancel {
                completion(selectedObject , selectedIndex , isCancel)
            }
        }
    }
    
    
    private func deleteDisease() {
        
        if Int((diseaseSelected?.disease_schedule)!) == FrequencyType.OnceType.rawValue || Int((diseaseSelected?.disease_schedule)!) == 0{
            
            DiseaseModel().deleteDisease(deleteID: (diseaseSelected?.disease_id)!, complition: { (result: Bool) in
                UserActivityModel().deleteActivity(type: (diseaseSelected?.type)!, typeid: (diseaseSelected?.typeID)!,  userActivityDate: "", reminderID: (diseaseSelected?.reminderID!)!, complition: { (result: Bool) in
                })
            })
            
        }else if Int((diseaseSelected?.disease_schedule)!) == FrequencyType.Twice.rawValue {
            
            DiseaseModel().deleteDisease(deleteID: (diseaseSelected?.disease_id)!, complition: { (result: Bool) in
                DiseaseModel().deleteDisease(deleteID: (diseaseSelected?.disease_id2)!, complition: { (result: Bool) in
                    UserActivityModel().deleteActivity(type: (diseaseSelected?.type)!, typeid: (diseaseSelected?.typeID)!,  userActivityDate: "", reminderID: (diseaseSelected?.reminderID!)!, complition: { (result: Bool) in
                    })
                })
            })
            
            
        }else if Int((diseaseSelected?.disease_schedule)!) == FrequencyType.Thrice.rawValue {
            
            DiseaseModel().deleteDisease(deleteID: (diseaseSelected?.disease_id)!, complition: { (result: Bool) in
                DiseaseModel().deleteDisease(deleteID: (diseaseSelected?.disease_id2)!, complition: { (result: Bool) in
                    
                    DiseaseModel().deleteDisease(deleteID: (diseaseSelected?.disease_id3)!, complition: { (result: Bool) in
                        UserActivityModel().deleteActivity(type: (diseaseSelected?.type)!, typeid: (diseaseSelected?.typeID)!,  userActivityDate: "", reminderID: (diseaseSelected?.reminderID!)!, complition: { (result: Bool) in
                        })
                    })
                    
                })
            })
            
        }
    }
    
    
    func insert(completion: (() -> Void)) {
        
        DiseaseModel().insertDisese(objDisease: objDisease, aObjReminder: reminderObj, flageUpdate: false) { (result: Bool) in
            
            print(result)
            
            completion()
        }
    }
    
    
    private func insertInToReminderForDisease(completion: (() -> Void)){
        
        DiseaseModel().insertInToReminderForDisease(objDisease: objDisease, aObjReminder: reminderObj, flageUpdate: false) { (result: Bool) in
            
            if !isBoolUpdate! {
                strForCancelNotification = "0"
            }
            
            if switchReminder.isOn {
                
                
            }else{
                cancelNotification(str: strForCancelNotification!, complition: { (Void) in
                    
                })
            }
        }
        
        completion( )
    }
    
    
    /// Set UITextField padding
    private func setPadding(){
        
        setTextFieldPadding(textfield: txtTime3, padding: 5)
        setTextFieldPadding(textfield: txtTime2, padding: 5)
        setTextFieldPadding(textfield: txtTime1, padding: 5)
        setTextFieldPadding(textfield: txtFrequency, padding: 5)
        setTextFieldPadding(textfield: txtDiseaseName, padding: 5)
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
    
    private func setNotificationOnce(identifire: String) {
        

        let hour = getHMS(date: selectedDateTime!).0
        let minutes = getHMS(date: selectedDateTime!).1
        
        // Set local notification for once type
        LocalNotificationHelper.sharedInstance.createReminderNotification(identifire,"\(name)", "\(name)", weekDay: 0, monthDay: 0, hour: hour, minute:minutes , seconds:0 , notificationDate: Date(), NotificationType.Daily)
    }
    
    private func setNotificationTwiceOne(identifire: String) {

            let hour = getHMS(date: selectedDateTime!).0
        let minutes = getHMS(date: selectedDateTime!).1
        
        // Set local notification for Twice : it wil set for 1st time we have set
        LocalNotificationHelper.sharedInstance.createReminderNotification(identifire,"\(name)", "\(name)", weekDay: 0, monthDay: 0, hour: hour, minute:minutes, seconds: 0, notificationDate: Date(), NotificationType.Daily)
    }
    
    private func setNotificationTwiceSecond(identifire: String) {

        // Get hours and minuts for local notification 2nd
        let hour2 = getHMS(date: selectedDateTime2!).0
        let minutes2 = getHMS(date: selectedDateTime2!).1
        
        
        // Set local notification for Twice : it wil set for 2nd time we have set
        LocalNotificationHelper.sharedInstance.createReminderNotification(identifire,"\(name)", "\(name)", weekDay: 0, monthDay: 0, hour: hour2, minute:minutes2, seconds: 0, notificationDate: Date(), NotificationType.Daily)
    }
    
    private func setNotificationThriceOne(identifire: String) {

        let hour = getHMS(date: selectedDateTime!).0
        let minutes = getHMS(date: selectedDateTime!).1
        
        // Set local notification for Twice : it wil set for 1st time we have set
        LocalNotificationHelper.sharedInstance.createReminderNotification(identifire,"\(name)", "\(name)", weekDay: 0, monthDay: 0, hour: hour, minute:minutes, seconds: 0, notificationDate: Date(), NotificationType.Daily)
    }
    
    private func setNotificationThriceSecond(identifire: String) {

        // Get hours and minuts for local notification 2nd
        let hour = getHMS(date: selectedDateTime2!).0
        let minutes = getHMS(date: selectedDateTime2!).1
        
        // Set local notification for Twice : it wil set for 2nd time we have set
        LocalNotificationHelper.sharedInstance.createReminderNotification(identifire,"\(name)", "\(name)" , weekDay: 0, monthDay: 0, hour: hour, minute: minutes, seconds: 0, notificationDate: Date(), NotificationType.Daily)
    }
    
    private func setNotificationThriceThird(identifire: String) {

        // Get hours and minuts for local notification 3rd
        let hour3 = getHMS(date: selectedDateTime3!).0
        let minutes3 = getHMS(date: selectedDateTime3!).1
        
        // Set local notification for Twice : it wil set for 3rd time we have set
        LocalNotificationHelper.sharedInstance.createReminderNotification(identifire,"\(name)", "\(name)", weekDay: 0, monthDay: 0, hour: hour3, minute:minutes3, seconds: 0, notificationDate: Date(), NotificationType.Daily)
    }
    
    private func getMAxCount(complition: ((String)  -> Void)) {
        DiseaseModel().getMaxCount(complitionCount: { (count: String) in
            
            complition(count)
        })
    }
    
    /// Cacel local notification using task name
    ///
    /// - Parameters:
    ///   - str: Notification task name
    ///   - complition: complition call after remove local notification
    func cancelNotification(str: String, complition: ((Void)-> Void)) {
        
//        LocalNotificationHelper.sharedInstance.removeNotification([str])
        
        LocalNotificationHelper.sharedInstance.removeNotification([str], completion: { (status) in
            
        })
        
        
    }
    
    /// Show alert
    ///
    /// - Parameter message: Message text
    fileprivate func showAlert(message: String) {
        UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey: message, value: "") , completion: { (Int, String) in
            
        })
    }
    
    private func popViewCnrtl() {
        
        if isBoolUpdate! {
            UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey:JMOLocalizedString(forKey: modificationAlert, value: ""), value: ""), completion: { (Int, String) in
                _ = self.navigationController?.popViewController(animated: true)
            })
            
        }else{
        UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey: "Addition process done successfully", value: ""), completion: { (Int, String) in
            _ = self.navigationController?.popViewController(animated: true)
        })
            
        }
    }
    
    
    /// Date picker delegate Done event
    ///
    /// - Parameters:
    ///   - amDatePicker: Picker object
    ///   - date: Selected date
    func mmDatePicker(_ amDatePicker: MMDatePicker, didSelect date: Date) {
        
        if intTagTime == 100 {
            
            selectedDateTime = date
            self.setTimeOnButton(dat: date, txtField: self.txtTime1)
            
        }else if intTagTime == 101 {
            
            selectedDateTime2 = date
            self.setTimeOnButton(dat: date, txtField: self.txtTime2)
            
        }else if intTagTime == 102 {
            
            selectedDateTime3 = date
            self.setTimeOnButton(dat: date, txtField: self.txtTime3)
        }
    }
    
    
    /// Date picker cancel delegate
    ///
    /// - Parameter amDatePicker: Picker object
    func mmDatePickerDidCancelSelection(_ amDatePicker: MMDatePicker) {
        // NOP
    }
    
    
    //MARK: UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        if textField == txtDiseaseName {
            if (textField.text?.count)! <= kSetChar128 {
                let newLength = (textField.text?.count)! + string.count - range.length
                return newLength <= kSetChar128
            }
        }
        return true
    }
    
}
