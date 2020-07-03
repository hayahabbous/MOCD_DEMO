//
//  renewalCardViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 6/24/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit


class renewalCardViewController: UIViewController {
    
    
    @IBOutlet var cardNoView: textFieldMandatory!
    @IBOutlet var searchButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupField()
    }
    
    func setupField() {
        cardNoView.textLabel.text = "Card No"
        cardNoView.textField.placeholder = "Card No"
        
        
        let gradient = CAGradientLayer()
               
        gradient.frame = self.searchButton.bounds
        
        gradient.colors = [UIColor.green]
               
        
        self.searchButton.applyGradient(colours: [AppConstants.firstBrownColor, AppConstants.secondBrownColor])
               //self.loginButton.backgroundColor = .green
        
        self.searchButton.layer.cornerRadius = 20
        
        self.searchButton.layer.masksToBounds = true
    }
}
