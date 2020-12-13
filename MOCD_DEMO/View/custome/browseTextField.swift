//
//  browseTextField.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 6/2/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices


@IBDesignable
class browseTextField: UIView , NibLoadable , UIDocumentPickerDelegate  , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    @IBOutlet var browseButton: UIButton!
    @IBOutlet var fileTypeLabel: UILabel!
    @IBOutlet var fileNameLabel: UILabel!
    @IBOutlet var starImage: UIImageView!
    @IBOutlet var extensionLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var attachemnetTableView: UITableView!
    var docItem: MOCDDocument?
    var docMasterItem: MOCDMasterDocument?
    
    
    var isMaster: Bool = false
    
    
    var viewController: UIViewController!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupFromNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromNib()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        browseButton.layer.cornerRadius = 15
        browseButton.layer.masksToBounds = true
        
        //tableView.isHidden = false
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(fileCell.self, forCellReuseIdentifier: "fileCell")
        tableView.register(UINib(nibName: "fileCell", bundle: nil), forCellReuseIdentifier: "fileCell")
        
    }
    @IBAction func browseButtonAction(_ sender: Any) {
        
        
        showAttachmentPhotos()
        
    }
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print(urls)
        
        if !isMaster {
            if docItem?.IsMany == "1"{
                
                for i in urls
                {
                    docItem?.filesArray.append(i)
                }
                
            }else{
                docItem?.filesArray = urls
            }
        }else{
            if docMasterItem?.IsMany == "1"{
                
                for i in urls
                {
                    docMasterItem?.filesArray.append(i)
                }
                
            }else{
                docMasterItem?.filesArray = urls
            }
        }
        
        
        self.tableView.reloadData()
        attachemnetTableView.reloadData()
    }
    
    @objc func showAttachmentPhotos() {
           
           
           let actionSheet = UIAlertController(title: "", message: NSLocalizedString("choose a resource" ,comment: ""), preferredStyle: .actionSheet)
           
           
           
           actionSheet.addAction(UIAlertAction(title: NSLocalizedString("gallery" ,comment: ""), style: .default, handler: { (action) -> Void in
               self.photoLibrary()
           }))
           actionSheet.addAction(UIAlertAction(title: NSLocalizedString("documents" ,comment: ""), style: .default, handler: { (action) -> Void in
               self.openDocuments()
           }))
        
           
           
           actionSheet.addAction(UIAlertAction(title: NSLocalizedString("Cancel" ,comment: ""), style: .cancel, handler: { (action) -> Void in
               //self.photoLibrary()
           }))
           
        self.viewController.present(actionSheet, animated: true, completion: nil)
       }
       
       //MARK: - CAMERA PICKER
       //This function is used to open camera from the iphone and
       func openCamera(){
           if UIImagePickerController.isSourceTypeAvailable(.camera){
               let myPickerController = UIImagePickerController()
               myPickerController.delegate = self
               myPickerController.sourceType = .camera
            self.viewController.present(myPickerController, animated: true, completion: nil)
           }
       }
       
       
       //MARK: - PHOTO PICKER
       func photoLibrary(){
           if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
               let myPickerController = UIImagePickerController()
               myPickerController.delegate = self
               myPickerController.sourceType = .photoLibrary
            self.viewController.present(myPickerController, animated: true, completion: nil)
           }
       }
    
    func openDocuments() {
        let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypeText),String(kUTTypeContent),String(kUTTypeItem),String(kUTTypeData),String(kUTTypePDF) , String(kUTTypeImage)], in: .import)
        documentPicker.delegate = self
        
        self.viewController.present(documentPicker, animated: true) {
            
            if !self.isMaster {
                if self.docItem?.IsMany == "1" {
                    documentPicker.allowsMultipleSelection = true
                }
            }else{
                if self.docMasterItem?.IsMany == "1" {
                    documentPicker.allowsMultipleSelection = true
                }
            }
            
            
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(info)
        
        
        var filename = ""
        let uuid = UUID().uuidString
        filename = uuid + ".jpg"
        let Mediatype = info[UIImagePickerController.InfoKey.mediaType] as? String
        let imageData = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        let imageJpegData = imageData!.jpegData(compressionQuality: 0.7)
        let documentPath = FileHelper.documentsPathForImages(filename: filename) // get the file path
        
        
        do {
            try imageJpegData?.write(to: URL(fileURLWithPath: documentPath),options: .atomic)
            let data = FileManager.default.contents(atPath: documentPath)
            
            
            if !isMaster {
                if docItem?.IsMany == "1"{
                    
                    docItem?.filesArray.append(URL(fileURLWithPath: documentPath))
                    
                }else{
                    docItem?.filesArray = [URL(fileURLWithPath: documentPath)]
                }
            }else{
                if docMasterItem?.IsMany == "1"{
                    
                    docMasterItem?.filesArray.append(URL(fileURLWithPath: documentPath))
                    
                }else{
                    docMasterItem?.filesArray = [URL(fileURLWithPath: documentPath)]
                }
            }
            
            
            
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.attachemnetTableView.reloadData()
                
                 picker.dismiss(animated: true, completion: nil)
            }
            /*
            let image = UIImage(data: data!)
            mimetype = FileHelper.mimeTypeForPath(path: documentPath)
            
            
            let galleryItem = Gallery()
            galleryItem.type = mimetype
            galleryItem.path = documentPath
            galleryItem.name = filename
            galleryItem.image = imageData ?? #imageLiteral(resourceName: "profile")
            photosArray.add(galleryItem)
 
 */
        }
        catch {
            print("error saving file : \(error)")
            return
        }
    }
}
extension browseTextField: UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if !isMaster {
            if docItem?.filesArray.count ?? 0 > 0 {
                return docItem?.filesArray.count  ?? 0
            }
        }else{
            if docMasterItem?.filesArray.count ?? 0 > 0 {
                return docMasterItem?.filesArray.count  ?? 0
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "fileCell", for: indexPath) as! fileCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.reuseIdentifier == "fileCell" {
            let cell = cell as! fileCell
            
            cell.deleteButton.addTarget(self, action: #selector(deleteFile(sender:)), for: .touchUpInside)
            
            if !isMaster {
                guard let docItem = docItem else {
                    cell.fileLabel.text = ""
                    
                    return
                }
                if docItem.filesArray.count > 0 {
                    cell.fileLabel.text = String(describing: docItem.filesArray[indexPath.row].lastPathComponent)
                }else{
                    cell.fileLabel.text = ""
                }
            }else{
                guard let docItem = docMasterItem else {
                    cell.fileLabel.text = ""
                    
                    return
                }
                if docItem.filesArray.count > 0 {
                    cell.fileLabel.text = String(describing: docItem.filesArray[indexPath.row].lastPathComponent)
                }else{
                    cell.fileLabel.text = ""
                }
            }
            
            
        }
    }
    
    
    @objc func deleteFile(sender: UIButton) {
        guard let cell = sender.superview?.superview as? fileCell else {
            return // or fatalError() or whatever
        }
        guard let indexPath = tableView.indexPath(for: cell) else {return }
        docItem?.filesArray.remove(at: indexPath.row)
        self.tableView.reloadData()
        
    }
}
class fileCell: UITableViewCell {
    @IBOutlet var fileLabel: UILabel!
    @IBOutlet var deleteButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
