//
//  ChildProfileViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 7/9/19.
//  Copyright © 2019 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView
import LinearProgressBar
import M13Checkbox
import EmptyDataSet_Swift
protocol answerAssessment {
    func changeIsOpenAssessment()
    func showPopup()
    func reloadChild()
    
}
class ChildProfileViewController: UIViewController ,answerAssessment{
    func changeIsOpenAssessment() {
        isOpenAssessmentWithoutAlert = false
    }
    
    
    
    
    
    
    @IBOutlet var surveyNotiLabel: UILabel!
    var isEditObjective = false
    var isOpenAssessmentWithoutAlert = false
    var isOpenAssessment = false
    @IBOutlet var statusView: UIView!
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var eidtButton: UIButton!
    var surveysList: [MOCDSurvey] = []
    var objectivesList: [Objective] = []
    var centers: [MOCDCenter] = []
    var objectivesListForDisplaying: [Objective] = []
    var answeredbjectivesList: [Objective] = []
    var answeredSurveys: [MOCDSurvey] = []
    
    var selectedSurvey: MOCDSurvey = MOCDSurvey()
    var selectedTask: Task = Task()
    
    var selectedObjective: Objective!
    @IBOutlet var backImageView: UIImageView!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var healthLabel: UILabel!
    @IBOutlet var yearsLabel: UILabel!
    //@IBOutlet var editButoon: UIButton!
    @IBOutlet var deleteButton: UIButton!
    @IBOutlet var tableView: UITableView!
    var mocd_user = MOCDUser.getMOCDUser()
    @IBOutlet var goalsProgress: LinearProgressBar!
    
    let activityData = ActivityData()
    var aspectValue = ""
    var childItem: ChildObject = ChildObject()
    var imageName = ""
    
    var assessmentArray: [String] = []


    var isShowPopupMessage = false
    
    @IBOutlet var notificationsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        
        
        backImageView.layer.cornerRadius = backImageView.frame.height / 2
        backImageView.layer.masksToBounds = true
        
        
        
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.layer.masksToBounds = true
        
        
        let string = "\(AppConstants.WEB_SERVER_IMAGE_MOCD_URL)\(childItem.child_picture )"
        let url = URL(string: string)
        profileImageView.kf.setImage(with: url, placeholder: UIImage(named: "profile") ?? UIImage())
        
        
        
        healthLabel.layer.cornerRadius = healthLabel.frame.height / 2
        healthLabel.layer.masksToBounds = true
        
        
        statusView.layer.cornerRadius = healthLabel.frame.height / 2
        statusView.layer.masksToBounds = true
        
        //profileImageView.image = UIImage(named: imageName)
        
        
        
        tableView.register(UINib(nibName: "taskCell", bundle: nil), forCellReuseIdentifier: "taskCell")
        setupCollectionView()
        
