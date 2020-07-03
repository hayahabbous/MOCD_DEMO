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
class browseTextField: UIView , NibLoadable , UIDocumentPickerDelegate {
    
    
    @IBOutlet var browseButton: UIButton!
    @IBOutlet var fileTypeLabel: UILabel!
    @IBOutlet var fileNameLabel: UILabel!
    @IBOutlet var starImage: UIImageView!
    @IBOutlet var extensionLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var attachemnetTableView: UITableView!
    var docItem: MOCDDocument?
    
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
        
        let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypeText),String(kUTTypeContent),String(kUTTypeItem),String(kUTTypeData),String(kUTTypePDF) , String(kUTTypeImage)], in: .import)
        documentPicker.delegate = self
        
        self.viewController.present(documentPicker, animated: true) {
            
            if self.docItem?.IsMany == "1" {
                documentPicker.allowsMultipleSelection = true
            }
            
        }
    }
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print(urls)
        
        docItem?.filesArray = urls
        self.tableView.reloadData()
        attachemnetTableView.reloadData()
    }
}
extension browseTextField: UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if docItem?.filesArray.count ?? 0 > 0 {
            return docItem?.filesArray.count  ?? 0
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
            if docItem?.filesArray.count ?? 0 > 0 {
                cell.fileLabel.text = String(describing: docItem?.filesArray[indexPath.row])
            }else{
                cell.fileLabel.text = ""
            }
            
        }
    }
}
class fileCell: UITableViewCell {
    @IBOutlet var fileLabel: UILabel!
    @IBOutlet var deleteButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
