    //
//  NotesVC.swift
//  SmartAgenda
//
//  Created by indianic on 03/01/17.
//  Copyright © 2017 indianic. All rights reserved.
//

import UIKit

class NotesVC: UIViewController ,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var lblScreenTitle: UILabel!
    
    @IBOutlet var tblNotes: TPKeyboardAvoidingTableView!
    var dateFormatter = DateFormatter()
    var dateFormatterMMM = DateFormatter()
    
    var mutArrNotes: [notesModel] = []
    var mutArrNotesSearch: [notesModel] = []
    
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
        
        lblScreenTitle.text = JMOLocalizedString(forKey: "NOTES", value: "")
        lblNoData.text = JMOLocalizedString(forKey: "No notes are added", value: "")
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
        
        
        isSearch = false
        
        var tempObj = [notesModel]()
         tempObj = notesModel().getAllNotes()
            
            mutArrNotes.removeAll()
            
            mutArrNotes = tempObj
        
            if mutArrNotes.count == 0
            {
                lblNoData.isHidden = false
            }else{
                lblNoData.isHidden = true
            }
            
            self.tblNotes.reloadData()
        
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
    
        
    //MARK: UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearch {
            // Search
            if mutArrNotesSearch.count == 0
            {
                lblNoData.isHidden = false
            }else{
                lblNoData.isHidden = true
            }
            return mutArrNotesSearch.count
        }else{
            if mutArrNotes.count == 0
            {
                lblNoData.isHidden = false
            }else{
                lblNoData.isHidden = true
            }
            return mutArrNotes.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let notesCell = tableView.dequeueReusableCell(withIdentifier:CellIdentifire.CellNotes.rawValue , for: indexPath) as! NotesCell
        
        var aTemp = notesModel()
        
        if isSearch {
            // Search
            aTemp =  mutArrNotesSearch[indexPath.row]
        }else{
            aTemp =  mutArrNotes[indexPath.row]
        }
        let aTitle = aTemp.title
        let aDescription = (aTemp.comments == nil) ? "" : aTemp.comments
        
        if  (aDescription?.count)! > 0 && !(aDescription?.contains(JMOLocalizedString(forKey: "Add Comment", value: "")))!{
            notesCell.lblNotesDiscription.text = aDescription
        }else{
            notesCell.lblNotesDiscription.text = "--"
        }
        //notesCell.lblNotesTitle.text = aTitle?.capitalized
        notesCell.lblNotesTitle.isHidden = true
//        let aDate = aTemp.date
        
        
//        let arrrDateComponent =  aDate?.components(separatedBy: "-")
//        
//        var aStrDate = String()
//        var aStrDay = String()
//        
//        if (arrrDateComponent?.count)! == 3 {
//            aStrDate = (arrrDateComponent?[2])!
//            aStrDay = dateFormatterMMM.string(from: dateFormatter.date(from: aDate!)!).uppercased()
//        }else{
//            aStrDate = "--"
//            aStrDay = "--"
//        }
//        
//        notesCell.lblNotesDate.text = aStrDate
//        notesCell.lblNotesDay.text = aStrDay
        
        LanguageManager.sharedInstance.localizeThingsInView(parentView: notesCell)
        LanguageManager.sharedInstance.localizeThingsInView(parentView: notesCell.lblNotesDateVal)
        
        if AppConstants.isArabic(){
            
            let aNoteDate = getDateFromStringByFormate(yyyyMMdd, aStrDate: aTemp.date)
            let aARNoteDate = DateFormatterAR.string(from: aNoteDate)
            
            notesCell.lblNotesDateVal.text = aARNoteDate
            notesCell.lblNotesDateVal.textAlignment = .left
            
        }else{
            
            notesCell.lblNotesDateVal.text = aTemp.date
            notesCell.lblNotesDateVal.textAlignment = .right
        }
        
        if GeneralConstants.DeviceType.IS_IPAD {
            customizeFonts(in:notesCell.lblNotesTitle , aFontName: Bold, aFontSize: 0)
            customizeFonts(in:notesCell.lblNotesDiscription , aFontName: Medium, aFontSize: 0)
            
        }else{
            customizeFonts(in:notesCell.lblNotesTitle , aFontName: Bold, aFontSize: 0)
            customizeFonts(in:notesCell.lblNotesDiscription , aFontName: Medium, aFontSize: 0)
        }
        
        return notesCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: SegueIdentifiers.ksegueNotes.rawValue, sender: nil)
        
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle
    {
        return .delete
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: JMOLocalizedString(forKey: "Delete", value: "")) {(action,index) in
            //handle delete
            
            UIAlertController.showDeleteAlert(self, aStrMessage: JMOLocalizedString(forKey: "Are you sure that you want to delete?", value: ""), completion: { (index: Int, str: String) in
                
                if index == 0 {
                    var aObjNote = notesModel()
                    if self.isSearch {
                        aObjNote =  self.mutArrNotesSearch[indexPath.row]
                    }else{
                        aObjNote = self.mutArrNotes[indexPath.row]
                    }
                    
                    
                    notesModel().deleteNotes(deleteID: (aObjNote.identifier)!) { (result: Bool) in
                        print(result)
                        if self.isSearch {
                            
                            var aIntCount = 0
                            for obj in self.mutArrNotes {
                                
                                
                                if obj.identifier == self.mutArrNotesSearch[indexPath.row].identifier
                                {
                                    self.mutArrNotes.remove(at: aIntCount)
                                }
                                
                                aIntCount = aIntCount + 1
                            }
                            
                            self.mutArrNotesSearch.remove(at: indexPath.row)
                            
                        }else{
                            self.mutArrNotes.remove(at: indexPath.row)
                        }
                        
                        self.tblNotes.reloadData()
                    }
                    
                    if self.mutArrNotes.count == 0
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
        searchSocialActivity(text: searchBar.text!)
        if searchBar.text == "" {
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
                self.isSearch = false
                
                UIView.animate(withDuration: 2.0) {
                    self.viewSearch.isHidden = true
                }
                
                self.tblNotes.reloadData()
                
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
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        guard let firstSubview = searchBar.subviews.first else { return }
        
        firstSubview.subviews.forEach {
            ($0 as? UITextField)?.clearButtonMode = .never
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.view.endEditing(true)
        isSearch = false
        
        UIView.animate(withDuration: 2.0) {
            self.viewSearch.isHidden = true
        }
        
        self.tblNotes.reloadData()
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //segueAppointment
        
        if segue.identifier == SegueIdentifiers.ksegueNotes.rawValue {
            let aObjVC:AddNoteVC = segue.destination as! AddNoteVC
            
            let indexPath = self.tblNotes.indexPathForSelectedRow
            
            if isSearch {
                aObjVC.aObjNotesModel = mutArrNotesSearch[(indexPath?.row)!]
            }else{
                aObjVC.aObjNotesModel = mutArrNotes[(indexPath?.row)!]
            }
            
//            aObjVC.isBoolEdit = true
            
        }else if segue.identifier == SegueIdentifiers.ksegueAddNotes.rawValue {
            let aObjVC:AddNoteVC = segue.destination as! AddNoteVC
            
//            aObjVC.isBoolEdit = false
            
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
    private let DateFormatterAR: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "ar") as Locale?
        formatter.dateFormat = yyyyMMdd
        return formatter
    }()

    
    func searchSocialActivity(text: String) {
        
        mutArrNotesSearch = mutArrNotes.filter { (obj: notesModel) -> Bool in
            
//            return obj.title.lowercased().contains(text.lowercased())
            return obj.comments.lowercased().contains(text.lowercased())
            
        }
        
        //        if mutArrNotesSearch.count == 0 {
        //            self.tblNotes.reloadData()
        //
        //            UIAlertController.showAlertWithOkButton(self, aStrMessage: JMOLocalizedString(forKey: "No found Social activities", value: ""), completion: { (Int, String) in
        //            })
        //        }else{
        self.tblNotes.reloadData()
        //        }
        
        
    }
}
