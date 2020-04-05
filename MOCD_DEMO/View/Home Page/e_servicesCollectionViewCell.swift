//
//  e_servicesCollectionViewCell.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 6/15/19.
//  Copyright © 2019 Datacellme. All rights reserved.
//

import Foundation
import UIKit



class e_servicesCollectionViewCell: UICollectionViewCell {
    

    @IBOutlet var serviceImageView: UIImageView!
    @IBOutlet var serviceLabel: UILabel!
    static func instanciateFromNib() -> e_servicesCollectionViewCell{
        return Bundle.main.loadNibNamed(String(describing: e_servicesCollectionViewCell.self), owner: self, options: nil)![0] as! e_servicesCollectionViewCell
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.addShadow(offset: CGSize(width: 0, height: 1), color: .lightGray, radius: 10, opacity: 0.6)
    }
    
    
}
