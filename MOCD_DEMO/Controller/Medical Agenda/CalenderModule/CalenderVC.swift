    //
    //  CalenderVC.swift
    //  SwiftDatabase
    //
    //  Created by indianic on 30/12/16.
    //  Copyright © 2016 demo. All rights reserved.
    //
    
    import UIKit
    import FSCalendar
    import SVProgressHUD
    import UserNotifications
    import SwiftyDropbox
    import MessageUI
    
    
    class CalenderVC: UIViewController, FSCalendarDataSource, FSCalendarDelegate , FSCalendarDelegateAppearance,MFMailComposeViewControllerDelegate {
        
        
        // Variables
        
        var strSelectedDate : String = ""
        var strStartDateOfMonth : String = ""
        var strEndDateOfMonth : String = ""
        var arrEventDates = [String]()
        var arrAppoinetmentList = [ReminderModel]()
        var arrAppoinetmentMasterList = [ReminderModel]()
        var objReminderCalModel = ReminderModel()
        var aOjbStartDate = Date()
        var aOjbEndDate = Date()
        var aStrStartDate = ""
        var eventCount : Int = 0
        
        
        // MARK: - Properties & Outlets
        @IBOutlet weak var calendar: FSCalendar!
        @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
        
        @IBOutlet weak var viewGuesture: UIView!
        
        @IBOutlet weak var lblScreenTitle: UILabel!
        @IBOutlet var lblDay: UILabel!
        @IBOutlet weak var monthLabel: UILabel!
        
        @IBOutlet var imgMark: UIImageView!
        
        @IBOutlet var btnPrevious: UIButton!
        @IBOutlet var btnNext: UIButton!
        
        @IBOutlet var lblQMonth: UILabel!
        @IBOutlet var lblQOwner: UILabel!
        
        
        //MARK: ViewController Methods
        override func viewDidLoad() {
            
            super.viewDidLoad()
            
            //        if AppConstants.isArabic()
            //        {
            //            btnPrevious.imageView?.transform = (btnPrevious.imageView?.transform.rotated(by: CGFloat(M_PI)))!
            //            btnNext.imageView?.transform = (btnNext.imageView?.transform.rotated(by: CGFloat(M_PI)))!
            //            imgMark.transform = (imgMark.transform.rotated(by: CGFloat(M_PI)))
            //
            //        }else{
            //            btnPrevious.imageView?.transform = (btnPrevious.imageView?.transform.rotated(by: CGFloat(M_PI*2)))!
            //            btnNext.imageView?.transform = (btnNext.imageView?.transform.rotated(by: CGFloat(M_PI*2)))!
            //            imgMark.transform = (imgMark.transform.rotated(by: CGFloat(M_PI * 2)))
            //
            //        }
            
            // Setup Calendar
            self.calendar.appearance.caseOptions = [.headerUsesUpperCase,.weekdayUsesUpperCase]
            self.calendar.appearance.headerTitleColor = GeneralConstants.hexStringToUIColor(hex: GeneralConstants.ColorConstants.k_Calendar_Day_Heading_46_Regular)
            self.calendar.appearance.titleDefaultColor = GeneralConstants.hexStringToUIColor(hex: GeneralConstants.ColorConstants.k_Calendar_Date_55_Light)
            self.calendar.appearance.titleFont = UIFont(name: FontName.kMyriadProLight.rawValue, size: 15)
            self.calendar.appearance.weekdayFont = UIFont(name: FontName.kMyriadProRegular.rawValue, size: 13)
       
            AppDelegate().appDelegateShared().strCurrentMonth = getStringFromDate("MM", date: calendar.currentPage)
            
            if GeneralConstants.DeviceType.IS_IPHONE_5 {
                self.calendar.appearance.imageOffset = CGPoint(x: 0, y: 4)
            }else{
                self.calendar.appearance.imageOffset = CGPoint(x: 0, y: -3)
            }
            
            
            self.calendar.register(DIYCalendarCell.self, forCellReuseIdentifier: "cell")
            self.calendar.clipsToBounds = true // Remove top/bottom line
            
            self.calendar.select(Date())
            self.calendar.scope = .month
            self.calendar.scopeGesture.isEnabled = false
            
            
            strSelectedDate = getStringFromDate("yyyy-MM-dd", date: calendar.selectedDate!)
            
            
            let CurrentCalMonth = getMonthFromDate(aDate: calendar.currentPage)
            kSelectedCalMonth = CurrentCalMonth
            print("kSelectedCalMonth = \(kSelectedCalMonth)")
            
            self.HandleQuoteByCalender(calendar)
            
            // Register Local notification
            self.RegistreLocalNotifications()
            
        }
        
        override func viewWillAppear(_ animated: Bool) {
            
            SVProgressHUD.show()
            
            if (appDelegate.aDropboxBackup == 1){
            
                var reminderObj = [ReminderModel]()
                
                ReminderModel().getAllReminder(completion: { (reminders: [ReminderModel]) in
                    
                    if reminderObj.count > 0{
                       reminderObj.removeAll()
                    }
                    
                    reminderObj = reminders
                })
                
                SettingsVC().setNotifications(reminderModelObjs: reminderObj)
                
                appDelegate.aDropboxBackup = 0
                

            }
            
//            _calendar.appearance.headerDateFormat = [NSDateFormatter dateFormatFromTemplate:@"MMMM yy" options:0 locale:[NSLocale localeWithLocaleIdentifier:@"en-US"]];
            
            
            

            // Set the current month on calender vc - view will appear
            self.calendar.setCurrentPage(Date(), animated: false)
            
            
            
            
            appDelegate.aDropboxBackup = 0
            
            // Hide Navigation bar
            self.navigationController?.navigationBar.isHidden = true
            
            // Language selection call
            self.LanguageSelectionMethod()
            
            
            customizeFonts(in: lblDay, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: monthLabel, aFontName: Medium, aFontSize: 0)
            
            aStrStartDate = getCurrentYearStartDate()!
            
            self.fetchEventsForCalender(aStrStartDate, aStrEndDateOfMonth: getStartEndDateOfMonth()[1]) { (obj: [ReminderModel]) in
                
                self.addDatesForEvents {
                    self.calendar.reloadData()
                    
                    print(arrAppoinetmentList)
                    SVProgressHUD.dismiss()
                }
            }
           
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        //MARK: Custom Private Method
        fileprivate func RegistreLocalNotifications() -> Void {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
            dateFormatter.timeZone = NSTimeZone.local
//            let aReminderDate = dateFormatter.date(from: "10-01-2017 19:33")!
//            print("aReminderDate = \(aReminderDate)")
            //        appDelegate.scheduleNotification(at: aReminderDate)
        }
        
        fileprivate func getStartEndDateOfMonth() -> [String] {
            
            var aArrStartEnd = [String]()
            
            strStartDateOfMonth = getStringFromDate("yyyy-MM-dd", date:calendar.currentPage)
            aArrStartEnd.append(strStartDateOfMonth)
            strStartEndDateOfMonth.append(strStartDateOfMonth)
            
            let currentMonth = self.calendar.currentPage
            let nextMonth = self.gregorian.date(byAdding: .month, value: 1, to: currentMonth, options: .init(rawValue: 0))
            let lastDateofCurrentMonth = self.gregorian.date(byAdding: .day, value: -1, to: nextMonth!, options: .init(rawValue: 0))
            strEndDateOfMonth = getStringFromDate("yyyy-MM-dd", date:lastDateofCurrentMonth!)
            
            aArrStartEnd.append(strEndDateOfMonth)
            strStartEndDateOfMonth.append(strEndDateOfMonth)
            
            return aArrStartEnd
        }
        
        fileprivate func fetchEventsForCalender(_ aStrStartDateOfMonth : String, aStrEndDateOfMonth : String, completion: (([ReminderModel]) -> Void)) {
            
            userInfoManager.sharedInstance.GetAllCalenderAppointmentList(aStrStartDateOfMonth, aStrEndDateOfMonth: aStrEndDateOfMonth, aReminderType: SmartAgenda.Appointment.rawValue) { (objReminder: [ReminderModel]) in
                
            
                arrAppoinetmentList = objReminder
                
                var tempArr = [ReminderModel]()
                
                if arrAppoinetmentList.count > 1 {
                    tempArr = arrAppoinetmentList.sorted(by: { (obj1:ReminderModel, obj2: ReminderModel) -> Bool in
                        return obj1.intOrder > obj2.intOrder

                    })
                    arrAppoinetmentList.removeAll()
                    arrAppoinetmentList = tempArr
                }
                
               
                
                print(arrAppoinetmentList)
                self.addDatesForEvents {
                    completion(objReminder)
                    
                }
                
            }
            
            
        }
        
        private func addDatesForEvents(completion : () -> Void){
            AppDelegate().appDelegateShared().arrEventOnlyDay.removeAll()
            
            print("remove \(AppDelegate().appDelegateShared().arrEventOnlyDay)")
            if arrAppoinetmentList.count > 0{

            }
            else{
                SVProgressHUD.dismiss()
            }
            completion()
            
        }
        
        
        fileprivate func getDayOfWeek(today:String)->Int? {
            
            let formatter  = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            if let todayDate = formatter.date(from: today) {
                let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
                let myComponents = myCalendar.components(.weekday, from: todayDate)
                let weekDay = myComponents.weekday
                return weekDay
            } else {
                return nil
            }
        }
        
        private let formatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.locale = NSLocale(localeIdentifier: "en") as Locale?
            formatter.dateFormat = "yyyy/MM/dd"
            return formatter
        }()
        
        private let monthFormatter: DateFormatter = {
            var formatter = DateFormatter()
            formatter.locale = NSLocale(localeIdentifier: "en") as Locale?
            formatter.dateFormat = "MMM YYYY"
            return formatter
        }()
        
        
        private let dayWholeFormatter: DateFormatter = {
            var formatter = DateFormatter()
            formatter.locale = NSLocale(localeIdentifier: "en") as Locale?
            formatter.dateFormat = "MMMM dd, YYYY"
            return formatter
        }()
        
        private let dayWholeFormatterAR: DateFormatter = {
            var formatter = DateFormatter()
            formatter.locale = NSLocale(localeIdentifier: "ar") as Locale?
            formatter.dateFormat = "MMMM dd, YYYY"
            return formatter
        }()
        
        private let dayFormatter: DateFormatter = {
            var formatter = DateFormatter()
            formatter.locale = NSLocale(localeIdentifier: "en") as Locale?
            formatter.dateFormat = "EEEE"
            return formatter
        }()
        
        private let SpecificDayFormatter: DateFormatter = {
            var formatter = DateFormatter()
            formatter.locale = NSLocale(localeIdentifier: "en") as Locale?
            formatter.dateFormat = "E"
            return formatter
        }()
        
        
        private let gregorian: NSCalendar! = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian)
        
        fileprivate func dayOfWeek(_ aDate : Date) -> Int? {
            guard
                let cal: NSCalendar = NSCalendar.current as NSCalendar?,
                let comp: NSDateComponents = cal.components(.weekday, from: aDate) as NSDateComponents? else { return nil }
            return comp.weekday
        }
        
        // Mark :- Button Click Events
        
        
        @IBAction func btnSideLeftMenuAction(_ sender: UIButton) {
            
            if AppConstants.isArabic() {
                appDelegate.mmDrawer?.open(.right, animated: true, completion: nil)
            }else{
                appDelegate.mmDrawer?.open(.left, animated: true, completion: nil)
            }
        }
        
        @IBAction func loadPrevious(sender: AnyObject) {
            SVProgressHUD.show()
            if AppConstants.isArabic() {
                let currentMonth = self.calendar.currentPage
                let nextMonth = self.gregorian.date(byAdding: .month, value: 1, to: currentMonth, options: .init(rawValue: 0))
                self.calendar.setCurrentPage(nextMonth!, animated: true)
            }else{
                let currentMonth = self.calendar.currentPage
                let previousMonth = self.gregorian.date(byAdding: .month, value: -1, to: currentMonth, options: .init(rawValue: 0))
                self.calendar.setCurrentPage(previousMonth!, animated: true)
            }
        }
        
        @IBAction func loadNext(sender: AnyObject) {
            SVProgressHUD.show()
            if AppConstants.isArabic() {
                let currentMonth = self.calendar.currentPage
                let previousMonth = self.gregorian.date(byAdding: .month, value: -1, to: currentMonth, options: .init(rawValue: 0))
                self.calendar.setCurrentPage(previousMonth!, animated: true)
            }else{
                let currentMonth = self.calendar.currentPage
                let nextMonth = self.gregorian.date(byAdding: .month, value: 1, to: currentMonth, options: .init(rawValue: 0))
                self.calendar.setCurrentPage(nextMonth!, animated: true)
            }
            
            
        }
        
        
        @IBAction func btnQuoteOfMonthAction(_ sender: UIButton) {
            
            let aObjQuoteVC = self.storyboard?.instantiateViewController(withIdentifier: "QuoteOfThemMonthVC") as? QuoteOfThemMonthVC
            
            self.present(aObjQuoteVC!, animated: true) {
                
            }
            
        }
        
        
        // MARK:- Other Methods
        
        fileprivate func LanguageSelectionMethod() -> Void {
            
            self.lblScreenTitle.text = JMOLocalizedString(forKey: "SMART AGENDA", value: "")
            
            // Set value of month and day
//            monthLabel.text = dayWholeFormatter.string(from: calendar.currentPage)
            
            if (AppConstants.isArabic()){
                monthLabel.text = JMOLocalizedString(forKey: dayWholeFormatterAR.string(from: Date()), value: "")
                self.calendar.locale = NSLocale.init(localeIdentifier: "ar_AE") as Locale
                
            }else{
                monthLabel.text = JMOLocalizedString(forKey: dayWholeFormatter.string(from: Date()), value: "")
                self.calendar.locale = NSLocale.init(localeIdentifier: "en_US") as Locale
            }
            
            self.calendar.reloadData()
            
            
            lblDay.text = JMOLocalizedString(forKey: dayFormatter.string(from: Date()), value: "")
//            lblDay.text = dayFormatter.string(from: calendar.currentPage)
            
            self.tabBarController?.tabBar.items?[0].title = JMOLocalizedString(forKey: "CALENDAR", value: "")
            self.tabBarController?.tabBar.items?[1].title = JMOLocalizedString(forKey: "CHECKLIST", value: "")
            self.tabBarController?.tabBar.items?[2].title = JMOLocalizedString(forKey: "REPORT", value: "")

            
            LanguageManager().localizeThingsInView(parentView: (self.view))
            LanguageManager().localizeThingsInView(parentView: (self.tabBarController?.view)!)
            
            
            DispatchQueue.main.async {
            
                if (AppConstants.isArabic()){
                    //self.calendar.calendarHeaderView.appearance.headerDateFormat = DateFormatter.dateFormat(fromTemplate: "EEEE", options: 0, locale: NSLocale(localeIdentifier: "ar") as? Locale)
                    
//
                }else{
                    //self.calendar.calendarHeaderView.appearance.headerDateFormat = DateFormatter.dateFormat(fromTemplate: "EEEE", options: 0, locale: NSLocale(localeIdentifier: "us") as Locale)
                    
//                  
                }
                
                self.calendar.reloadData()
            }
//            let aObjQuote: QuoteOfTheMonthModel = AppDelegate().appDelegateShared().quoteOfMonth[Int(getStringFromDate("MM", date: Date()))! - 1]
            
            if(kSelectedCalMonth < AppDelegate().appDelegateShared().quoteOfMonth.count){
                let aObjQuote: QuoteOfTheMonthModel = AppDelegate().appDelegateShared().quoteOfMonth[(kSelectedCalMonth - 1)]
                if AppConstants.isArabic()
                {
                    lblQMonth.text = aObjQuote.QuoteTextAR
                    lblQOwner.text = aObjQuote.QuoteTextAR
                }else{
                    lblQMonth.text = aObjQuote.QuoteText
                    lblQOwner.text = aObjQuote.QuoteText
                }
                
            }
         print(getStringFromDate("MM", date: Date()))
            
            // Set custom fonts
            if GeneralConstants.DeviceType.IS_IPAD {
                
                customizeFonts(in: lblScreenTitle, aFontName: Medium, aFontSize: 0)
                customizeFonts(in: lblDay, aFontName: Light, aFontSize: 0)
                customizeFonts(in: monthLabel, aFontName: Light, aFontSize: 0)
                customizeFonts(in: lblQMonth, aFontName: Medium, aFontSize: 0)
                customizeFonts(in: lblQOwner, aFontName: Bold, aFontSize: 0)
            }else{
                customizeFonts(in: lblScreenTitle, aFontName: Medium, aFontSize: 0)
                customizeFonts(in: lblDay, aFontName: Light, aFontSize: 0)
                customizeFonts(in: monthLabel, aFontName: Light, aFontSize: 0)
                customizeFonts(in: lblQMonth, aFontName: Medium, aFontSize: 0)
                customizeFonts(in: lblQOwner, aFontName: Bold, aFontSize: 0)
            }
            
            if AppConstants.isArabic()
            {
                btnPrevious.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
                btnNext.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
                imgMark.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
                
                
            }else{
                btnPrevious.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI*2))
                btnNext.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI*2))
                imgMark.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI*2))
                
                
            }
            
            
            
            
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

                                                                }
                                                                else{
                                                                 
                                                                    UIApplication.shared.openURL(url)
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
                appDelegate.aDropboxBackup = 0
                let obj = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as? SignUpVC
                AppDelegate().appDelegateShared().isDropBoxUpdateFromSignup = false
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
        
        // MARK: - Calendar Delegate And Datasource Methods
        
        func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
            
            let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)
            
