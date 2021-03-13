//
//  ViewController.swift
//  Paging_Swift
//
//  Created by olxios on 26/10/14.
//  Copyright (c) 2014 swiftiostutorials.com. All rights reserved.
//

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}


class TutorialVC: UIViewController, UIPageViewControllerDataSource {
    @IBOutlet weak var viewPageController: UIView!
    
    @IBOutlet var lblTitle: UILabel!
    
    @IBOutlet var btnSkip: UIButton!
    
    @IBOutlet var btnBackEN: UIButton!
    
    // MARK: - Variables
    fileprivate var pageViewController: UIPageViewController?
    
    var diseaseReminder = [DiseasesReminderModel]()
    
    // Initialize it right away here
    fileprivate let contentImagesEN = [
        "tutorialEN5",
                                       "tutorialEN1",
                                     "tutorialEN2",
                                     "tutorialEN3",
                                     "tutorialEN4"
                                     ]

    fileprivate let contentImagesAR = [
        "tutorialAR5","tutorialAR1",
                                       "tutorialAR2",
                                       "tutorialAR3",
                                       "tutorialAR4"]

    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set multilingual text
        LanguageManager.sharedInstance.localizeThingsInView(parentView: self.view)

        lblTitle.text = JMOLocalizedString(forKey: kTutorial, value: "")
        btnSkip.setTitle(JMOLocalizedString(forKey: "SKIP", value: ""), for: .normal)
        
        if AppConstants.isArabic()
        {
            btnBackEN.imageView?.transform = (btnBackEN.imageView?.transform.rotated(by: CGFloat(M_PI)))!
        }else{
            btnBackEN.imageView?.transform = (btnBackEN.imageView?.transform.rotated(by: CGFloat(M_PI*2)))!
        }
        
        
        // Set fonts
        if GeneralConstants.DeviceType.IS_IPAD {
            customizeFonts(in: lblTitle, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: btnSkip, aFontName: Bold, aFontSize: 0)
        }else{
            customizeFonts(in: lblTitle, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: btnSkip, aFontName: Bold, aFontSize: 0)
        }

        
        // Done by akash
        createPageViewController()
        setupPageControl()
        
        
        diseaseReminder = DiseaseModel().getBloodPS()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            
            print(self.diseaseReminder)
            
