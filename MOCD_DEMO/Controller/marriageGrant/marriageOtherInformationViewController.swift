//
//  marriageOtherInformationViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 7/1/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView


class marriageOtherInformationViewController: UIViewController ,NVActivityIndicatorViewable{
    
    
    var marriageItem: marriageService = marriageService()
    let nvactivity = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    @IBOutlet var specialNeedView: multipleTextField!
    @IBOutlet var relativeOfHusbandView: textFieldMandatory!
    @IBOutlet var mobileView: textFieldMandatory!
    @IBOutlet var relativeOfWifeView: textFieldMandatory!
    @IBOutlet var mobileTwoView: textFieldMandatory!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var previousButton: UIButton!
    
    var contentString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setupField()
        
        
    }
    
    func setupField()
    {
        
     
        specialNeedView.textLabel.text = "Categroy of Special Needs".localize
        specialNeedView.firstLabel.text = "No".localize
        specialNeedView.secondLabel.text = "Yes".localize
        
        relativeOfHusbandView.textLabel.text = "A relative of the Husband".localize
        relativeOfHusbandView.textField.placeholder = "A relative of the Husband".localize
        
        
        
        relativeOfWifeView.textLabel.text = "A relative of the Wife".localize
        relativeOfWifeView.textField.placeholder = "A relative of the Wife".localize
        
        mobileView.textLabel.text = "Mobile".localize
        mobileView.textField.placeholder = "Mobile".localize
        
        mobileTwoView.textLabel.text = "Mobile".localize
        mobileTwoView.textField.placeholder = "Mobile".localize
        
        
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
        
        
        
        if relativeOfHusbandView.textField.text == "" ||
            mobileView.textField.text == "" ||
            relativeOfWifeView.textField.text == "" ||
            mobileTwoView.textField.text == "" {
            
            Utils.showAlertWith(title: "Error".localize, message: "Please Fill All Fields".localize, viewController: self)
            return false
            
            
        }
        
        
        
        return true
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDoc" {
            let dest = segue.destination as! masterDocViewController
            dest.requestType = "0"
            dest.contentString = self.contentString
        }
    }
    @IBAction func saveAction(_ sender: Any) {
        
        if !validateFields() {
            return
        }
        //self.performSegue(withIdentifier: "toDoc", sender: self)
        
        let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
               
               
        WebService.SubmitGrantRequest(HusbandNationalId: marriageItem.HusbandNationalId, WifeNationalId: marriageItem.WifeNationalId, MarriageContractDate: marriageItem.MarriageContractDate, Court: marriageItem.Court, EmployerCategory: marriageItem.EmployerCategory, HusbandFullNameArabic: marriageItem.HusbandFullNameArabic, HusbandFullNameEnglish: marriageItem.HusbandFullNameEnglish, HusbandBirthDate: marriageItem.HusbandBirthDate, HusbandEducationLevel: marriageItem.HusbandEducationLevel, HusbandMobile1: marriageItem.HusbandMobile1, HusbandMobile2: marriageItem.HusbandMobile2, HusbandEmail: marriageItem.HusbandEmail, WifeFullNameArabic: marriageItem.HusbandFullNameArabic, WifeFullNameEnglish: marriageItem.WifeFullNameEnglish, WifeBirthDate: marriageItem.WifeBirthDate, WifeEducationLevel: marriageItem.WifeEducationLevel, WifeMobile1: marriageItem.WifeMobile1, WifeEmail: marriageItem.WifeEmail, FamilyBookNumber: marriageItem.FamilyBookNumber, TownNumber: marriageItem.TownNumber, FamilyNumber: marriageItem.FamilyNumber, FamilyBookIssueDate: marriageItem.FamilyBookIssueDate, FamilyBookIssuePlace: marriageItem.FamilyBookIssuePlace, Employer: marriageItem.Employer, WorkPlace: marriageItem.WorkPlace, Totalmonthlyincome: marriageItem.Totalmonthlyincome, BankName: marriageItem.BankName, IBAN: marriageItem.BankName) { (json) in
            
            
            print(json)
            DispatchQueue.main.async {
            
                self.stopAnimating(nil)
            }
            guard let ResponseDescriptionEn = json["ResponseDescriptionEn"] as? String else {return}
            guard let ResponseDescriptionAr = json["ResponseDescriptionAr"] as? String else {return}
            guard let ResponseTitle = json["ResponseTitle"] as? String else {return}
            
            
            
            guard let content = json["Content"] as? [String:Any] else {
                
                DispatchQueue.main.async {
             
                    Utils.showAlertWith(title: ResponseTitle, message: AppConstants.isArabic() ? ResponseDescriptionAr : ResponseDescriptionEn, viewController: self)
                }
                return
                
            }
            guard let RequestId = content["RequestId"] as? String else {
                
                DispatchQueue.main.async {
               
                    Utils.showAlertWith(title: ResponseTitle, message: AppConstants.isArabic() ? ResponseDescriptionAr : ResponseDescriptionEn, viewController: self)
                }
                return
                
            }
            
            
            
            DispatchQueue.main.async {
            
                
                self.contentString = RequestId
                
                self.performSegue(withIdentifier: "toDoc", sender: self)
            }
        }
           
       
    }
}
