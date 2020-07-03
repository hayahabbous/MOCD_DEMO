//
//  wifeInformationViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 7/1/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit

class wifeInformationViewController: UIViewController {
    
    @IBOutlet var wifeNameView: textFieldMandatory!
    
    @IBOutlet var wifeNameEnView: textFieldMandatory!
    @IBOutlet var dateOfBirthView: dateTexteField!
    @IBOutlet var nationalNumberView: textFieldMandatory!
    @IBOutlet var educationalLevelView: selectTextField!
    @IBOutlet var wifeMobile: textFieldMandatory!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var previousButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupField()
    }
    
    func setupField()
    {
        wifeNameView.textLabel.text = "Wife Name"
        wifeNameView.textField.placeholder = "Wife Name"
        
        
        wifeNameEnView.textLabel.text = "Wife Name [En]"
        wifeNameEnView.textField.placeholder = "Wife Name [En]"
        
        
        dateOfBirthView.textLabel.text = "Date of Birth of Wife"
        dateOfBirthView.viewController = self
        
        nationalNumberView.textLabel.text = "National Number For The Wife"
        nationalNumberView.textField.placeholder = "National Number For The Wife"
        
        educationalLevelView.textLabel.text = "Educational Level"
        educationalLevelView.textField.placeholder = "Please Select"
        
        wifeMobile.textLabel.text = "Wife Mobile"
        wifeMobile.textField.placeholder = "Wife Mobile"
        
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
    @IBAction func nextAction(_ sender: Any) {
        
        self.performSegue(withIdentifier: "toContarct", sender: self)
    }
}
