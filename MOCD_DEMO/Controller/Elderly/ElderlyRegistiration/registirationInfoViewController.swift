//
//  registirationInfoViewController.swift
//  MOCD_DEMO
//
//  Created by haya habbous on 11/04/2021.
//  Copyright © 2021 Datacellme. All rights reserved.
//

import Foundation
import UIKit

class registirationInfoViewController: UIViewController {
    
    
    
    @IBOutlet var nextButton: UIButton!
    @IBOutlet weak var emiratesIdView: textFieldMandatory!
    @IBOutlet weak var applicantNameView: textFieldMandatory!
    @IBOutlet weak var applicantTypeView: multipleTextField!
    @IBOutlet weak var establishmentDetailView: textFieldMandatory!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupField()
    }
    
    func setupField() {
        emiratesIdView.textLabel.text = "Emirates ID".localize
        emiratesIdView.textField.placeholder = "Emirates ID".localize
       
        applicantNameView.textLabel.text = "Applicant Name".localize
        applicantNameView.textField.placeholder = "Applicant Name".localize
        
        
        applicantTypeView.textLabel.text = "Applicant Type".localize
        applicantTypeView.firstLabel.text = "Establishment".localize
        applicantTypeView.secondLabel.text = "Personal".localize
        
        establishmentDetailView.textLabel.text = "Establishment Detail".localize
        establishmentDetailView.textField.placeholder = "Establishment Detail".localize
        
        
        let gradient = CAGradientLayer()
        gradient.frame = self.nextButton.bounds
        gradient.colors = [UIColor.green]
        
        self.nextButton.applyGradient(colours: [AppConstants.firstBrownColor, AppConstants.secondBrownColor])
        //self.loginButton.backgroundColor = .green
        self.nextButton.layer.cornerRadius = 20
        self.nextButton.layer.masksToBounds = true
        
    }
    
    func validateFields() -> Bool{
        
        
        
        
        if emiratesIdView.textField.text == "" ||
            applicantNameView.textField.text == "" ||
            
            establishmentDetailView.textField.text == ""
            
            {
            
            Utils.showAlertWith(title: "Error".localize, message: "Please Fill All Fields".localize, viewController: self)
            return false
            
            
        }
        
        
        return true
    }
       
    @IBAction func nextAction(_ sender: Any) {
        
        if validateFields() {
            self.performSegue(withIdentifier: "toPersonDetails", sender: self)
        }
        
    }
}
