//
//  addObjectiveViewController.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 3/11/20.
//  Copyright © 2020 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView




class addObjectiveViewController: UIViewController {
    
    
    
    
    var isEdit = false
    @IBOutlet var objectiveTextView: textFieldMandatory!
    
    var delegate: answerAssessment!
    var mocd_user = MOCDUser.getMOCDUser()
    var toolBar = UIToolbar()
    let activityData = ActivityData()
    var routinesArray: [Routine] = []
    var aspectsArray: [Aspect] = []
    var objective_text: String!
    var task_text: String!
    var selectedRoutine: Routine = Routine()
    var selectedAspect: Aspect = Aspect()
    
    @IBOutlet var domainPickerView: UIPickerView!
    @IBOutlet var routinPickerView: UIPickerView!
    
    var childItem: ChildObject!
    var selectedObjective: Objective?
    
    @IBOutlet var taskView: textFieldMandatory!
    @IBOutlet var domainView: selectTextField!
    @IBOutlet var routineView: selectTextField!
    var task_id: String?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        domainPickerView.delegate = self
        routinPickerView.delegate = self
        
        domainPickerView.dataSource = self
        routinPickerView.dataSource = self
               
        objectiveTextView.textLabel.text = "Objective Text".localize
        objectiveTextView.textField.placeholder = "Objective Text".localize
        
        
        domainView.textLabel.text = "Domain".localize
        domainView.textField.placeholder = "Please Select".localize
        domainView.textField.inputView = domainPickerView
        
        routineView.textLabel.text = "Routine".localize
        routineView.textField.placeholder = "Please Select".localize
        routineView.textField.inputView = routinPickerView
        
        
        domainPickerView.translatesAutoresizingMaskIntoConstraints = false
        routinPickerView.translatesAutoresizingMaskIntoConstraints = false
        
       
        
        taskView.textLabel.text = "Task Text".localize
        taskView.textField.placeholder = "Task Text".localize
        
        
        getRoutines()
        getAspects()
        
        
        routinPickerView.reloadAllComponents()
        domainPickerView.reloadAllComponents()
      