//            cell.titleLabel.forn
            customizeFonts(in: cell.titleLabel, aFontName: Medium, aFontSize: 0)
            
            
            
            let diyCell = (cell as! DIYCalendarCell)
            
            diyCell.selectionLayer.isHidden = true
            
            var selectionType = SelectionType.none
            
            
            eventCount  = IsCalenderEvent(arrAppoinetmentList, date: date)


            
            if eventCount == 2 {
                // Montly events.
                diyCell.selectionLayer.isHidden = false
                selectionType = .month
                diyCell.image  = UIImage(named: "priority icons-3");
                
            }
            else if eventCount == 1 {
                //  Week events.
                diyCell.selectionLayer.isHidden = false
                //            selectionType = .day
                selectionType = .week
                diyCell.image  = UIImage(named: "priority icons-2");
            }
            else if eventCount == 3 {
                // Daily events.
                diyCell.selectionLayer.isHidden = false
                selectionType = .day
                diyCell.image  = UIImage(named: "priority icons-1");
            }
            else if eventCount == 4 {
                // one day event.
                diyCell.selectionLayer.isHidden = false
                selectionType = .none
                diyCell.image  = UIImage(named: "priority icons-4");
            }else{
            
                diyCell.image  = nil;
            }
            //        else{
            //            selectionType = .none
            //        }
            
            
            //        let strToday = getTodayDateString("yyyy-MM-dd")
            //        let selectedDate = getStringFromDate("yyyy-MM-dd", date: date)
            //
            //        if strToday == selectedDate {
            //            diyCell.selectionLayer.isHidden = false
            //            selectionType = .today
            //        }
            diyCell.selectionType = selectionType
            diyCell.numberOfEvents = eventCount;
            
            return cell
        }
        
        func minimumDate(for calendar: FSCalendar) -> Date {
            return self.formatter.date(from: "2000/01/01")!
            
        }
        
        func HandleQuoteByCalender(_ calendar: FSCalendar) -> Void {
            
            let CurrentCalMonth = getMonthFromDate(aDate: calendar.currentPage)
            kSelectedCalMonth = CurrentCalMonth
            
            if(kSelectedCalMonth <= AppDelegate().appDelegateShared().quoteOfMonth.count){
            
                let aObjQuote: QuoteOfTheMonthModel = AppDelegate().appDelegateShared().quoteOfMonth[(kSelectedCalMonth - 1)]
                
                if AppConstants.isArabic()
                {
                    lblQMonth.text = aObjQuote.QuoteTextAR
                    lblQOwner.text = aObjQuote.QuoteTextAR
                    
                }else{
                    lblQMonth.text = aObjQuote.QuoteText
                    lblQOwner.text = aObjQuote.QuoteText
                    
                }
            }
            

            
        }
        
        func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
            
            SVProgressHUD.show()
            
            self.HandleQuoteByCalender(calendar)
            
            let CurrentCalMonth = getMonthFromDate(aDate: calendar.currentPage)
            let CurrentCalYear = getYearFromDate(aDate: calendar.currentPage)
            
            let currentMonthValue = getMonthFromDate(aDate: Date())
            let currentYearValue = getYearFromDate(aDate: Date())
            
            if (currentMonthValue != CurrentCalMonth) || (CurrentCalYear != currentYearValue){
            
                if (AppConstants.isArabic()){
                    
                    monthLabel.text = JMOLocalizedString(forKey: dayWholeFormatterAR.string(from: calendar.currentPage), value: "")
                }else{
                    monthLabel.text = JMOLocalizedString(forKey: dayWholeFormatter.string(from: calendar.currentPage), value: "")
                }
                
                lblDay.text = JMOLocalizedString(forKey: dayFormatter.string(from: calendar.currentPage), value: "")
            }else{
                // show current month today's date.
                if (AppConstants.isArabic()){
                    
                    monthLabel.text = JMOLocalizedString(forKey: dayWholeFormatterAR.string(from: Date()), value: "")
                }else{
                    monthLabel.text = JMOLocalizedString(forKey: dayWholeFormatter.string(from: Date()), value: "")
                }
                
                lblDay.text = JMOLocalizedString(forKey: dayFormatter.string(from: Date()), value: "")
            }
            
            
            
            AppDelegate().appDelegateShared().strCurrentMonth = getStringFromDate("MM", date: calendar.currentPage)
            
            
            self.fetchEventsForCalender(aStrStartDate, aStrEndDateOfMonth: getStartEndDateOfMonth()[1]) { (obj: [ReminderModel]) in
                
                
                self.addDatesForEvents {
                    
                    self.calendar.reloadData()
                    
                    print(arrAppoinetmentList)
                    
                    
                    SVProgressHUD.dismiss()
                    
                }
            }
        }
        
        func calendar(_ calendar: FSCalendar, didSelect date: Date) {
            
            
            //        self.configureVisibleCells()
            
            if (AppConstants.isArabic()){
                monthLabel.text = JMOLocalizedString(forKey: dayWholeFormatterAR.string(from: date), value: "")
            }else{
                monthLabel.text = JMOLocalizedString(forKey: dayWholeFormatter.string(from: date), value: "")
            }
            
            lblDay.text = JMOLocalizedString(forKey: dayFormatter.string(from: calendar.currentPage), value: "")
            
            
            let strToday = getTodayDateString("yyyy-MM-dd")
            let selectedDate = getStringFromDate("yyyy-MM-dd", date: date)
            
            if strToday != selectedDate {
                if (date.compare(Date()) == .orderedAscending) {
                    
                }else{
                    
                }
            }
            
            //        aStrChecklistDate = getStringFromDate(ddMMyyyyEEEE, date: date)
            //        aStrChecklistEventDate = getStringFromDate(yyyyMMdd, date: date)
            
            aDateChecklist = date
            aDateChecklistEvent = date
            
            
            let arrNavigationArr = appDelegate.mmDrawer?.centerViewController as! UINavigationController
            var indexTabbar : Int = 1
            for objViewcontoller in arrNavigationArr.viewControllers {
                if objViewcontoller is TabbarVC {
                    indexTabbar = arrNavigationArr.viewControllers.index(of: objViewcontoller)!
                    break
                }
            }
            let objTabbarVC = arrNavigationArr.viewControllers[indexTabbar] as! TabbarVC
            objTabbarVC.selectedIndex = 1
            
        }
        
