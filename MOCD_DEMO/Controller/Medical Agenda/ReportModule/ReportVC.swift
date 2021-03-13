//
//  ReportVC.swift
//  SwiftDatabase
//
//  Created by indianic on 30/12/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit
import SwiftyDropbox
import MessageUI

import Charts
import RealmSwift
import Realm

//import PDFGenerator

class ReportVC: UIViewController,MMDatePickerDelegate,MFMailComposeViewControllerDelegate,ChartViewDelegate {
    
    
    //MARK: Variables
    
    @IBOutlet weak var topWebViewConstraint: NSLayoutConstraint!
    var setToDate: Date?
    var datePicker = MMDatePicker.getFromNib()
    var dateFormatter = DateFormatter()
    var dateSelectedFormatter = DateFormatter()
    var medicinePlanObj = [medicinePlanReminderModel]()
    var arrMutDiseasesList = [DiseasesReminderModel]()
    var isFromDate = false
    var arrMutOnlyMedicineList = [medicinePlan]()
    var arrMutTitle = [String]()
    
    var arrMutOnlyDiseaseList = [DiseaseModel]()
    var arrMutDiseaseTitle = [String]()
    
    var selectedStartDate = Date()
    var selectedEndDate = Date()
    var aDictBasedOnReminder = [String:[UserActivityModel]]()
    
    var strSelectedObject = String()
    var intSelectedIndex = Int()
    
    //MARK: IBOutlets
    @IBOutlet weak var btnLeftMenu: UIButton!
    @IBOutlet var lblScreenTitle: UILabel!
    @IBOutlet var txtFieldFromDate: UITextField!
    @IBOutlet var txtFieldToDate: UITextField!
    @IBOutlet var txtMedicinePlan: UITextField!
    
    @IBOutlet var btnDiseaseReport: UIButton!
    @IBOutlet var btnMedicalPalnReport: UIButton!
    
    @IBOutlet var webview: UIWebView!
    
    @IBOutlet var scrollview: UIScrollView!
    
    @IBOutlet var webDiseaseView: UIWebView!
    
    @IBOutlet var chartView: LineChartView!
    
    @IBOutlet var btnExport: UIButton!
    @IBOutlet var btnGenerate: UIButton!
    
    weak var axisFormatDelegate: IAxisValueFormatter?
    
    var xAxisValues = [Double]()
    var yAxisValues = [Double]()
    var yAxisValuesForSecond = [Double]()
    
    private let dayFormatterEEEE: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        
        return formatter
    }()
    
    private let dayFormatterEEEE_AR: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "ar") as Locale?
        formatter.dateFormat = "EEE"
        
        return formatter
    }()
    
    private let dayFormatterDD: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        
        return formatter
    }()
    
    private let dayFormatterDD_AR: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "ar") as Locale?
        formatter.dateFormat = "dd"
        return formatter
    }()
    
    private let dayFormatterMM: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        return formatter
    }()
    
    private let dayFormatterMM_AR: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "ar") as Locale?
        formatter.dateFormat = "MM"
        return formatter
    }()
    
    //MARK: ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        btnExport.isHidden = true
        btnGenerate.isHidden = true
        // Do any additional setup after loading the view.
        
        webview.isHidden = true
        axisFormatDelegate = self
        
        // 1
        chartView.delegate = self
        // 2
        //chartView.text = ""
        chartView.legend.form = .circle
        chartView.legend.horizontalAlignment = .right
        chartView.pinchZoomEnabled = false
        chartView.doubleTapToZoomEnabled = false
        
//        let leftAxis = chartView.leftAxis
//        leftAxis.axisMaximum = 200.0;
//        leftAxis.axisMinimum = 00.0;

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        LanguageManager().localizeThingsInView(parentView: self.view)
        
        
        scrollview.isHidden = true
        
        self.txtFieldFromDate.placeholder = JMOLocalizedString(forKey: "From Date", value: "")
        self.txtFieldToDate.placeholder = JMOLocalizedString(forKey: "To Date", value: "")
        self.txtMedicinePlan.placeholder = JMOLocalizedString(forKey: "Medicine plan*", value: "")
        
        
        self.txtFieldToDate.text = ""
        self.txtFieldFromDate.text = ""
        self.txtMedicinePlan.text = ""
        
       
        
        btnExport.setTitle(JMOLocalizedString(forKey: "Export", value: ""), for: .normal)
        btnGenerate.setTitle(JMOLocalizedString(forKey: "Generate", value: ""), for: .normal)
        
//        txtFieldFromDate.text = dateFormatter.string(from: Date())
//        txtFieldToDate.text = dateFormatter.string(from: Date())
        
        // Set Padding
        setPadding()
        
        // Get medicine plan
        
        btnExport.isHidden = true
        btnGenerate.isHidden = true
        webview.isHidden = true
        scrollview.isHidden = true
        
        getOnlyMedicinePlan()
        getOnlyDiseases()
        
        // Set Picker
        setupDatePicker()
        
        self.lblScreenTitle.text = JMOLocalizedString(forKey: "SMART AGENDA", value: "")
        
        
        // Set custom fonts
        
