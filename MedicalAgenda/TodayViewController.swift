//
//  TodayViewController.swift
//  MedicalAgenda
//
//  Created by indianic on 18/02/17.
//  Copyright © 2017 demo. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    
    @IBOutlet var lblName: UILabel!
    
    @IBOutlet var lblBloodType: UILabel!
    
    @IBOutlet var lblEmergencyNumber: UILabel!
    
    @IBOutlet var lblBloodPressure: UILabel!
    
    @IBOutlet var lblBloodSugar: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        //        NotificationCenter.default.addObserver(self,
        //                                               selector: #selector(userDefaultsDidChange(notification:)),
        //                                                         name: UserDefaults.didChangeNotification,
        //                                                         object: nil)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openApp))
        gestureRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(gestureRecognizer)
        
        self.setWidgetData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        self.setWidgetData()
        completionHandler(NCUpdateResult.newData)
    }
    
    //    func userDefaultsDidChange(notification: Notification) {
    //        self.setWidgetData()
    //
    //    }
    
    func setWidgetData() -> Void {
        let defaults: UserDefaults = UserDefaults(suiteName: smartAgendaExtension)!
        print("group.\(smartAgendaExtension)")
        let name = defaults.value(forKey: "Name") as? String
        let bloodType = defaults.value(forKey: "BloodType") as? String
        let emergencyNumber = defaults.value(forKey: "EmergencyNumber") as? String
        let bloodpressure = defaults.value(forKey: "DefaultBloodPressure") as? String
        let bloodsugar = defaults.value(forKey: "DefaultBloodSugar") as? String
        
//        let bloodPressureDate = defaults.value(forKey: "DefaultBPressureDate") as? Date
//        let bloodSugarDate = defaults.value(forKey: "DefaultBSugarDate") as? Date
        
        if name != nil {
            lblName.text = name
        }
        if bloodType != nil {
            lblBloodType.text = bloodType
        }
        if emergencyNumber != nil {
            lblEmergencyNumber.text = emergencyNumber
        }
        if bloodpressure != nil {
            lblBloodPressure.text = "\(bloodpressure!)"
        }
        if bloodsugar != nil {
            lblBloodSugar.text = "\(bloodsugar!)"
        }
    }
    
    func openApp() -> Void {
        let url = URL(string: "SmartAgenda://")
        self.extensionContext?.open(url!, completionHandler: nil)
        self.extensionContext?.open(url!, completionHandler: { (status : Bool) in
            if status == true{
                
            }
        })
    }
}
