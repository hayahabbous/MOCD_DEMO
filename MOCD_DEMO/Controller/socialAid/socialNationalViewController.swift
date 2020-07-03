//
//  socialNationalViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 6/25/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit


class socialNationalViewController: UIViewController {
    @IBOutlet var nationalIdView: textFieldMandatory!
    @IBOutlet var nationalIssueDateView: dateTexteField!
    @IBOutlet var nationalExpiryDateView: dateTexteField!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var previousButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupField()
    }
    
    func setupField() {
        
        nationalIdView.textLabel.text = "National Id"
        nationalIdView.textField.placeholder = "National Id"
        
        nationalIssueDateView.textLabel.text = "National Id Issue Date"
        nationalIssueDateView.viewController = self
        
        
        nationalExpiryDateView.textLabel.text = "National Id Expiry Date"
        nationalExpiryDateView.starImage.isHidden = true
        nationalExpiryDateView.viewController = self
        
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
        
        self.performSegue(withIdentifier: "toInformation", sender: self)
    }
}
