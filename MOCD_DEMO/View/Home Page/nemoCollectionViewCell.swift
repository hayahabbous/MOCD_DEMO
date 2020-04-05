//
//  nemoCollectionViewCell.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 6/15/19.
//  Copyright © 2019 Datacellme. All rights reserved.
//

import Foundation
import UIKit

import LinearProgressBar

class nemoCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var childImageView: UIImageView!
    @IBOutlet var alphaImageView: UIImageView!
    
    @IBOutlet var proceedButton: UIButton!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var progressLine: LinearProgressBar!
    @IBOutlet var progressHeight: NSLayoutConstraint!
    static func instanciateFromNib() -> nemoCollectionViewCell{
        return Bundle.main.loadNibNamed(String(describing: nemoCollectionViewCell.self), owner: self, options: nil)![0] as! nemoCollectionViewCell
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .white
       childImageView.layer.cornerRadius = 5
        childImageView.layer.masksToBounds = true
        
        alphaImageView.layer.cornerRadius = 5
        alphaImageView.layer.masksToBounds = true
        
        let gradient = CAGradientLayer()
        gradient.frame = self.proceedButton.bounds
        gradient.colors = [UIColor.green]
        
        self.proceedButton.applyGradient(colours: [AppConstants.FIRST_GREEN_COLOR, AppConstants.SECOND_GREEN_COLOR])
        //self.loginButton.backgroundColor = .green
        self.proceedButton.layer.cornerRadius = self.proceedButton.frame.height / 2
        self.proceedButton.layer.masksToBounds = true
    }
    
    
}
