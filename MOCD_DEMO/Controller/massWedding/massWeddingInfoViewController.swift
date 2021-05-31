//
//  massWeddingInfoViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 7/1/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit


class massWeddingInfoViewController: UIViewController {
    
    var  massWeddingItem: massWedding!
    @IBOutlet var infoView: supportingField!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var previousButton: UIButton!
    
    var contentString: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupField()
    }
    
    func setupField() {
        
        infoView.textLabel.text = "Why you did not receive the grant".localize
        infoView.firstlabel.text = "Husband age".localize
        infoView.secondLabel.text = "Wife age".localize
        infoView.thirdLabel.text = "Total income".localize
        infoView.fourthLabel.text = "Student scholarship".localize
        infoView.fifthLabel.text = "Other reason".localize
        
        
        infoView.sixthLabel.isHidden = true
        infoView.sixthCheckBox.isHidden = true
        
        
        infoView.seventhLabel.isHidden = true
        infoView.sevenCheckBox.isHidden = true
        
        
        let gradient = CAGradientLayer()
        gradient.frame = self.nextButton.bounds
        gradient.colors = [UIColor.green]
        
        self.nextButton.applyGradient(colours: [AppConstants.firstBrownColor, AppConstants.secondBrownColor])
        //self.loginButton.backgroundColor = .green
        self.nextButton.layer.cornerRadius = 20
        self.nextButton.layer.masksToBounds = true
        
        /*
        gradient.frame = self.previousButton.bounds
        gradient.colors = [UIColor.green]
        
        self.previousButton.applyGradient(colours: [AppConstants.firstBrownColor, AppConstants.secondBrownColor])
        //self.loginButton.backgroundColor = .green
        self.previousButton.layer.cornerRadius = 20
        self.previousButton.layer.masksToBounds = true*/
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDoc" {
            let dest = segue.destination as! masterDocViewController
            dest.requestType = "2"
            dest.contentString = self.contentString
        }
    }
    @IBAction func saveAction(_ sender: Any) {
        
    
        WebService.SubmitMassWeddingRequest(HusbandNationalId: massWeddingItem.nationalForHusband, WifeNationalId: massWeddingItem.nationalForWife, MarriageContractDate: massWeddingItem.contractDate, Court: "", HusbandFullNameArabic: massWeddingItem.husbandName, HusbandFullNameEnglish: massWeddingItem.husbandName, HusbandBirthDate: "", HusbandEducationLevel: "", HusbandMobile1: massWeddingItem.mobile, HusbandMobile2: massWeddingItem.mobile, HusbandEmail: massWeddingItem.email, WifeFullNameArabic: massWeddingItem.wifName, WifeFullNameEnglish: massWeddingItem.wifName, WifeBirthDate: "", WifeEducationLevel: "", WifeMobile1: massWeddingItem.mobile, WifeEmail: massWeddingItem.email, FamilyBookIssuePlace: massWeddingItem.emirate, ReasonForNotRecievinggrant: "") { (json) in
            print(json)
            
            guard let code = json["Code"] as? Int else {return}
            guard let ResponseTitle = json["ResponseTitle"] as? String else {return}
            guard let ResponseDescriptionEn = json["ResponseDescriptionEn"] as? String else {return}
            guard let ResponseDescriptionAr = json["ResponseDescriptionAr"] as? String else {return}
            if code == 200 {
                
                guard let content = json["Content"] as? String else {
                    DispatchQueue.main.async {
                        Utils.showAlertWith(title: ResponseTitle, message: AppConstants.isArabic() ? ResponseDescriptionAr : ResponseDescriptionEn, viewController: self)
                    }
                    
                    return
                    
                }
                self.contentString = content
                
                DispatchQueue.main.async {
                    
                    self.performSegue(withIdentifier: "toDoc", sender: self)
                }
            }else{
                
                
                DispatchQueue.main.async {
                                   
                    Utils.showAlertWith(title: ResponseTitle, message: AppConstants.isArabic() ? ResponseDescriptionAr : ResponseDescriptionEn, viewController: self)
                    
                }
            }
            
            
        }
    }
}
