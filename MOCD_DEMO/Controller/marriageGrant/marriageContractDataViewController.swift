//
//  marriageContractDataViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 7/1/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit

class marriageContractDataViewController: UIViewController {
    
    
    @IBOutlet var dateOfMarriageContractView: dateTexteField!
    @IBOutlet var shariaCourtView: selectTextField!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var previousButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupField()
    }
    
    func setupField()
    {
        dateOfMarriageContractView.textLabel.text = "Date of the Marriage Contract"
        dateOfMarriageContractView.viewController = self
        
        shariaCourtView.textLabel.text = "Sharia Court Name"
        shariaCourtView.textField.placeholder = "Please Select"
        
        
        
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
        
        self.performSegue(withIdentifier: "toAbstract", sender: self)
    }
}
