//
//  massWeddingApplicantDetailsViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 7/1/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit


class massWeddingApplicantDetailsViewController: UIViewController {
    
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var husbandNameView: textFieldMandatory!
    @IBOutlet var nationalNumberView: textFieldMandatory!
    @IBOutlet var dateView: dateTexteField!
    @IBOutlet var wifeNameView: textFieldMandatory!
    @IBOutlet var nationalNumberWifeView: textFieldMandatory!
    @IBOutlet var emirateView: selectTextField!
    @IBOutlet var cityView: textFieldMandatory!
    @IBOutlet var mobileView: textFieldMandatory!
    @IBOutlet var emailView: textFieldMandatory!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupField()
    }
    
    func setupField() {
        
        
        husbandNameView.textLabel.text = "Husband Name"
        husbandNameView.textField.placeholder = "Husband Name"
        
        nationalNumberView.textLabel.text = "National Number For the Husband"
        nationalNumberView.textField.placeholder = "National Number For the Husband"
        
        dateView.textLabel.text = "Date of the Marriage Contract"
        dateView.viewController = self
        
        wifeNameView.textLabel.text = "Wife Name"
        wifeNameView.textField.placeholder = "Wife Name"
        
        
        nationalNumberWifeView.textLabel.text = "National Number For the Wife"
        nationalNumberWifeView.textField.placeholder = "National Number For the Wife"
        
        
        emirateView.textLabel.text = "Emirate"
        emirateView.textField.placeholder = "Please Select"
        
        
        
        mobileView.textLabel.text = "Mobile No"
        mobileView.textField.placeholder = "Mobile No"
        
        
        emailView.textLabel.text = "Email"
        emailView.textField.placeholder = "Email"
        
        cityView.textLabel.text = "City"
        cityView.textField.placeholder = "City"
        
        let gradient = CAGradientLayer()
        gradient.frame = self.nextButton.bounds
        gradient.colors = [UIColor.green]
        
        self.nextButton.applyGradient(colours: [AppConstants.firstBrownColor, AppConstants.secondBrownColor])
        //self.loginButton.backgroundColor = .green
        self.nextButton.layer.cornerRadius = 20
        self.nextButton.layer.masksToBounds = true
        
    }
    @IBAction func nextAction(_ sender: Any) {
        self.performSegue(withIdentifier: "toOther", sender: self)
    }
}
