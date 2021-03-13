//
//  AppointmentVC.swift
//  SmartAgenda
//
//  Created by indianic on 03/01/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit

class AppointmentVC: UIViewController ,UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate{
    
    @IBOutlet weak var lblScreenTitle: UILabel!

    @IBOutlet weak var tblAppointment: TPKeyboardAvoidingTableView!

    @IBOutlet weak var btnBackEN: UIButton!
    @IBOutlet weak var btnAddAppointment: UIButton!
    
    @IBOutlet var viewSearch: UIView!
    var appointments = [getAppointmentReminder]()
    
    @IBOutlet var searchbar: UISearchBar!
    var mutArrAppointmentSearch: [getAppointmentReminder] = []
    
    @IBOutlet var lblNoData: UILabel!
    
    var dateFormatterMMM = DateFormatter()
    var dateFormatter = DateFormatter()
    
    var isSearch: Bool = false

    //MARK: ViewController Methods
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        self.lblScreenTitle.text = JMOLocalizedString(forKey: kAppointments, value: "")
        
        dateFormatter.dateFormat = yyyyMMdd
        dateFormatterMMM.dateFormat = "MMM"

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

        LanguageManager().localizeThingsInView(parentView: (self.view))
        
        if GeneralConstants.DeviceType.IS_IPAD {
            customizeFonts(in: lblScreenTitle, aFontName: Medium, aFontSize: 0)
        }else{
            customizeFonts(in: lblScreenTitle, aFontName: Medium, aFontSize: 0)
        }
        
        // Get All Appointmets data from DB
        print(appointmentModelManager.sharedInstance.getAppointmentData(completion: { (appointments: [getAppointmentReminder]) in
            print(appointments)
            
            self.appointments.removeAll()

            self.appointments = appointments
            
            self.appointments.reverse()
            
            if self.appointments.count == 0
            {
                lblNoData.isHidden = false
            }else{
                lblNoData.isHidden = true
            }
            self.tblAppointment.reloadData()

          }))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    //MARK: Button Actions
    
    @IBAction func btnSearchClick(_ sender: UIButton) {
        searchbar.text = ""

        UIView.animate(withDuration: 3.0) {
            self.viewSearch.isHidden = false
        }
    }
    
    @IBAction func btnBackENAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    

    @IBAction func btnAddAppointmentAction(_ sender: UIButton) {
        
    }
    
    //MARK: Custom Method
    func cancelNotification(str: String, complition: ((Void)-> Void)) {
        
//        LocalNotificationHelper.sharedInstance.removeNotification([str])
        LocalNotificationHelper.sharedInstance.removeNotification([str]) { (status) in
            
        }
        
    }
    
    
    //MARK: UITableViewDelegate and UITableViewDatasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if isSearch {
            if mutArrAppointmentSearch.count > 0{
                lblNoData.isHidden = true
            }else{
                lblNoData.isHidden = false
            }
            return mutArrAppointmentSearch.count
        }else{
            if appointments.count > 0{
                lblNoData.isHidden = true
            }else{
                lblNoData.isHidden = false
            }
            return appointments.count
        }
    }
        

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let appoinmentCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifire.CellAppointment.rawValue, for: indexPath) as! AppointmentCell
        
         var aObjAppointment = getAppointmentReminder()
        if isSearch {
            aObjAppointment =  mutArrAppointmentSearch[indexPath.row]
        }else{
            aObjAppointment = appointments[indexPath.row]
        }

        let aDate = aObjAppointment.date
        let arrrDateComponent =  aDate?.components(separatedBy: "-")
        var aStrDate = String()
        var aStrDay = String()
    
        if (arrrDateComponent?.count)! == 3 {
            aStrDate = (arrrDateComponent?[2])!
            if aDate == "2017-03-31" {
                dateFormatter.timeZone = TimeZone(identifier: "UTC")!
            }
            aStrDay = dateFormatterMMM.string(from: dateFormatter.date(from: aDate!)!).uppercased()
        }else{
            aStrDate = "--"
            aStrDay = "--"
        }
        
        appoinmentCell.lblAppointmentTitle.text = aObjAppointment.title.capitalized