//        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
//            let strToday = getTodayDateString("yyyy-MM-dd")
//            let selectedDate = getStringFromDate("yyyy-MM-dd", date: date)
//            
//            if strToday == selectedDate {
//                return UIColor.red
//            }else{
//                return UIColor.clear
//            }
//            
//        }
        
        //    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        //        
        //        let strToday = getTodayDateString("yyyy-MM-dd")
        //        let selectedDate = getStringFromDate("yyyy-MM-dd", date: date)
        //
        //        if strToday == selectedDate {
        //            return UIColor.red
        //        }
        //        
        //        let eventCount : Int = IsCalenderEvent(arrAppoinetmentList, date: date)
        //        
        //        if eventCount == 1 {
        //            // Weekly events.
        //            return GeneralConstants.hexStringToUIColor(hex: GeneralConstants.ColorConstants.k_Event_Colors_Used_1)
        //        }
        //        else if eventCount == 2 {
        //            // Montly events.
        //            return GeneralConstants.hexStringToUIColor(hex: GeneralConstants.ColorConstants.k_Event_Colors_Used_2)
        //        }
        //        else if eventCount == 3 {
        //            // Daily events.
        //            return GeneralConstants.hexStringToUIColor(hex: GeneralConstants.ColorConstants.k_Event_Colors_Used_3)
        //        }
        //        else if eventCount == 4 {
        //            // one day event.
        //            return UIColor.blue
        //        }
        //        else{
        //            return GeneralConstants.hexStringToUIColor(hex: GeneralConstants.ColorConstants.k_Event_Colors_Used_3)
        //        }
        //    }
        
        
        
        func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
            calendarHeightConstraint.constant = bounds.height
            view.layoutIfNeeded()
        }
        
        
       
        @IBAction func dismissView(_ sender: Any) {
            self.dismiss(animated: true, completion: nil)
        }
        

        
    }
    extension NSDate {
        func dayOfTheWeek() -> String? {
            let weekdays = [
                "Sunday",
                "Monday",
                "Tuesday",
                "Wednesday",
                "Thursday",
                "Friday",
                "Satudrday,"
            ]
            
            let calendar: NSCalendar = NSCalendar.current as NSCalendar
            let components: NSDateComponents = calendar.components(.weekday, from: self as Date) as NSDateComponents
            return weekdays[components.weekday - 1]
        }
    }
    
    public extension UIImage {
        public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
            let rect = CGRect(origin: .zero, size: size)
            UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
            color.setFill()
            UIRectFill(rect)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            guard let cgImage = image?.cgImage else { return nil }
            self.init(cgImage: cgImage)
        }
    }
