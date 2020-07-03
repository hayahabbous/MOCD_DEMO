//
//  newCardAttachemnetViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 6/15/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView


class newCardAttachemnetViewController: UIViewController {
    
    var docsArray: [MOCDDocument] = []
    let activityData = ActivityData()
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "browseTableViewCell", bundle: nil), forCellReuseIdentifier: "browseTableViewCell")
        
        getDocuments()
    }
    
    
    func getDocuments() {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
        
        WebService.RetrieveNewDisabledCardDocumentTypes { (json) in
            print(json)
            DispatchQueue.main.async {
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            }
            
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
                
                guard let data = json["data"] as? [String: Any] else{return}
                guard let result = data["result"] as? [String: Any] else {return}
                guard let list = result["list"] as? [[String: Any]] else {return}
                
                for r in list {
                let docItem: MOCDDocument = MOCDDocument()
                    
                    
                    docItem.DocTypeTitleEn = String(describing: r["DocTypeTitleEn"] ?? "")
                    docItem.DocTypeTitleAr = String(describing: r["DocTypeTitleAr"] ?? "")
                    docItem.ValidExtension = String(describing: r["ValidExtension"] ?? "")
                    docItem.StatusTitleEN = String(describing: r["StatusTitleEN"] ?? "")
                    docItem.StatusTitleAR = String(describing: r["StatusTitleAR"] ?? "")
                    docItem.ServiceDocTypeId = String(describing: r["ServiceDocTypeId"] ?? "")
                    docItem.ServiceId = String(describing: r["ServiceId"] ?? "")
                    docItem.DocTypeId = String(describing: r["DocTypeId"] ?? "")
                    docItem.StatusId = String(describing: r["StatusId"] ?? "")
                    docItem.IsMandatory = String(describing: r["IsMandatory"] ?? "")
                    docItem.IsMany = String(describing: r["IsMany"] ?? "")
                    
                      
                    
                    
                    
                    
                    self.docsArray.append(docItem)
                    
                    
                }
                
                DispatchQueue.main.async {
                    
                    self.tableView.reloadData()
                    //self.organizationPickerView.reloadAllComponents()
                }
            }else{
                
                
                DispatchQueue.main.async {
                                   
                    Utils.showAlertWith(title: "Error", message: message, viewController: self)
                    
                }
            }

        }
    }
    
    @objc func submitAction() {
        servicesRequest.CreateDisabledCardRequest_ByObject(NationalityId: "1", IdentificationNo: "1234234248889", UID: "r34r34r", FirstNameAR: "vjfdvdfv", FatherNameAR: "vjfdvdfv", GrandfatherNameAR: "vjfdvdfv", FamilyNameAR: "vjfdvdfv", FirstNameEN: "vjfdvdfv", FatherNameEN: "vjfdvdfv", GrandfatherNameEN: "vjfdvdfv", FamilyNameEN: "vjfdvdfv", GenderId: "1", DateOfBirth: "05/08/2009", IsStudent: "false", MaritalStatusId: "1", AccommodationTypeId: "1", Address: "ndjskjvc1", EmirateId: "1", POBox: "fjdfds", MobileNo: "fjdfds", OtherMobileNo: "fjdfds", PhoneNo: "fjdfds", Email: "fjdfds@f.c", MakaniNo: "dsbvjsfdjsvs", XCoord: "dsbvjsfdjsvs", YCoord: "dsvj", DiagnosisAuthorityId: "1", DiagnosisInformation: "ffewf", DisabilityTypeId: "1", DisabilityLevelId: "1", SupportingEquipment: "fnksjvs", NeedSupporter: "false", CanLiveAlone: "false", ReportIssuedBy: "fbvjhf", Speciality: "fbvjhf", ReportDate: "05/08/2009", SecurityToken: "672382249327378423", UserId: "365e1b6e-85f4-45c1-b43c-55c7d769f2f8", ServiceDocTypeIds: "3710,2,19,", item: nil, view: self.view) { (json, _, error) in
            
            print(json)
        }
    }
}
extension newCardAttachemnetViewController: UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if docsArray.count > 0 {
            return docsArray.count + 2
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellIdentifier = "infoCell"

        if indexPath.row == 0 {
            cellIdentifier = "infoCell"
        }else if indexPath.row > docsArray.count {
            cellIdentifier = "doneCell"
        }else{
            cellIdentifier = "browseTableViewCell"
        }
        

        return tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.reuseIdentifier == "browseTableViewCell" {
            let cell = cell as! browseTableViewCell
            
            let docItem = docsArray[indexPath.row - 1]
            cell.browseView.docItem = docItem
            cell.browseView.attachemnetTableView = self.tableView
            cell.browseView.viewController = self
            cell.browseView.extensionLabel.text  = docItem.ValidExtension
            cell.browseView.fileNameLabel.text = AppConstants.isArabic() ? docItem.DocTypeTitleAr : docItem.DocTypeTitleEn
            cell.browseView.fileTypeLabel.text = docItem.IsMany == "0" ? "[Single]" : "[Many]"
            cell.browseView.starImage.isHidden = docItem.IsMandatory == "0" ? true : false
            
            if docItem.filesArray.count > 0 {
                cell.browseView.tableView.isHidden = false
                cell.browseView.tableView.reloadData()
            }else{
                cell.browseView.tableView.isHidden = true
            }
        }else if cell.reuseIdentifier == "doneCell"{
            
            
            let doneButton = cell.viewWithTag(1) as! UIButton
            let previousButton = cell.viewWithTag(2) as! UIButton
            
            
            
            let gradient = CAGradientLayer()
            gradient.frame = doneButton.bounds
            gradient.colors = [UIColor.green]
            
            doneButton.applyGradient(colours: [AppConstants.firstBrownColor, AppConstants.secondBrownColor])
            //self.loginButton.backgroundColor = .green
            doneButton.layer.cornerRadius = 20
            doneButton.layer.masksToBounds = true
            
            
            gradient.frame = previousButton.bounds
            gradient.colors = [UIColor.green]
            
            previousButton.applyGradient(colours: [AppConstants.firstBrownColor, AppConstants.secondBrownColor])
            //self.loginButton.backgroundColor = .green
            previousButton.layer.cornerRadius = 20
            previousButton.layer.masksToBounds = true
            
            
            doneButton.addTarget(self, action: #selector(submitAction), for: .touchUpInside)
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 60
        }else if indexPath.row > docsArray.count {
            return 120
        }
        
        let docItem = docsArray[indexPath.row - 1]
        if docItem.filesArray.count > 0 {
            return CGFloat( 150 + (docItem.filesArray.count * 44))
        }else{
            return 150
        }
        
        
    }
}
