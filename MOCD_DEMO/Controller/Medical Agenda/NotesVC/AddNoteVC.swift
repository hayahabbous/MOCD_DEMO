//
//  AddNoteVC.swift
//  SmartAgenda
//
//  Created by indianic on 04/01/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit

class AddNoteVC: UIViewController, UITextViewDelegate, MMDatePickerDelegate {
    
    @IBOutlet weak var lblScreenTitle: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnAddNote: UIButton!
    @IBOutlet weak var txtNoteTitle: UITextField!
    @IBOutlet weak var btnNoteDate: UIButton!
    @IBOutlet weak var btnNoteTime: UIButton!
    @IBOutlet weak var txtNoteDate: UITextField!
    @IBOutlet weak var txtNoteTime: UITextField!
    @IBOutlet weak var txtViewAddComment: UITextView!
    
    var datePicker = MMDatePicker.getFromNib()
    var dateFormatter = DateFormatter()
    var dateSelectedFormatter = DateFormatter()
    var timeFormatter = DateFormatter()
    
    var aObjNotesModel = notesModel()
    
    var isBooltime = false
    var selectedDateTime: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        if AppConstants.isArabic()
        {
            btnBack.imageView?.transform = (btnBack.imageView?.transform.rotated(by: CGFloat(M_PI)))!
        }else{
            btnBack.imageView?.transform = (btnBack.imageView?.transform.rotated(by: CGFloat(M_PI*2)))!
        }
        
        setPadding()
        setupDatePicker()
        
        txtViewAddComment.text = JMOLocalizedString(forKey: "Add comment", value: "")
        
        if aObjNotesModel.identifier != nil {
//            txtNoteTitle.text = aObjNotesModel.title!
            txtNoteDate.text = aObjNotesModel.date!
//            txtNoteTime.text = aObjNotesModel.time!
            let commentsVar = (aObjNotesModel.comments == nil) ? "" : aObjNotesModel.comments
            if commentsVar!.contains(JMOLocalizedString(forKey: "Add comment", value: "")) {
                txtViewAddComment.textColor = GeneralConstants.ColorConstants.kColor_PlaceHolder
            }

            txtViewAddComment.text = commentsVar

            if commentsVar!.count > 0 {
                txtViewAddComment.textColor = GeneralConstants.ColorConstants.kColor_Black
            }
            
            
            btnAddNote.setTitle(JMOLocalizedString(forKey: "UPDATE", value: ""), for: .normal)
            
            lblScreenTitle.text = JMOLocalizedString(forKey: "EDIT NOTE", value: "")
            
        }else{
           txtNoteDate.text = dateFormatter.string(from: Date())
           txtNoteTime.text = timeFormatter.string(from: Date())
            
            btnAddNote.setTitle(JMOLocalizedString(forKey: "ADD", value: ""), for: .normal)
            
            lblScreenTitle.text = JMOLocalizedString(forKey: "ADD NOTE", value: "")
        }
        
        LanguageManager().localizeThingsInView(parentView: (self.view))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        
        LanguageManager().localizeThingsInView(parentView: (self.view))
        
