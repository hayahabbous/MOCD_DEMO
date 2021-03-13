//
//  DiseaseListVC.swift
//  SmartAgenda
//
//  Created by indianic on 30/01/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit

class DiseaseListVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    //MARK: Variables
    var arrMutDiseasesList = [DiseasesReminderModel]()
    var arrMutDiseases = [DiseasesReminderModel]()
    var arrMutDiseasesTwice = [DiseasesReminderModel]()
    var arrMutDiseasesthrice = [DiseasesReminderModel]()
    var arrMutDiseasesSearchObj = [DiseasesReminderModel]()

    var isSearch: Bool = false
    var idThrice: Bool = false
    
    //MARK: IBOutlets
    @IBOutlet var lblScreenTitle: UILabel!
    
    @IBOutlet var tblDisease: TPKeyboardAvoidingTableView!
    
    @IBOutlet var viewSearch: UIView!
    
    @IBOutlet var searchbar: UISearchBar!
    
    @IBOutlet var lblNoData: UILabel!
    
    @IBOutlet var btnBackEN: UIButton!
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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        isSearch = false

        getDiseasesFromDB()

        
        if GeneralConstants.DeviceType.IS_IPAD {
            customizeFonts(in: lblScreenTitle, aFontName: Medium, aFontSize: 0)
        }else{
            customizeFonts(in: lblScreenTitle, aFontName: Medium, aFontSize: 0)
        }
            
        
        
        // Set Screen title label value
        lblScreenTitle.text = JMOLocalizedString(forKey: "USER DISEASES", value: "")
        
        // Change UI through localizeThingsInView method
        LanguageManager().localizeThingsInView(parentView: self.view)
        
        

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == SegueIdentifiers.ksegueDisease.rawValue {
            
            let aObjVC:AddDiseaseVC = segue.destination as! AddDiseaseVC
            
            let indexPath = self.tblDisease.indexPathForSelectedRow
            
           
            
            if isSearch {
                 let typeIDFromSerach = arrMutDiseasesSearchObj[(indexPath?.row)!].disease_id!
//                let scheduleFromSerach = arrMutDiseasesSearchObj[(indexPath?.row)!].disease_schedule!
                
                 logicForRecurring(typeID:"\(typeIDFromSerach)" , indexPath: indexPath!, disease:arrMutDiseasesSearchObj[(indexPath?.row)!] , compl: { (obj: DiseasesReminderModel) in
                    aObjVC.diseaseSelected = obj
                })
                
            }else{
                
                let typeIDFrom = arrMutDiseasesList[(indexPath?.row)!].disease_id!
//                let scheduleFrom = arrMutDiseasesList[(indexPath?.row)!].disease_schedule!
                
                logicForRecurring(typeID: "\(typeIDFrom)", indexPath: indexPath!, disease:arrMutDiseasesList[(indexPath?.row)!] , compl: { (aobj: DiseasesReminderModel) in
                    aObjVC.diseaseSelected = aobj
                })
                
            }
            
            aObjVC.isBoolEdit = true
            
        }else if segue.identifier == SegueIdentifiers.ksegueAddDisease.rawValue {
            let aObjVC:AddDiseaseVC = segue.destination as! AddDiseaseVC
            
            aObjVC.isBoolEdit = false

            
        }
    }
    
    func logicForRecurring(typeID: String, indexPath: IndexPath, disease: DiseasesReminderModel , compl: ((DiseasesReminderModel) -> Void)) {
    
        DiseaseModel().getDiseaseListBasedOnTypeID(typeID: typeID) { (objs: [DiseasesReminderModel]) in
            self.arrMutDiseases.removeAll()
            
//            self.arrMutDiseases = [disease]
            self.arrMutDiseasesTwice.removeAll()
            self.arrMutDiseasesthrice.removeAll()
            
           
            for objDisease in objs {
                
                if Int(disease.disease_schedule) == FrequencyType.OnceType.rawValue {
                    
                    
                    self.arrMutDiseases.append(disease)
                    
                    self.arrMutDiseases.last?.disease_id = disease.disease_id
                    self.arrMutDiseases.last?.reminderTime = objDisease.reminderTime
                    self.arrMutDiseases.last?.typeID = objDisease.typeID
                    self.arrMutDiseases.last?.type = objDisease.type
                    self.arrMutDiseases.last?.reminderWithNotification = objDisease.reminderWithNotification
                    self.arrMutDiseases.last?.reminderDate = objDisease.reminderDate
                    self.arrMutDiseases.last?.reminderID = objDisease.reminderID
                    
                    // Once
                }else if Int(disease.disease_schedule) == FrequencyType.Twice.rawValue {
                    
                    // Twice
                    
                    if disease.disease_title == self.arrMutDiseasesTwice.last?.disease_title {
                    
                        self.arrMutDiseases.last?.disease_id2 = disease.disease_id
                        self.arrMutDiseases.last?.time2 = objDisease.reminderTime
                    
                    }else{
                        
                        self.arrMutDiseasesTwice.append(disease)
                        self.arrMutDiseases.append(disease)
                        
                
                        self.arrMutDiseases.last?.disease_id = disease.disease_id
                        self.arrMutDiseases.last?.reminderTime = objDisease.reminderTime
                        self.arrMutDiseases.last?.typeID = objDisease.typeID
                        self.arrMutDiseases.last?.type = objDisease.type
                        self.arrMutDiseases.last?.reminderWithNotification = objDisease.reminderWithNotification
                        self.arrMutDiseases.last?.reminderDate = objDisease.reminderDate
                        self.arrMutDiseases.last?.reminderID = objDisease.reminderID

                    }
                    
                }else if Int(disease.disease_schedule) == FrequencyType.Thrice.rawValue {
                    
                    // Thrice
                    
                    if disease.disease_title == self.arrMutDiseasesthrice.last?.disease_title {
                        
                        if idThrice {
                            self.arrMutDiseases.last?.time3 = objDisease.reminderTime
                            self.arrMutDiseases.last?.disease_id3 = disease.disease_id
                            idThrice = false
                            
                        }else{
                            self.arrMutDiseases.last?.time2 = objDisease.reminderTime
                            self.arrMutDiseases.last?.disease_id2 = disease.disease_id
                            idThrice = true
                        }
                        
                    }else{
                        self.arrMutDiseasesthrice.append(disease)
                        self.arrMutDiseases.append(disease)
                        
                        self.arrMutDiseases.last?.disease_id = disease.disease_id
                        self.arrMutDiseases.last?.reminderTime = objDisease.reminderTime
                        self.arrMutDiseases.last?.typeID = objDisease.typeID
                        self.arrMutDiseases.last?.type = objDisease.type
                        self.arrMutDiseases.last?.reminderWithNotification = objDisease.reminderWithNotification
                        self.arrMutDiseases.last?.reminderDate = objDisease.reminderDate
                        self.arrMutDiseases.last?.reminderID = objDisease.reminderID

                    }
                    
                }else {
                    self.arrMutDiseases.append(disease)
                    
                   
                }
            }

            
            if self.arrMutDiseases.count > 0 {
                compl(self.arrMutDiseases[0])
            }
            
            
        }
        
    
        
        

        
    }
    //MARK: IBActions Events
    
    /// Back button click
    ///
    /// - Parameter sender: button reference
    @IBAction func btnBackClick(_ sender: UIButton) {
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    /// Search button click
    ///
    /// - Parameter sender: button reference
    @IBAction func btnSearchClick(_ sender: UIButton) {
        searchbar.text = ""

        self.viewSearch.isHidden = false

    }
    
    
    /// Button add click to add disease by user
    ///
    /// - Parameter sender: button reference
    @IBAction func btnAddDiseaseClick(_ sender: UIButton) {
    }
    
    //MARK: Custom Methods
    
    private func getDiseasesFromDB() {
        // To get all diseases from DB
        getDiseaseList { (objs: [DiseasesReminderModel]) in
            
            self.arrMutDiseasesList.removeAll()
            self.arrMutDiseasesTwice.removeAll()
            self.arrMutDiseasesthrice.removeAll()
            
//            for objDisease in objs {
//                
//                if Int(objDisease.disease_schedule) == FrequencyType.OnceType.rawValue {
//                    self.arrMutDiseasesList.append(objDisease)
//                    // Once
//                }else if Int(objDisease.disease_schedule) == FrequencyType.Twice.rawValue {
//                    
//                    // Twice
//                    
//                    if objDisease.disease_title == self.arrMutDiseasesTwice.last?.disease_title {
//                        
//                        self.arrMutDiseasesList.last?.disease_id2 = objDisease.disease_id
//                        self.arrMutDiseasesList.last?.time2 = objDisease.reminderTime
//                    
//                    }else{
//                        
//                        self.arrMutDiseasesTwice.append(objDisease)
//                        self.arrMutDiseasesList.append(objDisease)
//                    
//                    }
//                    
//                    
//                }else if Int(objDisease.disease_schedule) == FrequencyType.Thrice.rawValue {
//                    
//                    // Thrice
//                    
//                    if objDisease.disease_title == self.arrMutDiseasesthrice.last?.disease_title {
//                        
//                        if idThrice {
//                            self.arrMutDiseasesList.last?.time3 = objDisease.reminderTime
//                            self.arrMutDiseasesList.last?.disease_id3 = objDisease.disease_id
//                            idThrice = false
//                            
//                        }else{
//                            self.arrMutDiseasesList.last?.time2 = objDisease.reminderTime
//                            self.arrMutDiseasesList.last?.disease_id2 = objDisease.disease_id
//                            idThrice = true
//                        }
//                        
//                    }else{
//                        self.arrMutDiseasesthrice.append(objDisease)
//                        self.arrMutDiseasesList.append(objDisease)
//                    }
//                    
//                }else {
//                    self.arrMutDiseasesList.append(objDisease)
//                }
//            }
            
             self.arrMutDiseasesList = objs
            
            if self.arrMutDiseasesList.count == 0 {
                lblNoData.isHidden = false
            }else{
                lblNoData.isHidden = true
            }
            self.tblDisease.reloadData()

    }
        
    }
    func cancelNotification(str: String, complition: ((Void)-> Void)) {
        
        print("str = \(str)")
//        LocalNotificationHelper.sharedInstance.removeNotification([str])
        LocalNotificationHelper.sharedInstance.removeNotification([str], completion: { (status) in
            
        })
    }
    
    private func getDiseaseList(complition: (([DiseasesReminderModel]) -> Void)) {
        
        
        DiseaseModel().getDiseaseList { (objs: [DiseasesReminderModel]) in
            complition(objs)
        }
    }
    
    
    /// Search disease
    ///
    /// - Parameter text: Text which we have to search from array
    func searchDisease(text: String) {
        
        arrMutDiseasesSearchObj.removeAll()
        
        arrMutDiseasesSearchObj = arrMutDiseasesList.filter({ (obj: DiseasesReminderModel) -> Bool in
            let aDiseaseTitle = JMOLocalizedString(forKey: obj.disease_title, value: "")
            return aDiseaseTitle.lowercased().contains(text.lowercased())
//            return obj.disease_title.lowercased().contains(text.lowercased())
        })
        
//        if arrMutDiseasesSearchObj.count == 0 {
//            
//            lblNoData.text = JMOLocalizedString(forKey: "No found Result", value: "")
//            lblNoData.isHidden = false
//            
//        }
//        if arrMutDiseasesSearchObj.count == 0 {
        
       
            self.tblDisease.reloadData()
        
//            UIAlertController.showAlertWithOkButton(self, aStrMessage: "No disease found", completion: { (Int, String) in
//                
//            })
//        }else{
//            self.tblDisease.reloadData()
//        }
    }
    
    
    func delete(indexPath: IndexPath, aObjDisease: DiseasesReminderModel) {
        self.cancelNotification(str: String(aObjDisease.reminderID!) , complition: { (Void) in
            
        })
        
        if self.isSearch {
            
            var aIntCount = 0
            for obj in self.arrMutDiseasesList {
                
                if obj.disease_id == self.arrMutDiseasesSearchObj[indexPath.row].disease_id
                {
                    self.arrMutDiseasesList.remove(at: aIntCount)
                }
                
                aIntCount = aIntCount + 1
            }
            self.arrMutDiseasesSearchObj.remove(at: indexPath.row)
            
        }else{
            self.arrMutDiseasesList.remove(at: indexPath.row)
        }
        
        self.tblDisease.reloadData()
    }
    
    
    //MARK: UITableViewDelegate and UITableViewDatasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearch {
            if self.arrMutDiseasesSearchObj.count == 0 {
                self.lblNoData.isHidden = false
            }else{
                self.lblNoData.isHidden = true
            }
            
            
            return arrMutDiseasesSearchObj.count
        }else{
            
            if self.arrMutDiseasesList.count == 0 {
                self.lblNoData.isHidden = false
            }else{
                self.lblNoData.isHidden = true
            }
            
            return arrMutDiseasesList.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let diseaseCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifire.CellDisease.rawValue, for: indexPath) as! DiseaseCell
        
        var aObjDisease = DiseasesReminderModel()
        
        if isSearch {
            aObjDisease =  arrMutDiseasesSearchObj[indexPath.row]
        }else{
            aObjDisease = arrMutDiseasesList[indexPath.row]
        }
        
        diseaseCell.lblTitle.text = aObjDisease.disease_title
        
        var aStrFre = String()
        
        if Int(aObjDisease.disease_schedule!) == FrequencyType.OnceType.rawValue {
            aStrFre = JMOLocalizedString(forKey: Frequency.Once.rawValue, value: "")
        }else if Int(aObjDisease.disease_schedule!) == FrequencyType.Twice.rawValue {
            aStrFre = JMOLocalizedString(forKey: Frequency.Twice.rawValue, value: "")
        }else if Int(aObjDisease.disease_schedule!) == FrequencyType.Thrice.rawValue{
            aStrFre = JMOLocalizedString(forKey: Frequency.Thrice.rawValue, value: "")
        }else {
            aStrFre = "--"
        }
        
        // From system : default disease 
        if aObjDisease.disease_schedule == "1" && aObjDisease.disease_title.lowercased().contains("Blood Pressure".lowercased()){
            diseaseCell.imgViewIcon.image = UIImage(named: "diseases_03")
        }else if aObjDisease.disease_schedule == "1" && aObjDisease.disease_title.lowercased().contains("Blood Sugar".lowercased()){
            diseaseCell.imgViewIcon.image = UIImage(named: "diseases_06")
        }else {
            diseaseCell.imgViewIcon.image = UIImage(named: "diseases_06")

        }
        
        
        diseaseCell.lblFrequency.text = "\(JMOLocalizedString(forKey: "Frequency", value: "")): \(aStrFre)"
        
        LanguageManager().localizeThingsInView(parentView: diseaseCell)
        
        if (GeneralConstants.DeviceType.IS_IPAD) {
            customizeFonts(in: diseaseCell.lblTitle, aFontName: Bold, aFontSize: 0)
            customizeFonts(in: diseaseCell.lblFrequency, aFontName: Medium, aFontSize: 0)
        }else{
            customizeFonts(in: diseaseCell.lblTitle, aFontName: Bold, aFontSize: 0)
            customizeFonts(in: diseaseCell.lblFrequency, aFontName: Medium, aFontSize: 0)
        }
        return diseaseCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        var aObjDisease = DiseasesReminderModel()

        if self.isSearch {
            aObjDisease =  self.arrMutDiseasesSearchObj[indexPath.row]
        }else{
            aObjDisease = self.arrMutDiseasesList[indexPath.row]
        }

