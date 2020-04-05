//
//  ApplicantCardDetailsVC.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 2/26/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit


class ApplicantCardDetailsVC: UIViewController {
    
    
    @IBOutlet var typeView: multipleTextField!
    @IBOutlet var organizationView: selectTextField!
    @IBOutlet var submitButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        
    }
    
    func setupView() {
        let gradient = CAGradientLayer()
        gradient.frame = self.submitButton.bounds
        gradient.colors = [UIColor.green]
        
        self.submitButton.applyGradient(colours: [AppConstants.firstBrownColor, AppConstants.secondBrownColor])
        //self.loginButton.backgroundColor = .green
        self.submitButton.layer.cornerRadius = 20
        self.submitButton.layer.masksToBounds = true
        
        
    }
    func setupFields() {
        typeView.textLabel.text = "Type"
        typeView.firstLabel.text = "Personal"
        typeView.secondLabel.text = "Establishment"
        
        organizationView.textLabel.text = "Organization"
        organizationView.textField.placeholder = "Please Select"
        
        
        
    }
    @IBAction func nextButtonAction(_ sender: Any) {
        
        self.performSegue(withIdentifier: "toDisabledDetails", sender: self)
    }
}
