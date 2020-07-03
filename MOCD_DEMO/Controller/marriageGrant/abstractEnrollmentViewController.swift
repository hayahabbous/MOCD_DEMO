//
//  abstractEnrollmentViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 7/1/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit

class abstractEnrollmentViewController: UIViewController {
    
    
    @IBOutlet var numberofFamilyBookView: textFieldMandatory!
    @IBOutlet var NumberTown: textFieldMandatory!
    @IBOutlet var familyNoView: textFieldMandatory!
    @IBOutlet var dateOfIssuanceView: dateTexteField!
    @IBOutlet var placeIssuanceView: selectTextField!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var previousButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupField()
    }
    
    func setupField()
    {
        
        numberofFamilyBookView.textLabel.text = "Number of Family Book"
        numberofFamilyBookView.textField.placeholder = "Number of Family Book"
        
        NumberTown.textLabel.text = "Number Town"
        NumberTown.textField.placeholder = "Number Town"
        
        
        familyNoView.textLabel.text = "Family No"
        familyNoView.textField.placeholder = "Family No"
        
        
        dateOfIssuanceView.textLabel.text = "Date of Issuance of the Family Book"
        dateOfIssuanceView.viewController = self
        
        placeIssuanceView.textLabel.text = "Place Issuance of a Passport"
        placeIssuanceView.textField.placeholder = "Please Select"
        
        
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
        self.performSegue(withIdentifier: "toSatatment", sender: self)
    }
}
