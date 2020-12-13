//
//  lostCardViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 6/24/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

struct lostCard {
    
    var disabledCardId: String = ""
    var requestTypeId: String  = ""
    var comments: String = ""
    var emailAddress: String = ""
    var ServiceDocTypeIds:String = ""
    var allFiles: [MOCDReceivedDocumen] = []
}
class lostCardViewController: UIViewController ,NVActivityIndicatorViewable{
    
    
    let nvactivity = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    @IBOutlet var cardNoView: textFieldMandatory!
    @IBOutlet var searchButton: UIButton!
    var lostCardItem: lostCard = lostCard()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupField()
        
    }
    
    
    func setupField() {
        cardNoView.textLabel.text = "Card No".localize
        cardNoView.textField.placeholder = "Card No".localize
        //cardNoView.textField.text = "2016-0000023"
        
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
    
    
        WebService.SearchDisabledCardsForReplacement(card_number: cardNumber) { (json) in
        print(json)
        DispatchQueue.main.async {
            self.stopAnimating(nil)
        }
        
        guard let code = json["code"] as? Int else {return}
        guard let message = json["message"] as? String else {return}
        
        if code == 1 {
            
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
                self.lostCardItem.allFiles.append(docItem)
                
                
            }
            self.lostCardItem.emailAddress = String(describing: result["EmailAddress"] ?? "")
            self.lostCardItem.requestTypeId = String(describing: result["RequestTypeId"] ?? "")
            self.lostCardItem.disabledCardId = String(describing: result["DisabledCardId"] ?? "")
            DispatchQueue.main.async {
                
                
                //self.lostCardItem.disabledCardId = self.cardNoView.textField.text ?? ""
                self.performSegue(withIdentifier: "toInfo", sender: self)
                
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
        if segue.identifier == "toInfo" {
            let dest = segue.destination as! lostCardInformationViewController
            dest.lostCardItem = self.lostCardItem
        }
    }
}
