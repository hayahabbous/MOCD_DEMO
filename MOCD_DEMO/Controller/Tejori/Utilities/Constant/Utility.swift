//
//  Utility.swift
//  Edkhar
//
//  Created by indianic on 12/01/17.
//  Copyright © 2017 demo. All rights reserved.
//

import UIKit
import MessageUI
import SwiftyDropbox
import SSZipArchive
import SVProgressHUD

enum PickerType: String {
    case DatePicker = "Date"
    case TimePicker = "Time"
    case SimplePicker = "Simple"
}


class Utility: NSObject,UIPickerViewDelegate,UIPickerViewDataSource ,MFMailComposeViewControllerDelegate, SSZipArchiveDelegate{
    
    // MARK:singleton sharedInstance
    static let sharedInstance = Utility()
    
    //Picker
    typealias pickerCompletionBlock = (_ picker:AnyObject?, _ buttonIndex : Int,_ firstindex:Int) ->Void
    var pickerType :String?
    var datePicker : UIDatePicker?
    var simplePicker : UIPickerView?
    var pickerDataSource : NSMutableArray?
    var pickerBlock : pickerCompletionBlock?
    var pickerSelectedIndex :Int = 0
    var vc = UIViewController()
    var toolBar = UIToolbar()
    var isTextField = Bool()
    var txtF = UITextField()
    var btn = UIButton()
    
    //MARK: Picker
    