        setupToolbar()
        
        
        if isEdit {
            self.fillInformation()
        }
        
    }
    
    
    func fillInformation() {
        
        objectiveTextView.textField.isUserInteractionEnabled = false
        domainView.textField.isUserInteractionEnabled = false
        routineView.textField.isUserInteractionEnabled = false
    
        
        objectiveTextView.textField.text = selectedObjective?.objective_text_en
        domainView.textField.text = selectedObjective?.aspect_en
        routineView.textField.text = selectedObjective?.routine_en
        
        taskView.textField.text = selectedObjective?.tasks[0].task_text_en
        
    
        
        
    }
    func setupToolbar() {
        toolBar.tintColor = AppConstants.BROWN_COLOR
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        
        toolBar.sizeToFit()
        
        
        var items = [UIBarButtonItem]()
        
        /*
        items.append(
            UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(onClickedToolbeltButton(_:)))
        )
        items.append(
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace , target: self, action: nil))*/
        items.append(
            UIBarButtonItem(barButtonSystemItem: .done , target: self, action: #selector(onClickedToolbeltButton(_:)))
        )
        
        toolBar.items = items
        toolBar.backgroundColor = AppConstants.GREEN_COLOR
        
        domainView.textField.inputAccessoryView = toolBar
        

        domainView.textField.isUserInteractionEnabled = true
        
       routineView.textField.inputAccessoryView = toolBar
        

        routineView.textField.isUserInteractionEnabled = true
        
        
      
        
        
        
        
        
    }
    
    @objc func onClickedToolbeltButton(_ sender: Any){
        self.view.endEditing(true)
    }
    func getRoutines() {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
        
        WebService.getRoutines { (json) in
            print(json)
            DispatchQueue.main.async {
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            }
            
            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
                
                guard let data = json["data"] as? [String: Any] else{return}
                guard let result = data["result"] as? [[String: Any]] else {return}
                
                
                for r in result {
                let routine: Routine = Routine()
                    
                    routine.routine_id = r["id"] as? String  ?? ""
                    routine.routine_ar = r["routine_ar"] as? String  ?? ""
                    routine.routine_en = r["routine_en"] as? String  ?? ""
                    routine.time = r["time"] as? String  ?? ""
                    
                    self.routinesArray.append(routine)
                    
                    
                }
                
                DispatchQueue.main.async {
                    
                    
                    self.routinPickerView.reloadAllComponents()
                }
            }else{
                
                
                DispatchQueue.main.async {
                                   
                    Utils.showAlertWith(title: "Error", message: message, viewController: self)
                    
                }
            }

        }
    }
    
    
    func getAspects() {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
        WebService.getAspects { (json) in
            
            print(json)
            DispatchQueue.main.async {
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            }

            guard let code = json["code"] as? Int else {return}
            guard let message = json["message"] as? String else {return}
            
            if code == 200 {
                
                guard let data = json["data"] as? [String: Any] else{return}
                guard let result = data["result"] as? [[String: Any]] else {return}
                
                
                for r in result {
                let asp: Aspect = Aspect()
                    
                    asp.aspect_id = r["id"] as? String  ?? ""
                    asp.aspect_title_ar = r["aspect_title_ar"] as? String  ?? ""
                    asp.aspect_title_en = r["aspect_title_en"] as? String  ?? ""
                    
                    
                    asp.objective_title_ar = r["objective_title_ar"] as? String  ?? ""
                    asp.objective_title_en = r["objective_title_en"] as? String  ?? ""
                    
                    
                    self.aspectsArray.append(asp)
                    
                    
                }
                
                DispatchQueue.main.async {
                    
                    
                    self.domainPickerView.reloadAllComponents()
                }
            }else{
                DispatchQueue.main.async {
                                   
                    Utils.showAlertWith(title: "Error", message: message, viewController: self)
                    
                }
            }
            
            
        }
    }
    
    
    func checkFields() -> Bool {
        
        objective_text = objectiveTextView.textField.text ?? ""
        task_text = taskView.textField.text ?? ""
        if objective_text == "" {
            Utils.showErrorMessage(NSLocalizedString("Please enter a valid objective text", comment:""), withTitle: NSLocalizedString("objective is empty", comment:""), andInViewController: self)
            
            return false
        }
        
        if task_text == "" {
            Utils.showErrorMessage(NSLocalizedString("Please enter a valid task text", comment:""), withTitle: NSLocalizedString("task is empty", comment:""), andInViewController: self)
            
            return false
        }
        
        if selectedAspect == nil || selectedRoutine == nil {
            Utils.showErrorMessage(NSLocalizedString("Please enter a valid Routine and Aspect", comment:""), withTitle: NSLocalizedString("fields are empty", comment:""), andInViewController: self)
            
            return false
        }
        
        
        return true
    }
    func addObjective() {
        
        
        if !checkFields() {
            return
        }
        
        if isEdit {
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
            WebService.updateTask(taskId: selectedObjective?.tasks[0].taskId ?? "", new_task: task_text) { (json) in
                 print(json)
                               
                               
                DispatchQueue.main.async {
                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                    self.delegate.reloadChild()
                    self.dismiss(animated: true, completion: nil)
                                       
                    
                }
            }
        }else{
            
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
            
            WebService.insertNewObjective(objective_text_ar: objective_text, objective_text_en: objective_text, min_age: "\((Int(childItem.age) ?? 0) - 2)", max_age: "\((Int(childItem.age) ?? 0) + 2)", user_id: mocd_user?.DId ?? "0", child_id: childItem.objectID, aspect_id: selectedAspect.aspect_id , routine_id: selectedRoutine.routine_id ,task: task_text) { (json) in
                
                
                print(json)
                
                DispatchQueue.main.async {
                    
                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                    
                    self.delegate.reloadChild()
                    self.dismiss(animated: true, completion: nil)
                        
                }
                           
                
                
            }
        }
        
        
    }
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func addbuttonAction(_ sender: Any) {
        
        addObjective()
    }
    @IBAction func dismissAction(_ sender: Any) {
        
        self.view.endEditing(true)
    }
}
extension addObjectiveViewController: UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
        if pickerView == routinPickerView {
            return routinesArray.count
        }else if pickerView == domainPickerView{
            return aspectsArray.count
        }
        
        
        
        return 0
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == domainPickerView {
            let item = Array(aspectsArray)[row]
            let title = AppConstants.isArabic() ? item.aspect_title_ar : item.aspect_title_en
            
            return title
        }else if pickerView == routinPickerView{
            let item = Array(routinesArray)[row]
            
            let routineString = AppConstants.isArabic() ? item.routine_ar : item.routine_en
            
            let timeString = "( \(item.time ?? "") )"
            
            let title =  "\(routineString ?? "") \(timeString)"
            
            return title
        }
        
        
        return ""
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == routinPickerView {
            let item = Array(routinesArray)[row]
            
            
            selectedRoutine = item
            
            let timeString = "( \(item.time ?? "") )"
            
            
            let string  = AppConstants.isArabic() ? selectedRoutine.routine_ar : selectedRoutine.routine_en
            
            let completeString  =  "\(string ?? "") \(timeString)"
            routineView.textField.text = AppConstants.isArabic() ? selectedRoutine.routine_ar : selectedRoutine.routine_en
        }else if pickerView == domainPickerView{
            let item = Array(aspectsArray)[row]
          
            selectedAspect = item
            domainView.textField.text = AppConstants.isArabic() ? selectedAspect.aspect_title_ar :  selectedAspect.aspect_title_en
        }
        
        
    }
    
}
