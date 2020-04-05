//
//  selectTextField.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 2/25/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation

@IBDesignable
class selectTextField: UIView , NibLoadable{
    
    

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var textLabel: UILabel!
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupFromNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromNib()
    }
}
