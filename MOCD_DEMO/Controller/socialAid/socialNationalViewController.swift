//
//  socialNationalViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 6/25/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class socialNationalViewController: UIViewController , refreshDelegate ,NVActivityIndicatorViewable {
    
    
    var socialAidItem: socialAid = socialAid()
    func refreshDateView() {
        let date = nationalIssueDateView.date
        let datebyOneYear = Calendar.current.date(byAdding: .year, value: 5, to: Date())
        
        
        
        let df = DateFormatter()
        df.dateFormat = "MM/dd/yyyy"
        let now = df.string(from: datebyOneYear ?? Date())
        
        nationalExpiryDateView.textField.text = now
        
    }
    
    func refreshMultipleView() {
        
    }
    @IBOutlet var nationalIdView: textFieldMandatory!
    @IBOutlet var nationalIssueDateView: dateTexteField!
    @IBOutlet var nationalExpiryDateView: dateTexteField!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var previousButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupField()
        
        //isRejectedRequest()
    }
    
    func setupField() {
        
        nationalIdView.textLabel.text = "National Id".localize
        nationalIdView.textField.placeholder = "National Id".localize
        
        nationalIssueDateView.textLabel.text = "National Id Issue Date".localize
        nationalIssueDateView.viewController = self
        nationalIssueDateView.delegate = self
        
        
        nationalExpiryDateView.textLabel.text = "National Id Expiry Date".localize
        nationalExpiryDateView.starImage.isHidden = true
        nationalExpiryDateView.viewController = self
        nationalExpiryDateView.isUserInteractionEnabled = false
        let gradient = CAGradientLayer()
        gradient.frame = self.nextButton.bounds
        gradient.colors = [UIColor.green]
        
        self.nextButton.applyGradient(colours: [AppConstants.firstBrownColor, AppConstants.secondBrownColor])
        //self.loginButton.backgroundColor = .green
        self.nextButton.layer.cornerRadius = 20
        self.nextButton.layer.masksToBounds = true
        
        
        gradient.frame = self.previousButton.bounds
        gradient.colors = [UIColor.green]
        
        self.previousButton.applyGradient(colours: [AppConstants.firstBrownColor, AppConstants.secondBrownColor])
        //self.loginButton.backgroundColor = .green
        self.previousButton.layer.cornerRadius = 20
        self.previousButton.layer.masksToBounds = true
    }
    
    func validateFields() -> Bool{
        
        //return true
        
        
        socialAidItem.NationalId = nationalIdView.textField.text ?? ""
        socialAidItem.NationalIdIssueDate = nationalIssueDateView.textField.text ?? ""
        socialAidItem.NationalIdExpiryDate = nationalExpiryDateView.textField.text ?? ""
        
        
        
        let df = DateFormatter()
        df.dateFormat = "MM/dd/yyyy"
        socialAidItem.NationalIdIssueDate  = df.string(from: nationalIssueDateView.date )
        socialAidItem.NationalIdExpiryDate  = df.string(from: nationalExpiryDateView.date)
        
        
        
        if nationalIdView.textField.text == "" ||
            nationalIssueDateView.textField.text == "" 
            {
            
            Utils.showAlertWith(title: "Error".localize, message: "Please Fill All Fields".localize, viewController: self)
            return false
            
            
        }
        
        
        return true
        
    }
    
    func isRejectedRequest() {
        
        let size = CGSize(width: 30, height: 30)
        
        var mocd_user = MOCDUser.getMOCDUser()
        self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        
        WebService.ValidateNationalID(userId: mocd_user?.UserId ?? "" , nationalId: mocd_user?.UserIdentityNo ?? "") { (json) in
            print(json)
            DispatchQueue.main.async {
                self.stopAnimating(nil)
            }
            
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
                guard let data = json["data"] as? [String: Any] else{return}
                guard let result = data["result"] as? [String: Any] else {return}
                guard let list = result["list"] as? [String:Any] else {return}
                
                let ID = String(list["ID"] as? Int ?? -1)
                
                
                
                if ID == "0" {
                     DispatchQueue.main.async {
                
                        //self.getRequestTypes()
                        
                        if !self.validateFields() {
                            return
                        }
                        self.performSegue(withIdentifier: "toInformation", sender: self)
                    }
                }else{
                    DispatchQueue.main.async {
                        
                        
                        let alert = UIAlertController(title: "Error".localize, message: "You already have a submitted request".localize, preferredStyle: UIAlertController.Style.alert)
                      
                        
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            
                              self.dismiss(animated: true, completion: nil)
                        
                        }))
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                }
                DispatchQueue.main.async {
                    //self.requestTypeView.firstLabel.text = AppConstants.isArabic() ? self.Case_Type_Desc_Arabic : self.Case_Type_Desc_English
                    //self.centerPicker.reloadAllComponents()
                }
            }
            
        }
    }
    @IBAction func nextAction(_ sender: Any) {
        
        isRejectedRequest()
        /*
        if !validateFields() {
            return
        }
        self.performSegue(withIdentifier: "toInformation", sender: self)*/
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toInformation" {
            let dest = segue.destination as! socialInformationViewController
            dest.socialAidItem = self.socialAidItem
        }
    }
}
