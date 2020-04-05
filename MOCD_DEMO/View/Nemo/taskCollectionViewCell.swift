//
//  taskCollectionViewCell.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 3/10/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
protocol MyCellDelegate: AnyObject {
    func doneButtonTapped(cell: taskCollectionViewCell)
}

class taskCollectionViewCell: UICollectionViewCell {

    @IBOutlet var doneButton: UIButton!
    @IBOutlet var backImageWidth: NSLayoutConstraint!
    @IBOutlet var imageWidth: NSLayoutConstraint!
    @IBOutlet var backImageView: UIImageView!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailsLabel: UILabel!
    
    var taskItem: Task!
    
    var delegate: MyCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.layer.masksToBounds = true
        
        backImageView.layer.cornerRadius = backImageView.frame.height / 2
        backImageView.layer.masksToBounds = true
        
        
        doneButton.layer.cornerRadius = 5
        doneButton.layer.masksToBounds = true
        
 
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
    @IBAction func doneButtonAction(_ sender: Any) {
        
        delegate.doneButtonTapped(cell: self)
        
        
        LocalNotificationHelperT.sharedInstance.removeNotification([taskItem.taskId]) { (t) in
            
        }

    }
}
