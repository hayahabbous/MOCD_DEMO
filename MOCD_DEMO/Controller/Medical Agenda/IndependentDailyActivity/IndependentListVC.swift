//
//  IndependentListVC.swift
//  SmartAgenda
//
//  Created by indianic on 01/02/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit

class IndependentListVC: UIViewController, UITableViewDelegate, UITableViewDataSource ,UISearchBarDelegate {
    
    
    //MARK: Variables
    
    var arrMutIndependent = [indDailyReminderModel]()
    var arrMutIndependentSearch = [indDailyReminderModel]()
    
    var mutArrIcon = [String]()
    var isSearch: Bool = false
    
    
    //MARK: IBOutlets
    @IBOutlet var lblScreenTitle: UILabel!
    
    @IBOutlet var searchbar: UISearchBar!
    
    @IBOutlet var tblIndependent: TPKeyboardAvoidingTableView!
    
    @IBOutlet var viewSearch: UIView!
    
    @IBOutlet var btnBackEN: UIButton!
    
    @IBOutlet var lblNoData: UILabel!
    
    //MARK: Viewcontroller Methods
    override func viewDidLoad() {
        
        super.viewDidLoad()
        searchbar.delegate = self
        
        self.navigationController?.isNavigationBarHidden = true
        
        if AppConstants.isArabic()
        {
            btnBackEN.imageView?.transform = (btnBackEN.imageView?.transform.rotated(by: CGFloat(M_PI)))!
        }else{
            btnBackEN.imageView?.transform = (btnBackEN.imageView?.transform.rotated(by: CGFloat(M_PI*2)))!
        }
        mutArrIcon = ["independent-activities_03", "independent-activities_06", "independent-activities_08", "independent-activities_10"]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        isSearch = false
        
        LanguageManager().localizeThingsInView(parentView: (self.view))
        
        self.lblScreenTitle.text = JMOLocalizedString(forKey: kIndependent, value: "")
        
        if GeneralConstants.DeviceType.IS_IPAD {
            customizeFonts(in: lblScreenTitle, aFontName: Medium, aFontSize: 0)
        }else{
            customizeFonts(in: lblScreenTitle, aFontName: Medium, aFontSize: 0)
        }
        
        
        // Get All Daily independent data from DB
        
        getIndependentActivityData { (objs: [indDailyReminderModel]) in
            
            arrMutIndependent.removeAll()
            
            arrMutIndependent = objs
            
            if arrMutIndependent.count == 0 {
                lblNoData.isHidden = false
            }else{
                lblNoData.isHidden = true
            }
            self.tblIndependent.reloadData()
            
        }
        
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
        
        
        if segue.identifier == SegueIdentifiers.ksegueIndependent.rawValue {
            let aObjVC:AddIndependentVC = segue.destination as! AddIndependentVC
            
            let indexPath = self.tblIndependent.indexPathForSelectedRow
            
            if isSearch {
                aObjVC.independentSelected = arrMutIndependentSearch[(indexPath?.row)!]
            }else{
                aObjVC.independentSelected = arrMutIndependent[(indexPath?.row)!]
            }
            
            aObjVC.isBoolEdit = true
            
        }else if segue.identifier == SegueIdentifiers.ksegueAddIndependent.rawValue {
            let aObjVC:AddIndependentVC = segue.destination as! AddIndependentVC
            
            aObjVC.isBoolEdit = false
            
        }
    }
    
    
    //MARK: IBActions
    @IBAction func btnBackClcik(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnSearchClick(_ sender: UIButton) {
        searchbar.text = ""
        
        self.viewSearch.isHidden = false
        
        
    }
    
    //MARK: Custom Methods
    
    private func getIndependentActivityData(compltion: (([indDailyReminderModel]) -> Void)) {
        
        indDailyActivitiesModel().getAllIndependentList { (objs: [indDailyReminderModel]) in
            compltion(objs)
        }
        
    }
    
    
    //MARK: UITableViewDelegate and UITableViewDatasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearch {
            if arrMutIndependentSearch.count > 0{
                lblNoData.isHidden = true
            }else{
                lblNoData.isHidden = false
            }
            return arrMutIndependentSearch.count
        }else{
            if arrMutIndependent.count > 0{
                lblNoData.isHidden = true
            }else{
                lblNoData.isHidden = false
            }
            return arrMutIndependent.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let independentCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifire.CellIndependent.rawValue, for: indexPath) as! IndependentCell
        
        var aObjIndeRem = indDailyReminderModel()
        if isSearch {
            aObjIndeRem =  arrMutIndependentSearch[indexPath.row]
        }else{
            aObjIndeRem = arrMutIndependent[indexPath.row]
        }
        
        independentCell.lblTitle.text = aObjIndeRem.title
        
        var aStrIcon: String!
        if independentCell.lblTitle.text?.lowercased() == "eating" {
            // Predefined
            aStrIcon = mutArrIcon[0]
        }else if independentCell.lblTitle.text?.lowercased() == "getting dressed" {
            // Predefined
            aStrIcon = mutArrIcon[1]
        }else if independentCell.lblTitle.text?.lowercased() == "mobility" {
            // Predefined
            aStrIcon = mutArrIcon[2]
        }else if independentCell.lblTitle.text?.lowercased() == "playing sport" {
            // Predefined
            aStrIcon = mutArrIcon[3]
        }else{
            // Custom , added by user
            aStrIcon = mutArrIcon[1]
        }
        
