//
//  AddAppointmentVC.swift
//  Edkhar
//
//  Created by indianic on 03/01/17.
//  Copyright © 2017 demo. All rights reserved.
//

import UIKit

class AddAppointmentVCT: UIViewController {
    
    @IBOutlet weak var lblScreenTitle: UILabel!
    @IBOutlet weak var btnBackEN: UIButton!
    @IBOutlet weak var btnBackAR: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        
        self.lblScreenTitle.text = JMOLocalizedString(forKey: "Add Appointment", value: "")
        
        if AppConstants.isArabic() {
            btnBackEN.isHidden = true
        }
        else{
            btnBackAR.isHidden = true
        }
    }
    
    @IBAction func btnBackENAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnBackARAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
