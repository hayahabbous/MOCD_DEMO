//
//  newassessmentCollectionViewCell.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 11/19/19.
//  Copyright © 2019 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import M13Checkbox

class newassessmentCollectionViewCell: UICollectionViewCell  {
    
    
    var numberhaya = 0
    let firstGreenColor = UIColor(red: 111/256 , green: 187/256, blue: 119/256, alpha: 1.0)
    let secondGreenColor = UIColor(red: 147/256 , green: 202/256, blue: 90/256, alpha: 1.0)
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var questionNameLabel: UILabel!
    @IBOutlet var answerOneLabel: UILabel!
    @IBOutlet var answerTwoLabel: UILabel!
    @IBOutlet var answerThreeLabel: UILabel!
    @IBOutlet var aCheckBox: M13Checkbox!
    @IBOutlet var bCheckBox: M13Checkbox!
    @IBOutlet var cCheckBox: M13Checkbox!
    
    @IBOutlet var submitButton: UIButton!
    
    var answerDelegate: answerQuestionnair!
    
    var questionItem: Question = Question()
    
    override func awakeFromNib() {
        super.awakeFromNib()

        imageView.layer.cornerRadius = imageView.bounds.width / 2
        imageView.layer.masksToBounds = true
        aCheckBox.addTarget(self, action: #selector(checkboxValueChanged(_:)), for: .valueChanged)
     
        bCheckBox.addTarget(self, action: #selector(checkboxValueChanged(_:)), for: .valueChanged)
        cCheckBox.addTarget(self, action: #selector(checkboxValueChanged(_:)), for: .valueChanged)
        
        
        
        self.submitButton.applyGradient(colours: [firstGreenColor, secondGreenColor])
        //self.loginButton.backgroundColor = .green
        self.submitButton.layer.cornerRadius = 20
        self.submitButton.layer.masksToBounds = true
        
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
                questionItem.selectedAnswer?.checkedString = "a"
                answerDelegate.answerQuestion(q: questionItem, answerString: "a")
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
                questionItem.selectedAnswer?.checkedString = "b"
                answerDelegate.answerQuestion(q: questionItem, answerString: "b")
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
                questionItem.selectedAnswer?.checkedString = "c"
                
                answerDelegate.answerQuestion(q: questionItem, answerString: "c")
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

