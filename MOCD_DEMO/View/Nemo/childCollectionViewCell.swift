//
//  childCollectionViewCell.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 6/17/19.
//  Copyright © 2019 Datacellme. All rights reserved.
//

import Foundation
import UIKit



class childCollectionViewCell: UICollectionViewCell {
    
  
    @IBOutlet var backView: UIView!
    @IBOutlet var circularImageView: UIImageView!
    @IBOutlet var childImageView: UIImageView!
    @IBOutlet var backStatusView: UIView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var healthLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.addShadow(offset: CGSize(width: 0, height: 2), color: .lightGray, radius: 10, opacity: 0.9)
        backView.layer.cornerRadius = 10
        backView.layer.masksToBounds = true
        
        
        backStatusView.layer.cornerRadius = 3
        backStatusView.layer.masksToBounds = true
        
        
        childImageView.layer.cornerRadius = childImageView.frame.height / 2
        childImageView.layer.masksToBounds = true
        
        
        circularImageView.layer.cornerRadius = circularImageView.frame.height / 2
        circularImageView.layer.masksToBounds = true
        
        healthLabel.layer.cornerRadius = 3
        healthLabel.layer.masksToBounds = true
        
        
        
    }
}
class addchildCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var backView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.addShadow(offset: CGSize(width: 0, height: 2), color: .lightGray, radius: 10, opacity: 0.9)
        backView.layer.cornerRadius = 10
        backView.layer.masksToBounds = true
        
        
        
        
        
    }
}