//        if GeneralConstants.DeviceType.IS_IPAD {
//        }else{
//            customizeFonts(in: lblScreenTitle, aFontName: Medium, aFontSize: 0)
//            customizeFonts(in: txtFieldFromDate, aFontName: Medium, aFontSize: 0)
//            customizeFonts(in: txtFieldToDate, aFontName: Medium, aFontSize: 0)
//            customizeFonts(in: btnDiseaseReport, aFontName: Bold, aFontSize: 0)
//            customizeFonts(in: btnMedicalPalnReport, aFontName: Bold, aFontSize: 0)
//        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        txtFieldFromDate.text = dateFormatter.string(from: Date())
//        txtFieldToDate.text = dateFormatter.string(from: Date())
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    //MARK: Common Methods
    
    func setPadding(){
        
        setTextFieldPadding(textfield: txtFieldFromDate, padding: 5)
        setTextFieldPadding(textfield: txtFieldToDate, padding: 5)
        setTextFieldPadding(textfield: txtMedicinePlan, padding: 5)
    }
    
    
    func getOnlyMedicinePlan() {
        
        medicinePlan().getOnlyMedicineList { (objs: [medicinePlan]) in
            
            if self.arrMutOnlyMedicineList.count >= 0{
                self.arrMutOnlyMedicineList.removeAll()
                self.arrMutTitle.removeAll()
            }
            
            self.arrMutOnlyMedicineList = objs
            
            for objForTitle in arrMutOnlyMedicineList {
                arrMutTitle.append(objForTitle.name)
            }
            
           
        }
        
    }
    
    func getOnlyDiseases() {
        
        DiseaseModel().getOnlyDiseaseList { (objs: [DiseaseModel]) in
            
            if self.arrMutOnlyDiseaseList.count >= 0{
                self.arrMutOnlyDiseaseList.removeAll()
                self.arrMutDiseaseTitle.removeAll()
            }
            
            self.arrMutOnlyDiseaseList = objs
            
            for objForTitle in arrMutOnlyDiseaseList {
                arrMutDiseaseTitle.append(objForTitle.disease_title)
            }
        }
    }
    
    private func getMedicinePlanList() {
        
        let aFormDate = txtFieldFromDate.text!
        let aToDate = txtFieldToDate.text!
        
        // To get medicin plan list
        medicinePlan().getAllMedicinPlanListByDate(aFormDate, toDate: aToDate) { (objs: [medicinePlanReminderModel]) in
            
            
            
            self.medicinePlanObj.removeAll()
            if self.medicinePlanObj.count == 0 {
            }else{
                
                print(medicinePlanObj.count)
                let aObjMedicine = medicinePlanReminderModel()
                
                print(aObjMedicine)
            }
            
            
        }
    }
    
    
    private func getDiseasesFromDB() {
        
        let aFormDate = txtFieldFromDate.text!
        let aToDate = txtFieldToDate.text!
        
        // To get all diseases from DB
        DiseaseModel().getDiseaseListByDate(aFormDate, toDate:  aToDate)  { (objs: [DiseasesReminderModel]) in
            
            self.arrMutDiseasesList.removeAll()
            
            for objDisease in objs {
                
                self.arrMutDiseasesList.append(objDisease)
            }
            
            if self.arrMutDiseasesList.count == 0 {
            }else{
                print(arrMutDiseasesList.count)
                
            }
        }
    }
    
    
    //MARK: IBActions Events
    
    @IBAction func btnSideLeftMenuAction(_ sender: UIButton) {
        
        if AppConstants.isArabic() {
            appDelegate.mmDrawer?.open(.right, animated: true, completion: nil)
        }else{
            appDelegate.mmDrawer?.open(.left, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func btnMedicinePlanClick(_ sender: UIButton) {
        
        self.view.endEditing(true)
        btnExport.isHidden = true
        btnGenerate.isHidden = true
        
        if btnMedicalPalnReport.isSelected {
            // Medicine plan report

    
            medicineDropDown(sender: sender)
        }else{
            // Disease report
            diseaseDropDown(sender: sender)
        }
    }
    
    private func generateReportForMedicinePlan(selectedObject: String, selectedIndex: Int) {
        
       
        // Set inital html part
        let width = "\(GeneralConstants.ScreenSize.SCREEN_WIDTH)"
        let aStrInitHTML =  "<table width=\"\(width)\"><tbody>"
        var aStrBodyOfHTML = String()
        let aStrEndHTML =  "</tbody></table>"
        
        
        
        self.txtMedicinePlan.text = selectedObject as? String
        
        let selectedID = "\(self.arrMutOnlyMedicineList[selectedIndex].identifier!)"
        ReminderModel().getAllFromReminderBasedOnSelectedData(typrID:"3", identifire: selectedID, completion: { (objReminder: [ReminderModel]) in
            print(objReminder.count)
            
//            let aFormDate = self.txtFieldFromDate.text!
//            let aToDate = self.txtFieldToDate.text!
            var aFormDate = ""
            var aToDate = ""
            
            if AppConstants.isArabic(){
                
                let aFromDateVal = getDateFromString(yyyyMMdd, aStrDate: self.txtFieldFromDate.text!)
                let aToDateVal = getDateFromString(yyyyMMdd, aStrDate: self.txtFieldToDate.text!)
                
                let aENFromDate = dayWholeFormatterEN.string(from: aFromDateVal)
                let aENTODate = dayWholeFormatterEN.string(from: aToDateVal)
                
                aFormDate = aENFromDate
                aToDate = aENTODate
                
                
                
            }else{
                aFormDate = self.txtFieldFromDate.text!
                aToDate = self.txtFieldToDate.text!
                
            }
            

            
            let medicalPlanTitle = JMOLocalizedString(forKey: "Medical Plan Report", value: "")
            
            let currentDate = getStringValueFromDate(yyyyMMdd, date: Date())
            let currentTime = getStringValueFromDate(HHmm, date: Date())
            
            print("currentDate = \(currentDate)")
            print("currentTime = \(currentTime)")
            
            let acurrentDateTime = String.init(format: "%@ %@", currentDate, currentTime)
            
            aStrBodyOfHTML.append("<tr><td style=\"background-color: #ab3540; text-align: center; color: #ffffff;\" colspan=\"\(objReminder.count+1)\"><strong>\( medicalPlanTitle)</strong></td></tr>")
            
            aStrBodyOfHTML.append("<tr><td style=\"background-color: #ab3540; text-align: center; color: #ffffff;\" colspan=\"\(objReminder.count+1)\"><strong>\(self.txtMedicinePlan.text!)</strong></td></tr>")
            
            aStrBodyOfHTML.append("<tr><td style=\"background-color: #ab3540; text-align: center; color: #ffffff;\" colspan=\"\(objReminder.count+1)\"><strong>\(acurrentDateTime)</strong></td></tr>")
            
            aStrBodyOfHTML.append("<tr><td style=\"width: 100px; text-align: center;\">&nbsp;</td>")
            
            
            
            for eachRemider in objReminder {
                
                var aStrShowTime = ""
                if AppConstants.isArabic(){
                    
                    let aTime = getTimeFromString(HHmm, aStrDate: eachRemider.reminderTime!)
                    aStrShowTime = TimeWholeFormatterAR.string(from: aTime)
//                    aStrShowTime = eachRemider.reminderTime!
                }else{
                    
                    aStrShowTime = eachRemider.reminderTime!
                }
                
                
                aStrBodyOfHTML.append("<td style=\"text-align: center; \">\(aStrShowTime)</td>")
                
                UserActivityModel().getUserActivityForReport(aFormDate, toDate: aToDate, reimderID:"\(eachRemider.reminderID!)", complition: { (objs: [UserActivityModel]) in
                    
                    print(objs)
                    
                    self.aDictBasedOnReminder["\(eachRemider.reminderID!)"] = objs
                    
                })
            }
            
            aStrBodyOfHTML.append("</tr>")
            
            self.dateFormatter.dateFormat = yyyyMMdd
            
            print(aStrBodyOfHTML)
            
            var date = self.selectedStartDate

            let endDate = self.selectedEndDate
            
            let calendar = NSCalendar.current
            
            print(aStrBodyOfHTML)
            
            while date <= endDate {
                aStrBodyOfHTML.append("<tr>")
                
                var dtEEEE = ""
                var dtDd = ""
                var dtMM = ""
                
                if (AppConstants.isArabic()){
                    dtEEEE = self.dayFormatterEEEE_AR.string(from: date)
                    dtDd = self.dayFormatterDD_AR.string(from: date)
                    dtMM = self.dayFormatterMM_AR.string(from: date)
                    
                }else{
                    dtEEEE = self.dayFormatterEEEE.string(from: date)
                    dtDd = self.dayFormatterDD.string(from: date)
                    dtMM = self.dayFormatterMM.string(from: date)
                }
                
                date = calendar.date(byAdding: .day, value: 1, to: date)!
                print(self.dateFormatter.string(from: date))
                
                
                aStrBodyOfHTML.append("<td style=\"width: 100px; text-align: center;\">\(dtEEEE) \(dtDd)\\\(dtMM)</td>")
                
                for remider in objReminder {
                    
                    let userActivities: [UserActivityModel] = self.aDictBasedOnReminder["\(remider.reminderID!)"]!
                    
                    var isChecked: Bool = false
                    
                    for userActivity in userActivities {
                        
                        print(userActivity.user_activity_date)

                        if userActivity.user_activity_date == getStringFromDateusingUTC(yyyyMMdd, date: calendar.date(byAdding: .day, value: -1, to: date)!)
                        {
                            print("OK - \(userActivity.user_activity_date)")
                            
                            isChecked = true
                            
                            break
                            
                        }
                    }
                    
                    if isChecked {
                        
                        aStrBodyOfHTML.append("<td style=\"text-align: center;\"><img src=\"\(URL(fileURLWithPath: Bundle.main.path(forResource: "medical_plan_report_OK", ofType: "png")!))\" width=\"20\" height=\"20\" /></td>")
                    }else{
                        aStrBodyOfHTML.append("<td style=\"text-align: center;\"><img src=\"\(URL(fileURLWithPath: Bundle.main.path(forResource: "medical_plan_report_NO", ofType: "png")!))\" width=\"20\" height=\"20\" /></td>")
                    }
                    
                    
                }
                
               
                aStrBodyOfHTML.append("</tr>")
                
            }
            
            
            print(aStrBodyOfHTML)
            
            
        })
        
        print("'\(aStrInitHTML)''\(aStrBodyOfHTML)''\(aStrEndHTML)'")
        
        self.scrollview.isHidden = true
        self.webview.isHidden = false
        
        self.webview.loadHTMLString("\(aStrInitHTML)\(aStrBodyOfHTML)\(aStrEndHTML)", baseURL: nil)
        print(aStrBodyOfHTML)
        
        
        
    }
    
    
    private func medicineDropDown(sender: UIButton) {
        if arrMutTitle.count > 0 {
            
            var kpPickerView : KPPickerView?
            kpPickerView = KPPickerView.getFromNib()
            
            kpPickerView!.show(self , sender: sender , data: arrMutTitle , defaultSelected: JMOLocalizedString(forKey: txtMedicinePlan.text!, value: "")) { (selectedObject , selectedIndex , isCancel) in
                
                print(selectedObject)
                
                self.btnExport.isHidden = false
                self.btnGenerate.isHidden = false
                
                if !isCancel{
                    if(self.checkDateValidation()){
                        
                        if self.selectedStartDate > self.selectedEndDate {
                            UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey: "From Date is larger to date", value: ""), completion: { (index : Int, value : String) in
                                
                                
                            })
                        }else{
                            
                            self.strSelectedObject = (selectedObject as? String)!
                            self.intSelectedIndex = selectedIndex
                            self.generateReportForMedicinePlan(selectedObject: self.strSelectedObject, selectedIndex: self.intSelectedIndex)
                        }
                    }
                    else{
                        UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey: "please select proper dates", value: ""), completion: { (index : Int, value : String) in
                            
                            
                        })
                    }
                }
            }
            
        }
        
    }
    
    private func generateReportForDisease(selectedObject: String, selectedIndex: Int) {
    
        self.chartView.isHidden = true
        self.topWebViewConstraint.constant = 5
        let width = "\(GeneralConstants.ScreenSize.SCREEN_WIDTH)"
        
        let aStrInitHTML =  "<html><meta name=\"format-detection\" content=\"telephone=no\"><table  width=\"\(width)\"><tbody>"
        var aStrBodyOfHTML = String()
        let aStrEndHTML =  "</tbody></table></html>"
        
        self.xAxisValues.removeAll()
        self.yAxisValues.removeAll()
        self.yAxisValuesForSecond.removeAll()
        
        self.txtMedicinePlan.text = JMOLocalizedString(forKey: (selectedObject as? String)!, value: "")
        
        self.dismiss(animated: true, completion: nil)
        
        let diseaseID = "\(self.arrMutOnlyDiseaseList[selectedIndex].disease_id!)"
         let diseaseTitle = self.txtMedicinePlan.text
        ReminderModel().getAllFromReminderBasedOnSelectedData(typrID:"1", identifire: diseaseID, completion: { (objReminder: [ReminderModel]) in
            print(objReminder)
            
            var aFormDate = ""
            var aToDate = ""
            
            if AppConstants.isArabic(){
                
                let aFromDateVal = getDateFromStringByFormate(yyyyMMdd, aStrDate: self.txtFieldFromDate.text!)
                let aToDateVal = getDateFromStringByFormate(yyyyMMdd, aStrDate: self.txtFieldToDate.text!)
                
                let aENFromDate = dayWholeFormatterEN.string(from: aFromDateVal)
                let aENTODate = dayWholeFormatterEN.string(from: aToDateVal)
                
                aFormDate = aENFromDate
                aToDate = aENTODate
                
                
                
            }else{
                let aFromDateVal = getDateFromStringByFormate(yyyyMMdd, aStrDate: self.txtFieldFromDate.text!)
                let aToDateVal = getDateFromStringByFormate(yyyyMMdd, aStrDate: self.txtFieldToDate.text!)
                
                let aENFromDate = dayWholeFormatterEN.string(from: aFromDateVal)
                let aENTODate = dayWholeFormatterEN.string(from: aToDateVal)
                
                aFormDate = aENFromDate
                aToDate = aENTODate
                
//                aFormDate = self.txtFieldFromDate.text!
//                aToDate = self.txtFieldToDate.text!
                
            }
            
            print("aFormDate = \(aFormDate)")
            print("aToDate = \(aToDate)")
            
            aStrBodyOfHTML.append("<tr><td style=\"background-color: #ab3540; text-align: center; color: #ffffff;\" colspan=\"3\"><strong>\(JMOLocalizedString(forKey: "Daily Recond Report", value: ""))</strong></td></tr>")
           aStrBodyOfHTML.append("<tr><td style=\"background-color: #ab3540; text-align: center; color: #ffffff;\" colspan=\"3\"><strong>\(diseaseTitle!)</strong></td></tr>")
            // Set top menu layer
            aStrBodyOfHTML.append("<tr><td style=\"background-color: #ab3540; text-align: center; color: #ffffff;\"><strong>\(JMOLocalizedString(forKey: "Date", value: ""))</strong></td><td style=\"background-color: #ab3540; text-align: center; color: #ffffff;\"><strong>\(JMOLocalizedString(forKey: "Time", value: ""))</strong></td><td style=\"background-color: #ab3540; text-align: center; color: #ffffff;\"><strong>\(JMOLocalizedString(forKey: "Value", value: ""))</strong></td></tr>")
            
           

            
            //<td style=\"background-color: #ab3540; text-align: center; color: #ffffff;\"><strong>\(JMOLocalizedString(forKey: "Note", value: ""))</strong></td>
            for eachRemider in objReminder {
                
                UserActivityModel().getUserActivityForReport(aFormDate, toDate: aToDate, reimderID:"\(eachRemider.reminderID!)", complition: { (objs: [UserActivityModel]) in
                    
                    print(objs)
                    
                    self.aDictBasedOnReminder["\(eachRemider.reminderID!)"] = objs
                    
                })
            }
            
            self.dateFormatter.dateFormat = yyyyMMdd
            self.dateFormatter.locale = NSLocale(localeIdentifier: "en") as Locale?
            
            print(aStrBodyOfHTML)
            
            var date = self.selectedStartDate
            let endDate = self.selectedEndDate
            
            var calendar = NSCalendar.current
            calendar.locale = NSLocale(localeIdentifier: "en") as Locale?
//            date = calendar.date(byAdding: .day, value: -1, to: date)!
//            date = calendar.date(byAdding: .day, value: -1, to: date)!
            
            print(aStrBodyOfHTML)
            var aTempDate = ""
            
            var ReportID = 0
            dateFormatter.locale = NSLocale(localeIdentifier: "en") as Locale?
            
            while date <= endDate {
                aStrBodyOfHTML.append("<tr>")
//                font-family: GESSTextMedium-Medium; font-size: 12pt;
                
                date = calendar.date(byAdding: .day, value: 1, to: date)!
                
                print("Date in while loop \(date)")
                

                for remider in objReminder {
                    
                    let userActivities: [UserActivityModel] = self.aDictBasedOnReminder["\(remider.reminderID!)"]!
                    
                    //                                var isChecked: Bool = false
                    
                    // more 1
                    
                    // 16 
                    
                    
                    
                    for userActivity in userActivities {
                        
                        
                        print(userActivity.user_activity_date)
                        ReportID = userActivity.reminder_id
                        
                        if userActivity.user_activity_date == getStringFromDateusingUTC(yyyyMMdd, date: calendar.date(byAdding: .day, value: -1, to: date)!) {
                        
                            print("OK - \(userActivity.user_activity_date)")
                            
                            //                                        isChecked = true
                            var strSeprated = userActivity.user_activity_value.components(separatedBy: ",")
                            var strIndex0 = String()
                            var strIndex1 = String()
                            var strShowInHTML = String()
                            
                            if aTempDate != userActivity.user_activity_date
                            {
                                aTempDate = userActivity.user_activity_date
                                let timeIntervalForDate: TimeInterval = date.timeIntervalSince1970
                                self.xAxisValues.append(timeIntervalForDate)
                                
                            }
                            
                            if strSeprated.count > 1 {
                                // Blood Pressure
                                strIndex0 = strSeprated[0]
                                strIndex1 = strSeprated[1]
                                
                                if AppConstants.isArabic(){
                                    strIndex0 = convertNumberToArabic(aStr: strIndex0)
                                    strIndex1 = convertNumberToArabic(aStr: strIndex1)
                                }
                                
                                strShowInHTML = "\(strIndex0)/\(strIndex1)"
                                
                                
                            }else{
                                
                                // Blood Sugar
                                strIndex0 = strSeprated[0]
                                strIndex1 = ""
                                
                                if AppConstants.isArabic(){
                                    strIndex0 = convertNumberToArabic(aStr: strIndex0)
                                }
                                
                                strShowInHTML = "\(strIndex0)"
                                
                                let aIndex = self.xAxisValues.count
                                
                                if userActivity.reminder_id == 12 {
                                    // Before Eating
                                    

                                    
                                    if self.yAxisValues.count == aIndex
                                    {
                                        self.yAxisValues.remove(at: aIndex - 1)
                                    }else{
                                        self.yAxisValuesForSecond.append(0.0)

                                    }
                                    
                                    if strIndex0 == ""{
                                        self.yAxisValues.append(0.0)
                                    }else{
                                        
                                        
                                        if AppConstants.isArabic(){
                                
//                                            self.yAxisValuesForSecond.append(Double(convertNumberToArabic(aStr: strIndex0))!)
                                            self.yAxisValues.append(Double(convertNumberToArabic(aStr: strIndex0))!)
                                            
                                        }else{
                                            self.yAxisValues.append(Double(convertNumberToEnglish(aStr: strIndex0))!)
                                        }
                                    }
                                    
                                    
                                }else if userActivity.reminder_id == 13 {
                                
                                    // After Eating
                                    
                                    
                                    
                                    if self.yAxisValuesForSecond.count == aIndex
                                    {
                                        self.yAxisValuesForSecond.remove(at: aIndex - 1)
                                    }else{
                                        self.yAxisValues.append(0.0)

                                    }
                                    
                                    if strIndex0 == ""{
                                        self.yAxisValuesForSecond.append(0.0)
                                    }else{
                                        if AppConstants.isArabic(){
                                            
                                            
                                            self.yAxisValuesForSecond.append(Double(convertNumberToArabic(aStr: strIndex0))!)
                                            
                                        }else{
                                            self.yAxisValuesForSecond.append(Double(convertNumberToEnglish(aStr: strIndex0))!)
                                        }
                                        
                                    }
                                    
                                    
                                }
                                
                                
                            }
                            
                            
                            print("self.xAxisValues = \(self.xAxisValues)")
                            print("self.yAxisValues = \(self.yAxisValues)")
                            
                            
                            
                            if userActivity.reminder_id == 14 {
                                
                                if strIndex0 == ""{
                                    self.yAxisValues.append(0.0)
                                }else{

                                    if AppConstants.isArabic(){
                                        
                                        self.yAxisValues.append(Double(convertNumberToArabic(aStr: strIndex0))!)
                                        
                                    }else{
                                        self.yAxisValues.append(Double(convertNumberToEnglish(aStr: strIndex0))!)
                                    }
                                    
                                }
                                
                                if strIndex1 == ""{
                                    self.yAxisValuesForSecond.append(0.0)
                                }else{
                                    if AppConstants.isArabic(){
                                        
                                        //self.yAxisValues.append(Double(convertNumberToArabic(aStr: strIndex1))!)
                                        self.yAxisValuesForSecond.append(Double(convertNumberToArabic(aStr: strIndex1))!)
                                        
                                    }else{
                                        self.yAxisValuesForSecond.append(Double(convertNumberToEnglish(aStr: strIndex1))!)
                                    }
                                    
                                }
                                
                       
                            }
                            
                            aStrBodyOfHTML.append("<tr>")
                            
                            let aStrDate = userActivity.user_activity_date
                            let aStrTime = userActivity.user_activity_time
                            
                            var aStrShowDate = ""
                            var aStrShowTime = ""
                            
                            if AppConstants.isArabic(){
                                let aDate = getDateFromString(yyyyMMdd, aStrDate: aStrDate)
                                aStrShowDate = dayWholeFormatterAR.string(from: aDate)
                                
                                let aTime = getTimeFromString(HHmm, aStrDate: aStrTime)
                                aStrShowTime = TimeWholeFormatterAR.string(from: aTime)

                            }else{
                                aStrShowDate = aStrDate
                                aStrShowTime = aStrTime
                            }
                            
                            
                            
                            print("aStrDate = \(aStrDate)")
                            print("aStrShowDate = \(aStrShowDate)")
                            print("aStrShowTime = \(aStrShowTime)")
                            
                            var aFontName = String()
                            if (AppConstants.isArabic()) {
                                aFontName =  "GESSTextMedium-Medium"
                            }else{
                                aFontName =  "MyriadPro-Regular"
                            }
                            
                            aStrBodyOfHTML.append("<td style=\"text-align: center;\">\(aStrShowDate)</td><td style=\"text-align: center;\">\(aStrShowTime)</td><td style=\"text-align: center; font-family: '\(aFontName)'; font-size: 12pt;\">\(strShowInHTML)</td>")
                            
                            //<td style=\"text-align: center;\">NO NOTE</td>
                            aStrBodyOfHTML.append("</tr>")
                            break
                            
                        
                        }
                    
                    }
                }
                
            }
            
            print(aStrBodyOfHTML)
            
            
            print("\(aStrInitHTML)\(aStrBodyOfHTML)\(aStrEndHTML)")
            
            
            
            
            self.chartView.clearValues()
            if self.xAxisValues.count > 0 {
                self.scrollview.isHidden = false
                if ReportID == 12 ||  ReportID == 13 || ReportID == 14 {
                    self.chartView.isHidden = false
                    self.topWebViewConstraint.constant = 217
                    self.setChart(dataPoints: self.xAxisValues, values: self.yAxisValues, bloodPressure: self.txtMedicinePlan.text!)
                }
            }else{
                self.scrollview.isHidden = true
                self.topWebViewConstraint.constant = 5
                self.chartView.isHidden = true
            }
            
            self.webview.isHidden = true
            self.scrollview.isHidden = false
            self.webDiseaseView.isHidden = false
            
            self.webDiseaseView.loadHTMLString("\(aStrInitHTML)\(aStrBodyOfHTML)\(aStrEndHTML)", baseURL: nil)
            print(aStrBodyOfHTML)
            
            
        })
        
    }
    
    
    private func diseaseDropDown(sender: UIButton) {
        
        self.view.endEditing(true)
        
        if arrMutDiseaseTitle.count > 0 {
            
            var kpPickerView : KPPickerView?
            kpPickerView = KPPickerView.getFromNib()
            
            kpPickerView!.show(self , sender: sender , data: arrMutDiseaseTitle , defaultSelected: JMOLocalizedString(forKey: txtMedicinePlan.text!, value: "")) { (selectedObject , selectedIndex , isCancel) in
                
                print(selectedObject)
                let aSelectedDisease = self.arrMutDiseaseTitle[selectedIndex] as String
                
                if (aSelectedDisease == "Blood sugar" || aSelectedDisease == "Blood pressure"){
                    self.chartView.isHidden = false
                }else{
                    self.chartView.isHidden = true
                }
                
                
                // Set inital html part
          
                self.btnExport.isHidden = false
                self.btnGenerate.isHidden = false
                
                if !isCancel{
                    
                    if(self.checkDateValidation()){
                        if (self.selectedStartDate > self.selectedEndDate) {
                            UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey: "From Date is larger to date", value: ""), completion: { (index : Int, value : String) in
                                
                                
                            })
                        }else{
                            self.strSelectedObject = (selectedObject as? String)!
                            self.intSelectedIndex = selectedIndex
                            self.generateReportForDisease(selectedObject: self.strSelectedObject, selectedIndex: self.intSelectedIndex)
                        }
                        
                        
                    }
                    else{
                        UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey: "please select proper dates", value: ""), completion: { (index : Int, value : String) in
                            
                            
                        })
                    }
                   
                   
                }
                
           
            }
        }
    }
    
    func checkDateValidation() -> Bool {
        
        var aValidDates = false
        if (txtFieldFromDate.text == ""){
            aValidDates = false
        }
        else if (txtFieldToDate.text == ""){
            aValidDates = false
        }else{
            aValidDates = true
        }
//        else if selectedStartDate <= selectedEndDate {
//            aValidDates = true
//        }
        
        return aValidDates
    }
    
    func setChart(dataPoints: [Double], values: [Double], bloodPressure: String) {
        
        var dataEntries: [ChartDataEntry] = []
        var dataEntriesFor2: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            
            let timeIntervalForDate: TimeInterval = dataPoints[i]
            
            let dataEntry = ChartDataEntry(x: Double(timeIntervalForDate), y: Double(values[i]))
            let dataEntry2 = ChartDataEntry(x: Double(timeIntervalForDate), y: Double(self.yAxisValuesForSecond[i]))
            
            dataEntries.append(dataEntry)
            dataEntriesFor2.append(dataEntry2)
        }
        
        chartView.xAxis.labelPosition = .bottom
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: "")
        let lineChartData = LineChartData(dataSets: [lineChartDataSet])
        chartView.data = lineChartData
        
        let xaxis = chartView.xAxis
        
        chartView.xAxis.labelPosition = .bottom
        
        var FontName = String()
        if (AppConstants.isArabic()) {
            FontName =  "GESSTextMedium-Medium"
        }else{
            FontName =  "MyriadPro-Regular"
        }

        chartView.xAxis.labelFont = UIFont.init(name: FontName, size: 12)!
        chartView.leftAxis.labelFont = UIFont.init(name: FontName, size: 12)!
        
        
        chartView.rightAxis.enabled = false
        let data = LineChartData()
        data.clearValues()
        let ds = LineChartDataSet(entries: dataEntries, label: "SBP")
        ds.circleRadius = 2.0
        ds.circleHoleColor = UIColor.blue
        ds.circleColors = [UIColor.blue]
        ds.setColor(UIColor.blue.withAlphaComponent(0.5))
        
        data.addDataSet(ds)
        chartView.data = data
        
