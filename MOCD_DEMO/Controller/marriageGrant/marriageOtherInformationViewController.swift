//
//  marriageOtherInformationViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 7/1/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit

class marriageOtherInformationViewController: UIViewController {
    
    
    @IBOutlet var specialNeedView: multipleTextField!
    @IBOutlet var relativeOfHusbandView: textFieldMandatory!
    @IBOutlet var mobileView: textFieldMandatory!
    @IBOutlet var relativeOfWifeView: textFieldMandatory!
    @IBOutlet var mobileTwoView: textFieldMandatory!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var previousButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupField()
        
        
    }
    
    func setupField()
    {
        specialNeedView.textLabel.text = "Categroy of Special Needs"
        specialNeedView.firstLabel.text = "No"
        specialNeedView.secondLabel.text = "Yes"
        
        relativeOfHusbandView.textLabel.text = "A relative of the Husband"
        relativeOfHusbandView.textField.placeholder = "A relative of the Husband"
        
        
        
        relativeOfWifeView.textLabel.text = "A relative of the Wife"
        relativeOfWifeView.textField.placeholder = "A relative of the Wife"
        
        mobileView.textLabel.text = "Mobile"
        mobileView.textField.placeholder = "Mobile"
        
        mobileTwoView.textLabel.text = "Mobile"
        mobileTwoView.textField.placeholder = "Mobile"
        
        
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
    @IBAction func saveAction(_ sender: Any) {
    }
}
