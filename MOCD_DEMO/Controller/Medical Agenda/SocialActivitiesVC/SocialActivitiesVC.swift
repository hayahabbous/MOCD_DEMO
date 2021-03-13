//
//  SocialActivitiesVC.swift
//  SmartAgenda
//
//  Created by indianic on 04/01/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit

class SocialActivitiesVC: UIViewController ,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var lblScreenTitle: UILabel!
    @IBOutlet weak var tblSocialActivities: TPKeyboardAvoidingTableView!
    
    var dateFormatter = DateFormatter()
    var dateFormatterMMM = DateFormatter()
    
    var mutArrSocialActivities: [getSocialReminder] = []
    var mutArrSocialActivitiesSearch: [getSocialReminder] = []

    var isSearch: Bool = false

    @IBOutlet var viewSearch: UIView!
    @IBOutlet var btnBackEN: UIButton!
    @IBOutlet var searchbar: UISearchBar!
    
    @IBOutlet var lblNoData: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        dateFormatter.dateFormat = yyyyMMdd
        dateFormatterMMM.dateFormat = "MMM"
        
        lblScreenTitle.text = JMOLocalizedString(forKey: "SOCIAL ACTIVITIES", value: "")
        if GeneralConstants.DeviceType.IS_IPAD {
            customizeFonts(in: lblScreenTitle, aFontName: Medium, aFontSize: 0)
        }else{
            customizeFonts(in: lblScreenTitle, aFontName: Medium, aFontSize: 0)
        }
        
        LanguageManager.sharedInstance.localizeThingsInView(parentView: self.view)
        
        if AppConstants.isArabic()
        {
            btnBackEN.imageView?.transform = (btnBackEN.imageView?.transform.rotated(by: CGFloat(M_PI)))!
        }else{
            btnBackEN.imageView?.transform = (btnBackEN.imageView?.transform.rotated(by: CGFloat(M_PI*2)))!
        }
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mutArrSocialActivities.removeAll()
        
        isSearch = false
        
          socialActivity().GetAllSocialList(complition: { (objs: [getSocialReminder]) in
         
            mutArrSocialActivities.removeAll()
            
            mutArrSocialActivities = objs
            
            mutArrSocialActivities.reverse()

            if mutArrSocialActivities.count == 0
            {
                lblNoData.isHidden = false
            }else{
                lblNoData.isHidden = true
            }
            
            self.tblSocialActivities.reloadData()
        })
        
    }
    
    @IBAction func btnSearchClick(_ sender: UIButton) {
        
        searchbar.text = ""
        UIView.animate(withDuration: 3.0) {
            self.viewSearch.isHidden = false
        }
    }
    
    @IBAction func btnBackENAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    

    @IBAction func btnAddSocialActivitiesAction(_ sender: UIButton) {
        
    }
    
    //MARK: UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearch {
            // Search
            if mutArrSocialActivitiesSearch.count > 0{
                lblNoData.isHidden = true
            }else{
                lblNoData.isHidden = false
            }
                    return mutArrSocialActivitiesSearch.count
        }else{
            if mutArrSocialActivities.count > 0{
                lblNoData.isHidden = true
            }else{
                lblNoData.isHidden = false
            }
                    return mutArrSocialActivities.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let socialActivitiesCell = tableView.dequeueReusableCell(withIdentifier:CellIdentifire.CellSocialActivities.rawValue , for: indexPath) as! SocialActivitiesCell
        
        var aTemp = getSocialReminder()
       
        if isSearch {
            // Search
            aTemp =  mutArrSocialActivitiesSearch[indexPath.row]
        }else{
           aTemp =  mutArrSocialActivities[indexPath.row]
        }
        let aTitle = aTemp.title
        let aReminderTime = aTemp.reminderTime
        let aDate = aTemp.date
        
        socialActivitiesCell.lblSocialActivitiesTitle.text = aTitle?.capitalized
        socialActivitiesCell.lblSocialActivitiesDate.text = aReminderTime
        if aDate == "2017-03-31" {
            dateFormatter.timeZone = TimeZone(identifier: "UTC")!
        }
        socialActivitiesCell.lblDay.text = dateFormatterMMM.string(from: dateFormatter.date(from: aDate!)!).uppercased()
        socialActivitiesCell.lblDate.text = aDate?.components(separatedBy: "-")[2]
        
        LanguageManager.sharedInstance.localizeThingsInView(parentView: socialActivitiesCell)
        
        
        if GeneralConstants.DeviceType.IS_IPAD {
            customizeFonts(in: lblScreenTitle, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: socialActivitiesCell.lblSocialActivitiesTitle, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: socialActivitiesCell.lblDay, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: socialActivitiesCell.lblSocialActivitiesDate, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: socialActivitiesCell.lblDate, aFontName: Medium, aFontSize: 0)
        }else{
            customizeFonts(in: lblScreenTitle, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: socialActivitiesCell.lblSocialActivitiesTitle, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: socialActivitiesCell.lblDay, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: socialActivitiesCell.lblSocialActivitiesDate, aFontName: Medium, aFontSize: 0)
            customizeFonts(in: socialActivitiesCell.lblDate, aFontName: Medium, aFontSize: 0)
        }
        
        
        return socialActivitiesCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: SegueIdentifiers.ksegueSocialActivity.rawValue, sender: nil)

    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle
    {
        return .delete
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: JMOLocalizedString(forKey: "Delete", value: "")) {(action ,index) in
            //handle delete
            
            UIAlertController.showDeleteAlert(self, aStrMessage: JMOLocalizedString(forKey: "Are you sure that you want to delete?", value: ""), completion: { (index: Int, str: String) in
                
                if index == 0 {
                    var aObjSocial = getSocialReminder()
                    if self.isSearch {
                        aObjSocial =  self.mutArrSocialActivitiesSearch[indexPath.row]
                    }else{
                        aObjSocial = self.mutArrSocialActivities[indexPath.row]
                    }
                    
                    
                    socialActivity().deleteSocialActivity(deleteID: (aObjSocial.identifier)!) { (result: Bool) in
                        print(result)
                    
                        
                        UserActivityModel().deleteActivity(type: (aObjSocial.type)!, typeid: (aObjSocial.typeID)!,  userActivityDate: "", reminderID: (aObjSocial.reminderID!), complition: { (result: Bool) in
                            
                            if self.isSearch {
                                
                                var aIntCount = 0
                                for obj in self.mutArrSocialActivities {
                                    
                                    if obj.identifier == self.mutArrSocialActivitiesSearch[indexPath.row].identifier
                                    {
                                        self.mutArrSocialActivities.remove(at: aIntCount)
                                    }
                                    
                                    aIntCount = aIntCount + 1
                                }
                                
                                self.mutArrSocialActivitiesSearch.remove(at: indexPath.row)
                                
                            }else{
                                self.mutArrSocialActivities.remove(at: indexPath.row)
                            }
                            
                            self.tblSocialActivities.reloadData()
                        })
                        
                        
                     
                   
                    
                    
                    }
                    
                    if self.mutArrSocialActivities.count == 0
                    {
                        self.lblNoData.isHidden = false
                    }else{
                        self.lblNoData.isHidden = true
                    }
                }
                
            })
            

        }
        
        return [deleteAction]
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        isSearch = true
        
        searchSocialActivity(text: searchText)
        
        
        if searchBar.text == "" {
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
   

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)

        isSearch = true
        if (searchBar.text?.count)! > 0 {
            
            searchSocialActivity(text: searchBar.text!)
        }else{
            
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
         lblNoData.isHidden = true
        
        self.view.endEditing(true)
        isSearch = false

        UIView.animate(withDuration: 2.0) {
            self.viewSearch.isHidden = true
        }
        
        self.tblSocialActivities.reloadData()
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //segueAppointment
        
        if segue.identifier == SegueIdentifiers.ksegueSocialActivity.rawValue {
            let aObjVC:AddSocialActivitieVC = segue.destination as! AddSocialActivitieVC
            
            let indexPath = self.tblSocialActivities.indexPathForSelectedRow
            
            if isSearch {
                aObjVC.socialSelected = mutArrSocialActivitiesSearch[(indexPath?.row)!]
            }else{
                aObjVC.socialSelected = mutArrSocialActivities[(indexPath?.row)!]
            }

            aObjVC.isBoolEdit = true
            
        }else if segue.identifier == SegueIdentifiers.ksegueAddSocial.rawValue {
            let aObjVC:AddSocialActivitieVC = segue.destination as! AddSocialActivitieVC
            
            aObjVC.isBoolEdit = false
            
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

    func searchSocialActivity(text: String) {
        
        if (text.count) > 0 {
            
            
            mutArrSocialActivitiesSearch = mutArrSocialActivities.filter { (obj: getSocialReminder) -> Bool in
                return obj.title.lowercased().contains(text.lowercased())
            }
            
            if mutArrSocialActivitiesSearch.count == 0 {
                lblNoData.text = JMOLocalizedString(forKey: "No found Social activities", value: "")
                lblNoData.isHidden = false
                self.tblSocialActivities.reloadData()
                //
                //            UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey: "No found Social activities", value: ""), completion: { (Int, String) in
                //            })
            }else{
                lblNoData.isHidden = true
                self.tblSocialActivities.reloadData()
            }
            
        }else{
            
            lblNoData.isHidden = true
            
            self.view.endEditing(true)
            isSearch = false
            
            UIView.animate(withDuration: 2.0) {
                self.viewSearch.isHidden = true
            }
            
            self.tblSocialActivities.reloadData()

            
        }
        
    }
}
