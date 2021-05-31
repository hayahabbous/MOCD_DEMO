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


class newCardAttachemnetViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate ,NVActivityIndicatorViewable{
    
    let nvactivity = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    var newCardItem: newCardStruct = newCardStruct()
    var docsArray: [MOCDDocument] = []
    var isRenewal: Bool = false
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "browseTableViewCell", bundle: nil), forCellReuseIdentifier: "browseTableViewCell")
        
        getDocuments()
    }
    
    
    func checkIfRenewal() {
        
        
        if isRenewal {
           
            
            for r in newCardItem.allFiles {
                guard let docItem = docsArray.filter({ (f) -> Bool in
                    f.ServiceDocTypeId == r.ServiceDocTypeId
                }).first else {
                    continue
                }
                
                if docItem.IsMany == "1"{
                    
                    docItem.filesArray.append(r.documentURL!)
                    
                }else{
                    docItem.filesArray = [r.documentURL!]
                }
                
            }
            
        }
    }
    
    func getDocuments() {
        let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        
        if isRenewal{
            WebService.RetrieveRenewDisabledCardDocumentTypes { (json) in
                print(json)
                DispatchQueue.main.async {
                    self.stopAnimating(nil)
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
                        
                        self.checkIfRenewal()
                        self.tableView.reloadData()
                        //self.organizationPickerView.reloadAllComponents()
                    }
                }else{
                    
                    
                    DispatchQueue.main.async {
                                       
                        Utils.showAlertWith(title: "Error", message: message, viewController: self)
                        
                    }
                }

            }
        }else{
            WebService.RetrieveNewDisabledCardDocumentTypes { (json) in
                print(json)
                DispatchQueue.main.async {
                    self.stopAnimating(nil)
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
        
        
    }
    
   
    
    @objc func submitAction() {
        
        
        var mocd_user = MOCDUser.getMOCDUser()
        var docTypeId = ""
        var allFiles: [URL] = []
        for item in docsArray {
            
            for fileItem in item.filesArray {
                docTypeId += item.ServiceDocTypeId + ","
                allFiles.append(fileItem.url)
            }
            
        }
        
        
        print(docTypeId)
        print(allFiles)
        if isRenewal {
            
            
            let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
            disabledCardRequests.CreateRenewDisabledCardRequest_ByObject(ApplicantTypeId: self.newCardItem.ApplicantTypeId ,NationalityId: newCardItem.NationalityId, IdentificationNo: newCardItem.IdentificationNo, UID: newCardItem.UID, FirstNameAR: newCardItem.FirstNameAR, FatherNameAR: newCardItem.FatherNameAR, GrandfatherNameAR: newCardItem.GrandfatherNameAR, FamilyNameAR: newCardItem.FamilyNameAR, FirstNameEN: newCardItem.FirstNameEN, FatherNameEN: newCardItem.FatherNameEN, GrandfatherNameEN: newCardItem.GrandfatherNameEN, FamilyNameEN: newCardItem.FamilyNameEN, GenderId: newCardItem.GenderId, DateOfBirth: newCardItem.DateOfBirth, IsStudent: newCardItem.IsStudent, MaritalStatusId: newCardItem.MaritalStatusId, AccommodationTypeId: newCardItem.AccommodationTypeId, Address: newCardItem.Address, EmirateId: newCardItem.EmirateId, POBox: newCardItem.POBox, MobileNo: newCardItem.MobileNo, OtherMobileNo: newCardItem.OtherMobileNo, PhoneNo: newCardItem.PhoneNo, Email: newCardItem.Email, MakaniNo: newCardItem.MakaniNo, XCoord: newCardItem.XCoord, YCoord: newCardItem.YCoord, DiagnosisAuthorityId: newCardItem.DiagnosisAuthorityId, DiagnosisInformation: newCardItem.DiagnosisInformation, DisabilityTypeId: newCardItem.DisabilityTypeId, DisabilityLevelId: newCardItem.DisabilityLevelId, SupportingEquipment: newCardItem.SupportingEquipment, NeedSupporter: newCardItem.NeedSupporter, CanLiveAlone: newCardItem.CanLiveAlone, ReportIssuedBy: newCardItem.ReportIssuedBy, Speciality: newCardItem.Speciality, ReportDate: newCardItem.ReportDate,OrganizationId: self.newCardItem.OrganizationId , ResidenceExpiryDate: self.newCardItem.ResidenceExpiryDate ,WorkingStatusId: self.newCardItem.WorkingStatusId , WorkFieldId: self.newCardItem.WorkFieldId,Company: self.newCardItem.WorkingStatusId , InstitutionId: self.newCardItem.InstitutionId , CenterId: self.newCardItem.CenterId, SecurityToken: newCardItem.SecurityToken, UserId: mocd_user?.UserId ?? "",DisabledCardNo: self.newCardItem.disabledCardNumber , cardIssueDate: self.newCardItem.cardIssueDate , cardExpiryDate: self.newCardItem.cardExpiryDate, ServiceDocTypeIds: docTypeId,filesArray:allFiles, item: nil, view: self.view) { (json, _, error) in
                           
                          
                print(json)
                           
                
                DispatchQueue.main.async {
                
                    self.stopAnimating(nil)
                 
                }
                guard let code = json["code"] as? Int else {return}
                
                let message = json["message"] as? String ?? ""
                
                if code == 10 {
                
                    self.navigationController?.dismiss(animated: true) {
                    
                        DispatchQueue.main.async {
                            Utils.showAlertWith(title: "Success", message: message, viewController: self)
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "openHappinessMeter"), object: nil)
                        }
                        
                    }
                    
                }else{
                
                    Utils.showAlertWith(title: "Error", message: message, viewController: self)
                        
                }
            }
            
        }else{
            let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
            

            servicesRequest.CreateDisabledCardRequest_ByObject(ApplicantTypeId: self.newCardItem.ApplicantTypeId, NationalityId: newCardItem.NationalityId, IdentificationNo: newCardItem.IdentificationNo, UID: newCardItem.UID, FirstNameAR: newCardItem.FirstNameAR, FatherNameAR: newCardItem.FatherNameAR, GrandfatherNameAR: newCardItem.GrandfatherNameAR, FamilyNameAR: newCardItem.FamilyNameAR, FirstNameEN: newCardItem.FirstNameEN, FatherNameEN: newCardItem.FatherNameEN, GrandfatherNameEN: newCardItem.GrandfatherNameEN, FamilyNameEN: newCardItem.FamilyNameEN, GenderId: newCardItem.GenderId, DateOfBirth: newCardItem.DateOfBirth, IsStudent: newCardItem.IsStudent, MaritalStatusId: newCardItem.MaritalStatusId, AccommodationTypeId: newCardItem.AccommodationTypeId, Address: newCardItem.Address, EmirateId: newCardItem.EmirateId, POBox: newCardItem.POBox, MobileNo: newCardItem.MobileNo, OtherMobileNo: newCardItem.OtherMobileNo, PhoneNo: newCardItem.PhoneNo, Email: newCardItem.Email, MakaniNo: newCardItem.MakaniNo, XCoord: newCardItem.XCoord, YCoord: newCardItem.YCoord, DiagnosisAuthorityId: newCardItem.DiagnosisAuthorityId, DiagnosisInformation: newCardItem.DiagnosisInformation, DisabilityTypeId: newCardItem.DisabilityTypeId, DisabilityLevelId: newCardItem.DisabilityLevelId, SupportingEquipment: newCardItem.SupportingEquipment, NeedSupporter: newCardItem.NeedSupporter, CanLiveAlone: newCardItem.CanLiveAlone, ReportIssuedBy: newCardItem.ReportIssuedBy, Speciality: newCardItem.Speciality, ReportDate: newCardItem.ReportDate,OrganizationId: self.newCardItem.OrganizationId , ResidenceExpiryDate: self.newCardItem.ResidenceExpiryDate ,WorkingStatusId: self.newCardItem.WorkingStatusId , WorkFieldId: self.newCardItem.WorkFieldId,Company: self.newCardItem.WorkingStatusId , InstitutionId: self.newCardItem.InstitutionId , CenterId: self.newCardItem.CenterId, SecurityToken:  newCardItem.SecurityToken, UserId: mocd_user?.UserId ?? "", ServiceDocTypeIds: docTypeId,filesArray:allFiles, item: nil, view: self.view) { (json, _, error) in
                
                print(json)
                
                DispatchQueue.main.async {
                    self.stopAnimating(nil)
                    
                    
                }
                
                guard let code = json["code"] as? Int else {return}
                let message = json["message"] as? String ?? ""
                if code == 10 {
                    self.navigationController?.dismiss(animated: true) {
                        DispatchQueue.main.async {
                            Utils.showAlertWith(title: "Success", message: message, viewController: self)
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "openHappinessMeter"), object: nil)
                        }
                    }
                }else{
                    Utils.showAlertWith(title: "Error".localize, message: message, viewController: self)
                }
                
            }
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
