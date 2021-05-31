//
//  visitingElderlyViewController.swift
//  MOCD_DEMO
//
//  Created by haya habbous on 15/04/2021.
//  Copyright © 2021 Datacellme. All rights reserved.
//

import Foundation
import UIKit


struct visitingElderly {
    
    var emiratesID: String = ""
    var applicantName: String = ""
    var telephoneNumber: String = ""
    var personEmiratesID: String = ""
    var firstNameEn: String = ""
    var fatherNameEn: String = ""
    var grandFatherEn: String = ""
    var familyNameEn: String = ""
    var firstNameAr: String = ""
    var fatherNameAr: String = ""
    var grandFatherAr: String = ""
    var familyNameAr: String = ""
    
    
    
    var nationality: String = ""
    var emirate: String = ""
    var gender: String = ""
    var dateOfBirth: String = ""
    var residenceAddress: String = ""
    var personTelephone: String = ""
    var personOtherTelephone: String = ""
    var personMobileNumber: String = ""
    var personEmail: String = ""
    var hobby: String = ""
    var activity: String = ""
  
    

}


class visitingElderlyViewController: UIViewController {
    
    
    var  visitElderlyItemItem: visitingElderly = visitingElderly()
    @IBOutlet weak var emiratesIDView: textFieldMandatory!
    @IBOutlet weak var applicantNameView: textFieldMandatory!
    @IBOutlet weak var telephoneNumberView: textFieldMandatory!
    
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupField()
    }
    
    func setupField() {
        emiratesIDView.textLabel.text = "Emirates ID".localize
        emiratesIDView.textField.placeholder = "Emirates ID".localize
       
        applicantNameView.textLabel.text = "Applicant Name".localize
        applicantNameView.textField.placeholder = "Applicant Name".localize
        
        
        telephoneNumberView.textLabel.text = "Telephone Number".localize
        telephoneNumberView.textField.placeholder = "Telephone Number".localize
        
      
        
        
        let gradient = CAGradientLayer()
        gradient.frame = self.nextButton.bounds
        gradient.colors = [UIColor.green]
        
        self.nextButton.applyGradient(colours: [AppConstants.firstBrownColor, AppConstants.secondBrownColor])
        //self.loginButton.backgroundColor = .green
        self.nextButton.layer.cornerRadius = 20
        self.nextButton.layer.masksToBounds = true
        
    }
    
    func validateFields() -> Bool{
        
        
        visitElderlyItemItem.emiratesID = emiratesIDView.textField.text ?? ""
        visitElderlyItemItem.applicantName = applicantNameView.textField.text ?? ""
        visitElderlyItemItem.telephoneNumber = telephoneNumberView.textField.text ?? ""
        
        
        if emiratesIDView.textField.text == "" ||
            applicantNameView.textField.text == "" ||
            telephoneNumberView.textField.text == ""
            {
            
            Utils.showAlertWith(title: "Error".localize, message: "Please Fill All Fields".localize, viewController: self)
            return false
            
            
        }
        
        
        
        return true
        
    }
    @IBAction func nextAction(_ sender: Any) {
        
        if validateFields() {
            self.performSegue(withIdentifier: "toDetails", sender: self)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetails" {
            let dest = segue.destination as! visitingPersonDetailsViewController
            dest.visitElderlyItemItem = self.visitElderlyItemItem
        }
    }
}