//        if ((aObjDisease.disease_schedule == "1") && ((JMOLocalizedString(forKey: aObjDisease.disease_title!, value: "") == JMOLocalizedString(forKey: "Blood pressure", value: "")))){
//            
//        }else if ((aObjDisease.disease_schedule == "2") && (JMOLocalizedString(forKey: aObjDisease.disease_title!, value: "") == JMOLocalizedString(forKey: "Blood sugar", value: ""))) {
//            
//        }

        if (aObjDisease.disease_id == 4) || (aObjDisease.disease_id == 5){
            
        }
        else{
            performSegue(withIdentifier: SegueIdentifiers.ksegueDisease.rawValue, sender: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    internal func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle
    {
        var aObjDisease = DiseasesReminderModel()
        if self.isSearch {
            aObjDisease =  self.arrMutDiseasesSearchObj[indexPath.row]
        }else{
            aObjDisease = self.arrMutDiseasesList[indexPath.row]
        }
        
        if (aObjDisease.disease_id == 4) || (aObjDisease.disease_id == 5){
            return .none

        }
        return .delete
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        var aObjDisease = DiseasesReminderModel()
        if self.isSearch {
            aObjDisease =  self.arrMutDiseasesSearchObj[indexPath.row]
        }else{
            aObjDisease = self.arrMutDiseasesList[indexPath.row]
        }

      
            let deleteAction = UITableViewRowAction(style: .default, title: JMOLocalizedString(forKey: "Delete", value: "")) { (action , index) in
                //handle delete
                
                UIAlertController.showDeleteAlert(self, aStrMessage: JMOLocalizedString(forKey: "Are you sure that you want to delete?", value: ""), completion: { (index: Int, str: String) in
                    //handle delete
                    
                    
                    if index == 0 {
                        
                        if Int(aObjDisease.disease_schedule) == FrequencyType.OnceType.rawValue || Int(aObjDisease.disease_schedule) == 0{
                            
                            self.cancelNotification(str: String(aObjDisease.disease_id!), complition: { (Void) in
                                
                            })
                            
                            DiseaseModel().deleteDisease(deleteID: (aObjDisease.disease_id)!, complition: { (result: Bool) in
                                
                                    if((aObjDisease.type) != nil && (aObjDisease.typeID) != nil && (aObjDisease.reminderID!) != 0){
                                    
                                        UserActivityModel().deleteActivity(type: (aObjDisease.type)!, typeid: (aObjDisease.typeID)!,  userActivityDate: "", reminderID: (aObjDisease.reminderID!), complition: { (result: Bool) in
                                            self.delete(indexPath: indexPath, aObjDisease: aObjDisease)
                                        })
                                    }
                             
                            })
                            
                            self.arrMutDiseasesList.remove(at: indexPath.row)
                            
                            self.tblDisease.reloadData()
                            
                            
                        }else if Int(aObjDisease.disease_schedule) == FrequencyType.Twice.rawValue {
                            
                            if self.isSearch {
                                let typeIDFromSerach = self.arrMutDiseasesSearchObj[(indexPath.row)].disease_id!
                                self.logicForRecurring(typeID:"\(typeIDFromSerach)" , indexPath: indexPath, disease:self.arrMutDiseasesSearchObj[(indexPath.row)] , compl: { (obj: DiseasesReminderModel) in
                                    
                                    DiseaseModel().deleteDisease(deleteID: (aObjDisease.disease_id)!, complition: { (result: Bool) in
                                        
                                        self.cancelNotification(str: String(aObjDisease.reminderID!), complition: { (Void) in
                                            
                                        })
                                        

                                        
                                        DiseaseModel().deleteDisease(deleteID: (aObjDisease.disease_id2)!, complition: { (result: Bool) in
                                            
                                            self.cancelNotification(str: String(aObjDisease.reminderID!), complition: { (Void) in
                                                
                                            })
                                            UserActivityModel().deleteActivity(type: (aObjDisease.type)!, typeid: (aObjDisease.typeID)!,  userActivityDate: "", reminderID: (aObjDisease.reminderID!), complition: { (result: Bool) in
                                                self.delete(indexPath: indexPath, aObjDisease: aObjDisease)
                                            })
                                        })
                                    })
                                })
                            }else{
                                
                                let typeIDFrom = self.arrMutDiseasesList[(indexPath.row)].disease_id!

                                self.logicForRecurring(typeID: "\(typeIDFrom)", indexPath: indexPath, disease:self.arrMutDiseasesList[(indexPath.row)] , compl: { (aobj: DiseasesReminderModel) in
                                    
                                    ReminderModel().getAllFromReminderIDByDiseaseID(typrID: String((aObjDisease.type)!), completion: { (obj: [ReminderModel]) in
                                        
                                        let aDeleteReminderIDs = obj
                                        
                                        for objDeleteReminderID in aDeleteReminderIDs{
                                            print("objDeleteReminderID = \(objDeleteReminderID)")
                                            
                                            let aDeleteReminderID = String.init(format: "%d", objDeleteReminderID.reminderID)
                                            self.cancelNotification(str: aDeleteReminderID, complition: { (Void) in
                                                
                                            })
                                            
                                        }
                                    })
                                    
                                    DiseaseModel().deleteDisease(deleteID: (aObjDisease.disease_id)!, complition: { (result: Bool) in
                                        DiseaseModel().deleteDisease(deleteID: (aObjDisease.disease_id2)!, complition: { (result: Bool) in
                                            
                                            UserActivityModel().deleteActivity(type: (aObjDisease.type)!, typeid: (aObjDisease.typeID)!,  userActivityDate: "", reminderID: (aObjDisease.reminderID!), complition: { (result: Bool) in
                                                self.delete(indexPath: indexPath, aObjDisease: aObjDisease)
                                            })
                                        })
                                    })
                                    
                                })
                            }
                            
                        }else if Int(aObjDisease.disease_schedule) == FrequencyType.Thrice.rawValue {
                            
                            if self.isSearch {
                                
                                let typeIDFromSerach = self.arrMutDiseasesSearchObj[(indexPath.row)].disease_id!
                                
                                

                                
                                self.logicForRecurring(typeID:"\(typeIDFromSerach)" , indexPath: indexPath, disease:self.arrMutDiseasesSearchObj[(indexPath.row)] , compl: { (obj: DiseasesReminderModel) in
                                    
                                    ReminderModel().getAllFromReminderIDByDiseaseID(typrID: String((aObjDisease.type)!), completion: { (obj: [ReminderModel]) in
                                        
                                        let aDeleteReminderIDs = obj
                                        
                                        for objDeleteReminderID in aDeleteReminderIDs{
                                            print("objDeleteReminderID = \(objDeleteReminderID)")
                                            let aDeleteReminderID = String.init(format: "%d", objDeleteReminderID.reminderID)
                                            self.cancelNotification(str: aDeleteReminderID, complition: { (Void) in
                                                
                                            })
                                            
                                        }
                                        
                                    })
                                    
                                    
                                    DiseaseModel().deleteDisease(deleteID: (aObjDisease.disease_id)!, complition: { (result: Bool) in
                                        
                                        DiseaseModel().deleteDisease(deleteID: (aObjDisease.disease_id2)!, complition: { (result: Bool) in
                                            
                                            DiseaseModel().deleteDisease(deleteID: (aObjDisease.disease_id3)!, complition: { (result: Bool) in
                                                
                                                UserActivityModel().deleteActivity(type: (aObjDisease.type)!, typeid: (aObjDisease.typeID)!,  userActivityDate: "", reminderID: (aObjDisease.reminderID!), complition: { (result: Bool) in
                                                    self.delete(indexPath: indexPath, aObjDisease: aObjDisease)
                                                })
                                            })
                                        })
                                    })
                                })
                            }else{
                                let typeIDFrom = self.arrMutDiseasesList[(indexPath.row)].disease_id!
                                
                                

                                
                                
                                self.logicForRecurring(typeID: "\(typeIDFrom)", indexPath: indexPath, disease:self.arrMutDiseasesList[(indexPath.row)] , compl: { (aobj: DiseasesReminderModel) in
                                    
                                    ReminderModel().getAllFromReminderIDByDiseaseID(typrID: String((aObjDisease.type)!), completion: { (obj: [ReminderModel]) in
                                        
                                        let aDeleteReminderIDs = obj
                                        
                                        for objDeleteReminderID in aDeleteReminderIDs{
                                            print("objDeleteReminderID = \(objDeleteReminderID)")
                                            let aDeleteReminderID = String.init(format: "%d", objDeleteReminderID.reminderID)
                                            self.cancelNotification(str: aDeleteReminderID, complition: { (Void) in
                                                
                                            })
                                            
                                        }
                                        
                                    })
                                    
                                    DiseaseModel().deleteDisease(deleteID: (aObjDisease.disease_id)!, complition: { (result: Bool) in
                                       
                                        
                                        DiseaseModel().deleteDisease(deleteID: (aObjDisease.disease_id2)!, complition: { (result: Bool) in
                                            self.cancelNotification(str: String(aObjDisease.disease_id2!), complition: { (Void) in
                                                
                                            })
                                            DiseaseModel().deleteDisease(deleteID: (aObjDisease.disease_id3)!, complition: { (result: Bool) in
                                                
                                                self.cancelNotification(str: String(aObjDisease.disease_id3!), complition: { (Void) in
                                                    
                                                })
                                                UserActivityModel().deleteActivity(type: (aObjDisease.type)!, typeid: (aObjDisease.typeID)!,  userActivityDate: "", reminderID: (aObjDisease.reminderID!), complition: { (result: Bool) in
                                                    self.delete(indexPath: indexPath, aObjDisease: aObjDisease)
                                                })
                                            })
                                            
                                        })
                                    })
                                    
                                })
                            }
                        }
                        
                        if self.arrMutDiseasesList.count == 0 {
                            self.lblNoData.isHidden = false
                        }else{
                            self.lblNoData.isHidden = true
                        }
                        
                    }
                })

            }
            
            return [deleteAction]
            
//        }
//        return nil
    }
    
    
    
    
    //MARK: UISearchBarDelegate Methods
    
    //MARK: UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        isSearch = true
        searchDisease(text: searchBar.text!)
        
        if searchBar.text == "" {
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
                
                self.isSearch = false
                
                UIView.animate(withDuration: 2.0) {
                    self.viewSearch.isHidden = true
                }
                
                self.tblDisease.reloadData()
                
            }
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        
        isSearch = true
        if (searchBar.text?.count)! > 0 {
            
            searchDisease(text: searchBar.text!)
        }else{
            
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.view.endEditing(true)
        isSearch = false
        
        UIView.animate(withDuration: 2.0) {
            self.viewSearch.isHidden = true
        }
        
        self.tblDisease.reloadData()
    }
}