            for dis in self.diseaseReminder {
                
                let dateFromReminder = dateSelectedFormatter.date(from: "2000-12-31 \(dis.reminderTime!):00")
                let hour = self.getHMS(date: dateFromReminder!).0
                let minutes = self.getHMS(date: dateFromReminder!).1
                
                
                if dis.reminderID == 14 {
                    // BP
                    
                    //                        let hms = getHMS(date: Date())
                    //                        let hour = hms.0
                    //                        let min = hms.1 + 1
                    //
                    let aStrhourmin = String.init(format: "%d:%d", hour,minutes)
                    
                    UserDefaults().set(aStrhourmin, forKey: "BPTime")
                    
                    appDelegate.setNotifications(identifire: "\(dis.reminderID!)", strname: "\(dis.reminderTxt!)", h:hour, m: minutes, s: 0, type: NotificationType.Daily, monthDay: 0, week: 0)
                    
                }else if dis.reminderID == 13 {
                    // Fasting
                    //                        let hms = getHMS(date: Date())
                    //                        let hour = hms.0
                    //                        let min = hms.1 + 1
                    //
                    let aStrhourmin = String.init(format: "%d:%d", hour,minutes)
                    
                    
                    UserDefaults().set(aStrhourmin, forKey: "BSFastingTime")
                    appDelegate.setNotifications(identifire: "\(dis.reminderID!)", strname: "\(dis.reminderTxt!)", h:hour, m: minutes, s: 0, type: NotificationType.Daily, monthDay: 0, week: 0)
                    
                    
                }else if dis.reminderID == 12 {
                    // Eating
                    
                    //                        let hms = getHMS(date: Date())
                    //                        let hour = hms.0
                    //                        let min = hms.1 + 1
                    //
                    let aStrhourmin = String.init(format: "%d:%d", hour,minutes)
                    
                    UserDefaults().set(aStrhourmin, forKey: "BSEatingTime")
                    appDelegate.setNotifications(identifire: "\(dis.reminderID!)", strname: "\(dis.reminderTxt!)", h:hour, m: minutes, s: 0, type: NotificationType.Daily, monthDay: 0, week: 0)
                    
                }
            }
        })
    }
    
    //MARK: General Methods
    fileprivate func createPageViewController() {
        
        let pageController = self.storyboard!.instantiateViewController(withIdentifier: "PageController") as! UIPageViewController
        pageController.dataSource = self
        
        if contentImagesEN.count > 0 {
            let firstController = getItemController(0)!
            let startingViewControllers = [firstController]
            pageController.setViewControllers(startingViewControllers, direction: UIPageViewController.NavigationDirection.forward, animated: false, completion: nil)
        }
        
        pageViewController = pageController
        addChild(pageViewController!)
        viewPageController.frame = self.view.bounds
        pageViewController!.view.frame = viewPageController.bounds
        viewPageController.addSubview(pageViewController!.view)
        pageViewController!.didMove(toParent: self)

    
    }
    
    fileprivate func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.gray
        appearance.currentPageIndicatorTintColor = UIColor.green
        appearance.backgroundColor = UIColor.clear
    
    }
    
    // MARK: - UIPageViewControllerDataSource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! PageItemController
        
        if itemController.itemIndex == contentImagesEN.count - 1{
            
            btnSkip.setTitle(JMOLocalizedString(forKey: "Get Started", value: ""), for: .normal)
        }else{
            btnSkip.setTitle(JMOLocalizedString(forKey: "SKIP", value: ""), for: .normal)
        }
        if itemController.itemIndex > 0 {
            return getItemController(itemController.itemIndex-1)
        }
            
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! PageItemController
        
        if itemController.itemIndex == contentImagesEN.count - 1{
            
            btnSkip.setTitle(JMOLocalizedString(forKey: "Get Started", value: ""), for: .normal)
        }else{
            btnSkip.setTitle(JMOLocalizedString(forKey: "SKIP", value: ""), for: .normal)
        }
        
        if itemController.itemIndex+1 < contentImagesEN.count {
            return getItemController(itemController.itemIndex+1)
        }
        
        return nil
    }
    
    fileprivate func getItemController(_ itemIndex: Int) -> PageItemController? {
        print(itemIndex)
        
        
        if itemIndex < contentImagesEN.count {
            let pageItemController = self.storyboard!.instantiateViewController(withIdentifier: "ItemController") as! PageItemController
            pageItemController.itemIndex = itemIndex
            
            if AppConstants.isArabic() {
                pageItemController.imageName = contentImagesAR[itemIndex]
            }else{
                pageItemController.imageName = contentImagesEN[itemIndex]
            }


            return pageItemController
        }
        
        return nil
    }
    
    // MARK: - Page Indicator
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return contentImagesEN.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    /// - Parameter sender: Button reference
    @IBAction func btnBackENAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Additions
    
    func currentControllerIndex() -> Int {
        
        let pageItemController = self.currentController()
        
        if let controller = pageItemController as? PageItemController {
            return controller.itemIndex
        }
        
        return -1
    }
    
    func currentController() -> UIViewController? {
        
        if self.pageViewController?.viewControllers?.count > 0 {
            return self.pageViewController?.viewControllers![0]
        }
        
        return nil
    }
    
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
    
