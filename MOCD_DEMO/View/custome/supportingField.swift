//
//  supportingField.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 6/14/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import M13Checkbox

@IBDesignable
class supportingField: UIView , NibLoadable  {
    
    
    
    @IBOutlet var textLabel: UILabel!
    
    @IBOutlet var firstCheckBox: M13Checkbox!
    @IBOutlet var secondCheckBox: M13Checkbox!
    @IBOutlet var thirdCheckBox: M13Checkbox!
    @IBOutlet var fourthCheckBox: M13Checkbox!
    @IBOutlet var fifthCheckBox: M13Checkbox!
    @IBOutlet var sixthCheckBox: M13Checkbox!
    @IBOutlet var sevenCheckBox: M13Checkbox!
    
    
    @IBOutlet var firstlabel: UILabel!
    @IBOutlet var secondLabel: UILabel!
    @IBOutlet var thirdLabel: UILabel!
    @IBOutlet var fourthLabel: UILabel!
    @IBOutlet var fifthLabel: UILabel!
    @IBOutlet var sixthLabel: UILabel!
    @IBOutlet var seventhLabel: UILabel!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupFromNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromNib()
    }
}