        setupInfromation()
        
        
        deleteButton.addTarget(self, action: #selector(deleteChild), for: .touchUpInside)
        //loadAssesmnts()
        
        if AppConstants.isArabic() {
            goalsProgress.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        }
        
        
        let rightBarButton = UIBarButtonItem(title: "add objective".localize, style: .plain, target: self, action: #selector(addnewobjective))
        
        
        if mocd_user?.isCenter == "1" || mocd_user?.isCenter == "true"  {
            self.navigationItem.rightBarButtonItems = [rightBarButton]
        }
        getChildFull()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //getChildFull()
        
        
        let string = "\(AppConstants.WEB_SERVER_IMAGE_MOCD_URL)\(childItem.child_picture )"
        let url = URL(string: string)
        profileImageView.kf.setImage(with: url, placeholder: UIImage(named: "profile") ?? UIImage())
        
        
        self.checkTime()
        
         if self.answeredSurveys.count == self.surveysList.count {
            
            surveyNotiLabel.text = ""
            
         }else{
            let message = """

            عزيزي (\(mocd_user?.firstName ?? "")) لتقييم التطور النمائى لطفلك (\(childItem.firstName)) في المراحل العمرية المختلفة، عليك الإجابة على جميع الأسئلة في الاستبيان.
            """
            surveyNotiLabel.text = message
        }
    }
    func reloadChild() {
        isShowPopupMessage = true
        getChildFull()
    }
    
    func openAssessmentWithoutAlert()
    {
        if isOpenAssessmentWithoutAlert == false {
            isOpenAssessmentWithoutAlert = true
            
        }else {
            return
        }
        
        for s in surveysList {
        if s.status == .NEED_TEST {
            
           
            self.selectedSurvey = s
            
            
            self.performSegue(withIdentifier: "toSurvey", sender: self)
            
            
            break
            }
        }
    }
    func openAssessment() {
        //Utils.showAlertWith(title: "open", message: "openAssessment", viewController: self)
        
        if isOpenAssessment == false {
            isOpenAssessment = true
            
        }else {
            return
        }
        
        
    
        for s in surveysList {
            if s.status == .NEED_TEST {
                
                
                
                let message = """

                عزيزي (\(mocd_user?.firstName ?? "")) لتقييم التطور النمائى لطفلك (\(childItem.firstName)) في المراحل العمرية المختلفة، عليك الإجابة على جميع الأسئلة في الاستبيان.
                """
                let logOutAlertActionController = UIAlertController(title:"", message: message, preferredStyle: .alert )
                
                let yesAlerActionOption = UIAlertAction(title: "نعم", style: .default) { (alert) in
                    
                    
                    self.selectedSurvey = s
                    
                    self.performSegue(withIdentifier: "toSurvey", sender: self)
                }
                
                let noAlertActionOption = UIAlertAction(title:NSLocalizedString("No",comment:""), style: .default, handler: nil)
                
                logOutAlertActionController.addAction(yesAlerActionOption)
                logOutAlertActionController.addAction(noAlertActionOption)
                
                self.present(logOutAlertActionController, animated: true, completion: nil)
                
                
                break
            }
        }
         
        
        
    }
    func showPopup() {
        
        
        //self.getChildFull()
        if self.answeredSurveys.count == self.surveysList.count {
            
            
            let dangerString = """

نتيجة المسح تظهر علامات تأخر نمائي في بعض المجالات لدى الطفل
الرجاء التواصل مع مركز التدخل المبكر الأقرب إليكم لإجراء التقييم الشامل

"""
            
            
            let normalString = """
يبدو أن هناك تأخر طفيف في بعض المجالات النمائية، سيقوم التطبيق بتزويدكم ببعض الأهداف التي يمكنكم تدريب الطفل عليها


"""
            
            let healthString = """

تهانينا، تطور طفلك متناسب مع عمره سيتم إعلامكم بموعد الاستبيان القادم عندما يحين موعده.  مع تمنياتنا لكم بموفور الصحة والعافية
"""
            
            switch  childItem.status{
            case .DANGER:
                print("danger")
                Utils.showAlertWith(title: "", message:dangerString, viewController: self)
            case .FINE:
                print("fine")
                Utils.showAlertWith(title: "", message:healthString, viewController: self)
            case .NEED_TEST:
               
                print("need test")
                
            case .UN_HEALTH:
                 Utils.showAlertWith(title: "", message:normalString, viewController: self)
                print("un health")
            
            }
        }
        
    }
    @IBAction func editChildAction(_ sender: Any) {
        
        self.performSegue(withIdentifier: "toEditChild", sender: self)
    }
    
    @objc func addnewobjective() {
        
        isEditObjective = false
        self.performSegue(withIdentifier: "toAddObjective", sender: self)
        
        
    }
    @objc func deleteChild() {
        
        
        let logOutAlertActionController = UIAlertController(title:"", message: NSLocalizedString("Are you sure you want to delete this child ?", comment:""), preferredStyle: .alert )
               
               
        let yesAlerActionOption = UIAlertAction(title:NSLocalizedString("Sure",comment:""), style: UIAlertAction.Style.default, handler: { (UIAlertAction) -> Void in
            
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(self.activityData)
            
            
            WebService.deleteChild(childId: self.childItem.objectID) { (json) in
                print(json)
                DispatchQueue.main.async {
                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                }
                
                guard let code = json["code"] as? Int else {return}
                guard let message = json["message"] as? String else {return}
                         
                if code == 200 {
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                }else{
                    DispatchQueue.main.async {
                        Utils.showAlertWith(title: "Error", message: message, viewController: self)
                    }
                }
            }
            
            
        })
        
        
        let noAlertActionOption = UIAlertAction(title:NSLocalizedString("No",comment:""), style: .default, handler: nil)
        
        logOutAlertActionController.addAction(yesAlerActionOption)
        logOutAlertActionController.addAction(noAlertActionOption)
        
        self.present(logOutAlertActionController, animated: true, completion: nil)
        
    }
    func getChildFull() {
        
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        WebService.getChild(childId: childItem.objectID) { (json) in
            print(json)
            DispatchQueue.main.async {
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            }
            
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
                     
            if code == 200 {
                guard let data = json["data"] as? [String: Any] else{return}
                guard let result = data["result"] as? [String: Any] else {return}
                guard let surveys = result["all_surveys"] as? [[String: Any]] else {return}
                guard let objectives = result["objective"] as? [[String: Any]] else {return}
                guard let answeredObjectives = result["answered_objectives"] as? [[String: Any]] else {return}
                guard let answeredS = result["answered surveys"] as? [[String: Any]] else {return}
                
                guard let centers = result["centers"] as? [[String: Any]] else {return}
                
                
                self.childItem.status = CHILD_STATUS(value: result["overall_status"] as? String ?? "") ?? .NEED_TEST
                self.childItem.picture = result["child_picture"] as? String ?? ""
                self.surveysList = []
                for r in surveys {
                    let survey: MOCDSurvey = MOCDSurvey()
                    
                    survey.survey_id = r["id"] as? String  ?? ""
                    survey.survey_title_ar = r["survey_title_ar"] as? String  ?? ""
                    survey.survey_title_en = r["survey_title_en"] as? String  ?? ""
                    
                    survey.aspect_title_ar = r["aspect_title_ar"] as? String  ?? ""
                    survey.aspect_title_en = r["aspect_title_en"] as? String  ?? ""
                    
                    survey.age_text_ar = r["age_text_ar"] as? String  ?? ""
                    survey.age_text_en = r["age_text_en"] as? String  ?? ""
                  
                    
                    self.surveysList.append(survey)
                }
                
                
                
                self.answeredSurveys = []
                for r in answeredS {
                    let survey: MOCDSurvey = MOCDSurvey()
                    
                    survey.survey_id = r["id"] as? String  ?? ""
                    
                    survey.aspect_title_ar = r["aspect_title_ar"] as? String  ?? ""
                    survey.aspect_title_en = r["aspect_title_en"] as? String  ?? ""
                    survey.status = CHILD_STATUS(value: r["result"] as? String ?? "") ?? .NEED_TEST
                  
                    
                    self.answeredSurveys.append(survey)
                }
                
                
                self.objectivesList = []
                for r in objectives {
                    let obj: Objective = Objective()
                    
                    obj.objectiveId = r["objective_id"] as? String  ?? ""
                    obj.objective_text_ar = r["objective_text_ar"] as? String  ?? ""
                    obj.objective_text_en = r["objective_text_en"] as? String  ?? ""
                    obj.child_id = r["child_id"] as? String  ?? ""
                    obj.routine_ar = r["routine_ar"] as? String  ?? ""
                    obj.routine_en = r["routine_ar"] as? String  ?? ""
        
                    obj.aspect_ar = r["aspect_ar"] as? String  ?? ""
                    obj.aspect_en = r["aspect_en"] as? String  ?? ""
                    obj.aspect_id = r["aspect_id"] as? String  ?? ""
                    obj.routine_id = r["routine_id"] as? String ?? ""
                    
                    obj.routine_time = ROUTINE_TIME(value: obj.routine_id) ?? .NONE
                   
                    
                    
                    
                    if let tasks = r["tasks"] as? [[String: Any]] {
                        var tList:[Task] = []
                                         
                        for t in tasks {
                        
                            let task: Task = Task()
                        
                            task.taskId = t["id"] as? String ?? ""
                            task.task_text_ar = t["task_text_ar"] as? String ?? ""
                            task.task_text_en = t["task_text_en"] as? String ?? ""
                
                            tList.append(task)
                            
                        }
                        
                        obj.tasks = tList
                    }
                    
                    
                    
                    
                   
                    
                    
                    
                    self.objectivesList.append(obj)
                }
                
                self.centers = []
                
                for c in centers {
                    let centerItem: MOCDCenter = MOCDCenter()
                    
                    centerItem.center_address = c["center_address"] as? String ?? ""
                    centerItem.center_name = c["center_name"] as? String ?? ""
                    centerItem.email = c["email"] as? String ?? ""
                    centerItem.id = c["id"] as? String ?? ""
                    centerItem.latitude = c["latitude"] as? String ?? ""
                    centerItem.longitude = c["longitude"] as? String ?? ""
                    centerItem.telephone = c["telephone"] as? String ?? ""
                    
                    
                    self.centers.append(centerItem)
                    
                }
                self.answeredbjectivesList = []
                        for r in answeredObjectives {
                            let t: Objective = Objective()
                            
                            t.objectiveId = r["objective_id"] as? String  ?? ""
                            t.result = r["result"] as? String  ?? ""
                           
                
                           
                            
                           
                            
                            self.answeredbjectivesList.append(t)
                        }
                
                
                if self.mocd_user?.isCenter == "1" || self.mocd_user?.isCenter == "true"  {
                    
                    
                    //cenetr case
                    self.objectivesListForDisplaying = []
                    self.centers = []
                    for o in self.objectivesList {
                        
                        var result = self.answeredbjectivesList.filter { (obj) -> Bool in
                            obj.objectiveId == o.objectiveId
                        }.first
                        
                        if result != nil {
                            
                            o.result = result?.result ?? ""
                            self.objectivesListForDisplaying.append(o)
                        }else {
                            self.objectivesListForDisplaying.append(o)
                        }
                        
                    }
                    
                    
                    DispatchQueue.main.async {
                        self.setupInfromation()
                        self.notificationsCollectionView.reloadData()
                        if self.notificationsCollectionView.numberOfItems(inSection: 0) > 0  {
                            self.notificationsCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: false)
                        }
                        
                        self.tableView.reloadData()
                    }
                    return
                }
                
                for surveyItem in self.surveysList {
                    if let s = self.answeredSurveys.filter({ (s1) -> Bool in
                        if AppConstants.isArabic() {
                            return s1.aspect_title_ar == surveyItem.aspect_title_ar
                        }else{
                            return s1.aspect_title_en == surveyItem.aspect_title_en
                        }
                        
                    }).first {
                        surveyItem.status = s.status
                    }
                }
                
                
                if self.answeredbjectivesList.count > 0 {
                    
                    
                    self.objectivesListForDisplaying = []
                    for o in self.objectivesList {
                        
                        var result = self.answeredbjectivesList.filter { (obj) -> Bool in
                            obj.objectiveId == o.objectiveId
                        }.first
                        
                        if result == nil {
                            self.objectivesListForDisplaying.append(o)
                        }else if result?.result == "not" || result?.result == "need" {
                            
                            o.result = result?.result ?? ""
                            self.objectivesListForDisplaying.append(o)
                        }
                        
                        
                    }
                    
                    
                    
                }else {
                    self.objectivesListForDisplaying = self.objectivesList
                }
                
                
                //filter objectives according to time
                
                
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
                    self.objectivesListForDisplaying = self.objectivesListForDisplaying.filter { (o) -> Bool in
                        o.routine_time == .FIVE_AM_TOW_PM
                    }
                  print("The time is between 5:00 AM and 14:00 PM")
                }else if now >= towPM_today &&
                  now <= fivePM_today
                {
                    self.objectivesListForDisplaying = self.objectivesListForDisplaying.filter { (o) -> Bool in
                        o.routine_time == .TOW_PM_FIVE_PM
                    }
                    print("The time is between 2:00 PM and 5:00 PM")
                }else if now >= fivePM_today &&
                    now <= ninePM_today {
                    
                    self.objectivesListForDisplaying = self.objectivesListForDisplaying.filter { (o) -> Bool in
                        o.routine_time == .FIVE_PM_NINE_PM
                    }
                    print("The time is between 5:00 PM and 8:00 PM")
                }else if now >= ninePM_today &&
                now <= fiveAM_tommorow {
                    self.objectivesListForDisplaying = self.objectivesListForDisplaying.filter { (o) -> Bool in
                        o.routine_time == .NINE_PM_FIVE_AM_NEXT_DAY
                    }
                    print("The time is between 8:00 PM and 5:00 AM")
                    
                }
                
                
                
                DispatchQueue.main.async {
                    
                    self.setupInfromation()
                    
                    self.notificationsCollectionView.reloadData()
                    if self.notificationsCollectionView.numberOfItems(inSection: 0) > 0  {
                        self.notificationsCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: false)
                    }
                  
                    
                    if self.isShowPopupMessage {
                        self.showPopup()
                        self.isShowPopupMessage = false
                    }
                    
                    
                    self.openAssessment()
                    self.openAssessmentWithoutAlert()
                    self.tableView.reloadData()
                }
                
            }else{
                DispatchQueue.main.async {
                    Utils.showAlertWith(title: "Error", message: message, viewController: self)
                }
            }
            
        }
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
       
       
    
    func setupInfromation() {
        /*
        if let userPicture = childItem.picture {
            
            DispatchQueue.global(qos: .background).async {
                userPicture.getDataInBackground({ (imageData: Data?, error: Error?) -> Void in
                    let image = UIImage(data: imageData!)
                    if image != nil {
                        
                        DispatchQueue.main.async {
                            self.profileImageView.image = image
                        }
                    }
                })
            }
            
            
        }else{
            profileImageView.image = UIImage(named: "placeholder-baby")
        }
        */
        self.nameLabel.text = "\(childItem.firstName)"
        
        switch childItem.status {
        case .NEED_TEST:
            self.statusView.backgroundColor = AppConstants.GRAY_COLOR
            self.healthLabel.backgroundColor = AppConstants.GRAY_COLOR
            self.healthLabel.text = "".localize
        case .FINE:
            self.statusView.backgroundColor = AppConstants.GREEN_COLOR
            self.healthLabel.backgroundColor = AppConstants.GREEN_COLOR
            self.healthLabel.text = "".localize
        case .UN_HEALTH:
            self.statusView.backgroundColor = AppConstants.ORANGE_COLOR
            self.healthLabel.backgroundColor = AppConstants.ORANGE_COLOR
            self.healthLabel.text = "".localize
        case .DANGER:
            self.statusView.backgroundColor = AppConstants.F_RED_COLOR
            self.healthLabel.backgroundColor = AppConstants.F_RED_COLOR
            self.healthLabel.text = "".localize
            
        }
        self.goalsProgress.progressValue = self.childItem.overallProgress.floatValue * 100
        
        self.yearsLabel.text = "\(childItem.birthdate) (\(childItem.age)" + " Months".localize + ")"
        
        
    }
    func setupCollectionView() {
        
        
        
        notificationsCollectionView.delegate = self
        notificationsCollectionView.dataSource = self
        
        notificationsCollectionView.showsVerticalScrollIndicator = false
        
        notificationsCollectionView.register(UINib(nibName: "childNotificationCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "notiCell")
        
        
        
        if let layout = notificationsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal  // .horizontal
        }
        notificationsCollectionView.isPagingEnabled = true
        notificationsCollectionView.reloadData()
        
        
        
        
   
    }
   
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
    func loadAssesmnts() {
        var assessmentQuery = PFQuery(className: "Aspects")
        
        assessmentQuery.findObjectsInBackground { (objects, error) in
            
            
            guard let objectsArray = objects else {return}
            for currentObject: PFObject in objectsArray {
                
                let title = currentObject["aspect_name"] as? String ?? ""
                let objectId = currentObject["objectId"] as? String ?? ""
                let value : [String:String ] = [title:objectId]
                self.assessmentArray.append(title)
                
                
                
            }
            
            
            DispatchQueue.main.async {
                self.notificationsCollectionView.reloadData()
            }
        }
    }*/
}

