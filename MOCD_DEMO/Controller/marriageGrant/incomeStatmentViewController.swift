//
//  incomeStatmentViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 7/1/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit

class incomeStatmentViewController: UIViewController {
    
    
    @IBOutlet var totalMonthlyIncomeView: textFieldMandatory!
    @IBOutlet var bankNameView: selectTextField!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var previousButton: UIButton!
    @IBOutlet var ibanView: textFieldMandatory!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupField()
    }
    
    func setupField()
    {
        totalMonthlyIncomeView.textLabel.text = "Total monthly income"
        totalMonthlyIncomeView.textField.placeholder = "Total monthly income"
        
        
        bankNameView.textLabel.text = "Bank Name"
        bankNameView.textField.placeholder = "Please Select"
        
        
        ibanView.textLabel.text = "International Account Number (IBAN)"
        ibanView.textField.placeholder = "International Account Number (IBAN)"
        
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
        self.performSegue(withIdentifier: "toOtherInfo", sender: self)
    }
}
