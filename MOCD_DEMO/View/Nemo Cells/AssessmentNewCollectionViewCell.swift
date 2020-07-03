//
//  AssessmentNewCollectionViewCell.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 2/1/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit



class AssessmentNewCollectionViewCell: UICollectionViewCell  {
    
    
    var questionItem: Question = Question()
    var isYesSelected = false
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var yesButton: UIButton!
    @IBOutlet var noButton: UIButton!
    
    var collectionView: UICollectionView!
    
    var delegate: visibleCells!
    
    var index: IndexPath!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        yesButton.layer.cornerRadius = yesButton.frame.height / 2
        yesButton.layer.masksToBounds = true
        
        
        
        noButton.layer.cornerRadius = noButton.frame.height / 2
        noButton.layer.masksToBounds = true
        
            
        setButtons()
     
    

    }
    func setButtons() {
        noButton.backgroundColor = .lightGray
        yesButton.backgroundColor = .lightGray
        
        
        
        
        
    }
    
    
    func checkAnswer() {
        
        
        yesButton.setTitle(AppConstants.isArabic() ? questionItem.answersItem[0].answer_text_ar : questionItem.answersItem[0].answer_text_en, for: .normal)
        
        
        noButton.setTitle(AppConstants.isArabic() ? questionItem.answersItem[1].answer_text_ar : questionItem.answersItem[1].answer_text_en, for: .normal)
        if questionItem.selectedAnswer != nil {
            
            //yes
            if questionItem.selectedAnswer?.answer_id == questionItem.answersItem[0].answer_id {
                
                
                yesButton.backgroundColor = AppConstants.BROWN_COLOR
                noButton.backgroundColor = .lightGray
                
                
                yesButton.setTitleColor(.white, for: .normal)
                noButton.setTitleColor(.black, for: .normal)
                
                isYesSelected = true
                
            }else if questionItem.selectedAnswer?.answer_id == questionItem.answersItem[1].answer_id {
                
                noButton.backgroundColor = AppConstants.BROWN_COLOR
                yesButton.backgroundColor = .lightGray
                
                
                
                yesButton.setTitleColor(.black, for: .normal)
                noButton.setTitleColor(.white, for: .normal)
                isYesSelected = false
            }
        }else{
            setButtons()
        }
        
    }
    @IBAction func yesAction(_ sender: Any) {
        
        yesButton.backgroundColor = AppConstants.BROWN_COLOR
        noButton.backgroundColor = .lightGray
        
        
        yesButton.setTitleColor(.white, for: .normal)
        noButton.setTitleColor(.black, for: .normal)
        
        
        questionItem.selectedAnswer = questionItem.answersItem[0]
        self.delegate.changequestionState(index: index)
        isYesSelected = true
        
        
    }
    
    @IBAction func noAction(_ sender: Any) {
        
        noButton.backgroundColor = AppConstants.BROWN_COLOR
        yesButton.backgroundColor = .lightGray
        
        
        
        yesButton.setTitleColor(.black, for: .normal)
        noButton.setTitleColor(.white, for: .normal)
        questionItem.selectedAnswer = questionItem.answersItem[1]
        
        
        self.delegate.changequestionState(index: index)
        isYesSelected = false
        
        
    }
    
}