//
        if aObjAppointment.reminderFrequency! == "" {
            
            appoinmentCell.lblAppointmentDate.isHidden = false
            appoinmentCell.lblDay.isHidden = false
            appoinmentCell.lblAppointmentRecurring.isHidden = true
            
            appoinmentCell.lblAppointmentDate.text = aStrDate
            appoinmentCell.lblDay.text = aStrDay
            
        }else{
            appoinmentCell.lblAppointmentDate.isHidden = true
            appoinmentCell.lblDay.isHidden = true
            appoinmentCell.lblAppointmentRecurring.isHidden = false
            
            appoinmentCell.lblAppointmentRecurring.text = JMOLocalizedString(forKey: aObjAppointment.reminderFrequency!, value: "")
        }
        
        
        
        appoinmentCell.lblTime.text = aObjAppointment.reminderTime
        
        
        LanguageManager().localizeThingsInView(parentView: appoinmentCell)
        
        if AppConstants.isArabic() {
            appoinmentCell.lblAppointmentTitle.textAlignment = .right
            appoinmentCell.lblTime.textAlignment = .right
        }
        if GeneralConstants.DeviceType.IS_IPAD {
            
            customizeFonts(in: appoinmentCell.lblAppointmentTitle, aFontName: Bold, aFontSize: 0)
            customizeFonts(in: appoinmentCell.lblAppointmentDate, aFontName: Bold, aFontSize: 0)
            customizeFonts(in: appoinmentCell.lblDay, aFontName: Bold, aFontSize: 0)
            customizeFonts(in: appoinmentCell.lblTime, aFontName: Medium, aFontSize: 0)

        }else{
            customizeFonts(in: appoinmentCell.lblAppointmentTitle, aFontName: Bold, aFontSize: 0)
            customizeFonts(in: appoinmentCell.lblAppointmentDate, aFontName: Bold, aFontSize: 0)
            customizeFonts(in: appoinmentCell.lblDay, aFontName: Bold, aFontSize: 0)
            customizeFonts(in: appoinmentCell.lblTime, aFontName: Medium, aFontSize: 0)
            

        }
        
        
        return appoinmentCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        performSegue(withIdentifier: SegueIdentifiers.kSegueAppointment.rawValue, sender: nil)
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle
{
    return .delete
}
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .default, title: JMOLocalizedString(forKey: "Delete", value: "")) {(action, index) in
            
            UIAlertController.showDeleteAlert(self, aStrMessage: JMOLocalizedString(forKey: "Are you sure that you want to delete?", value: ""), completion: { (index: Int, str: String) in
            
            //handle delete

                
                if index == 0 {
                    
                    var aObjAppointment = getAppointmentReminder()
                    if self.isSearch {
                        aObjAppointment =  self.mutArrAppointmentSearch[indexPath.row]
                    }else{
                        aObjAppointment = self.appointments[indexPath.row]
                    }
                    
                    UserActivityModel().deleteActivity(type: aObjAppointment.type, typeid: aObjAppointment.typeID, userActivityDate: "", reminderID: aObjAppointment.reminderID!, complition: { (result: Bool) in
                        
                    })
                    
                    appointmentModelManager().deleteAppointmentData(deleteID: (aObjAppointment.identifier)!) { (result: Bool) in
                        
                        print(result)
                        self.cancelNotification(str: String(aObjAppointment.reminderID!), complition: { (Void) in
                            
                        })
                        if self.isSearch {
                            
                            var aIntCount = 0
                            for obj in self.appointments {
                                
                                if obj.identifier == self.mutArrAppointmentSearch[indexPath.row].identifier
                                {
                                    self.appointments.remove(at: aIntCount)
                                }
                                
                                aIntCount = aIntCount + 1
                            }
                            self.mutArrAppointmentSearch.remove(at: indexPath.row)
                            
                        }else{
                            self.appointments.remove(at: indexPath.row)
                        }
                        
                        self.tblAppointment.reloadData()
                    }
                    
                    if self.appointments.count == 0
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
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //segueAppointment

        if segue.identifier == SegueIdentifiers.kSegueAppointment.rawValue {
            let aObjVC: AddAppointmentVC = segue.destination as! AddAppointmentVC
            
            let indexPath = self.tblAppointment.indexPathForSelectedRow
            
            if isSearch {
                aObjVC.appointmentSelected = mutArrAppointmentSearch[(indexPath?.row)!]
            }else{
                aObjVC.appointmentSelected = appointments[(indexPath?.row)!]
            }
            
            aObjVC.isBoolEdit = true
            
        }else if segue.identifier == SegueIdentifiers.kAddAppointment.rawValue {
            let aObjVC: AddAppointmentVC = segue.destination as! AddAppointmentVC
            
            aObjVC.isBoolEdit = false
            
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 
    //MARK: UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        isSearch = true
        
        searchAppointment(text: searchText)
        
        if searchBar.text == "" {
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
        
        
        //if (searchBar.text?.characters.count)! > 0 {
            
          //  searchAppointment(text: searchText)
            
        //}else{
          //  self.view.endEditing(true)
        //}
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        
        isSearch = true
        if (searchBar.text?.count)! > 0 {
            
            searchAppointment(text: searchBar.text!)
        }else{
            
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.view.endEditing(true)
        isSearch = false
        
        lblNoData.isHidden = true

        UIView.animate(withDuration: 2.0) {
            self.viewSearch.isHidden = true
        }
        
        self.tblAppointment.reloadData()
    }

    
    
    
    func searchAppointment(text: String) {
        
        if (text.count) > 0 {
        
            mutArrAppointmentSearch.removeAll()
            
            mutArrAppointmentSearch = appointments.filter { (obj: getAppointmentReminder) -> Bool in
                return obj.title.lowercased().contains(text.lowercased())
            }
            
            
            if mutArrAppointmentSearch.count == 0 {
                
                lblNoData.text = JMOLocalizedString(forKey: "No found Result", value: "")
                lblNoData.isHidden = false
                
            }
            self.tblAppointment.reloadData()
        }else{
            self.view.endEditing(true)
            isSearch = false
            
            lblNoData.isHidden = true
            
            UIView.animate(withDuration: 2.0) {
                self.viewSearch.isHidden = true
            }
            
            self.tblAppointment.reloadData()
        }
        
    
        
    }
}
