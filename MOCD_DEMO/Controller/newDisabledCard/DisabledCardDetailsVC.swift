//
//  DisabledCardDetailsVC.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 2/26/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit


class DisabledCardDetailsVC: UIViewController {
    
    @IBOutlet var nationalityView: selectTextField!
    @IBOutlet var identificationNoView: textFieldMandatory!
    @IBOutlet var UIDView: textFieldMandatory!
    @IBOutlet var firstNameEnView: textFieldMandatory!
    @IBOutlet var fatherNameEnView: textFieldMandatory!
    @IBOutlet var grandFatherView: textFieldMandatory!
    @IBOutlet var familyNameEnView: textFieldMandatory!
    
    
    @IBOutlet var FirstNameArView: textFieldMandatory!
    @IBOutlet var FatherNameArView: textFieldMandatory!
    @IBOutlet var grandFatherArView: textFieldMandatory!
    @IBOutlet var FamilyNameArView: textFieldMandatory!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setupFields()
    }
    
    
    func setupFields() {
        nationalityView.textField.placeholder = "Please Select"
        nationalityView.textLabel.text = "Nationality"
        
        
        identificationNoView.textField.placeholder = "Identification No"
        identificationNoView.textLabel.text = "Identification No"
        
        UIDView.textField.placeholder = "U.ID"
        UIDView.textLabel.text = "U.ID"
        
        
        firstNameEnView.textField.placeholder = "First Name [EN]"
        firstNameEnView.textLabel.text = "First Name [EN]"
        
        
        fatherNameEnView.textField.placeholder = "Father Name [EN]"
        fatherNameEnView.textLabel.text = "Father Name [EN]"
        
        
        familyNameEnView.textField.placeholder = "Family Name [EN]"
        familyNameEnView.textLabel.text = "Family Name [EN]"
        
        
        grandFatherView.textField.placeholder = "Grandfather Name [EN]"
        grandFatherView.textLabel.text = "Grandfather Name [EN]"
        
        
        
        
        FirstNameArView.textField.placeholder = "First Name [AR]"
        FirstNameArView.textLabel.text = "First Name [AR]"
        
        
        FatherNameArView.textField.placeholder = "Father Name [AR]"
        FatherNameArView.textLabel.text = "Father Name [AR]"
        
        
        FamilyNameArView.textField.placeholder = "Family Name [AR]"
        FamilyNameArView.textLabel.text = "Family Name [AR]"
        
        
        grandFatherArView.textField.placeholder = "Grandfather Name [AR]"
        grandFatherArView.textLabel.text = "Grandfather Name [AR]"
        
        
    }
}
