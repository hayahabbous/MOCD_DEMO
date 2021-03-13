//
//  AssessmentViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 6/19/19.
//  Copyright © 2019 Datacellme. All rights reserved.
//

import Foundation
import UIKit

import NVActivityIndicatorView



protocol visibleCells {
    func changequestionState(index: IndexPath)
}
class AssessmentViewController: UIViewController ,visibleCells ,NVActivityIndicatorViewable{
    func changequestionState(index: IndexPath) {
        
        
        if index.item <= questions.count - 2 {
            questions[index.item + 1].isVisible = true
            
            
            let indexnew = IndexPath(row: index.item + 1, section: 0)
            let indexnew2 = IndexPath(row: index.item + 2, section: 0)
            self.collectionView.reloadItems(at: [indexnew,indexnew2])
            
            
        }
        
        submitAnswers()
    
    }
    var delegate: answerAssessment!
    let firstGreenColor = UIColor(red: 111/256 , green: 187/256, blue: 119/256, alpha: 1.0)
    let secondGreenColor = UIColor(red: 147/256 , green: 202/256, blue: 90/256, alpha: 1.0)
    let nvactivity = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    var questions:[Question] = []
    var aspectValue = ""
    var selectedChild: ChildObject = ChildObject()
    var selectedSurvey: MOCDSurvey = MOCDSurvey()
    @IBOutlet var collectionView: UICollectionView!
    
    var childItem: ChildObject = ChildObject()
    
    
    var userAnwersArray: [[String:String]] = [[:]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = childItem.firstName
        
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.register(UINib(nibName: "AssessmentNewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AssessmentNewCollectionViewCell")
        
        getQuestionList()
        
        getAssessmentForAspectAndMonth()
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
                    
                    
                    questionItem.isVisible = false
                    self.questions.append(questionItem)
                    
                    //create user answers
                    user_answer["answer_id"] = ""
                    user_answer["question_id"] = questionItem.question_id
                    
                    
                    //self.userAnwersArray.append(user_answer)
                    
                    
                }
                
                //self.selectedSurvey.questions = self.questions
                DispatchQueue.main.async {
                    
                    self.questions[0].isVisible = true
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
            //Utils.showErrorMessage("answer all survey", withTitle: "missing answers", andInViewController: self)
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
                    
                    
                    self.delegate.reloadChild()
                    //self.delegate.showPopup()
                    self.delegate.changeIsOpenAssessment()
                }
            }else{
                DispatchQueue.main.async {
                    Utils.showAlertWith(title: "Error", message: message, viewController: self)
                }
            }
        }
    }
    func getAssessmentForAspectAndMonth() {
        /*
        let size = CGSize(width: 30, height: 30)
            
            
            self.startAnimating(size, message: "Loading ...", messageFont: nil, type: .ballBeat)
        let qQuery: PFQuery = PFQuery(className: "Question")
        //qQuery.whereKey("q_age", equalTo: "3 months")
        qQuery.whereKey("Category", contains: self.aspectValue)
        qQuery.whereKey("Section", contains: "2")
        qQuery.findObjectsInBackground { (objects, error) in
            DispatchQueue.main.async {
                self.stopAnimating(nil)
            }
            if error != nil {
                
                return
            }
            guard let objectsArray = objects else {return}
            
            for currentObject: PFObject in objectsArray {
                let s = currentObject["En_qn"] as? String ?? ""
                
                self.questions.append(s)
                
                
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                
            }
        }*/
    }
    
}
extension AssessmentViewController: UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout  {
    
    
    
    
    //collectionView
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if questions.count > 0 {
            return questions.count + 1
        }else{
            return questions.count
        }
        
        
        //return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if cell.reuseIdentifier == "AssessmentNewCollectionViewCell" {
            
            
            let assessmentcell = cell as! AssessmentNewCollectionViewCell
            
            let qItem = questions[indexPath.item]
            assessmentcell.questionItem = qItem
            
            assessmentcell.checkAnswer()
            
            if qItem.isVisible {
                cell.isHidden = false
            }else{
                cell.isHidden = true
            }
        }else if cell.reuseIdentifier == "submitCell" {
            if questions[5].isVisible {
                cell.isHidden = false
            }else {
                cell.isHidden = true
            }
            
            
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print(indexPath.row)
        var cellIdentifier = "AssessmentNewCollectionViewCell"
        if questions.count > 0 {
            if indexPath.row == questions.count {
                cellIdentifier = "submitCell"
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
                let submitButton = cell.viewWithTag(1) as! UIButton
                submitButton.isHidden = true
                submitButton.addTarget(self, action: #selector(submitAnswers), for: .touchUpInside)
                
                
                
                let gradient = CAGradientLayer()
                gradient.frame = submitButton.bounds
                gradient.colors = [UIColor.green]
                
                submitButton.applyGradient(colours: [firstGreenColor, secondGreenColor])
                //self.loginButton.backgroundColor = .green
                submitButton.layer.cornerRadius = 20
                submitButton.layer.masksToBounds = true
                return cell
            }
        }
        
        cellIdentifier = "AssessmentNewCollectionViewCell"
         
         
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! AssessmentNewCollectionViewCell
         
         
         let qItem = questions[indexPath.row]
        cell.questionLabel.text = AppConstants.isArabic() ? qItem.quest_text_ar :qItem.quest_text_en
        
        cell.delegate = self
        cell.index = indexPath
        
       
        cell.questionItem = qItem
        
        cell.collectionView = collectionView
        //cell.answerOneLabel.text = qItem.answersItem[0].answer_text_en
        //cell.answerTwoLabel.text = qItem.answersItem[1].answer_text_en
        //cell.answerThreeLabel.text = qItem.answersItem[2].answer_text_en
         
         
         
         return cell
       
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        if questions.count > 0 {
            if indexPath.row == questions.count {
                return CGSize(width: self.collectionView.frame.width, height: 60 )
            }
        }
         let qItem = questions[indexPath.item]
        
        let labelString = NSAttributedString(string: AppConstants.isArabic() ? qItem.quest_text_ar : qItem.quest_text_en , attributes: [.font : UIFont.systemFont(ofSize: 15)])
            
        let cellrect = labelString.boundingRect(with: CGSize(width:  self.collectionView.frame.width, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
       
        
        
        return CGSize(width: self.collectionView.frame.width, height: cellrect.size.height  + 100)
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtminimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.collectionView{
            return 0
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.collectionView{
            return 10
        }else{
            return 10
        }
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        return true
    }
    
}

