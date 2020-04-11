//
//  nemoMainViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 6/16/19.
//  Copyright © 2019 Datacellme. All rights reserved.
//

import Foundation
import UIKit

import NVActivityIndicatorView

protocol quetionnairDelegate {
    func openQuestionnair()
}


protocol answerQuestionnair{
    func answerQuestion(q: Question, answerString: String) -> Question
}

protocol answerObjective{
    func answerObjective(o: Objective, answerString: String , cell: taskCell)
}



class nemoMainViewController: UIViewController ,quetionnairDelegate , MyCellDelegate {
    
    
    
    
    func checkTime() {
        let calendar = Calendar.current
        let now = Date()
        let tomorrow = DateComponents(year: now.year, month: now.month, day: now.day + 1)
        let dateTomorrow = Calendar.current.date(from: tomorrow)!
        let fiveAM_today = calendar.date(
          bySettingHour: 5,
          minute: 0,
          second: 0,
          of: now)!
        
        let fiveAM_tommorow = calendar.date(
        bySettingHour: 5,
        minute: 0,
        second: 0,
        of: dateTomorrow)!

        let towPM_today = calendar.date(
          bySettingHour: 14,
          minute: 0,
          second: 0,
          of: now)!
        
        
        
        let fivePM_today = calendar.date(
        bySettingHour: 17,
        minute: 0,
        second: 0,
        of: now)!
        
        
        let eightPM_today = calendar.date(
        bySettingHour: 20,
        minute: 0,
        second: 0,
        of: now)!
        
        

        if now >= fiveAM_today &&
          now <= towPM_today
        {
            AppConstants.backgroundImage = UIImage(named: "morning")!
            self.backgroundImage.image = AppConstants.backgroundImage
          print("The time is between 5:00 AM and 14:00 PM")
        }else if now >= towPM_today &&
          now <= fivePM_today
        {
            AppConstants.backgroundImage = UIImage(named: "afternoon")!
              self.backgroundImage.image = AppConstants.backgroundImage
            print("The time is between 2:00 PM and 5:00 PM")
        }else if now >= fivePM_today &&
            now <= eightPM_today {
            AppConstants.backgroundImage = UIImage(named: "evening")!
              self.backgroundImage.image = AppConstants.backgroundImage
            print("The time is between 5:00 PM and 8:00 PM")
        }else if now >= eightPM_today &&
        now <= fiveAM_tommorow {
            AppConstants.backgroundImage = UIImage(named: "night")!
              self.backgroundImage.image = AppConstants.backgroundImage
            print("The time is between 8:00 PM and 5:00 AM")
            
        }
        
        
    }
    /*
    
    var timerMorning: Timer!
    var timerEvening: Timer!
    var timerNight: Timer!
    var timerAfternoon: Timer!
    
    
    
    func changBackground() {

        
        let calendar = Calendar.current
        let now = Date()
        
        
        let dateMorning = calendar.date(
            bySettingHour: 5,
            minute: 0,
            second: 0,
            of: now)!
        timerMorning = Timer(fireAt: dateMorning, interval: 0, target: self, selector: #selector(runCodeMorning), userInfo: nil, repeats: true)
        RunLoop.main.add(timerMorning, forMode: .common)
        
        
        let dateAfternoon = calendar.date(
            bySettingHour: 14,
            minute: 0,
            second: 0,
            of: now)!
        timerAfternoon = Timer(fireAt: dateAfternoon, interval: 0, target: self, selector: #selector(runCodeAfternoon), userInfo: nil, repeats: true)
        RunLoop.main.add(timerAfternoon, forMode: .common)
        
        
        let dateevening = calendar.date(
            bySettingHour: 15,
            minute: 4,
            second: 0,
            of: now)!
        timerEvening = Timer(fireAt: dateevening, interval: 0, target: self, selector: #selector(runCodeEvening), userInfo: nil, repeats: true)
        RunLoop.main.add(timerEvening, forMode: .common)
        
        
        let dateNight = calendar.date(
            bySettingHour: 20,
            minute: 0,
            second: 0,
            of: now)!
        timerNight = Timer(fireAt: dateNight, interval: 0, target: self, selector: #selector(runCodeNight), userInfo: nil, repeats: true)
        RunLoop.main.add(timerNight, forMode: .common)
        
        
        
        
        
        
    }
    
    @objc func runCodeMorning() {
    
        AppConstants.backgroundImage = UIImage(named: "morning")!
        backgroundImage.image = AppConstants.backgroundImage
        
    }
    @objc func runCodeEvening() {
    
        AppConstants.backgroundImage = UIImage(named: "evening")!
        backgroundImage.image = AppConstants.backgroundImage
        
    }
    @objc func runCodeAfternoon() {
    
        AppConstants.backgroundImage = UIImage(named: "afternoon")!
        backgroundImage.image = AppConstants.backgroundImage
        
    }
    @objc func runCodeNight() {
    
        AppConstants.backgroundImage = UIImage(named: "night")!
        backgroundImage.image = AppConstants.backgroundImage
        
    }
    
    
    */
    func doneButtonTapped(cell: taskCollectionViewCell) {
        if let indexPath = self.notificationsCollectionView.indexPath(for: cell) {
            
            let task = tasksList[indexPath.row]
            submitTask(task: task, indexPath: indexPath)
            
        }
        
        
    }
    @IBOutlet var backgroundImage: UIImageView!
    var searchbarOutlet: UIBarButtonItem!
    var isSearchAdded = false
    var searchText = ""
    var searchActive : Bool = false
    