    func addPicker(_ controller:UIViewController,onTextFieldORButton:UIView,typePicker:String,pickerArray:[String], showMinDate : Bool,withCompletionBlock:@escaping pickerCompletionBlock) {
        
        self.pickerSelectedIndex = 0
        
        self.removePickerView()
        
        vc = controller
        
        var YConstantForPicker = CGFloat()
        if onTextFieldORButton is UITextField {
            txtF = onTextFieldORButton as! UITextField
            isTextField = true
        }
        else if onTextFieldORButton is UIButton{
            btn = onTextFieldORButton as! UIButton
            isTextField = false
        }
        
        pickerType = typePicker
        
        if isTextField{
            txtF.tintColor = UIColor.clear
            YConstantForPicker = 0
        }else{
            YConstantForPicker = CGFloat.screenHeight - 216 - 44
        }
        
        let keyboardDateToolbar = UIToolbar.init(frame: CGRect(x: 0, y: YConstantForPicker, width: controller.view.bounds.size.width, height: 44))
        
        keyboardDateToolbar.barTintColor = UIColor.colorFromRGB(R: 0.0, G: 132.0, B: 61.0, Alpha: 1.0)
        
        let flexSpace = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let done = UIBarButtonItem.init(title: JMOLocalizedString(forKey: "Done", value: ""), style: .done, target: self, action:  #selector(pickerDone))
        done.tintColor = UIColor.white
        
        //        let cancel = UIBarButtonItem.init(title: "Cancel", style: .done, target: self, action:  #selector(pickerCancel))
        //        cancel.tintColor = UIColor.white
        //
        
        let clear = UIBarButtonItem.init(title: JMOLocalizedString(forKey: "Clear", value: ""), style: .done, target: self, action:  #selector(textFieldClear))
        clear.tintColor = UIColor.white
        
        if isTextField {
            if AppConstants.isArabic() {
                keyboardDateToolbar.setItems([done,flexSpace,clear], animated: true)
            }
            else{
                keyboardDateToolbar.setItems([clear,flexSpace,done], animated: true)
            }
        }
        else{
            if AppConstants.isArabic() {
                keyboardDateToolbar.setItems([done], animated: true)
            }
            else{
                
                keyboardDateToolbar.setItems([flexSpace,done], animated: true)
            }
        }
        
        
        
        
        toolBar = keyboardDateToolbar
        
        if isTextField{
            txtF.inputAccessoryView = keyboardDateToolbar
        }else{
            keyboardDateToolbar.translatesAutoresizingMaskIntoConstraints = false
            controller.view.addSubview(keyboardDateToolbar)
            controller.view.bringSubviewToFront(keyboardDateToolbar)
            controller.view.addConstraints([
                NSLayoutConstraint(item: keyboardDateToolbar, attribute: .bottom, relatedBy: .equal, toItem: controller.view, attribute: .bottom, multiplier: 1, constant: -216),
                NSLayoutConstraint(item: keyboardDateToolbar, attribute: .leading, relatedBy: .equal, toItem: controller.view, attribute: .leading, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: keyboardDateToolbar, attribute: .trailing, relatedBy: .equal, toItem: controller.view, attribute: .trailing, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: keyboardDateToolbar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 44)
                ]
            )
        }
        
        
        if typePicker == "Date" {
            
            datePicker = UIDatePicker.init()
            
            if AppConstants.isArabic() {
                datePicker?.locale = Locale.init(identifier: "ar")
            }else{
                datePicker?.locale = Locale.init(identifier: "en")
            }
            
            
            datePicker!.backgroundColor = UIColor.white
            datePicker!.datePickerMode = .date
            if showMinDate == true {
                datePicker!.maximumDate = Date()
            }
            
            
            let dateFormatter = DateFormatter.init()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            if isTextField{
                if let date = dateFormatter.date(from: txtF.text!)
                {
                    datePicker?.date = date
                }
                txtF.inputView = datePicker
            }else{
                
                if ((btn.titleLabel?.text) != nil)  {
                    
                    if let date = dateFormatter.date(from: (btn.titleLabel?.text!)!)
                    {
                        datePicker?.date = date
                    }
                }else{
                    //                    let date = dateFormatter.date(from: (self.getStringFromDate("dd/MM/yyyy", date: Date())))
                    let date = dateFormatter.date(from: (self.getStringFromDate("yyyy-MM-dd", date: Date())))
                    datePicker?.date = date!
                    
                }
                
                
                //                if let date = dateFormatter.date(from: (btn.titleLabel?.text!)!)
                //                {
                //                    datePicker?.date = date
                //                }
                
                datePicker?.frame = CGRect(x: 0, y: YConstantForPicker+44, width: controller.view.bounds.size.width, height: 216)
                datePicker?.translatesAutoresizingMaskIntoConstraints = false
                controller.view.addSubview(datePicker!)
                controller.view.addConstraints([
                    NSLayoutConstraint(item: datePicker!, attribute: .bottom, relatedBy: .equal, toItem: controller.view, attribute: .bottom, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: datePicker!, attribute: .leading, relatedBy: .equal, toItem: controller.view, attribute: .leading, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: datePicker!, attribute: .trailing, relatedBy: .equal, toItem: controller.view, attribute: .trailing, multiplier: 1, constant: 0)
                    ]
                )
                datePicker?.addConstraint(
                    NSLayoutConstraint(item: datePicker!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 216)
                )
            }
            
        }  else if typePicker == "Time" {
            
            datePicker = UIDatePicker.init()
            datePicker!.backgroundColor = UIColor.white
            datePicker!.datePickerMode = .time
            
            if showMinDate == true {
                datePicker!.maximumDate = Date()
            }
            datePicker!.date = Date()
            if isTextField{
                txtF.inputView = datePicker
            }else{
                datePicker?.frame = CGRect(x: 0, y: YConstantForPicker+44, width: controller.view.bounds.size.width, height: 216)
                datePicker?.translatesAutoresizingMaskIntoConstraints = false
                
                controller.view.addSubview(datePicker!)
                
                controller.view.addConstraints([
                    NSLayoutConstraint(item: datePicker!, attribute: .bottom, relatedBy: .equal, toItem: controller.view, attribute: .bottom, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: datePicker!, attribute: .leading, relatedBy: .equal, toItem: controller.view, attribute: .leading, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: datePicker!, attribute: .trailing, relatedBy: .equal, toItem: controller.view, attribute: .trailing, multiplier: 1, constant: 0)
                    ]
                )
                datePicker?.addConstraint(
                    NSLayoutConstraint(item: datePicker!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 216)
                )
            }
            
            
        } else {
            pickerDataSource = NSMutableArray.init(array: pickerArray)
            simplePicker = UIPickerView.init()
            simplePicker!.backgroundColor = UIColor.white
            simplePicker!.delegate = self
            simplePicker!.dataSource = self
            
            if isTextField{
                if let index = pickerArray.index(of: txtF.text!) {
                    simplePicker!.selectRow(index, inComponent: 0, animated: true)
                }
                txtF.inputView = simplePicker
            }else{
                if let index = pickerArray.index(of: (btn.titleLabel?.text!)!) {
                    simplePicker!.selectRow(index, inComponent: 0, animated: true)
                }
                simplePicker?.frame = CGRect(x: 0, y: YConstantForPicker+44, width: controller.view.bounds.size.width, height: 216)
                
                simplePicker?.translatesAutoresizingMaskIntoConstraints = false
                
                controller.view.addSubview(simplePicker!)
                
                controller.view.addConstraints([
                    NSLayoutConstraint(item: simplePicker!, attribute: .bottom, relatedBy: .equal, toItem: controller.view, attribute: .bottom, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: simplePicker!, attribute: .leading, relatedBy: .equal, toItem: controller.view, attribute: .leading, multiplier: 1, constant: 0),
                    NSLayoutConstraint(item: simplePicker!, attribute: .trailing, relatedBy: .equal, toItem: controller.view, attribute: .trailing, multiplier: 1, constant: 0)
                    ]
                )
                simplePicker?.addConstraint(
                    NSLayoutConstraint(item: simplePicker!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 216)
                )
            }
            
        }
        pickerBlock = withCompletionBlock
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerDataSource != nil) {
            return pickerDataSource!.count;
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource![row] as? String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        
        pickerSelectedIndex = row
    }
    
    @objc func pickerDone()
    {
        self.removePickerView()
        print(pickerBlock!)
        if pickerType == "Date" {
            
            pickerBlock!(datePicker!,1,0)
        } else if pickerType == "Time"  {
            pickerBlock!(datePicker!,1,0)
        } else {
            pickerBlock!(simplePicker!,1,pickerSelectedIndex)
        }
        
    }
    
    func pickerCancel()
    {
        self.removePickerView()
        pickerBlock!(nil,0,0)
    }
    
    @objc func textFieldClear(){
        txtF.text = ""
    }
    
    func removePickerView(){
        toolBar.removeFromSuperview()
        datePicker?.removeFromSuperview()
        simplePicker?.removeFromSuperview()
    }
    func validateBlank(strVal: String) -> Bool {
        
        let strValue = self.removeWhiteSpace(strVal: strVal)
        
        if (strValue.count <= 0) {
            return false
        }
        return true
    }
    
    func removeWhiteSpace(strVal: String) -> String {
        let strValue = strVal.trimmingCharacters(in: NSMutableCharacterSet.whitespaceAndNewline() as CharacterSet)
        return strValue
    }
    
    func validatePhoneNumber(_ strPhoneNum : String?) -> Bool {
        let strValue = self.removeWhiteSpace(strVal: strPhoneNum!)
        if self.validateMinimumMaximumValue(minimumValue: 8, maximumValue: 16, strVal: strValue){
            //            let aCharcterSet = NSMutableCharacterSet.decimalDigit()
            ////            aCharcterSet.addCharacters(in: "'-*+#,;. ")
            //            let boolValidator = self.validateInCharacterSet(aCharcterSet, strVal: strValue)
            //            if boolValidator == false {
            //                return false
            //            }
            return true
        }else{
            return false
        }
    }
    
    //    func validateInCharacterSet(_ characterSet : NSMutableCharacterSet , strVal : String?) -> Bool {
    //        let range = strVal?.rangeOfCharacter(from: characterSet.inverted)
    //        if range.location != NSNotFound {
    //            return false
    //        }
    //        return true
    //    }
    
    
    func validateMinimumMaximumValue(minimumValue : Float,maximumValue : Float , strVal : String?) -> Bool {
        if let strValue = Float(self.removeWhiteSpace(strVal: strVal!)) {
            if strValue >= minimumValue && strValue <= maximumValue {
                return true
            }
        }
        return false
    }
    
    func getStringFromDate(_ format : String , date : Date) -> String {
        
        let dateFormatter  = DateFormatter()
        dateFormatter.dateFormat = format
        //                dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        return dateFormatter.string(from: date)
        
    }
    
    func getDateFromString(_ format : String , aStrDate : String) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: aStrDate)
        
        return date!
    }
    
