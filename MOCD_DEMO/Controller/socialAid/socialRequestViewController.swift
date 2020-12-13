//
//  socialRequestViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 6/25/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView
struct socialAid {
    
    var AccommodationTypeId: String = ""
    var EmirateId: String = ""
    var Area: String = ""
    var CenterId: String = ""
    var CaseReason: String = ""
    var NationalId: String = ""
    var NationalIdIssueDate: String = ""
    var NationalIdExpiryDate: String = ""
    var ApplicantNameAR: String = ""
    var ApplicantNameEN: String = ""
    var FamilyNo: String = ""
    var TownNo: String = ""
    var DateOfBirth: String = ""
    var GenderId: String = ""
    var MaritalStatusId: String = ""
    var EducationId: String = ""
    var NationalityId: String = ""
    var Occupation: String = ""
    var EmailAddress: String = ""
    var MotherNameAR: String = ""
    var PhoneNo: String = ""
    var MobileNo: String = ""
    var PassportNo: String = ""
    var PassportIssueDate: String = ""
    var PassportIssuePlace: String = ""
    var PassportIssuePlaceId: String = ""
    
    
    var PassportExpiryDate: String = ""
    var ImmigrationNo: String = ""
    var OwnershipTypeId: String = ""
    var NoOfRooms: String = ""
    var NoOfPersons: String = ""
    var PersonsAccommodatedId: String = ""
    var ConditionId: String = ""
    var Latitude: String = ""
    var Longitude: String = ""
    var MakaniNo: String = ""
    var membersObject: NSMutableArray = NSMutableArray()
    var incomesObject: NSMutableArray = NSMutableArray()

    
   
}
class socialRequestViewController: UIViewController ,NVActivityIndicatorViewable  {
    
    @IBOutlet var requestTypeView: multipleTextField!
    @IBOutlet var nextButton: UIButton!
    
    var socialAidItem: socialAid = socialAid()
    var caseId: String = ""
    var Case_Type_Desc_English: String = ""
    var Case_Type_Desc_Arabic: String = ""
    
    
    
    var mocd_user: MOCDUser? = MOCDUser.getMOCDUser()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupField()
        isRejectedRequest()
    }
    
    func setupField() {
        
        requestTypeView.textLabel.text = "Request Type".localize
        requestTypeView.firstLabel.text = "Normal".localize
        
        requestTypeView.secondLabel.isHidden = true
        requestTypeView.secondCheckBox.isHidden = true
        
        
        
        let gradient = CAGradientLayer()
               
        gradient.frame = self.nextButton.bounds
        
        gradient.colors = [UIColor.green]
               
        
        self.nextButton.applyGradient(colours: [AppConstants.firstBrownColor, AppConstants.secondBrownColor])
               //self.loginButton.backgroundColor = .green
        
        self.nextButton.layer.cornerRadius = 20
        
        self.nextButton.layer.masksToBounds = true
        
    }
    
    func getRequestTypes() {
        
        
        let size = CGSize(width: 30, height: 30)
        
        
        self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        WebService.RetrieveRequestTypeSocial { (json) in
            print(json)
            
            DispatchQueue.main.async {
                self.stopAnimating(nil)
            }
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
                guard let data = json["data"] as? [String: Any] else{return}
                guard let result = data["result"] as? [String: Any] else {return}
                guard let list = result["list"] as? [[String: Any]] else {return}
                
                for r in list {
       
                    self.caseId = String(describing: r["Case_Type_Id"] ?? "")
                    self.Case_Type_Desc_English = String(describing: r["Case_Type_Desc_English"] ?? "")
                    self.Case_Type_Desc_Arabic = String(describing: r["Case_Type_Desc_Arabic"] ?? "")
                    /*
                    let item = MOCDCenterService()
                    item.EmirateId = String(describing: r["EmirateId"] ?? "")
                    item.CenterId = String(describing: r["CenterId"] ?? "")
                    item.OfficeNameAR = String(describing: r["OfficeNameAR"] ?? "")
                    item.OfficeNameEN = String(describing: r["OfficeNameEN"] ?? "")
                    */
                   // self.centersArray.append(item)
                    
                }
                
                
                DispatchQueue.main.async {
                    self.requestTypeView.firstLabel.text = AppConstants.isArabic() ? self.Case_Type_Desc_Arabic : self.Case_Type_Desc_English
                    //self.centerPicker.reloadAllComponents()
                }
            }
            
        }
    }
    
    func isRejectedRequest() {
        
        let size = CGSize(width: 30, height: 30)
        
        
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
                
                        self.getRequestTypes()
                    }
                }else{
                    DispatchQueue.main.async {
                        
                        self.dismiss(animated: true, completion: nil)
                    }
                }
                DispatchQueue.main.async {
                    self.requestTypeView.firstLabel.text = AppConstants.isArabic() ? self.Case_Type_Desc_Arabic : self.Case_Type_Desc_English
                    //self.centerPicker.reloadAllComponents()
                }
            }
            
        }
    }
    
    @IBAction func nextAction(_ sender: Any) {
        
        self.performSegue(withIdentifier: "toFinancial", sender: self)
    }
}