extension ChildProfileViewController: UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    //MARK: - CollectionView
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.notificationsCollectionView {
            return surveysList.count
            
        }
        
        return 0
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cellIdentifier = "Cell"
        
        
        
        
        if collectionView == self.notificationsCollectionView  {
            
            cellIdentifier = "notiCell"
            
            
            let cell = notificationsCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! childNotificationCollectionViewCell
            
            cell.imageWidth.constant = 0
            cell.backImageWidth.constant = 0
            let surveyItem = surveysList[indexPath.row]
            
            cell.titleLabel.text = AppConstants.isArabic() ? surveyItem.aspect_title_ar : surveyItem.aspect_title_en
            //cell.detailsLabel.text = AppConstants.isArabic() ? surveyItem.aspect_title_ar : surveyItem.aspect_title_en
            cell.backgroundColor = AppConstants.BROWN_COLOR
            cell.detailsLabel.text = ""
            
            if let s = answeredSurveys.filter({ (s1) -> Bool in
                if AppConstants.isArabic() {
                    return s1.aspect_title_ar == surveyItem.aspect_title_ar
                }else{
                    return s1.aspect_title_en == surveyItem.aspect_title_en
                }
                
            }).first {
                surveyItem.status = s.status
            }
            
            switch surveyItem.status {
            case .NEED_TEST:
                print("")
                cell.backgroundColor = .lightGray
               
                
            case .FINE:
                cell.backgroundColor = AppConstants.GREEN_COLOR
                
            case .UN_HEALTH:
                cell.backgroundColor = .orange
                
            case .DANGER:
                cell.backgroundColor = AppConstants.F_RED_COLOR
                
            }
            
            /*
            if indexPath.row == 0 {
                
                cell.backgroundColor = AppConstants.BROWN_COLOR
                cell.profileImageView.image = UIImage(named: "c1")
                cell.titleLabel.text = "Communications skills "
                cell.detailsLabel.text = "please follow naya objectives in order to check her health status "
            }else if indexPath.row == 1 {
                cell.backgroundColor = AppConstants.BROWN_COLOR
                cell.profileImageView.image = UIImage(named: "c2")
                
                cell.titleLabel.text = "big movement skill"
                cell.detailsLabel.text = "please keep jad health status updated by asking all remainig questions"
            }else if indexPath.row == 2 {
                cell.backgroundColor = AppConstants.BROWN_COLOR
                cell.profileImageView.image = UIImage(named: "c3")
                cell.titleLabel.text = "Fine movement skills"
                cell.detailsLabel.text = "please keep selen health status updated by asking all remainig questions"
            }
            else if indexPath.row == 3 {
                cell.backgroundColor = AppConstants.BROWN_COLOR
                cell.profileImageView.image = UIImage(named: "c3")
                cell.titleLabel.text = "Cognitive / problem solving skills "
                cell.detailsLabel.text = "please keep selen health status updated by asking all remainig questions"
            }
            else if indexPath.row == 4 {
                cell.backgroundColor = AppConstants.BROWN_COLOR
                cell.profileImageView.image = UIImage(named: "c3")
                cell.titleLabel.text = "Social skills"
                cell.detailsLabel.text = "please keep selen health status updated by asking all remainig questions"
            }
            else if indexPath.row == 5 {
                cell.backgroundColor = AppConstants.BROWN_COLOR
                cell.profileImageView.image = UIImage(named: "c3")
                cell.titleLabel.text = "In general skills "
                cell.detailsLabel.text = "please keep selen health status updated by asking all remainig questions"
            }
            
            cell.titleLabel.text = assessmentArray[indexPath.row]
            */
            //scell.backgroundColor = .red
            return cell
        }
        
      
        
        return collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        selectedSurvey = surveysList[indexPath.row]
        
        self.performSegue(withIdentifier: "toSurvey", sender: self)
        //self.performSegue(withIdentifier: "toAssessment", sender: self)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        if collectionView == self.notificationsCollectionView  {
            
            return CGSize(width: collectionView.frame.width - 10  , height: 60)
            
        }
        
        
        return CGSize(width: 150, height: 150)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
  
}