        independentCell.imgView.image = UIImage(named: aStrIcon)
        
        
        LanguageManager().localizeThingsInView(parentView: independentCell)
        
        if AppConstants.isArabic() {
            independentCell.lblTitle.textAlignment = .right
        }
        if GeneralConstants.DeviceType.IS_IPAD {
            
            customizeFonts(in: independentCell.lblTitle, aFontName: Bold, aFontSize: 0)
            
        }else{
            customizeFonts(in: independentCell.lblTitle, aFontName: Bold, aFontSize: 0)
        }
        
        return independentCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        var aObjIndeRem = indDailyReminderModel()
        if self.isSearch {
            aObjIndeRem =  self.arrMutIndependentSearch[indexPath.row]
        }else{
            aObjIndeRem = self.arrMutIndependent[indexPath.row]
        }
        
        
        if (aObjIndeRem.title!.lowercased() == "eating") ||
            (aObjIndeRem.title!.lowercased() == "getting dressed") ||
            (aObjIndeRem.title!.lowercased() == "mobility") ||
            (aObjIndeRem.title!.lowercased() == "playing sport") {
            // Predefined
        }else{
            performSegue(withIdentifier: SegueIdentifiers.ksegueIndependent.rawValue, sender: nil)
            
        }
        
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
   func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle
    {
        
        var aObjIndeRem = indDailyReminderModel()
        if self.isSearch {
            aObjIndeRem =  self.arrMutIndependentSearch[indexPath.row]
        }else{
            aObjIndeRem = self.arrMutIndependent[indexPath.row]
        }
        
        
        if (aObjIndeRem.title!.lowercased() == "eating") ||
            (aObjIndeRem.title!.lowercased() == "getting dressed") ||
            (aObjIndeRem.title!.lowercased() == "mobility") ||
            (aObjIndeRem.title!.lowercased() == "playing sport") {
            // Predefined
            return .none
        }
        
        return .delete
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: JMOLocalizedString(forKey: "Delete", value: "")) {(action,index)  in
            //handle delete
            
            
            UIAlertController.showDeleteAlert(self, aStrMessage: JMOLocalizedString(forKey: "Are you sure that you want to delete?", value: ""), completion: { (index: Int, str: String) in
                //handle delete
                
                
                if index == 0 {
                    
                    var aObjIndeRem = indDailyReminderModel()
                    if self.isSearch {
                        aObjIndeRem =  self.arrMutIndependentSearch[indexPath.row]
                    }else{
                        aObjIndeRem = self.arrMutIndependent[indexPath.row]
                    }
                    
                    indDailyActivitiesModel().deleteIndpendent(deleteID: (aObjIndeRem.identifier)!, complition: { (result: Bool) in
                        print(result)
                        
                        UserActivityModel().deleteActivity(type: (aObjIndeRem.type)!, typeid: (aObjIndeRem.typeID)!,  userActivityDate: "", reminderID: (aObjIndeRem.reminderID!), complition: { (result: Bool) in
                            
                            if self.isSearch {
                                
                                var aIntCount = 0
                                for obj in self.arrMutIndependent {
                                    
                                    if obj.identifier == self.arrMutIndependentSearch[indexPath.row].identifier
                                    {
                                        self.arrMutIndependent.remove(at: aIntCount)
                                    }
                                    
                                    aIntCount = aIntCount + 1
                                }
                                self.arrMutIndependentSearch.remove(at: indexPath.row)
                                
                            }else{
                                self.arrMutIndependent.remove(at: indexPath.row)
                            }
                            
                            self.tblIndependent.reloadData()
                            
                        })
                    })
                    
                    
                    
                    
                    if self.arrMutIndependent.count == 0 {
                        self.lblNoData.isHidden = false
                    }else{
                        self.lblNoData.isHidden = true
                    }
                    
                    
                }
            })
            
            
            
            
        }
        
        return [deleteAction]
    }
    
    
    //MARK: UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        isSearch = true
        
        searchIndepdent(text: searchText)
        
        
        if searchBar.text == "" {
            
            DispatchQueue.main.async {
                
                searchBar.resignFirstResponder()
                
                self.isSearch = false
                
                UIView.animate(withDuration: 2.0) {
                    self.viewSearch.isHidden = true
                }
                
                self.tblIndependent.reloadData()
                
            }
        }

        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        
        isSearch = true
        if (searchBar.text?.count)! > 0 {
            
            searchIndepdent(text: searchBar.text!)
        }else{
            
        }
    }
    
//    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        
////        isSearch = true
////        
////        searchIndepdent(text: text)n
//        
//        return true
//    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.view.endEditing(true)
        isSearch = false
        
        UIView.animate(withDuration: 2.0) {
            self.viewSearch.isHidden = true
        }
        
        self.tblIndependent.reloadData()
    }
   
    
    
    func searchIndepdent(text: String) {
        
        
        
        arrMutIndependentSearch.removeAll()
        
        arrMutIndependentSearch = arrMutIndependent.filter { (obj: indDailyReminderModel) -> Bool in
            let indDailyReminderModelTitle = JMOLocalizedString(forKey: obj.title, value: "")
            return indDailyReminderModelTitle.lowercased().contains(text.lowercased())
        }
        
        self.tblIndependent.reloadData()
        
        
    }
    
}