    var settingBarButton: UIBarButtonItem!
    var backBarButton: UIBarButtonItem!
    
    
    
    var objectivesList: [Objective] = []
    var answeredbjectivesList: [Objective] = []
    var answeredTasks: [Task] = []
    var tasksList: [Task] = []
    
    
    func openQuestionnair() {
        self.performSegue(withIdentifier: "toAssessment", sender: self)
    }
    
    
    @IBOutlet var searchBar: UISearchBar!
    @IBAction func searchbarOutlet(_ sender: Any) {
        
        if isSearchAdded {
            
            
            UIView.animate(withDuration: 0.7, delay: 0.0, options: .transitionFlipFromRight, animations: {
                self.navigationItem.title = "Nemow"
                
                self.searchBar.alpha = 0
            }) { (finished) in
                
                
                self.searchText = ""
                self.isSearchAdded = false
            }
            
            
            
        }else {
            
            
            UIView.animate(withDuration: 0.7, delay: 0.0, options: .transitionFlipFromBottom, animations: {
                
                self.navigationItem.titleView = self.searchBar
                self.searchBar.alpha = 1
                
            }) { (finished) in
                
                self.searchText = ""
                self.isSearchAdded = true
            }
            
            
        }
    }
    
    @IBOutlet var notificationHeightConstraints: NSLayoutConstraint!
    @IBAction func settingAction(_ sender: Any) {
        self.performSegue(withIdentifier: "toSetting", sender: self)
    }
    var surveysList: [MOCDSurvey] = []
    var selectedSurvey: MOCDSurvey = MOCDSurvey()
    let activityData = ActivityData()
    var mocd_user = MOCDUser.getMOCDUser()
    
    @IBOutlet var first_name_label: UILabel!
    @IBOutlet var circularImageView: UIImageView!
    @IBOutlet var backImageView: UIImageView!
   
    @IBOutlet var parentProfileImageView: UIImageView!
    
    @IBOutlet var childrensCollectionView: UICollectionView!
    @IBOutlet var notificationsCollectionView: UICollectionView!

    
    var resultChild: ChildObject!
    var childsArray: [ChildObject] = []
    var selectedChild: ChildObject = ChildObject()
    var childNotificationsArray: [ChildObject] = []
    
    var imagename = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearch()

        first_name_label.text = "\(mocd_user?.firstName ?? "") \(mocd_user?.lastName ?? "") "
        
       
        circularImageView.layer.cornerRadius = self.circularImageView.frame.height / 2
        
        circularImageView.layer.masksToBounds = true
        backImageView.addCurvedView(imageview: backImageView ,backgroundColor: .brown, curveRadius: 30, shadowColor: .lightGray, shadowRadius: 4.0, heightOffset: 0.0)
        //addCurvedNavigationBar(backgroundColor: .brown, curveRadius: 17.0, shadowColor: .lightGray, shadowRadius: 4.0, heightOffset: 0.0)
        parentProfileImageView.layer.cornerRadius = self.parentProfileImageView.frame.height / 2
        
