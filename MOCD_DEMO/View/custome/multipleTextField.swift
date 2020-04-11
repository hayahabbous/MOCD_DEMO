//
//  multipleTextField.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 2/25/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import M13Checkbox

@IBDesignable
class multipleTextField: UIView , NibLoadable{
    
    

    @IBOutlet var secondLabel: UILabel!
    @IBOutlet var firstLabel: UILabel!
    override  func awakeFromNib() {
        super.awakeFromNib()
        
        
        firstCheckBox.checkState = .checked
        firstCheckBox.addTarget(self, action: #selector(didSelectCheckBox), for: .valueChanged)
        secondCheckBox.addTarget(self, action: #selector(didSelectCheckBox), for: .valueChanged)
        
        
        
    }
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet var firstCheckBox: M13Checkbox!
    
    @IBOutlet var secondCheckBox: M13Checkbox!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupFromNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromNib()
    }
    
    
    @objc func didSelectCheckBox(sender: M13Checkbox) {
        
        
        if sender == firstCheckBox {
            switch firstCheckBox.checkState {
            case .checked:
                secondCheckBox.setCheckState(.unchecked, animated: true)
            case .unchecked:
                secondCheckBox.setCheckState(.checked, animated: true)
            case .mixed:
                print("Mixed")
            
            }
        }
        
        
        if sender == secondCheckBox {
            switch secondCheckBox.checkState {
            case .checked:
                firstCheckBox.setCheckState(.unchecked, animated: true)
            case .unchecked:
                firstCheckBox.setCheckState(.checked, animated: true)
            case .mixed:
                print("Mixed")
            
            }
        }
        
       
        /*
        if sender == firstCheckBox {
            if(firstCheckBox.checkState == .checked) {
                firstCheckBox.checkState = .unchecked
                secondCheckBox.checkState = .checked
                
            }else{
                firstCheckBox.checkState = .checked
                secondCheckBox.checkState = .unchecked
            }
        }
        
        if sender == secondCheckBox {
            if(secondCheckBox.checkState == .checked) {
                secondCheckBox.checkState = .unchecked
                firstCheckBox.checkState = .checked
                
            }else{
                secondCheckBox.checkState = .checked
                firstCheckBox.checkState = .unchecked
            }
        }*/
        
    }
    
    
}
