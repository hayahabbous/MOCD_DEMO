//
//  cn1.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 11/26/19.
//  Copyright © 2019 Datacellme. All rights reserved.
//

import Foundation
//
//  childNotificationCollectionViewCell.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 6/16/19.
//  Copyright © 2019 Datacellme. All rights reserved.
//

import Foundation
import UIKit




class cn1: UICollectionViewCell {

    @IBOutlet var backImageWidth: NSLayoutConstraint!
    @IBOutlet var imageWidth: NSLayoutConstraint!
    @IBOutlet var backImageView: UIImageView!
    @IBOutlet var profileImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.layer.masksToBounds = true
        
        backImageView.layer.cornerRadius = backImageView.frame.height / 2
        backImageView.layer.masksToBounds = true
        
        
        
        
 
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
}