        parentProfileImageView.layer.masksToBounds = true
        
        
        circularImageView.layer.borderWidth = 2
        circularImageView.layer.borderColor = UIColor.white.cgColor
        
        
        setupCollectionView()
        
        
        backBarButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(dismissView(_:)))
        settingBarButton = UIBarButtonItem(image: UIImage(named: "home-settings"), style: .plain, target: self, action: #selector(settingAction(_:)))
        
        searchbarOutlet = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchbarOutlet(_:)))
        
        if mocd_user?.isCenter == "1" || mocd_user?.isCenter == "true" {
            notificationHeightConstraints.constant = 0
            
           
            self.navigationItem.rightBarButtonItems = [backBarButton , searchbarOutlet]
        }else {
            self.navigationItem.rightBarButtonItems = [backBarButton , settingBarButton]
        }
        /*
        let path = UIBezierPath(roundedRect:backImageView.bounds, byRoundingCorners:[.bottomRight,.bottomLeft], cornerRadii: CGSize(width: 0, height: 0))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        
        backImageView.layer.mask = maskLayer
        */
        
        /*
        if let userPicture = PFUser.current()?.value(forKey: "picture") as? PFFileObject{
            userPicture.getDataInBackground({ (imageData: Data?, error: Error?) -> Void in
                let image = UIImage(data: imageData!)
                if image != nil {
                    
                    DispatchQueue.main.async {
                        self.parentProfileImageView.image = image
                    }
                }
            })
        }
        
        */
        
        //getSurveys()
        
        setupView()
        
        backgroundImage.image = AppConstants.backgroundImage
        
        
        
        
    }
    
    
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadChild()
        
        self.notificationsCollectionView.reloadData()
        self.childrensCollectionView.reloadData()
        
        self.checkTime()
    }
    
    
    func setupSearch() {
        searchBar.delegate = self
        
        searchBar.showsCancelButton = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        
        if isSearchAdded {
            
            
            self.navigationItem.title = "Nemow"
            self.searchBar.alpha = 0
            self.searchText = ""
            self.isSearchAdded = false
            
        }
        
    }
    @IBAction func profileAction(_ sender: Any) {
        
        //self.performSegue(withIdentifier: "toParentProfile", sender: self)
    }
    
    
    func setupView() {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "mocd_logo")
        
        let logoview = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        let logoavatarImage = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        
        logoavatarImage.setImage(logoImageView.image, for: .normal)
        logoavatarImage.imageView?.contentMode = .scaleAspectFill
        //avatarImage.imageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "profile"))
        logoavatarImage.clipView(withRadius: logoavatarImage.frame.width/2, withBoarderWidth: 0, borderColor: UIColor.clear)
        
        
        
        logoview.addSubview(logoavatarImage)
        let leftButton = UIBarButtonItem(customView: logoview)
        self.navigationItem.leftBarButtonItems = [leftButton]
    }
    func getSurveys() {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
        WebService.getSurveysList { (json) in
            print(json)
            DispatchQueue.main.async {
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            }
            
            
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
                guard let data = json["data"] as? [String: Any] else{return}
                guard let result = data["result"] as? [[String: Any]] else {return}
                
                
                for r in result {
                    let survey: MOCDSurvey = MOCDSurvey()
                    
                    survey.survey_id = r["survey_id"] as? String  ?? ""
                    survey.survey_title_ar = r["survey_title_ar"] as? String  ?? ""
                    survey.survey_title_en = r["survey_title_en"] as? String  ?? ""
                    
                    survey.aspect_title_ar = r["aspect_title_ar"] as? String  ?? ""
                    survey.aspect_title_en = r["aspect_title_en"] as? String  ?? ""
                    
                    survey.age_text_ar = r["age_text_ar"] as? String  ?? ""
                    survey.age_text_en = r["age_text_en"] as? String  ?? ""
                  
                    
                    self.surveysList.append(survey)
                }
                
                
                DispatchQueue.main.async {
                    self.notificationsCollectionView.reloadData()
                }
            }else{
                DispatchQueue.main.async {
                    Utils.showAlertWith(title: "Error", message: message, viewController: self)
                }
            }
        }
    }
    
    
    func scrollToBeginning() {
        guard childrensCollectionView.numberOfItems(inSection: 0) > 0 else { return }
        let indexPath = IndexPath(item: 0, section: 0)
        childrensCollectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }
    
    func searchForChild() {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
        WebService.searchChild(emiratesId: searchText) { (json) in
            print(json)
            
            DispatchQueue.main.async {
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            }
            
            
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            
            
            if code == 200 {
                guard let data = json["data"] as? [String: Any] else{return}
                guard let r = data["result"] as? [String: Any] else {return}
                
                guard let id = r["id"] as? String else {
                    
                    Utils.showAlertWith(title: "Not found", message: "", viewController: self)
                    
                    return
                }
                
                
                
                let child: ChildObject = ChildObject()
                child.firstName = r["first_name"] as? String ?? ""
                child.lastName = r["last_name"] as? String ?? ""
                child.mobile = r["mobile"] as? String ?? ""
                child.email = r["email"] as? String ?? ""
                child.address = r["address"] as? String ?? ""
                child.birthdate = r["date_of_birth"] as? String ?? ""
                child.objectID = r["id"] as? String ?? ""
                child.child_picture = r["child_picture"] as? String ?? ""
          
                
                
                self.resultChild = child
                
                
                
                let result =  self.childsArray.filter({ (c) -> Bool in
                    c.objectID == self.resultChild.objectID
                    }).first
                
                if result != nil {
                    
                    DispatchQueue.main.async {
                        Utils.showAlertWith(title: "Child Exist", message: "this child already in your list", style: .alert, viewController: self)
                    }
                    
                    return
                }
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "toSearchChild", sender: self)
                }
               
                
            }
        }
    }
    func loadChild() {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
        WebService.getChildsForParent(isCenter:  (mocd_user?.isCenter == "1" || mocd_user?.isCenter == "true".lowercased())) { (json) in
            print(json)
            DispatchQueue.main.async {
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            }
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
                guard let data = json["data"] as? [String: Any] else{return}
                guard let result = data["result"] as? [[String: Any]] else {return}
                
                self.childsArray = []
                
                for r in result {
                    let child: ChildObject = ChildObject()
                    child.firstName = r["first_name"] as? String ?? ""
                    child.lastName = r["last_name"] as? String ?? ""
                    child.mobile = r["mobile"] as? String ?? ""
                    child.email = r["email"] as? String ?? ""
                    child.address = r["address"] as? String ?? ""
                    child.birthdate = r["date_of_birth"] as? String ?? ""
                    child.objectID = r["id"] as? String ?? ""
                    child.child_picture = r["child_picture"] as? String ?? ""
                    
                    child.emiratesId = r["emirates_id"] as? String ?? ""
                    
                    child.emirateStringAr = r["emirate_ar"] as? String ?? ""
                    child.emirateStringEn = r["emirate_en"] as? String ?? ""
                    
                    
                    
                    child.status = CHILD_STATUS(value: r["overall_status"] as? String ?? "") ?? .NEED_TEST
                    child.overallProgress = r["overall_progress"] as? String ?? ""
                    child.age = r["age"] as? String ?? ""
                    
                    child.countryCode = r["country_code"] as? String ?? ""
                    child.nationalityEn = r["country_enNationality"] as? String ?? ""
                    child.nationalityAr = r["country_arNationality"] as? String ?? ""
                    
                    
                    child.genderID = r["gender"] as? String ?? ""
                    child.genderStringEn = r["gender_en"] as? String ?? ""
                    child.genderStringAr = r["gender_ar"] as? String ?? ""
                    
                    child.emirateID = r["emirate"] as? String ?? ""
                    
                    //child.status =  CHILD_STATUS(value: currentObject["child_status"] as? String ?? "3") ?? .NEED_TEST
                    //child.picture = currentObject["picture"] as? PFFileObject
                    //child.child_age = Utils.checkDomains(month: child.birthdate.returnAge())
                   
                    self.childsArray.append(child)
                    
                    
                    
                    if let objetives = r["objective"] as? [[String:Any]] {

                        self.objectivesList = []
                        for o in objetives {
                            let obj: Objective = Objective()
                            
                            obj.objectiveId = o["objective_id"] as? String  ?? ""
                            obj.objective_text_ar = o["objective_text_ar"] as? String  ?? ""
                            obj.objective_text_en = o["objective_text_en"] as? String  ?? ""
                            
                            obj.routine_ar = o["routine_ar"] as? String  ?? ""
                            obj.routine_en = o["routine_ar"] as? String  ?? ""
                            obj.routine_id = o["routine_id"] as? String ?? ""
                            obj.routine_time = ROUTINE_TIME(value: obj.routine_id) ?? .NONE
                            
                            
                            if let tasks = o["tasks"] as? [[String: Any]] {
                                var tList:[Task] = []
                                                 
                                for t in tasks {
                                
                                    let task: Task = Task()
                                
                                    task.objectiveId = obj.objectiveId
                                    task.taskId = t["id"] as? String ?? ""
                                    task.task_text_ar = t["task_text_ar"] as? String ?? ""
                                    task.task_text_en = t["task_text_en"] as? String ?? ""
                                    task.childItem = child
                                    task.objective = obj
                                    tList.append(task)
                                    
                                }
                                
                                obj.tasks = tList
                            }
                            
                            self.objectivesList.append(obj)
                        }
                        
                    }
                    
                    
                    if let answered_objetives = r["answered_objectives"] as? [[String:Any]] {
                        
                        
                        self.answeredbjectivesList = []
                        for a_o in answered_objetives {
                            let obj: Objective = Objective()
                            
                            obj.objectiveId = a_o["objective_id"] as? String  ?? ""
                            obj.result = a_o["result"] as? String  ?? ""
                            
                            self.answeredbjectivesList.append(obj)
                        }
                        
                    }
                    
                    if let answered_tasks = r["answered_tasks"] as? [[String:Any]] {
                        self.answeredTasks = []
                        
                        for a_t in answered_tasks {
                            let task: Task = Task()
                            
                            task.taskId = a_t["task_id"] as? String ?? ""
                            task.task_text_ar = a_t["task_text_ar"] as? String ?? ""
                            task.task_text_en = a_t["task_text_en"] as? String ?? ""
                            task.objectiveId = a_t["objective_id"] as? String ?? ""
                            task.result = a_t["result"] as? String ?? ""
                            task.childItem = child
                            self.answeredTasks.append(task)
                            
                        }
                    }
                    
                    if self.answeredTasks.count > 0 && self.objectivesList.count > 0{
                        
                        
                        //self.tasksList = []
                        LocalNotificationHelperT.sharedInstance.removeAllPendingNotifications()
                        for o in self.objectivesList {
                            
                            //loop on objective tasks
                            for t in o.tasks{
                                
                                let a_t = self.answeredTasks.filter { (result) -> Bool in
                                    result.taskId == t.taskId
                                }.first
                                
                                
                                if a_t == nil {
                                    //append task to task list
                                    self.tasksList.append(t)
                                    
                                    
                                    
                                    
                                    
                                }else{
                                    print("\(a_t?.task_text_en)")
                                }
                                
                            }
                            
                        }
                        
                       
                    }else if self.objectivesList.count > 0 {
                        
                        //self.tasksList = []
                        for o in self.objectivesList {
                            
                            //loop on objective tasks
                            for t in o.tasks{
                                
                                
                                //append task to task list
                                self.tasksList.append(t)
                            }
                            
                        }
                    }
                    
                    for t in self.tasksList {
                        //LocalNotificationHelperT.sharedInstance.createReminderNotification(t.taskId, t.childItem.firstName, t.task_text_en, hour: 19,minute: 53, notificationDate: Date(), .Daily)//10
                        
                        
                        switch t.objective?.routine_time {
                        case .NONE:
                            print("none")
                        case .FIVE_AM_TOW_PM:
                            LocalNotificationHelperT.sharedInstance.createReminderNotification(t.taskId, t.childItem.firstName, t.task_text_en, hour: 10,minute: 1, notificationDate: Date(), .Daily)//10
                        case .TOW_PM_FIVE_PM:
                            LocalNotificationHelperT.sharedInstance.createReminderNotification(t.taskId, t.childItem.firstName, t.task_text_en, hour: 16,minute: 1, notificationDate: Date(), .Daily)//16
                        case .FIVE_PM_NINE_PM:
                            LocalNotificationHelperT.sharedInstance.createReminderNotification(t.taskId, t.childItem.firstName, t.task_text_en,hour: 19,minute: 1 ,notificationDate: Date(), .Daily)//19
                        case .NINE_PM_FIVE_AM_NEXT_DAY:
                            LocalNotificationHelperT.sharedInstance.createReminderNotification(t.taskId, t.childItem.firstName, t.task_text_en, hour: 21,minute: 1, notificationDate: Date() ,.Daily)//21
                        default:
                            print("default")
                        }
                        
                    }
                    
                }
                
                
                
                //filter tasks list according to time
                
                let calendar = Calendar.current
                let now = Date()
                let tomorrow = DateComponents(year: now.year, month: now.month, day: now.day + 1)
                let dateTomorrow = Calendar.current.date(from: tomorrow)!
                let fiveAM_today = calendar.date(
                  bySettingHour: 5,
                  minute: 0,
                  second: 0,
                  of: now)!
                
                let fiveAM_tommorow = calendar.date(
                bySettingHour: 5,
                minute: 0,
                second: 0,
                of: dateTomorrow)!

                let towPM_today = calendar.date(
                  bySettingHour: 14,
                  minute: 0,
                  second: 0,
                  of: now)!
                
                
                
                let fivePM_today = calendar.date(
                bySettingHour: 17,
                minute: 0,
                second: 0,
                of: now)!
                
                
                let ninePM_today = calendar.date(
                bySettingHour: 21,
                minute: 0,
                second: 0,
                of: now)!
                
                
                
                
                if now >= fiveAM_today &&
                  now <= towPM_today
                {
                    self.tasksList = self.tasksList.filter { (o) -> Bool in
                        o.objective?.routine_time == .FIVE_AM_TOW_PM
                    }
                  print("The time is between 5:00 AM and 14:00 PM")
                }else if now >= towPM_today &&
                  now <= fivePM_today
                {
                    self.tasksList = self.tasksList.filter { (o) -> Bool in
                        o.objective?.routine_time == .TOW_PM_FIVE_PM
                    }
                    print("The time is between 2:00 PM and 5:00 PM")
                }else if now >= fivePM_today &&
                    now <= ninePM_today {
                    
                    self.tasksList = self.tasksList.filter { (o) -> Bool in
                        o.objective?.routine_time == .FIVE_PM_NINE_PM
                    }
                    print("The time is between 5:00 PM and 8:00 PM")
                }else if now >= ninePM_today &&
                now <= fiveAM_tommorow {
                    self.tasksList = self.tasksList.filter { (o) -> Bool in
                        o.objective?.routine_time == .NINE_PM_FIVE_AM_NEXT_DAY
                    }
                    print("The time is between 8:00 PM and 5:00 AM")
                    
                }
                
                
                
                
                DispatchQueue.main.async {
                    
                
                    self.childrensCollectionView.reloadData()
                    self.notificationsCollectionView.reloadData()
                
                    if self.notificationsCollectionView.numberOfItems(inSection: 0) > 0  {
                    
                        self.notificationsCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: false)
                    
                    }
                    /*
                    for c in self.childsArray {
                        self.getChildsStatues(child: c)
                    }
 
 */
                }
                
            }else{
                
                
                DispatchQueue.main.async {
                    Utils.showAlertWith(title: "Error", message: message, viewController: self)
                }
            }
        }
    }
    
    
    func submitTask(task: Task , indexPath: IndexPath) {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        WebService.submitObjective(objectiveId: task.objectiveId, taskId: task.taskId, childId: task.childItem.objectID, result: "done") { (json) in
            
            
            print(json)
            DispatchQueue.main.async {
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            }
            
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
                     
            if code == 200 {
                
                DispatchQueue.main.async {
                    self.tasksList.remove(at: indexPath.row)
                    
                    
                    self.notificationsCollectionView.reloadData()
                }
            }else{
                DispatchQueue.main.async {
                    Utils.showAlertWith(title: "Error", message: message, viewController: self)
                }
            }
            
        }
        
    }
    func loadChilds() {
        /*
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
        let childQuery: PFQuery = PFQuery(className: "Child")
        
        
        childQuery.whereKey("parent", equalTo: PFUser.current()!)
        childQuery.findObjectsInBackground { (objects, error) in
            DispatchQueue.main.async {
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            }
            if error != nil {
                
                return
            }
            guard let objectsArray = objects else {return}
            
            for currentObject: PFObject in objectsArray {
                let child: ChildObject = ChildObject()
                child.address = currentObject["child_address"] as! String
                child.birthdate = currentObject["child_birthdate"] as! String
                child.name = currentObject["child_name"] as! String
                child.nationality = currentObject["child_nationality"] as! String
                child.status =  CHILD_STATUS(value: currentObject["child_status"] as? String ?? "3") ?? .NEED_TEST
                child.picture = currentObject["picture"] as? PFFileObject
                child.child_age = Utils.checkDomains(month: child.birthdate.returnAge())
                child.objectID = currentObject.objectId ?? ""
                self.childsArray.append(child)
                
                
                
            }
            DispatchQueue.main.async {
                self.childrensCollectionView.reloadData()
                self.notificationsCollectionView.reloadData()
            
                for c in self.childsArray {
                    self.getChildsStatues(child: c)
                }
            
                
                
            }
        }*/
    }
    
    func getChildsStatues (child: ChildObject) {
        /*
        //no need for make assessment for this child
        if child.child_age == .noNeedForTest {
            return
        }
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        let childQuery: PFQuery = PFQuery(className: "MonitorChild")
        childQuery.includeKey("child_id")
        childQuery.includeKey("aspect_id")
        
        print("test child age \(child.child_age.rawValue)")
        //childQuery.whereKey("child_id", equalTo: child.objectID)
        //childQuery.whereKey("age", equalTo: child.child_age.rawValue)
        
        childQuery.findObjectsInBackground { (objects, error) in
            DispatchQueue.main.async {
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            }
            if error != nil {
                
                return
            }
            guard let objectsArray = objects else {return}
            
            if objectsArray.count > 0 {
                for currentObject: PFObject in objectsArray {
                    let child: ChildObject = ChildObject()
                    
                    let childParseObj = currentObject["child_id"] as! PFObject
                    
                    child.address = childParseObj["child_address"] as? String ?? ""
                    child.birthdate = childParseObj["child_birthdate"] as! String
                    child.name = childParseObj["child_name"] as! String
                    child.nationality = childParseObj["child_nationality"] as! String
                    child.status =  CHILD_STATUS(value: childParseObj["child_status"] as? String ?? "3") ?? .NEED_TEST
                    child.picture = childParseObj["picture"] as? PFFileObject
                    child.child_age = Utils.checkDomains(month: child.birthdate.returnAge())
                    child.objectID = childParseObj.objectId ?? ""
                    
                    
                   
                    let array = self.childNotificationsArray.filter({ (childObject) -> Bool in
                        childObject.status == .NEED_TEST && childObject.objectID == child.objectID
                    })
                    
                    if array.count > 0 {
                        
                    }else{
                        self.childNotificationsArray.append(child)
                    }
                    
                    
                    
                    
                    DispatchQueue.main.async {
                        self.notificationsCollectionView.reloadData()
                    }
                }
                return
            }else{
                for a in AppConstants.AssessmentsArray {
                    let childObject: PFObject = PFObject(className: "MonitorChild")
                    childObject["aspect_id"] = PFObject(withoutDataWithClassName: "Aspects", objectId: a.objectId)
                    childObject["child_id"] = PFObject(withoutDataWithClassName:"Child" , objectId:child.objectID)
                    childObject["age"] = String(describing:child.child_age.rawValue)
                    childObject["results"] = "0"
                    childObject["status"] = "3"
                    
                    
                    //Save to DB ...
                    childObject.saveInBackground(block: {(succeeded, error)in
                        print("Finish")
                        
                    })
                }
                
                self.getChildsStatues(child: child)
            }
            
            
            
        }*/
    }
    func buttonTapped(_ sender:AnyObject) {
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.notificationsCollectionView)
       // let indexPath = self.notificationsCollectionView.c
        
        
        //self.submitTask(task: , indexPath: indexPath)
    }
    @IBAction func dismissView(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    func setupCollectionView() {
    
        
        
        notificationsCollectionView.delegate = self
        notificationsCollectionView.dataSource = self
        
        notificationsCollectionView.showsVerticalScrollIndicator = false
        
        notificationsCollectionView.register(UINib(nibName: "childNotificationCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "notiCell")
        
        
        notificationsCollectionView.register(UINib(nibName: "taskCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "taskCollectionViewCell")
        
        
        //notificationsCollectionView.register(UINib(nibName: "cn1", bundle: nil), forCellWithReuseIdentifier: "notiCell11")
        
        
        
        if let layout = notificationsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal  // .horizontal
        }
        notificationsCollectionView.isPagingEnabled = true
        notificationsCollectionView.reloadData()
        
    
        //---------------------------------------------------------------------------------------
        
        
        childrensCollectionView.delegate = self
        childrensCollectionView.dataSource = self
        
        childrensCollectionView.showsVerticalScrollIndicator = false
        
        childrensCollectionView.register(UINib(nibName: "childCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "childCell")
        childrensCollectionView.register(UINib(nibName: "addChildCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "addCell")
        
        
        
        if let layout = childrensCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal  // .horizontal
        }
        
        childrensCollectionView.reloadData()
    }
    
    
    
    

}
class curvedView: UIView {
    
    override func layoutSubviews() {
        self.backgroundColor = .red
       
    }
    
    override func draw(_ rect: CGRect) {
        let color = UIColor.red
        let y:CGFloat = 0
        let myBezier = UIBezierPath()
        myBezier.move(to: CGPoint(x: 0, y: y))
        myBezier.addQuadCurve(to: CGPoint(x: rect.width, y: y), controlPoint: CGPoint(x: rect.width / 2, y: rect.height / 3))
        myBezier.addLine(to: CGPoint(x: rect.width, y: rect.height))
        myBezier.addLine(to: CGPoint(x: 0, y: rect.height))
        myBezier.close()
        color.setFill()
        myBezier.fill()
    }
}
extension nemoMainViewController: UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    //MARK: - CollectionView
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.notificationsCollectionView {
            
            
            return self.tasksList.count
            
        }
        if collectionView == self.childrensCollectionView {
            //return childsArray.count + 1
            
            if childsArray.count == 0 {
                return 1
            }else {
                return childsArray.count + 1
            }
            
           
        }
        return 0
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cellIdentifier = "Cell"
        
        
        
        
        if collectionView == self.notificationsCollectionView  {
            
            cellIdentifier = "taskCollectionViewCell"
            
            
            let cell = notificationsCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! taskCollectionViewCell
            
            
            cell.delegate = self
            let taskItem = tasksList[indexPath.row]
            
            cell.taskItem = taskItem
            //let childItem = childsArray[indexPath.row]
        
            
            //let status = childItem.status
            
            /*
            if let userPicture = childItem.picture {
                
                DispatchQueue.global(qos: .background).async {
                    userPicture.getDataInBackground({ (imageData: Data?, error: Error?) -> Void in
                        let image = UIImage(data: imageData!)
                        if image != nil {
                            
                            DispatchQueue.main.async {
                                cell.profileImageView.image = image
                            }
                        }
                    })
                }
                
                
            }else{
                cell.profileImageView.image = UIImage(named: "placeholder-baby")
            }*/
            
            
            let string = "\(AppConstants.WEB_SERVER_IMAGE_MOCD_URL)\(taskItem.childItem.child_picture )"
            let url = URL(string: string)
            cell.profileImageView.kf.setImage(with: url, placeholder: UIImage(named: "profile") ?? UIImage())
           
            cell.titleLabel.text = "\(taskItem.childItem.firstName)"
            cell.detailsLabel.text = "\(taskItem.task_text_en)"
            /*
            switch childItem.status {
            case .NEED_TEST:
                print("")
                cell.backgroundColor = AppConstants.GRAY_COLOR
                cell.titleLabel.text = "\(childItem.firstName)" + " need test".localize
                cell.detailsLabel.text = "Please ensure that your child" + " \(childItem.firstName)" + " helth is fine".localize
                
            case .FINE:
                cell.backgroundColor = AppConstants.GREEN_COLOR
                cell.titleLabel.text = "\(childItem.firstName)" + " is Perfect".localize
                cell.detailsLabel.text = "\(childItem.firstName)" + " helth is perfect".localize
            case .UN_HEALTH:
                cell.backgroundColor = .orange
                cell.titleLabel.text = "\(childItem.firstName)" + " Might Need Attention".localize
                cell.detailsLabel.text = "\(childItem.firstName)" + " child's health Might need attention . Keep checking his health ".localize
            case .DANGER:
                cell.backgroundColor = AppConstants.F_RED_COLOR
                cell.titleLabel.text = "\(childItem.firstName)" + " need attention".localize
                cell.detailsLabel.text = "\(childItem.firstName)" + " child's health need attention .visit your closest medical center to get a check-up ".localize
            
            }*/
            
            /*
            if indexPath.row == 0 {
                
                cell.backgroundColor = .orange
                cell.profileImageView.image = UIImage(named: "c1")
                cell.titleLabel.text = "Naya need more attention"
                cell.detailsLabel.text = "please follow naya objectives in order to check her health status "
            }else if indexPath.row == 1 {
                cell.backgroundColor = AppConstants.GREEN_COLOR
                cell.profileImageView.image = UIImage(named: "c2")
                
                cell.titleLabel.text = "Jad is Fine"
                cell.detailsLabel.text = "please keep jad health status updated by asking all remainig questions"
            }else if indexPath.row == 2 {
                cell.backgroundColor = AppConstants.F_RED_COLOR
                cell.profileImageView.image = UIImage(named: "c3")
                cell.titleLabel.text = "selen need to visit center to check her health"
                cell.detailsLabel.text = "please keep selen health status updated by asking all remainig questions"
            }*/
            
            //scell.backgroundColor = .red
            return cell
        }
        
        if collectionView == self.childrensCollectionView  {
            
            var cell: UICollectionViewCell!
            if childsArray.count == 0 {
                return collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
            }
            
            if indexPath.row == 0 {
                cellIdentifier = "addCell"
                cell = childrensCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! addchildCollectionViewCell
            }else{
                cellIdentifier = "childCell"
                var cell = childrensCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! childCollectionViewCell
                
                let childItem = childsArray[indexPath.row - 1]
                cell.nameLabel.text = childItem.firstName
                cell.yearLabel.text = "\(childItem.age)" + " Months".localize
                
                
                //cell.yearLabel.text = childItem.birthdate.calculateAge()//
                //Utils.checkDomains(month: childItem.birthdate.returnAge())
                var healthstatus = ""
                var colorHealth = UIColor.clear
            
                let string = "\(AppConstants.WEB_SERVER_IMAGE_MOCD_URL)\(childItem.child_picture )"
                let url = URL(string: string)
                cell.childImageView.kf.setImage(with: url, placeholder: UIImage(named: "profile") ?? UIImage())
                if childItem.status == .NEED_TEST {
                    healthstatus = "need test".localize
                    colorHealth = AppConstants.GRAY_COLOR
                    
                }
                else if childItem.status == .FINE {
                    healthstatus = "fine".localize
                    colorHealth = AppConstants.GREEN_COLOR
                }else if childItem.status == .UN_HEALTH {
                    healthstatus = "un-health".localize
                    colorHealth = AppConstants.ORANGE_COLOR
                }else if childItem.status == .DANGER {
                    healthstatus = "danger".localize
                    colorHealth = AppConstants.F_RED_COLOR
                }
                cell.healthLabel.text = healthstatus
                cell.healthLabel.backgroundColor = colorHealth
                cell.backStatusView.backgroundColor = colorHealth
                /*
                if indexPath.row == 1 {
                    cell.childImageView.image = UIImage(named: "c1")
                }else if indexPath.row == 2{
                    cell.childImageView.image = UIImage(named: "c2")
                }else if indexPath.row == 3{
                    cell.childImageView.image = UIImage(named: "c3")
                }
                */
                /*
                if let userPicture = childItem.picture {
                    userPicture.getDataInBackground({ (imageData: Data?, error: Error?) -> Void in
                        let image = UIImage(data: imageData!)
                        if image != nil {
                            
                            DispatchQueue.main.async {
                                cell.childImageView.image = image
                            }
                        }
                    })
                }else{
                    if indexPath.row == 1 {
                        cell.childImageView.image = UIImage(named: "c1")
                    }else if indexPath.row == 2{
                        cell.childImageView.image = UIImage(named: "c2")
                    }else if indexPath.row == 3{
                        cell.childImageView.image = UIImage(named: "c3")
                    }
                }
                */
                return cell
            }
            
            
            
            
            
            
            
            //scell.backgroundColor = .red
            return cell
        }
        
        return collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.childrensCollectionView {
            if indexPath.row == 0 {
                self.performSegue(withIdentifier: "toAddChild", sender: self)
            }else{
                
                
                selectedChild = childsArray[indexPath.row - 1]
                if indexPath.row == 1 {
                    imagename = "c1"
                    
                }
                
                if indexPath.row == 2 {
                    imagename = "c2"
                }
                
                if indexPath.row == 3 {
                    imagename = "c3"
                }
                self.performSegue(withIdentifier: "toChildProfile", sender: self)
            }
        }else if collectionView == notificationsCollectionView {
            //selectedChild = childsArray[indexPath.row ]
            
            //self.performSegue(withIdentifier: "toChildProfile", sender: self)
        }
        
       
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        if collectionView == self.notificationsCollectionView  {
            
             return CGSize(width: collectionView.frame.width - 10  , height: 80)
            
        }
        if collectionView == self.childrensCollectionView  {
            if childsArray.count == 0 {
                return CGSize(width: collectionView.frame.width - 20  , height: 180)
            }
            
            return CGSize(width: 120  , height: 190)
        }
       
        return CGSize(width: 150, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toChooseCategory" {
            let dest = segue.destination as! categoriesViewController
            dest.qDelegate = self
        }
        
        if segue.identifier == "toChildProfile" {
            let dest = segue.destination as! ChildProfileViewController
            //dest.imageName = imagename
            dest.childItem = self.selectedChild
        }
        if segue.identifier == "toAssessment" {
            let dest = segue.destination as! AssessmentViewController
            //dest.imageName = imagename
            dest.selectedSurvey = self.selectedSurvey
            dest.selectedChild = self.selectedChild
        }
        if segue.identifier == "toSearchChild" {
            
            
            let dest = segue.destination as! SearchViewController
            
            dest.childItem = self.resultChild
            dest.centerId = mocd_user?.DId ?? ""
            
            
        }
        
        
        
    }
}


extension String {
    /*
    func calculateAge()-> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date = dateFormatter.date(from: self)!
        
        let now = Date()
        let birthday: Date = date
        let calendar = Calendar.current
        
        let ageComponents = calendar.dateComponents([.year ,.month], from: birthday, to: now)
        let age = ageComponents.year!
        let ageMonth = ageComponents.month ?? 0
        
        
        if ageMonth > 0 {
            return "\(age) years and \(ageMonth) months"
        }else {
            return "\(age) years"
        }
        
        
    }
    
    func returnAge() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date = dateFormatter.date(from: self)!
        
        var totalSum = 0
        let now = Date()
        let birthday: Date = date
        let calendar = Calendar.current
        
        let ageComponents = calendar.dateComponents([.year ,.month], from: birthday, to: now)
        let age = ageComponents.year!
        let ageMonth = ageComponents.month ?? 0
        
        
        if age > 0 {
            totalSum = age * 12
            
        }
        
        totalSum += ageMonth
        print("the child age in months is \(totalSum))")
        return String(describing: totalSum)
        
    }*/
}
extension nemoMainViewController: UISearchBarDelegate {
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
        
        searchText = searchBar.text ?? ""
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
        
        searchText = searchBar.text ?? ""
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        
        
        UIView.animate(withDuration: 0.7, delay: 0.0, options: .transitionFlipFromRight, animations: {
            self.navigationItem.title = "Nemow"
            
            self.searchBar.alpha = 0
        }) { (finished) in
            
            self.searchText = ""
            self.isSearchAdded = false
            
            
            
            
        }
        
        
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
       
        
        
        searchActive = false;
        
       
        searchText = searchBar.text ?? ""
        
        searchForChild()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.searchText = searchText
        
    }
    
    
}
