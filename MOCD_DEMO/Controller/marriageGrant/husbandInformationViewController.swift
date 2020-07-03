//
//  husbandInformationViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 7/1/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit

class husbandInformationViewController: UIViewController {
    
    
    @IBOutlet var husbandNameView: textFieldMandatory!
    @IBOutlet var husbandNameEnView: textFieldMandatory!
    @IBOutlet var dateOfBirthView: dateTexteField!
    @IBOutlet var nationalNumberView: textFieldMandatory!
    @IBOutlet var educationalLevelView: selectTextField!
    @IBOutlet var emailView: textFieldMandatory!
    @IBOutlet var mobileoneView: textFieldMandatory!
    @IBOutlet var mobiletowView: textFieldMandatory!
    @IBOutlet var nextButton: UIButton!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupField()
    }
    
    func setupField()
    {
        
        husbandNameView.textLabel.text = "Husband Name"
        husbandNameView.textField.placeholder = "Husband Name"
        
        
        husbandNameEnView.textLabel.text = "Husband Name [EN]"
        husbandNameEnView.textField.placeholder = "Husband Name [EN]"
        
        
        dateOfBirthView.textLabel.text = "Date of Birth of Husband"
        dateOfBirthView.viewController = self
        
        nationalNumberView.textLabel.text = "National Number For The Husband"
        nationalNumberView.textField.placeholder = "National Number For The Husband"
        
        educationalLevelView.textLabel.text = "Educational Level"
        educationalLevelView.textField.placeholder = "Please Select"
        
        
        emailView.textLabel.text = "Email"
        emailView.textField.placeholder = "Email"
        
        mobileoneView.textLabel.text = "Mobile 1"
        mobileoneView.textField.placeholder = "Mobile 1"
        
        
        mobiletowView.textLabel.text = "Mobile 2"
        mobiletowView.textField.placeholder = "Mobile 2"
        
        
        let gradient = CAGradientLayer()
        gradient.frame = self.nextButton.bounds
        gradient.colors = [UIColor.green]
        
        self.nextButton.applyGradient(colours: [AppConstants.firstBrownColor, AppConstants.secondBrownColor])
        //self.loginButton.backgroundColor = .green
        self.nextButton.layer.cornerRadius = 20
        self.nextButton.layer.masksToBounds = true
        
        
        
    }
    @IBAction func nextAction(_ sender: Any) {
        self.performSegue(withIdentifier: "toWifeInformation", sender: self)
    }
}