//    private func setNotifications(reminderModelObjs: [ReminderModel]) {
//        
//        for reminderObj in reminderModelObjs {
//            // Loop for each and every reminder
//            
//            print(reminderObj)
//            
//            
//            // Daily
//            // Weekly
//            // Monthly
//            // Once
//            if reminderObj.reminderTime != ""{
//                
//                let dateFromReminder = dateSelectedFormatter.date(from: "2000-12-31 \(reminderObj.reminderTime!):00")
//                let hour = getHMS(date: dateFromReminder!).0
//                let minutes = getHMS(date: dateFromReminder!).1
//                
//                if reminderObj.reminderFrequency == JMOLocalizedString(forKey: Recurring.DailyRecurr.rawValue, value: ""){
//                    // Daily
//                    setNotifications(identifire: "\(reminderObj.reminderID!)", strname: reminderObj.reminderTxt, h: hour, m: minutes, s: 0, type: NotificationType.Daily, monthDay:0, week:0)
//                }else if reminderObj.reminderFrequency == JMOLocalizedString(forKey: Recurring.MonthlyRecurr.rawValue, value: ""){
//                    //Monthly
//                    
//                    
//                    setNotifications(identifire: "\(reminderObj.reminderID!)", strname: reminderObj.reminderTxt, h: hour, m: minutes, s: 0, type: NotificationType.Monthly, monthDay:Int(reminderObj.reminderMonthlyDay!)!, week:0)
//                }else if reminderObj.reminderFrequency == JMOLocalizedString(forKey: Recurring.WeeklyRecurr.rawValue, value: ""){
//                    //Weekly
//                    
//                    var selectedDay: Int!
//                    
//                    switch JMOLocalizedString(forKey: reminderObj.reminderWeaklyDay!, value: "") {
//                        
//                    case JMOLocalizedString(forKey: reminderObj.reminderWeaklyDay!, value: ""):
//                        selectedDay = WeekDay.Sunday.rawValue
//                    case JMOLocalizedString(forKey: reminderObj.reminderWeaklyDay!, value: ""):
//                        selectedDay = WeekDay.Monday.rawValue
//                    case JMOLocalizedString(forKey: reminderObj.reminderWeaklyDay!, value: ""):
//                        selectedDay = WeekDay.Tuesday.rawValue
//                    case JMOLocalizedString(forKey: reminderObj.reminderWeaklyDay!, value: ""):
//                        selectedDay = WeekDay.Wednesday.rawValue
//                    case JMOLocalizedString(forKey: reminderObj.reminderWeaklyDay!, value: ""):
//                        selectedDay = WeekDay.Thrusday.rawValue
//                    case JMOLocalizedString(forKey: reminderObj.reminderWeaklyDay!, value: ""):
//                        selectedDay = WeekDay.Friday.rawValue
//                    case JMOLocalizedString(forKey: reminderObj.reminderWeaklyDay!, value: ""):
//                        selectedDay = WeekDay.Saturday.rawValue
//                    default :
//                        print("")
//                    }
//                    
//                    
//                    setNotifications(identifire: "\(reminderObj.reminderID!)", strname: reminderObj.reminderTxt, h: hour, m: minutes, s: 0, type: NotificationType.Weekly, monthDay:0, week:selectedDay)
//                }else if reminderObj.reminderFrequency == ""{
//                    //Once
//                    setNotifications(identifire: "\(reminderObj.reminderID!)", strname: reminderObj.reminderTxt, h: hour, m: minutes, s: 0, type: NotificationType.OnceOnly,monthDay:0, week:0)
//                }
//            }
//        }
//    }
//    
//    func setNotifications(identifire: String, strname: String, h:Int, m: Int, s: Int, type: NotificationType, monthDay: Int, week:Int) {
//        
//        print("identifire ==\(identifire)")
//        LocalNotificationHelper.sharedInstance.createReminderNotification(identifire,"\(strname)", "\(strname)", weekDay: week, monthDay: monthDay, hour: h, minute:m, seconds: s, notificationDate: Date(), NotificationType(rawValue: type.rawValue)!)
//        
//    }
    
}

