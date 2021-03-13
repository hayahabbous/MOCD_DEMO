//
//  servicesCollectionView.swift
//  MOCD
//
//  Created by haya habbous on 6/1/18.
//  Copyright © 2018 haya habbous. All rights reserved.
//

import Foundation
import UIKit
import UICircularProgressRing
import LinearProgressBar

class servicesCollectionView: UICollectionViewCell {
    
   
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var alphaImageView: UIImageView!
    @IBOutlet var appTitle: UILabel!
    @IBOutlet var appdescription: UILabel!
    @IBOutlet var circularProgress: UICircularProgressRing!
    
    
    @IBOutlet var backSmallImageView: UIImageView!
    
    @IBOutlet var firstLinerProgressLabel: UILabel!
    @IBOutlet var firstValueProgressLabel: UILabel!
    @IBOutlet var secondLinerProgressLabel: UILabel!
    
    @IBOutlet var smallIconImageView: UIImageView!
    @IBOutlet var secondValueProgressLabel: UILabel!
    
    @IBOutlet var firstProgressLine: LinearProgressBar!
    
    @IBOutlet var secondProgressLine: LinearProgressBar!
    
    
    
    
    static func instanciateFromNib() -> servicesCollectionView{
        return Bundle.main.loadNibNamed(String(describing: servicesCollectionView.self), owner: self, options: nil)![0] as! servicesCollectionView
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 10
       
       backSmallImageView.layer.cornerRadius = 5
        smallIconImageView.layer.cornerRadius = 5
        backSmallImageView.layer.masksToBounds = true
        smallIconImageView.layer.masksToBounds = true
    }
    
    
}
