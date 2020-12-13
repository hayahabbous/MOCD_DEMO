//
//  renewalCardViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 6/24/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class renewalCardViewController: UIViewController ,NVActivityIndicatorViewable {
    
    
    var newCardItem: newCardStruct = newCardStruct()
    let nvactivity = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    @IBOutlet var cardNoView: textFieldMandatory!
    @IBOutlet var searchButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupField()
        //searchCard()
    }
    
    func setupField() {
        cardNoView.textLabel.text = "Card No".localize
        cardNoView.textField.placeholder = "Card No".localize
        //cardNoView.textField.text = "2020-02010002"
        
        let gradient = CAGradientLayer()
               
        gradient.frame = self.searchButton.bounds
        
        gradient.colors = [UIColor.green]
               
        
        self.searchButton.applyGradient(colours: [AppConstants.firstBrownColor, AppConstants.secondBrownColor])
               //self.loginButton.backgroundColor = .green
        
        self.searchButton.layer.cornerRadius = 20
        
        self.searchButton.layer.masksToBounds = true
    }
    
    func searchCard() {
        
        
        let cardNumber = cardNoView.textField.text ?? ""
        if cardNumber == ""  {
            Utils.showAlertWith(title: "Error".localize, message: "Please add card number".localize, viewController: self)
        }
    let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
    
    
        WebService.SearchDisabledCardsForRenewal(card_number: cardNumber) { (json) in
        print(json)
        DispatchQueue.main.async {
            self.stopAnimating(nil)
        }
        
        guard let code = json["code"] as? Int else {return}
        guard let message = json["message"] as? String else {return}
        
        if code == 4 {
            
            guard let data = json["data"] as? [String: Any] else{return}
            guard let result = data["result"] as? [String: Any] else {return}
            
            
            let Documents = result["Documents"] as? [[String:Any]] ?? [[:]]
            
            
            for r in Documents {
                let docItem = MOCDReceivedDocumen()
                docItem.DocumentContentType = String(describing: r["DocumentContentType"] ?? "")
                docItem.DocumentContents = String(describing: r["DocumentContents"] ?? "")
                docItem.DocumentLength = String(describing: r["DocumentLength"] ?? "")
                docItem.DocumentName = String(describing: r["DocumentName"] ?? "")
                docItem.ServiceDocTypeId = String(describing: r["ServiceDocTypeId"] ?? "")
                
                let url = Utils.saveBase64StringToFile(docItem.DocumentContents, fileName: docItem.DocumentName.trimmingCharacters(in: .whitespaces))
                docItem.documentURL = URL(string: url)!
                
                print(docItem.documentURL?.absoluteString)
                self.newCardItem.allFiles.append(docItem)
                
                
            }
            
            
            self.newCardItem.AccommodationTypeId = String(describing: result["AccommodationTypeId"] ?? "")
            self.newCardItem.Address = String(describing: result["Address"] ?? "")
            self.newCardItem.FirstNameEN = String(describing: result["ApplicantName"] ?? "")
            self.newCardItem.IsStudent = String(describing: result["IsStudent"] ?? "")
            self.newCardItem.Email = String(describing: result["Email"] ?? "")
            self.newCardItem.EmirateId = String(describing: result["EmirateId"] ?? "")
            self.newCardItem.FamilyNameAR = String(describing: result["FamilyNameAR"] ?? "")
            self.newCardItem.FamilyNameEN = String(describing: result["FamilyNameEN"] ?? "")
            self.newCardItem.FatherNameAR = String(describing: result["FatherNameAR"] ?? "")
            self.newCardItem.FatherNameEN = String(describing: result["FatherNameEN"] ?? "")
            self.newCardItem.FirstNameAR = String(describing: result["FirstNameAR"] ?? "")
            self.newCardItem.FirstNameEN = String(describing: result["FirstNameEN"] ?? "")
            self.newCardItem.GenderId = String(describing: result["GenderId"] ?? "")
            self.newCardItem.GrandfatherNameAR = String(describing: result["GrandfatherNameAR"] ?? "")
            self.newCardItem.GrandfatherNameEN = String(describing: result["GrandfatherNameEN"] ?? "")
            self.newCardItem.IdentificationNo = String(describing: result["IdentificationNo"] ?? "")
            self.newCardItem.MakaniNo = String(describing: result["MakaniNo"] ?? "")
            self.newCardItem.MaritalStatusId = String(describing: result["MaritalStatusId"] ?? "")
            self.newCardItem.MobileNo = String(describing: result["MobileNo"] ?? "")
            self.newCardItem.NationalityId = String(describing: result["NationalityId"] ?? "")
            self.newCardItem.NeedSupporter = String(describing: result["NeedSupporter"] ?? "")
            
            
            self.newCardItem.OtherMobileNo = String(describing: result["OtherMobileNo"] ?? "")
            self.newCardItem.PhoneNo = String(describing: result["PhoneNo"] ?? "")
            self.newCardItem.ReportIssuedBy = String(describing: result["ReportIssuedBy"] ?? "")
            self.newCardItem.ReportDate = String(describing: result["ReportDate"] ?? "")
            
            
            self.newCardItem.Speciality = String(describing: result["Speciality"] ?? "")
            self.newCardItem.SupportingEquipment = String(describing: result["SupportingEquipment"] ?? "")
            self.newCardItem.XCoord = String(describing: result["XCoord"] ?? "")
            self.newCardItem.YCoord = String(describing: result["YCoord"] ?? "")
            
            
            
            self.newCardItem.DateOfBirth = String(describing: result["DateOfBirth"] ?? "")
            self.newCardItem.expireVisaDate = String(describing: result["ResidenceExpiryDate"] ?? "")
            self.newCardItem.cardIssueDate = String(describing: result["CardIssueDate"] ?? "")
            self.newCardItem.cardExpiryDate = String(describing: result["CardExpiryDate"] ?? "")
            
            let dateFormatter = DateFormatter()
            let isoDate = self.newCardItem.DateOfBirth
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            let date = dateFormatter.date(from:isoDate)!
            
            let dateString = self.newCardItem.DateOfBirth.dateFromFormat("yyyy-MM-dd'T'HH:mm:ss")!
            print(dateString)
            self.newCardItem.DateOfBirth = self.newCardItem.DateOfBirth.dateFromFormat("yyyy-MM-dd'T'HH:mm:ss")!.stringFromFormat("MM/dd/yyyy")
            self.newCardItem.DiagnosisAuthorityId = String(describing: result["DiagnosisAuthorityId"] ?? "")
            self.newCardItem.DiagnosisInformation = String(describing: result["DiagnosisInformation"] ?? "")
            self.newCardItem.DisabilityLevelId = String(describing: result["DisabilityLevelId"] ?? "")
            self.newCardItem.DisabilityTypeId = String(describing: result["DisabilityTypeId"] ?? "")
        
            
            self.newCardItem.ReportDate = String(describing: result["ReportDate"] ?? "")
            self.newCardItem.ReportDate = self.newCardItem.ReportDate.dateFromFormat("yyyy-MM-dd'T'HH:mm:ss")!.stringFromFormat("MM/dd/yyyy")
            self.newCardItem.expireVisaDate = self.newCardItem.expireVisaDate.dateFromFormat("yyyy-MM-dd'T'HH:mm:ss")!.stringFromFormat("MM/dd/yyyy")
            self.newCardItem.cardIssueDate = self.newCardItem.cardIssueDate.dateFromFormat("yyyy-MM-dd'T'HH:mm:ss")!.stringFromFormat("MM/dd/yyyy")
            
            self.newCardItem.cardExpiryDate = self.newCardItem.cardExpiryDate.dateFromFormat("yyyy-MM-dd'T'HH:mm:ss")!.stringFromFormat("MM/dd/yyyy")
            
            
            DispatchQueue.main.async {
                
                self.performSegue(withIdentifier: "toNewCard", sender: self)
                
            }
        }else{
            
            
            DispatchQueue.main.async {
                               
                Utils.showAlertWith(title: "Error".localize, message: message, viewController: self)
                
            }
        }

        }
        
    }
    @IBAction func nextAction(_ sender: Any) {
        
        searchCard()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNewCard" {
            let dest = segue.destination as! ApplicantCardDetailsVC
            dest.isRenewal = true
            
            self.newCardItem.disabledCardNumber = self.cardNoView.textField.text ?? ""
            dest.newCardItem = self.newCardItem
        }
    }
}
