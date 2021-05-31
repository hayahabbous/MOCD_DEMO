//
//  masterDocViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 7/27/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView


class masterDocViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate ,NVActivityIndicatorViewable{
    
    let nvactivity = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    var newCardItem: newCardStruct!
    var docsArray: [MOCDMasterDocument] = []
    var isRenewal: Bool = false
    
    
    
    var serviceId:  String = ""
    var serviceTypeId:  String = ""
    
    
    var requestType: String = ""
    
    var contentString: String = ""
    
    
    var requestId: String = ""
    var appReference: String = ""
    var isElderly: Bool = false
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "browseTableViewCell", bundle: nil), forCellReuseIdentifier: "browseTableViewCell")
        
        switch requestType {
        case "0":
            serviceId = AppConstants.RequestingServiceGrantRequestDEV
            serviceTypeId = AppConstants.TypeOfRequestGrantRequestDEV
            
            
        case "1":
            serviceId = AppConstants.RequestingServiceEdaadDEV
            serviceTypeId = AppConstants.TypeOfRequestEdaadDEV
            
            
        case "2":
            serviceId = AppConstants.RequestingServiceMassWeddingDEV
            serviceTypeId = AppConstants.TypeOfRequestMassWeddingDEV
        case "3":
            serviceId = AppConstants.RequestingServiceElderly
            serviceTypeId = AppConstants.TypeOfRequestMobileUnit
        case "4":
            serviceId = AppConstants.RequestingServiceElderly
            serviceTypeId = AppConstants.TypeOfRequestNursinghome
        case "5":
            serviceId = AppConstants.RequestingServiceElderly
            serviceTypeId = AppConstants.TypeOfRequestAppointmentservice
        default:
            print("")
        }
        
        getDocuments()
    }
    
    
    func getDocuments() {
        //let size = CGSize(width: 30, height: 30)
            
            
           // self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        
        WebService.GetDocumentListByServiceMaster(ServiceId: serviceId, ServiceTypeId: serviceTypeId){ (json) in
            print(json)
            DispatchQueue.main.async {
                //self.stopAnimating(nil)
                self.stopAnimating(nil)
            }
            
            guard let code = json["Code"] as? Int else {return}
            guard let ResponseTitle = json["ResponseTitle"] as? String else {return}
            guard let ResponseDescriptionEn = json["ResponseDescriptionEn"] as? String else {return}
            guard let ResponseDescriptionAr = json["ResponseDescriptionAr"] as? String else {return}
            if code == 200 {
                
                guard let content = json["Content"] as? [[String: Any]] else{return}
               
                for r in content {
                let docItem: MOCDMasterDocument = MOCDMasterDocument()
                    
                    
                    docItem.Id = String(describing: r["Id"] ?? "")
                    docItem.Name = String(describing: r["Name"] ?? "")
                    docItem.NameinArabic = String(describing: r["NameinArabic"] ?? "")
                    docItem.Typedoc = String(describing: r["Type"] ?? "")
                    docItem.FileExtension = String(describing: r["FileExtension"] ?? "")
                    
                    docItem.IsMandatory = String(describing: r["IsMandatory"] ?? "")
                    docItem.IsMany = String(describing: r["IsMany"] ?? "")
                    
                      
                    
                    
                    
                    
                    self.docsArray.append(docItem)
                    
                    
                }
                
                DispatchQueue.main.async {
                    
                    
                    if self.docsArray.count == 0 {
                        if self.isElderly {
                            self.submitElderlyRequest()
                        }else{
                            self.submitRequest()
                        }
                        
                        
                    }
                    self.tableView.reloadData()
                    //self.organizationPickerView.reloadAllComponents()
                }
            }else{
                
                
                DispatchQueue.main.async {
                                   
                    Utils.showAlertWith(title: ResponseTitle, message: AppConstants.isArabic() ? ResponseDescriptionAr : ResponseDescriptionEn, viewController: self)
                    
                }
            }

        }
    }
    
   
    
    @objc func submitAction() {
        
        var docTypeId = ""
        var allFiles: [URL] = []
        for item in docsArray {
            
            for fileItem in item.filesArray {
                docTypeId += item.Id + ","
                allFiles.append(fileItem.url)
            }
            
        }
        
        
        print(docTypeId)
        print(allFiles)
        
        let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        DispatchQueue.global(qos: .background).async {
            print("This is run on the background queue")

            for d in self.docsArray
            {
                for item in d.filesArray {
                    
                    do{
                        let fileData = try Data.init(contentsOf: item)
                        let fileStream:String = fileData.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
                        WebService.UploadDocumentByServiceRequest(ServiceRequestId: self.contentString, FileName: item.lastPathComponent, FileContent: fileStream, DocumentType: d.Typedoc, DocumentId: d.Id, FileSize: "0", FileExtenstion: "", DocumentName: d.Name) { (json) in
                            
                            
                            print(json)
                        }
                    }catch{
                        
                    }
                    
                    
                }
            }
            
            DispatchQueue.main.async {
                self.stopAnimating(nil)
                
                if self.isElderly {
                    self.submitElderlyRequest()
                }else{
                    self.submitRequest()
                }
            }
            
        }
        
        
        
        
        
    }
    
    
    func submitRequest() {
        let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        
        WebService.ServiceRequestSubmit(RequestId: self.contentString) { (json) in
            print(json)
            
            guard let Code = json["Code"] as? Int else {return}
            guard let ResponseDescriptionEn = json["ResponseDescriptionEn"] as? String else {return}
            guard let ResponseDescriptionAr = json["ResponseDescriptionAr"] as? String else {return}
            guard let ResponseTitle = json["ResponseTitle"] as? String else {return}
            
            if Code == 200 {
                DispatchQueue.main.async {
                    self.stopAnimating(nil)
                     //Utils.showAlertWith(title: ResponseTitle, message: AppConstants.isArabic() ? ResponseDescriptionAr : ResponseDescriptionEn, viewController: self)
                    self.navigationController?.dismiss(animated: true, completion: {
                        
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "openHappinessMeter"), object: nil)
                        }
                        
                    })
                }
            }else {
                DispatchQueue.main.async {
                
                    self.stopAnimating(nil)
                       Utils.showAlertWith(title: ResponseTitle, message: AppConstants.isArabic() ? ResponseDescriptionAr : ResponseDescriptionEn, viewController: self)
                   }
                   return
            }
            
            
            
        }
    }
    
    func submitElderlyRequest() {
        let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        
        WebService.SubmitElderlyRequest(RequestId: self.requestId, AppReference: self.appReference, IsUpdate: "true") { (json) in
            print(json)
            
            guard let Code = json["Code"] as? Int else {return}
            guard let ResponseDescriptionEn = json["ResponseDescriptionEn"] as? String else {return}
            guard let ResponseDescriptionAr = json["ResponseDescriptionAr"] as? String else {return}
            guard let ResponseTitle = json["ResponseTitle"] as? String else {return}
            
            if Code == 200 {
                DispatchQueue.main.async {
                    self.stopAnimating(nil)
                     //Utils.showAlertWith(title: ResponseTitle, message: AppConstants.isArabic() ? ResponseDescriptionAr : ResponseDescriptionEn, viewController: self)
                    self.navigationController?.dismiss(animated: true, completion: {
                        
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "openHappinessMeter"), object: nil)
                        }
                        
                    })
                }
            }else {
                DispatchQueue.main.async {
                
                    self.stopAnimating(nil)
                       Utils.showAlertWith(title: ResponseTitle, message: AppConstants.isArabic() ? ResponseDescriptionAr : ResponseDescriptionEn, viewController: self)
                   }
                   return
            }
            
            
            
        }
    }
}
extension masterDocViewController: UITableViewDelegate , UITableViewDataSource {
    
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
            cell.browseView.isMaster = true
            cell.browseView.docMasterItem = docItem
            cell.browseView.attachemnetTableView = self.tableView
            cell.browseView.viewController = self
            cell.browseView.extensionLabel.text  = docItem.FileExtension
            cell.browseView.fileNameLabel.text = AppConstants.isArabic() ? docItem.NameinArabic : docItem.Name
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