        if (GeneralConstants.DeviceType.IS_IPAD) {
            customizeFonts(in: lblScreenTitle, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtNoteTitle, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtNoteDate, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtNoteTime, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtViewAddComment, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: btnAddNote, aFontName: Bold, aFontSize: 0)
        }else{
            customizeFonts(in: lblScreenTitle, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtNoteTitle, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtNoteDate, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtNoteTime, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: txtViewAddComment, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: btnAddNote, aFontName: Bold, aFontSize: 0)
        }
        
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnAddNoteAction(_ sender: UIButton) {
        
        if self.validateForm() {
            
            let objNotesModel = notesModel()
            if aObjNotesModel.identifier != nil {
                objNotesModel.identifier = aObjNotesModel.identifier!
            }
            objNotesModel.title = ""//self.txtNoteTitle.text!
            if objNotesModel.title.contains("'") {
                objNotesModel.title.replace("'", with: "")
            }
            objNotesModel.date = getTodayDateString(yyyyMMdd)
//            objNotesModel.time = self.txtNoteTime.text!
            objNotesModel.comments = self.txtViewAddComment.text!
            
            if objNotesModel.comments.contains("'") {
                objNotesModel.comments.replace("'", with: "")
            }
            
            if aObjNotesModel.identifier != nil {
                notesModel().updateNotes(objNoteModel: objNotesModel, complition: { (status) in
                    if status {
                        UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey: kUpdateNotesSuccess, value: ""), completion: { (Int, String) in
                            _ = self.navigationController?.popViewController(animated: true)
                        })
                    }
                })
            }
            else{
                notesModel().addNewNotes(objNoteModel: objNotesModel, complition: { (status) in
                    if status {
                        UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey: kAddNotesSuccess, value: ""), completion: { (Int, String) in
                            _ = self.navigationController?.popViewController(animated: true)
                        })
                    }
                })
            }
        }
    }
    
    @IBAction func btnDateAction(_ sender: UIButton) {
        if GeneralConstants.DeviceType.IS_IPAD {
            // iPad
            
            self.view.endEditing(true)
            
            MMDatePickerPopover.appearOn(originView: sender, baseViewController: self, title: "DatePicker", dateMode: .date, initialDate: Date(), maxDate: nil, timeFormat: nil, doneAction: { selectedDate in
                
                print("selectedDate \(selectedDate)")
                
                self.selectedDateTime = selectedDate
                
                
                self.setDateOnButton(dat: selectedDate, txtField: self.txtNoteDate)
                
            },
                                         cancelAction: {
                                            print("cancel")
            })
            
            
        }else{
            // iPhone
            
            isBooltime = false
            datePicker.config.dateMode = .date
            datePicker.config.minDate = Date()
            datePicker.show(inVC: self)
            
        }
        
    }
    
    @IBAction func btnTimeAction(_ sender: UIButton) {
        
        if GeneralConstants.DeviceType.IS_IPAD {
            // iPad
            
            self.view.endEditing(true)
            
            MMDatePickerPopover.appearOn(originView: sender, baseViewController: self, title: "TimePicker", dateMode: .time, initialDate: Date(), maxDate: nil, timeFormat: NSLocale(localeIdentifier: "en_GB"), doneAction: { selectedDate in
                
                print("selectedDate \(selectedDate)")
                self.selectedDateTime = selectedDate
                
                self.setTimeOnButton(dat: selectedDate, txtField: self.txtNoteTime)
                
                
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setPadding(){
        setTextFieldPadding(textfield: txtNoteTitle, padding: 5)
        setTextFieldPadding(textfield: txtNoteDate, padding: 5)
        setTextFieldPadding(textfield: txtNoteTime, padding: 5)
        txtViewAddComment.textColor = GeneralConstants.ColorConstants.kColor_PlaceHolder
    }
    
    /// Setup datepicker
    fileprivate func setupDatePicker() {
        
        datePicker.delegate = self
        dateSelectedFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateSelectedFormatter.locale = Locale(identifier: "en_US_POSIX")
//        dateSelectedFormatter.timeZone = NSTimeZone(abbreviation: "IST") as TimeZone!
        dateSelectedFormatter.timeZone = NSTimeZone.local
        dateFormatter.dateFormat = "yyyy-MM-dd"
        timeFormatter.dateFormat = "HH:mm"
        
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
    
    
    //MARK: MMDatePickerDelegate
    
    /// Date picker delegate Done event
    ///
    /// - Parameters:
    ///   - amDatePicker: Picker object
    ///   - date: Selected date
    func mmDatePicker(_ amDatePicker: MMDatePicker, didSelect date: Date) {
        
        selectedDateTime = date
        
        if isBooltime {
            
            setTimeOnButton(dat: date, txtField: self.txtNoteTime)
            
        }else{
            
            setDateOnButton(dat: date, txtField: self.txtNoteDate)
        }
        
    }
    
    
    /// Date picker cancel delegate
    ///
    /// - Parameter amDatePicker: Picker object
    func mmDatePickerDidCancelSelection(_ amDatePicker: MMDatePicker) {
        // NOP
    }
    
    
    //MARK: UITextViewDelegate
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == GeneralConstants.ColorConstants.kColor_PlaceHolder {
            textView.text = nil
            textView.textColor = GeneralConstants.ColorConstants.kColor_Black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = JMOLocalizedString(forKey: "Add comment", value: "")
            textView.textColor = GeneralConstants.ColorConstants.kColor_PlaceHolder
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // Remove placeholder
        if textView.textColor == GeneralConstants.ColorConstants.kColor_PlaceHolder && text.count > 0 {
            textView.text = ""
            textView.textColor = GeneralConstants.ColorConstants.kColor_Black
        }
        
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        
        return true
    }
    
    func validateForm () -> Bool{
        if !GeneralConstants.trimming(self.txtViewAddComment.text!) || JMOLocalizedString(forKey: "Add comment", value: "") == self.txtViewAddComment.text!{
            showAlert(message: JMOLocalizedString(forKey: kAddComment, value: ""))
            return false
        }
//        else if !GeneralConstants.trimming(self.txtNoteDate.text!) {
//            showAlert(message: JMOLocalizedString(forKey: kAddDate, value: ""))
//            return false
//        }
//        else if !GeneralConstants.trimming(self.txtNoteTime.text!) {
//            showAlert(message: JMOLocalizedString(forKey: kAddTime, value: ""))
//            return false
//        }
        else {
            return true
        }
    }
    
    fileprivate func showAlert(message: String) {
        UIAlertController.showAlertWithOkButton(self, aStrMessage: message, completion: { (Int, String) in
            
        })
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
