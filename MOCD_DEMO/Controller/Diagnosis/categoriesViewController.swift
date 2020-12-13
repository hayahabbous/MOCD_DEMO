//
//  categoriesViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 6/19/19.
//  Copyright © 2019 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import AnimatedCollectionViewLayout
import NVActivityIndicatorView
import M13Checkbox


class categoriesViewController: UIViewController ,NVActivityIndicatorViewable{
    
    
    
    @IBOutlet var titleLabel: UILabel!
    var selectedChild: ChildObject = ChildObject()
    var selectedSurvey: MOCDSurvey = MOCDSurvey()
    var questions:[Question] = []
    let nvactivity = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    @IBOutlet var collectionViewHeight: NSLayoutConstraint!
    var qDelegate: quetionnairDelegate!
    var animator: (LayoutAttributesAnimator, Bool, Int, Int)?
    @IBOutlet var collectionView: UICollectionView!
    
    
    
    var aCheckBox: M13Checkbox!
    var bCheckBox: M13Checkbox!
    var cCheckBox: M13Checkbox!
    
    var questionItem: Question = Question()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionViewHeight.constant = self.view.bounds.height - 30
        animator = (LinearCardAttributesAnimator(), false, 1, 1)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView?.isPagingEnabled = true
        
        let layout = AnimatedCollectionViewLayout()
        layout.animator = LinearCardAttributesAnimator()
        collectionView.collectionViewLayout = layout
        layout.scrollDirection = .horizontal
        
        self.collectionView.register(UINib(nibName: "newAssessmentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "newAssessmentCollectionViewCell")
        
        collectionView.reloadData()
        
        getQuestionList()
    }
    func getQuestionList () {
        let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        
        WebService.getQuestions(surveyId: self.selectedSurvey.survey_id) { (json) in
            print(json)
            
            DispatchQueue.main.async {
                self.stopAnimating(nil)
            }
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
                guard let data = json["data"] as? [String: Any] else{return}
                guard let result = data["result"] as? [[String: Any]] else {return}
                
                //self.userAnwersArray = [[:]]
                for r in result {
                    
                
                    let questionItem = Question()
                    questionItem.question_id = r["id"] as? String ?? ""
                    questionItem.quest_text_ar = r["quest_text_ar"] as? String ?? ""
                    questionItem.quest_text_en = r["quest_text_en"] as? String ?? ""
                    
                    
                    let answersArray = r["Answers"] as! [[String:Any]]
                    
                    var answersItemsArray: [Answer] = []
                    var user_answer:[String:String]=[:]
                    for a in answersArray {
                        let answerItem: Answer = Answer()
                        
                        answerItem.answer_id = a["id"] as? String ?? ""
                        answerItem.answer_text_ar = a["answer_text_ar"] as? String ?? ""
                        answerItem.answer_text_en = a["answer_text_en"] as? String ?? ""
                        
                        
                        answersItemsArray.append(answerItem)
                        
                    }
                    
                    questionItem.answersItem = answersItemsArray
                    
                    self.questions.append(questionItem)
                    
                    //create user answers
                    user_answer["answer_id"] = ""
                    user_answer["question_id"] = questionItem.question_id
                    
                    
                    //self.userAnwersArray.append(user_answer)
                    
                    
                }
                
                //self.selectedSurvey.questions = self.questions
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    if self.collectionView.numberOfItems(inSection: 0) > 0  {
                        self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: false)
                    }
                    
                }
            }else{
                DispatchQueue.main.async {
                    Utils.showAlertWith(title: "Error", message: message, viewController: self)
                }
            }
        }
    }
    @objc func submitAnswers() {
        
        guard questions.filter({ (q) -> Bool in
            q.selectedAnswer?.answer_id == nil
        }).first == nil else {
            Utils.showErrorMessage("answer all survey", withTitle: "missing answers", andInViewController: self)
            return 
        }
        
        var parametersArray =  NSMutableArray()
        
        for q in questions {
            
            let dic: NSMutableDictionary = NSMutableDictionary()
            
            dic.setValue("\(q.selectedAnswer?.answer_id ?? "")", forKey: "answer_id")
            dic.setValue("\(q.question_id)", forKey: "question_id")
            
            
            
            parametersArray.add(dic)
        }
        
         let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        WebService.submitAnswers(survey_id:self.selectedSurvey.survey_id , child_id: self.selectedChild.objectID, answers: parametersArray) { (json) in
            print(json)
            
            DispatchQueue.main.async {
                self.stopAnimating(nil)
            }
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
                
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }else{
                DispatchQueue.main.async {
                    Utils.showAlertWith(title: "Error", message: message, viewController: self)
                }
            }
        }
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
extension categoriesViewController: UICollectionViewDelegate,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    //MARK: - CollectionView
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return questions.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newAssessmentCollectionViewCell", for: indexPath) as! newassessmentCollectionViewCell
        
        let view = cell.viewWithTag(2)
        
        
        
        
        
    
        cell.answerDelegate = self
        cell.submitButton.addTarget(self, action: #selector(submitAnswers), for: .touchUpInside)
        
        if indexPath.row  == questions.count - 1 {
            cell.submitButton.isHidden = false
        }else{
            cell.submitButton.isHidden = true
        }
        let q = questions[indexPath.row]
        
        cell.questionNameLabel.text = AppConstants.isArabic() ?  q.quest_text_ar :  q.quest_text_en
        cell.questionItem = q
        
        
        print(q.selectedAnswer?.checkedString)
        
        if q.selectedAnswer?.checkedString == "a" {
            cell.aCheckBox.setCheckState(.checked, animated: true)
        }else{
            cell.aCheckBox.setCheckState(.unchecked, animated: true)
        }
        
        if q.selectedAnswer?.checkedString == "b" {
            cell.bCheckBox.setCheckState(.checked, animated: true)
        }else{
            cell.bCheckBox.setCheckState(.unchecked, animated: true)
        }
        
        
        if q.selectedAnswer?.checkedString == "c" {
            cell.cCheckBox.setCheckState(.checked, animated: true) 
        }else{
            cell.cCheckBox.setCheckState(.unchecked, animated: true)
        }
        
        self.questions[indexPath.row] = q
        
    
        view?.backgroundColor = .white
        view?.layer.cornerRadius = 10
        view?.layer.borderWidth = 0.5
        view?.layer.borderColor = UIColor.lightGray.cgColor
        view?.layer.masksToBounds = true
        cell.addShadow(offset: CGSize(width: 0, height: 1), color: .lightGray, radius: 10, opacity: 0.9)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        /*
        self.dismiss(animated: true) {
            self.qDelegate.openQuestionnair()
        }*/
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        
        //self.titleLabel.text = "\(selectedSurvey.aspect_title_en):  \(indexPath.row + 1) / \(questions.count) "
    
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let animator = animator else { return view.bounds.size }
        return CGSize(width: collectionView.bounds.width - 10 , height: collectionView.bounds.height )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension categoriesViewController: answerQuestionnair {
    
    
    func answerQuestion(q: Question , answerString: String) -> Question {
        
        self.submitAnswers()
        q.selectedAnswer?.checkedString = answerString
        
        var question = questions.filter { (qObject) -> Bool in
            qObject.question_id == q.question_id
        }.first
        
        question = q
        return q
    }
    
    
}
