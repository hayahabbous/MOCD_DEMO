//
//  NotesVC.swift
//  Edkhar
//
//  Created by indianic on 03/01/17.
//  Copyright © 2017 demo. All rights reserved.
//

import UIKit

class NotesVCT: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var lblScreenTitle: UILabel!
    @IBOutlet weak var tblNotes: UITableView!
    
    @IBOutlet weak var btnBackEN: UIButton!
    @IBOutlet weak var btnBackAR: UIButton!
    @IBOutlet weak var btnAddNotes: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        
        self.lblScreenTitle.text = JMOLocalizedString(forKey: "Notes", value: "")
        
        
        if AppConstants.isArabic() {
            btnBackEN.setImage(UIImage.init(named: "ic_search"), for: .normal)
            btnBackAR.setImage(UIImage.init(named: "ic_back_ar"), for: .normal)
        }
        else{
            btnBackEN.setImage(UIImage.init(named: "ic_back_en"), for: .normal)
            btnBackAR.setImage(UIImage.init(named: "ic_search"), for: .normal)
        }
        
    }
    
    @IBAction func btnBackENAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnBackARAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAddNotesAction(_ sender: UIButton) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let appoinmentCell = tableView.dequeueReusableCell(withIdentifier: "NotesCell", for: indexPath) as! NotesCell
        appoinmentCell.lblNotesTitle.text = "Note"
        return appoinmentCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
