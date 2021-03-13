//
//  AssessmentCollectionViewCell.swift
//  MOCD_UAPP
//
//  Created by macbook pro on 4/14/19.
//  Copyright © 2019 haya habbous. All rights reserved.
//

import Foundation
import UIKit
import M13Checkbox

class AssessmentCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var questionNameLabel: UILabel!
    @IBOutlet var answerOneLabel: UILabel!
    @IBOutlet var answerTwoLabel: UILabel!
    @IBOutlet var answerThreeLabel: UILabel!
    @IBOutlet var aCheckBox: M13Checkbox!
    @IBOutlet var bCheckBox: M13Checkbox!
    @IBOutlet var cCheckBox: M13Checkbox!
    
    
    var questionItem: Question = Question()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
        aCheckBox.addTarget(self, action: #selector(checkboxValueChanged(_:)), for: .valueChanged)
     
        bCheckBox.addTarget(self, action: #selector(checkboxValueChanged(_:)), for: .valueChanged)
        cCheckBox.addTarget(self, action: #selector(checkboxValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func checkboxValueChanged(_ sender: M13Checkbox) {
        
        
        print(questionItem.selectedAnswer?.answer_text_en)
        if sender == aCheckBox {
            
            questionItem.selectedAnswer = questionItem.answersItem[0]
            switch sender.checkState {
            case .unchecked:
                break
            case .checked:
                bCheckBox.checkState = .unchecked
                cCheckBox.checkState = .unchecked
                break
            default:
                break
            }
        }
        if sender == bCheckBox {
            questionItem.selectedAnswer = questionItem.answersItem[1]
            switch sender.checkState {
            case .unchecked:
                break
            case .checked:
                aCheckBox.checkState = .unchecked
                cCheckBox.checkState = .unchecked
                break
            default:
                break
            }
        }
        
        if sender == cCheckBox {
            questionItem.selectedAnswer = questionItem.answersItem[2]
            switch sender.checkState {
            case .unchecked:
                break
            case .checked:
                aCheckBox.checkState = .unchecked
                bCheckBox.checkState = .unchecked
                break
            default:
                break
            }
        }
        print(questionItem.selectedAnswer?.answer_text_en)
        /*
        switch sender.checkState {
        case .unchecked:
            
        case .checked:
            cell.segmentedControl?.selectedSegmentIndex = 1
            break
        case .mixed:
            cell.segmentedControl?.selectedSegmentIndex = 2
            break
        }*/
    }
}
