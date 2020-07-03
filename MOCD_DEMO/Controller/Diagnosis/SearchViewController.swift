//
//  SearchViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 3/10/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView


class SearchViewController: UIViewController {
    
    @IBOutlet var backView: UIView!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var backImageView: UIImageView!
    @IBOutlet var profileImageView: UIImageView!
    let activityData = ActivityData()
    var delegate: reloadNemowPage!
    @IBOutlet var nameLabel: UILabel!
    var childItem: ChildObject!
    var centerId: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.layer.masksToBounds = true
        
        backImageView.layer.cornerRadius = backImageView.frame.height / 2
        backImageView.layer.masksToBounds = true
        
        self.nameLabel.text = " \(childItem.firstName) \(childItem.lastName)"
        
        let string = "\(AppConstants.WEB_SERVER_IMAGE_MOCD_URL)\(childItem.child_picture )"
        let url = URL(string: string)
        self.profileImageView.kf.setImage(with: url, placeholder: UIImage(named: "profile") ?? UIImage())
        
        
        
        addButton.layer.cornerRadius = 5
        addButton.layer.masksToBounds = true
        
        
        cancelButton.layer.cornerRadius = 5
        cancelButton.layer.masksToBounds = true
        
        
        self.backView.layer.cornerRadius = 5
        self.backView.layer.masksToBounds = true
        
        
        
    }
    @IBAction func cancelButtonAction(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func dismissAction(_ sender: Any) {
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addChildButton(_ sender: Any) {
        
        
        
        
        addChildToCenter()
    }
    func addChildToCenter() {
        
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
        
        WebService.insertCenetrChild(centerId: centerId, child_id: childItem.objectID) { (json) in
            
            print(json)
            DispatchQueue.main.async {
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            }
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
                
                
                DispatchQueue.main.async {
                    
                    self.delegate.reloadNemow()
                    self.dismiss(animated: true, completion: nil)
                    Utils.showAlertWith(title: "Success", message: "you have added child successfully", style: .alert, viewController: self)
                    
                    
                    
                }
            }else {
                DispatchQueue.main.async {
                    Utils.showAlertWith(title: "Error", message: message, viewController: self)
                }
            }
        }
    }
}