extension ChildProfileViewController: UITableViewDelegate ,UITableViewDataSource ,EmptyDataSetSource ,EmptyDataSetDelegate {
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        
        
         let healthString = """

        تهانينا، تطور طفلك متناسب مع عمره سيتم إعلامكم بموعد الاستبيان القادم عندما يحين موعده.  مع تمنياتنا لكم بموفور الصحة والعافية
        """
                    
        let font = UIFont.systemFont(ofSize: 16)
        if self.answeredSurveys.count == self.surveysList.count {
            
            if childItem.status == .FINE {
                return NSAttributedString(string: healthString,attributes: [NSAttributedString.Key.font: font, .foregroundColor: UIColor.darkGray] )
            }
            
        }
        return NSAttributedString(string: "")
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.answeredSurveys.count == self.surveysList.count {
            
            if childItem.status == .DANGER {
                if objectivesListForDisplaying.count == 0 {
                    return centers.count
                }
            }
        }
        return objectivesListForDisplaying.count
    }
    
    /*
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let o = objectivesList[section]
        
        return o.objective_text_en
    }
    */
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if self.answeredSurveys.count == self.surveysList.count {
                   
                   if childItem.status == .DANGER {
                       if objectivesListForDisplaying.count == 0 {
                        
                        return tableView.dequeueReusableCell(withIdentifier: "centerCell", for: indexPath)
                    }
            }
        }
        let cellIdentifier = "taskCell"
        
        let obje = objectivesListForDisplaying[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! taskCell
        
        let taskLabel = cell.viewWithTag(1) as! UILabel
        
        
        
        
        //selectedTask = task
        
        
        cell.taskLabel.text = obje.objective_text_en
        
        cell.answerObjDelegate = self
        //cell.selectedTask = task
        cell.selectedObj = objectivesListForDisplaying[indexPath.row]
        
        /*
        
        if let o = answeredbjectivesList.filter({ (t) -> Bool in
            t.taskId == task.taskId
        }).first {
            task.selectedTask = o.selectedTask
        }
        if task.selectedTask == "done" {
            cell.aCheckBox.setCheckState(.checked, animated: true)
        }else{
            cell.aCheckBox.setCheckState(.unchecked, animated: true)
        }
        
        
        if task.selectedTask == "not" {
            cell.bCheckBox.setCheckState(.checked, animated: true)
        }else{
            cell.bCheckBox.setCheckState(.unchecked, animated: true)
        }
        
        
        if task.selectedTask == "need" {
            cell.cCheckBox.setCheckState(.checked, animated: true)
        }else{
            cell.cCheckBox.setCheckState(.unchecked, animated: true)
        }
        
        
       */
        
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if cell.reuseIdentifier == "centerCell" {
            let view = cell.viewWithTag(2)
            
            
            view?.layer.cornerRadius = 10
            view?.layer.masksToBounds = true
            let stackView = cell.viewWithTag(1)
            
            let centername = stackView?.viewWithTag(11) as! UILabel
            let cenetrEmirate = stackView?.viewWithTag(22) as! UILabel
            let cenetrNumber = stackView?.viewWithTag(33) as! UILabel
            
            
            let centerItem = centers[indexPath.row]
            centername.text = centerItem.center_name
            cenetrEmirate.text = centerItem.center_address
            cenetrNumber.text = centerItem.telephone
            
            
            
        }
        if cell.reuseIdentifier == "taskCell" {
            
            
            let cell = cell as! taskCell
            let obje = objectivesListForDisplaying[indexPath.row]
            cell.selectedObj = obje
            cell.answerObjDelegate = self
            cell.checkAnswers()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        //self.performSegue(withIdentifier: "toAssessment", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if self.answeredSurveys.count == self.surveysList.count {
                   
                   if childItem.status == .DANGER {
                       if objectivesListForDisplaying.count == 0 {
                        return 140
                    }
            }
        }
        
        return 80
        
    }
    
    
   
    
    func submitAnswer() {
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "toSurvey" {
            let vc = segue.destination as! AssessmentViewController
          
            vc.delegate = self
            vc.selectedSurvey = self.selectedSurvey
            vc.selectedChild = self.childItem
            
        }
        if segue.identifier == "toAssessment" {
            let vc = segue.destination as! categoriesViewController
          
            
            vc.selectedSurvey = self.selectedSurvey
            vc.selectedChild = self.childItem
            
        }else if segue.identifier == "toEditChild"
        {
            let vc = segue.destination as! AddChildViewController
            vc.isEdit = true
            vc.childItem = self.childItem
        }else if segue.identifier == "toAddObjective" {
            
            let dest = segue.destination as! addObjectiveViewController
            dest.delegate = self
            dest.isEdit = isEditObjective
            dest.selectedObjective = self.selectedObjective
            dest.childItem = self.childItem
            
        }
        
    }
}
extension ChildProfileViewController: answerObjective {
    
