//
//  taskCell.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 11/21/19.
//  Copyright © 2019 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import M13Checkbox

class taskCell: UITableViewCell {
    
    

    @IBOutlet var aCheckBox: M13Checkbox!
    @IBOutlet var bCheckBox: M13Checkbox!
    @IBOutlet var cCheckBox: M13Checkbox!
    @IBOutlet var taskLabel: UILabel!
    
    
    
    var answerObjDelegate: answerObjective!
    

    var selectedObj: Objective!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        

        
        aCheckBox.addTarget(self, action: #selector(checkboxValueChanged(_:)), for: .valueChanged)
        
        bCheckBox.addTarget(self, action: #selector(checkboxValueChanged(_:)), for: .valueChanged)
        cCheckBox.addTarget(self, action: #selector(checkboxValueChanged(_:)), for: .valueChanged)
        
    }
    
    func checkAnswers() {
        if selectedObj.result == "done" {
            aCheckBox.setCheckState(.checked, animated: true)
            
            
            bCheckBox.setCheckState(.unchecked, animated: true)
            cCheckBox.setCheckState(.unchecked, animated: true)
            
        }else if selectedObj.result == "not" {
            bCheckBox.setCheckState(.checked, animated: true)
            
            aCheckBox.setCheckState(.unchecked, animated: true)
            cCheckBox.setCheckState(.unchecked, animated: true)
            
        }else if selectedObj.result == "need" {
            cCheckBox.setCheckState(.checked, animated: true)
            
            bCheckBox.setCheckState(.unchecked, animated: true)
            aCheckBox.setCheckState(.unchecked, animated: true)
        }else{
            aCheckBox.setCheckState(.unchecked, animated: true)
            bCheckBox.setCheckState(.unchecked, animated: true)
            cCheckBox.setCheckState(.unchecked, animated: true)
                  
        }
        
        
    }
    
    
    @objc func checkboxValueChanged(_ sender: M13Checkbox) {
        
        //print(selectedTask.selectedTask)
        if sender == aCheckBox {
            
            
            switch sender.checkState {
            case .unchecked:
                break
            case .checked:
                //bCheckBox.checkState = .unchecked
                //cCheckBox.checkState = .unchecked
                selectedObj.result = "done"
                answerObjDelegate.answerObjective(o: selectedObj, answerString: "done" , cell: self)
                break
            default:
                break
            }
        }
        if sender == bCheckBox {
            
            switch sender.checkState {
            case .unchecked:
                break
            case .checked:
                //aCheckBox.checkState = .unchecked
                //cCheckBox.checkState = .unchecked
                selectedObj.result = "not"
                answerObjDelegate.answerObjective(o: selectedObj, answerString: "not" , cell: self)
                break
            default:
                break
            }
        }
        
        if sender == cCheckBox {
           
            switch sender.checkState {
            case .unchecked:
                break
            case .checked:
                //aCheckBox.checkState = .unchecked
                //bCheckBox.checkState = .unchecked
                
                
               selectedObj.result = "need"
                answerObjDelegate.answerObjective( o: selectedObj, answerString: "need" , cell: self)
                break
            default:
                break
            }
        }
        
        
        
    }
}