    func showAlert(_ controller: UIViewController, message: String)  -> Void {
        let alertController = UIAlertController(title:  JMOLocalizedString(forKey: "Edkhar", value: ""), message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: JMOLocalizedString(forKey: "OK", value: ""), style: .default, handler: nil)
        alertController.addAction(okAction)
        controller.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertWithTitleMsg(_ controller: UIViewController, title: String, message: String) -> Void {
        
        let alertController = UIAlertController(title:  title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: JMOLocalizedString(forKey: "OK", value: ""), style: .default, handler: nil)
        alertController.addAction(okAction)
        controller.present(alertController, animated: true, completion: nil)
    }
    
    func setPaddingAndShadowForUIComponents(parentView: UIView) -> Void{
        for view in parentView.subviews{
            if view is UITextField {
                let txtF = view as! UITextField
                self.setPaddingForTextField(left: 10, right: 10, txtF: txtF)
                self.setShadowForView(view: txtF)
            }
            if view.subviews.count > 0 {
                self.setPaddingAndShadowForUIComponents(parentView: view)
            }
        }
    }
    
    func setPaddingForTextField(left: CGFloat, right: CGFloat, txtF: UITextField){
        let leftPaddingView = UIView(frame:CGRect(x: 0, y: 0, width: left, height: txtF.bounds.size.height))
        let rightPaddingView = UIView(frame:CGRect(x: 0, y: 0, width: right, height: txtF.bounds.size.height))
        txtF.leftView=leftPaddingView
        txtF.rightView = rightPaddingView
        txtF.leftViewMode = UITextField.ViewMode.always
    }
    
    func setShadowForView(view: UIView){
        let shadowPath = UIBezierPath(rect: view.bounds)
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowPath = shadowPath.cgPath
    }
    
    func getDayOfWeek(today:String)->Int {
        
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todayDate = formatter.date(from: today)!
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let myComponents = myCalendar.components(.weekday, from: todayDate)
        let weekDay = myComponents.weekday
        return weekDay!
    }
    
    
    func setStatusBarBackgroundColor(color: UIColor) {
        
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        
        statusBar.backgroundColor = color
    }
    
    func uicolorFromHex(rgbValue:UInt32)->UIColor {
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
    
    
    func customizeFonts(in tmpView: UIView, aFontName: String, aFontSize: CGFloat) {
        
        var fontName: String = ""
        var fontSize = aFontSize
        
        let aStrUserdefultLanguage = UserDefaults.standard.value(forKey: "Language") as? String
        
        
        if((aStrUserdefultLanguage != nil) && aStrUserdefultLanguage == "ar")
        {
            if aFontName == "light" {
                fontName = AppFonts.kGESSUltraLight.rawValue
                if (ConstantsT.DeviceType.IS_IPAD) {
                    fontSize = fontSize + 2
                }
                else{
                    fontSize = fontSize + 1
                }
            }else if aFontName == "Medium" {
                fontName = AppFonts.kGESSMedium.rawValue
            }
            else if ((aFontName == "Bold") || (aFontName == "SemiBold")) {
                fontName = AppFonts.kGESSBold.rawValue
            }
            
        }
        else {
            
            if aFontName == "light" {
                fontName = AppFonts.kMyriadProLight.rawValue
            }else if aFontName == "Medium" {
                fontName = AppFonts.kMyriadProMedium.rawValue
            }
            else if aFontName == "Bold" {
                fontName = AppFonts.kMyriadProBold.rawValue
            }
            else if aFontName == "SemiBold" {
                fontName = AppFonts.kMyriadProSemibold.rawValue
            }
            else if aFontName == "Black" {
                fontName = AppFonts.kMyriadProBlack.rawValue
            }
            else if aFontName == "Cond" {
                fontName = AppFonts.kMyriadProCond.rawValue
            }
            else if aFontName == "SemiCn" {
                fontName = AppFonts.kMyriadProSemiCn.rawValue
            }
        }
        
        
        if (tmpView is UILabel) {
            (tmpView as? UILabel)?.font = UIFont(name: fontName, size: CGFloat(((tmpView as? UILabel)?.font?.pointSize)! + fontSize))
        }
        else if (tmpView is UIButton) {
            (tmpView as? UIButton)?.titleLabel?.font = UIFont(name: fontName, size: CGFloat(((tmpView as? UIButton)?.titleLabel?.font?.pointSize)! + fontSize))
        }
        else if (tmpView is UITextView) {
            (tmpView as? UITextView)?.font = UIFont(name: fontName, size: CGFloat(((tmpView as? UITextView)?.font?.pointSize)! + fontSize))
        }
        else if (tmpView is UITextField) {
            (tmpView as? UITextField)?.font = UIFont(name: fontName, size: CGFloat(((tmpView as? UITextField)?.font?.pointSize)! + fontSize))
        }
        else{
            for v in tmpView.subviews {
                if (v is UILabel) {
                    (v as? UILabel)?.font = UIFont(name: fontName, size: CGFloat(((v as? UILabel)?.font?.pointSize)! + fontSize))
                }
                else if (v is UIButton) {
                    (v as? UIButton)?.titleLabel?.font = UIFont(name: fontName, size: CGFloat(((v as? UIButton)?.titleLabel?.font?.pointSize)! + fontSize))
                }
                else if (v is UITextView) {
                    (v as? UITextView)?.font = UIFont(name: fontName, size: CGFloat(((v as? UITextView)?.font?.pointSize)! + fontSize))
                }
                else if (v is UITextField) {
                    
                    (v as? UITextField)?.font = UIFont(name: fontName, size: CGFloat(((v as? UITextField)?.font?.pointSize)! + fontSize))
                }
                else if v.subviews.count > 0 {
                    self.customizeFonts(in: v, aFontName: aFontName, aFontSize: fontSize)
                }
            }
        }
        
    }
    
    func sendEmail(_ controller: UIViewController, aStrToMailID : [String] , aStrMailSubject : String, aStrMailBody : String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(aStrToMailID)
            mail.setSubject(aStrMailSubject)
            mail.setMessageBody(aStrMailBody, isHTML: false)
            controller.present(mail, animated: true, completion: nil)
        } else {
            // show failure alert
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    
    func shareAppOnSocialMedia(_ controller: UIViewController, aStrShareMSG : String) {
        // text to share
        if let myWebsite = NSURL(string: "http://www.google.com/") {
            let objectsToShare = [aStrShareMSG, myWebsite] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            activityVC.popoverPresentationController?.sourceView = controller.view
            controller.present(activityVC, animated: true, completion: nil)
        }
    }
    
    
    func UploadFileToDropboxAC() -> Void {
        
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        let filePath = url.appendingPathComponent("Edkhar.sqlite")?.path
        let fileManager = FileManager.default
        
        let zipPath =  path.appendingFormat("/MyZipFiles")
        let zipPathCopy =  path.appendingFormat("/MyZipFiles/Edkhar.sqlite")
        let success = fileManager.fileExists(atPath: zipPath) as Bool
        if success == false {
            do {
                try! fileManager.createDirectory(atPath: zipPath, withIntermediateDirectories: false, attributes: nil)
                
            }
        }
        
        let successok = fileManager.fileExists(atPath: zipPathCopy) as Bool
        if successok == false {
            do {try! fileManager.copyItem(atPath: filePath!, toPath: zipPathCopy)}
        }
        
        let archivePath = path.appendingFormat("/Edkhar.zip") // Sample folder is going to zip with name Demo.zip
        
        
        let successfile = fileManager.fileExists(atPath: archivePath) as Bool
        if successfile == true {
            do {
                try! fileManager.removeItem(atPath: archivePath)
                
            }
        }
        
        SSZipArchive.createZipFile(atPath: archivePath, withContentsOfDirectory:zipPath)
        
        print("zip archivePath = \(archivePath)")
        print("zip zipPath = \(zipPath)")
        
        
        if fileManager.fileExists(atPath: archivePath) {
            
            print("FILE AVAILABLE")
            
            // Verify user is logged into Dropbox
            let fileURL =  NSURL(fileURLWithPath: archivePath) as URL
            
            if let client = DropboxClientsManager.authorizedClient {
                
                client.files.deleteV2(path: "/Edkhar.zip")
                
                client.files.upload(path: "/Edkhar.zip", mode: .overwrite, autorename: false, clientModified: nil, mute: true, input: fileURL).response { response, error in
                    if let metadata = response {
                        print("*** Upload file ****")
                        print("Uploaded file name: \(metadata.name)")
                        print("Uploaded file revision: \(metadata.rev)")
                        client.files.getMetadata(path: "/Edkhar.zip").response { response, error in
                            print("*** Get file metadata ***")
                            if let metadata = response {
                                if let file = metadata as? Files.FileMetadata {
                                    print("This is a file with path: \(file.pathLower)")
                                    print("File size: \(file.size)")
                                } else if let folder = metadata as? Files.FolderMetadata {
                                    print("This is a folder with path: \(folder.pathLower)")
                                }
                            } else {
                                print(error!)
                                Utility.sharedInstance.showAlert(appDelegate.topMostController(), message: JMOLocalizedString(forKey: "the backup process failed", value: ""))
                            }
                        }
                    }
                }
                
            }
            
            SVProgressHUD.dismiss()
            
        } else {
            print("FILE NOT AVAILABLE")
            Utility.sharedInstance.showAlert(appDelegate.topMostController(), message: JMOLocalizedString(forKey: "the backup process failed", value: ""))
        }
        
    }
    
    func DownloadFileFromDropboxAC(completionBlock:@escaping (_ status: Bool) -> Void) -> Void {
        
        var aDownloadRestoreStatus = false
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        
        let fileManager = FileManager.default
        let dbfilepath =  path.appendingFormat("/Edkhar.sqlite")
        let dbfilezippath =  path.appendingFormat("/Edkhar.zip")
        
        let success = fileManager.fileExists(atPath: dbfilezippath) as Bool
        if success == true {
            do {
                try! fileManager.removeItem(atPath: dbfilezippath)

            }
        }
        
        if fileManager.fileExists(atPath: path.appendingFormat("%@","/")) {
            
            print("FILE AVAILABLE")
            
            // Verify user is logged into Dropbox
            
            if let client = DropboxClientsManager.authorizedClient {
                // Download to URL
                let directoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let destURL = directoryURL.appendingPathComponent("Edkhar.zip")
                let destination: (URL, HTTPURLResponse) -> URL = { temporaryURL, response in
                    return destURL
                }
                
//                let success = fileManager.fileExists(atPath: dbfilepath) as Bool
//                if success == true {
//                    do {
//                        try! fileManager.removeItem(atPath: dbfilepath)
//                        
//                    }
//                }
                
                let url = URL(fileURLWithPath: path)
                let unzipfilepath = path + "/Edkhar"
//                let unzipfilepath = path
                let unzipfilepathurl = URL(fileURLWithPath: unzipfilepath)
                
                do {
                    try FileManager.default.createDirectory(at: unzipfilepathurl, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    
                }
                
                client.files.download(path: "/Edkhar.zip", overwrite: true, destination: destination)
                    .response { response, error in
                        if let response = response {
                            
                            print(response)
                            
                            let success = fileManager.fileExists(atPath: dbfilepath) as Bool
                            if success == true {
                                do {
                                    try! fileManager.removeItem(atPath: dbfilepath)
                                    
                                }
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                                
                                let success = SSZipArchive.unzipFile(atPath: dbfilezippath, toDestination: unzipfilepathurl.path)
                                
                                if success {
                                    
                                    let successok = fileManager.fileExists(atPath: unzipfilepath + "/Edkhar.sqlite") as Bool
                                    let filePath = url.appendingPathComponent("Edkhar.sqlite").path
                                    let filePath1 = url.appendingPathComponent("/").path
                                    if successok == true {
                                        
                                        let sourceFilepath = unzipfilepath + "/Edkhar.sqlite"
                                        
                                        print("sourceFilepath = \(sourceFilepath)")
                                        print("Distination filePath = \(filePath)")
                                        print("Distination filePath = \(filePath1)")
                                        
                                        do {try! fileManager.copyItem(atPath: sourceFilepath, toPath: filePath
                                            )}catch let error as NSError {
                                                print("Ooops! Something went wrong: \(error)")
                                        }

//                                        do {
//                                            try! fileManager.replaceItem(at: NSURL(string: filePath) as! URL, withItemAt: NSURL(string: sourceFilepath)  as! URL, backupItemName: "test", options: FileManager.ItemReplacementOptions.usingNewMetadataOnly, resultingItemURL: nil)
//                                        }catch let error as NSError {
//                                            print("Ooops! Something went wrong: \(error)")
//                                        }
                                        
                                        
                                        aDownloadRestoreStatus = true
                                        completionBlock(aDownloadRestoreStatus)
                                        if currentViewContoller != nil{
                                            
                                            if  (currentViewContoller != nil) && (currentViewContoller is SignupVC) {
                                                
                                                let aSingupvc =  currentViewContoller as! SignupVC
                                                aSingupvc.aDropboxBackup = 1
                                                
                                            }
                                            
                                            currentViewContoller?.viewWillAppear(true)
                                            
                                        }
                                    }
                                    
                                    return
                                }
                                
                            })
                        }
                        else if let error = error {
                            print(error)
                            if currentViewContoller != nil{
                                AppDelegate().appDelegateShared().isNoBackupAvailable = true
                                currentViewContoller?.viewWillAppear(true)
                            }
                            aDownloadRestoreStatus = false
                            completionBlock(aDownloadRestoreStatus)
                        }
                    }
                    .progress { progressData in
                        print(progressData)
                }
                
                
            }
            
            
        } else {
            print("FILE NOT AVAILABLE")
        }
    }
    
    func convertDoubleToString(aStr: String) -> String{
        let aEndIndex = aStr.index(aStr.endIndex, offsetBy: -2)
        let aStrVal = aStr.substring(to: aEndIndex)
        return aStrVal
    }
    
    func convertNumberToEnglish(aStr: String) -> String{
        let Formatter: NumberFormatter = NumberFormatter()
        Formatter.locale = Locale.init(identifier: "EN")
        if let final = Formatter.number(from: aStr) {
            print(final)
            return final.stringValue
        }
        return ""
    }
    
    func showAlertWithCompletion( controller: UIViewController,  message: String,withCompletionBlock:@escaping (_ status: Bool) -> Void){
        let alertController = UIAlertController(title:  JMOLocalizedString(forKey: "Edkhar", value: ""), message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: JMOLocalizedString(forKey: "YES", value: ""), style: .default) { (action) in
            withCompletionBlock(true)
        }
        let cancelAction = UIAlertAction(title: JMOLocalizedString(forKey: "NO", value: ""), style: .default) { (action) in
            withCompletionBlock(false)
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        controller.present(alertController, animated: true, completion: nil)
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
    
    func getNumberOfDaysInMonth(month: Int, year: Int) -> Int {
        let dateComponents = DateComponents(year: year, month: month)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        return numDays
    }
    
    func getYearFromTodayDate() -> Int {
        let year = Calendar.current.component(.year, from: Date())
        return year
    }
    
    func getMonthFromTodayDate() -> Int {
        let year = Calendar.current.component(.month, from: Date())
        return year
    }
    
    func getDayFromTodayDate() -> Int {
        let year = Calendar.current.component(.day, from: Date())
        return year
    }
    
    func getWeekFromTodayDate() -> Int {
        let year = Calendar.current.component(.weekOfMonth, from: Date())
        return year
    }
    
    func getWeekFromTodayDateOfYear() -> Int {
        let year = Calendar.current.component(.weekOfYear, from: Date())
        return year
    }
    
    func getTodaysDaysFromTodayDateOfYear() -> Int {
        let year = Calendar.current.component(.day, from: Date())
        return year
    }
    
    func getNumberofDaysInMonth(aYear : Int, aMonth : Int) -> Int{
        let dateComponents = DateComponents(year: aYear, month: aMonth)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        print(numDays) // 31
        
        return numDays
    }
    
    
}

//MARK :- UIColor extension

extension UIColor{
    
    @nonobjc public static let themeColor : UIColor = UIColor(red: 194.2/255.0, green: 154.3/255.0, blue: 33.4/255.0, alpha: 1.0)
    
    public static func themeColorWithAlpha(_ Alpha:CGFloat ) -> UIColor{
        return UIColor(red: 249/255.0, green: 164/255.0, blue: 118/255.0, alpha: Alpha)
    }
    
    public static func colorFromRGB(R r:CGFloat, G:CGFloat, B:CGFloat, Alpha:CGFloat ) -> UIColor{
        return UIColor(red: r/255.0, green: G/255.0, blue: B/255.0, alpha: Alpha)
    }
}

extension CGFloat{
    @nonobjc public static let screenWidht : CGFloat = UIScreen.main.bounds.width
    @nonobjc public static let screenHeight: CGFloat = UIScreen.main.bounds.height
    
}

extension String
{
    var isNumeric: Bool
    {
        let range = self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted)
        return (range == nil)
    }
}

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}

