//
//  SocialActivitiesVC.swift
//  Edkhar
//
//  Created by indianic on 04/01/17.
//  Copyright © 2017 demo. All rights reserved.
//

import UIKit

class SocialActivitiesVCT: UIViewController ,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var lblScreenTitle: UILabel!
    @IBOutlet weak var lblTableTitle: UILabel!
    @IBOutlet weak var tblSocialActivities: UITableView!
    
    @IBOutlet weak var btnBackEN: UIButton!
    @IBOutlet weak var btnBackAR: UIButton!
    @IBOutlet weak var btnAddSocialActivities: UIButton!
    
    @IBOutlet weak var viewTopNavigation: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true

        
//        self.lblScreenTitle.text = JMOLocalizedString(forKey: "Social Activities", value: "")
//        self.lblTableTitle.text = JMOLocalizedString(forKey: "Social activities list", value: "")
        
        if AppConstants.isArabic() {
            btnBackEN.setImage(UIImage.init(named: "ic_search"), for: .normal)
            btnBackAR.setImage(UIImage.init(named: "ic_back_ar"), for: .normal)
        }
        else{
            btnBackEN.setImage(UIImage.init(named: "ic_back_en"), for: .normal)
            btnBackAR.setImage(UIImage.init(named: "ic_search"), for: .normal)
        }
        
        LanguageManager.sharedInstance.localizeThingsInView(parentView: self.view)
        
    }

    @IBAction func btnBackENAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnBackARAction(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAddSocialActivitiesAction(_ sender: UIButton) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let socialActivitiesCell = tableView.dequeueReusableCell(withIdentifier: "SocialActivitiesCell", for: indexPath) as! SocialActivitiesCell
        socialActivitiesCell.lblSocialActivitiesTitle.text = "Social activity name"
        socialActivitiesCell.lblSocialActivitiesDate.text = "Date : 01/01/2017"
        
        LanguageManager.sharedInstance.localizeThingsInView(parentView: socialActivitiesCell)
        
        return socialActivitiesCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
