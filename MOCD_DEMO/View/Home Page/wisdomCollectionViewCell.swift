//
//  wisdomCollectionViewCell.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 6/18/19.
//  Copyright © 2019 Datacellme. All rights reserved.
//

import Foundation
import UIKit



class wisdomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var detailsButton: UIButton!
    @IBOutlet var familyImageView: UIImageView!
    @IBOutlet var topImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let gradient = CAGradientLayer()
        gradient.frame = self.detailsButton.bounds
        gradient.colors = [UIColor.green]
        
        self.detailsButton.applyGradient(colours: [AppConstants.FIRST_GREEN_COLOR, AppConstants.SECOND_GREEN_COLOR])
        //self.loginButton.backgroundColor = .green
        self.detailsButton.layer.cornerRadius = self.detailsButton.frame.height / 2
        self.detailsButton.layer.masksToBounds = true
        
        
        familyImageView.layer.cornerRadius = 10
        familyImageView.layer.masksToBounds = true
        
        
        topImageView.layer.cornerRadius = 10
        topImageView.layer.masksToBounds = true
        
    }
}
