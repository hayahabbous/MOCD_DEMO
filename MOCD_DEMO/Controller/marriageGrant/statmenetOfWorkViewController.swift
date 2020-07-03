//
//  statmenetOfWorkViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 7/1/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit

class statmenetOfWorkViewController: UIViewController {
    
    
    @IBOutlet var employerCategoryView: selectTextField!
    @IBOutlet var emplyerView: textFieldMandatory!
    @IBOutlet var placeOfWorkView: selectTextField!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var previousButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupField()
        
    }
    
    func setupField()
    {
        
        employerCategoryView.textLabel.text = "The Employee Category"
        employerCategoryView.textField.placeholder = "Please Select"
        
        
        emplyerView.textLabel.text = "Employer"
        emplyerView.textField.placeholder = "Employer"
        
        placeOfWorkView.textLabel.text = "Place of Work"
        placeOfWorkView.textField.placeholder = "Please Select"
        
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
        self.performSegue(withIdentifier: "toIncomeStatment", sender: self)
    }
}
