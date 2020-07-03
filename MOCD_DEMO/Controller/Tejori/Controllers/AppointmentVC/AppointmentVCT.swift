//
//  AppointmentVC.swift
//  Edkhar
//
//  Created by indianic on 03/01/17.
//  Copyright © 2017 demo. All rights reserved.
//

import UIKit

class AppointmentVCT: UIViewController ,UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var lblScreenTitle: UILabel!
    @IBOutlet weak var lblTableTitle: UILabel!
    @IBOutlet weak var tblAppointment: UITableView!

    @IBOutlet weak var btnBackEN: UIButton!
    @IBOutlet weak var btnBackAR: UIButton!
    @IBOutlet weak var btnAddAppointment: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        self.lblScreenTitle.text = JMOLocalizedString(forKey: "Appointments", value: "")
        self.lblTableTitle.text = JMOLocalizedString(forKey: "Appointment list", value: "")
        
        if AppConstants.isArabic() {
            btnBackEN.setImage(UIImage.init(named: "ic_search"), for: .normal)
            btnBackAR.setImage(UIImage.init(named: "ic_back_ar"), for: .normal)
        }
        else{
            btnBackEN.setImage(UIImage.init(named: "ic_back_en"), for: .normal)
            btnBackAR.setImage(UIImage.init(named: "ic_search"), for: .normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    @IBAction func btnBackENAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnBackARAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAddAppointmentAction(_ sender: UIButton) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let appoinmentCell = tableView.dequeueReusableCell(withIdentifier: "AppointmentCell", for: indexPath) as! AppointmentCell
        appoinmentCell.lblAppointmentTitle.text = "Go to hospital"
        appoinmentCell.lblAppointmentDate.text = "01/01/2017"
        return appoinmentCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