//        if bloodPressure.contains(JMOLocalizedString(forKey: "Blood pressure", value: "")) {
        let lineChartDataSet1 = LineChartDataSet(entries: dataEntriesFor2, label: "")
            let lineChartData1 = LineChartData(dataSets: [lineChartDataSet1])
            
            chartView.data = lineChartData1
            
        let ds1 = LineChartDataSet(entries: dataEntriesFor2, label: "DBP")
            ds1.circleHoleColor = UIColor.red
            ds1.circleRadius = 2.0
            ds1.circleColors = [UIColor.red]
            ds1.setColor(UIColor.red.withAlphaComponent(0.5))
            data.addDataSet(ds1)
            chartView.data = data
//        }
        
        self.chartView.animate(xAxisDuration: 4.0)
        xaxis.valueFormatter = axisFormatDelegate
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnSelectReportClick(_ sender: UIButton) {
        
        btnExport.isHidden = true
        btnGenerate.isHidden = true
        webview.isHidden = true
        scrollview.isHidden = true
        
        if sender.tag == 10 {
            // Medical
            
            txtMedicinePlan.text = ""
            txtMedicinePlan.placeholder = JMOLocalizedString(forKey: "Medicine plan*", value: "")
            
            
            sender.isSelected = true
            
            btnDiseaseReport.isSelected = false
            btnMedicalPalnReport.backgroundColor = GeneralConstants.hexStringToUIColor(hex: "#AD343E")
            btnDiseaseReport.backgroundColor = GeneralConstants.hexStringToUIColor(hex: "#E0DFCD")
            
        }else{
            // Disease

            txtMedicinePlan.text = ""
            txtMedicinePlan.placeholder = JMOLocalizedString(forKey: "Diseases*", value: "")
            sender.isSelected = true
            
            btnMedicalPalnReport.isSelected = false
            btnDiseaseReport.backgroundColor = GeneralConstants.hexStringToUIColor(hex: "#AD343E")
            btnMedicalPalnReport.backgroundColor = GeneralConstants.hexStringToUIColor(hex: "#E0DFCD")
            
        }
    }
    
    
    @IBAction func btnFromDateClick(_ sender: UIButton) {
        isFromDate = true
        if GeneralConstants.DeviceType.IS_IPAD {
            // iPad
            
            self.view.endEditing(true)
            
            MMDatePickerPopover.appearOn(originView: sender, baseViewController: self, title: "DatePicker", dateMode: .date, initialDate: nil, maxDate: Date(), timeFormat: nil, doneAction: { selectedDate in
                
                print("selectedDate \(selectedDate)")
                
                
                
                self.selectedStartDate = selectedDate
                
                self.setDateOnButton(dat: selectedDate, txtField: self.txtFieldFromDate)
                
            },
                                         cancelAction: {
                                            print("cancel")
            })
            
            
        }else{
            // iPhone
            
            datePicker.config.dateMode = .date
//            datePicker.config.minDate = Date()
            datePicker.config.maxDate = Date()
            datePicker.show(inVC: self)
        }
        
    }
    
    @IBAction func btnToDateClick(_ sender: UIButton) {
        
        isFromDate = false
        if GeneralConstants.DeviceType.IS_IPAD {
            // iPad
            
            self.view.endEditing(true)
            
            MMDatePickerPopover.appearOn(originView: sender, baseViewController: self, title: "DatePicker", dateMode: .date, initialDate:nil , maxDate: Date(), timeFormat: nil, doneAction: { selectedDate in
                
                print("selectedDate \(selectedDate)")
                
                self.selectedEndDate = selectedDate
                
                
                self.setDateOnButton(dat: selectedDate, txtField: self.txtFieldToDate)
                
            },
                                         cancelAction: {
                                            print("cancel")
            })
            
            
        }else{
            // iPhone
            
            datePicker.config.dateMode = .date
//            datePicker.config.minDate = Date()
            datePicker.config.maxDate = Date()
            
            datePicker.show(inVC: self)
        }
    }
    
    @IBAction func btnExportToPDFClick(_ sender: UIButton) {
        if(self.checkDateValidation()){
        
            if selectedStartDate > selectedEndDate {
                UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey: "From Date is larger to date", value: ""), completion: { (index : Int, value : String) in
                    
                    
                })
            }else{
            
                do {
                    let dst = getDestinationPath()
                    
                    if btnMedicalPalnReport.isSelected {
                        try PDFGenerator.generate([self.webview], to: dst)
                    }else{
                        try PDFGenerator.generate([self.webDiseaseView], to: dst)
                    }
                    
                    
                    sharePDFOnSocialMedia()
                    
                } catch (let e) {
                    print(e)
                }
            }
            
        }
        else{
            UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey: "please select proper dates", value: ""), completion: { (index : Int, value : String) in
                
                
            })
        }
        
        
    }
    
    @IBAction func btnGenerateReportClick(_ sender: UIButton) {
        
        if(self.checkDateValidation()){
        
            if selectedStartDate > selectedEndDate {
                UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey: "From Date is larger to date", value: ""), completion: { (index : Int, value : String) in
                    
                    
                })
            }else{
            
                if btnMedicalPalnReport.isSelected {
                    // Medicine plan report
                    
                    self.generateReportForMedicinePlan(selectedObject: strSelectedObject, selectedIndex: intSelectedIndex)
                    
                }else{
                    // Disease report
                    
                    self.generateReportForDisease(selectedObject: strSelectedObject, selectedIndex: intSelectedIndex)
                }
            }
            
        }
        else{
            UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey: "please select proper dates", value: ""), completion: { (index : Int, value : String) in
                
                
            })
        }
        
        
        
    }
    
    
    /// Setup datepicker
    
    fileprivate func setupDatePicker() {
        
        datePicker.delegate = self
        dateSelectedFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        dateSelectedFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        
//        dateSelectedFormatter.timeZone = NSTimeZone(abbreviation: "IST") as TimeZone!
//        dateSelectedFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if AppConstants.isArabic() {
            dateFormatter.locale = NSLocale(localeIdentifier: "ar") as Locale?
        }else{
            dateFormatter.locale = NSLocale(localeIdentifier: "en") as Locale?
        }
        datePicker.config.minDate = dateFormatter.date(from: "2000-12-31")
        datePicker.config.maxDate = dateFormatter.date(from: "3000-12-31")
        datePicker.config.startDate = Date()
        
    }
    
    //MARK: MMDatePickerDelegate
    
    /// Date picker delegate Done event
    ///
    /// - Parameters:
    ///   - amDatePicker: Picker object
    ///   - date: Selected date
    
    func mmDatePicker(_ amDatePicker: MMDatePicker, didSelect date: Date) {
        
        if isFromDate {
            setDateOnButton(dat: date, txtField: txtFieldFromDate)
            setToDate = date
            self.selectedStartDate = date
            
        }else{
            setDateOnButton(dat: date, txtField: txtFieldToDate)
            
            
            self.selectedEndDate = date
            
            DispatchQueue.main.asyncAfter(deadline: .now()+0.1, execute: {
                
                self.getMedicinePlanList()
                self.getDiseasesFromDB()
                
            })
            
        }
        
    }
    
    
    /// Date picker cancel delegate
    ///
    /// - Parameter amDatePicker: Picker object
    func mmDatePickerDidCancelSelection(_ amDatePicker: MMDatePicker) {
        // NOP
    }
    
    
    
    //MARK: Custom Methods
    
    fileprivate func setDateOnButton(dat: Date, txtField: UITextField) {
        let aStrDate = dateFormatter.string(from: dat)
        
        
        var aStrShowDate = ""
        if AppConstants.isArabic(){
            aStrShowDate = dayWholeFormatterAR.string(from: dat)
        }else{
            aStrShowDate = aStrDate
        }
        
//        txtField.text = aStrDate
        txtField.text = aStrShowDate
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
                                                            
                                                            if #available(iOS 10.0, *)
                                                            {
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
            // User profile
            //            self.performSegue(withIdentifier: SegueIdentifiers.ksegueIndependent.rawValue, sender: nil)
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
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Swift.Error?) {
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
        
        LanguageManager().localizeThingsInView(parentView: (self.view))
        LanguageManager().localizeThingsInView(parentView: (self.tabBarController?.view)!)
        
        btnMedicalPalnReport.setTitle(JMOLocalizedString(forKey: "Medical Plan Report", value: ""), for: .normal)
        btnDiseaseReport.setTitle(JMOLocalizedString(forKey: "Daily Recond Report", value: ""), for: .normal)
        
        if btnMedicalPalnReport.isSelected {
            
            txtMedicinePlan.text = ""
            txtMedicinePlan.placeholder = JMOLocalizedString(forKey: "Medicine plan*", value: "")
            
        }else{
            if txtMedicinePlan.text == JMOLocalizedString(forKey: "Blood sugar", value: "") {
                txtMedicinePlan.text = JMOLocalizedString(forKey: "Blood sugar", value: "")
            }else if txtMedicinePlan.text == JMOLocalizedString(forKey: "Blood pressure", value: "") {
                txtMedicinePlan.text = JMOLocalizedString(forKey: "Blood pressure", value: "")
            }else{
                txtMedicinePlan.text = ""
                txtMedicinePlan.placeholder = JMOLocalizedString(forKey: "Diseases*", value: "")
            }
        }
        
        LanguageManager().localizeThingsInView(parentView: self.txtFieldFromDate)
        LanguageManager().localizeThingsInView(parentView: self.txtFieldToDate)
        
        self.txtFieldFromDate.text = ""
        self.txtFieldToDate.text = ""
        self.chartView.isHidden = true
        self.webview.isHidden = true
        self.webDiseaseView.isHidden = true
        self.txtFieldFromDate.placeholder = JMOLocalizedString(forKey: "From Date", value: "")
        self.txtFieldToDate.placeholder = JMOLocalizedString(forKey: "To Date", value: "")
        
        customizeFonts(in: lblScreenTitle, aFontName: Medium, aFontSize: 0)
        customizeFonts(in: txtFieldFromDate, aFontName: Medium, aFontSize: 0)
        customizeFonts(in: txtFieldToDate, aFontName: Medium, aFontSize: 0)
        customizeFonts(in: btnDiseaseReport, aFontName: Medium, aFontSize: 0)
        customizeFonts(in: btnMedicalPalnReport, aFontName: Medium, aFontSize: 0)
        customizeFonts(in: txtMedicinePlan, aFontName: Medium, aFontSize: 0)

        
        btnExport.setTitle(JMOLocalizedString(forKey: "Export", value: ""), for: .normal)
        btnGenerate.setTitle(JMOLocalizedString(forKey: "Generate", value: ""), for: .normal)

        self.view.endEditing(true)
        
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
        
//        if btnMedicalPalnReport.isSelected {
//            // Medicine plan report
//            
//        }else{
//            // Disease report
//
//            self.chartView.isHidden = false
//        }
//
        
    }
    
    
    func sharePDFOnSocialMedia() {
        
        let textToShare = "Export PDF"
        
        let urlPDF = URL.init(fileURLWithPath: getDestinationPath())
        
        let activityVC = UIActivityViewController(activityItems: [urlPDF], applicationActivities: nil)
        
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone {
            self.present(activityVC, animated: true, completion: nil)
        }
        else{
            
            activityVC.popoverPresentationController?.sourceView = self.view
            activityVC.popoverPresentationController?.sourceRect = self.view.bounds
            
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    //MARK: HTML to PDF
    
    fileprivate func getDestinationPath() -> String {
        return NSHomeDirectory() + "/Documents/export.pdf"
    }
    
    private let dayWholeFormatterAR: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "ar") as Locale?
//        formatter.dateFormat = "MMMM dd, YYYY"
        formatter.dateFormat = yyyyMMdd
        return formatter
    }()
    
    private let dayWholeFormatterEN: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en") as Locale?
        //        formatter.dateFormat = "MMMM dd, YYYY"
        formatter.dateFormat = yyyyMMdd
        return formatter
    }()
    
    private let TimeWholeFormatterAR: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "ar") as Locale?
        //        formatter.dateFormat = "MMMM dd, YYYY"
        formatter.dateFormat = HHmm
        return formatter
    }()
    
    func getStringValueFromDate(_ format : String , date : Date) -> String {
        
        let dateFormatter  = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = NSTimeZone.local
        if AppConstants.isArabic() {
            dateFormatter.locale = NSLocale(localeIdentifier: "ar") as Locale?
        }else{
            dateFormatter.locale = NSLocale(localeIdentifier: "en") as Locale?
        }
        
        //        dateFormatter.timeZone = TimeZone(identifier: "UTC")
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        //    dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone!
        
        return dateFormatter.string(from: date)
    }
}


//let predicate = NSPredicate(format:"%@ >= addedDate AND %@ <= doneDate", txtFieldFromDate.text!, txtFieldToDate.text!)
//let searchResults = aObjMedicine.    filter(predicate)

// MARK: axisFormatDelegate
extension ReportVC: IAxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
    
}