    func editObjective(cell: taskCell) {
        if let indexPath = self.tableView.indexPath(for: cell) {
            
            isEditObjective = true
            self.selectedObjective = objectivesListForDisplaying[indexPath.row]
            self.performSegue(withIdentifier: "toAddObjective", sender: self)
            
            //self.tableView.reloadData()
        }
    }
    func answerObjective(o: Objective, answerString: String , cell: taskCell) {
        
        
       
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        WebService.answerObjectiveChild(objectiveId: o.objectiveId, childId: childItem.objectID, result: answerString) { (json) in
            
            
            print(json)
            DispatchQueue.main.async {
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            }
            
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
                     
            if code == 200 {
                
                DispatchQueue.main.async {
                    
                    
                    
                
                    if self.mocd_user?.isCenter == "1" || self.mocd_user?.isCenter == "true"  {
                        return
                    }
                    if o.result == "done" || answerString == "done" {
                        if let indexPath = self.tableView.indexPath(for: cell) {
                            self.objectivesListForDisplaying.remove(at: indexPath.row)
                            
                            
                            self.tableView.deleteRows(at: [indexPath], with: .fade)
                            
                            //self.tableView.reloadData()
                        }
                        
                    }
                    
                }
            }else{
                DispatchQueue.main.async {
                    Utils.showAlertWith(title: "Error", message: message, viewController: self)
                }
            }
            
        }
        
    }
    
    
}
