//
//  MOCD_survey.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 11/11/19.
//  Copyright © 2019 Datacellme. All rights reserved.
//

import Foundation


class MOCDSurvey: NSObject {
    
    var survey_id: String = ""
    var survey_title_ar: String = ""
    var survey_title_en: String = ""
    
    
    var aspect_title_ar: String = ""
    var aspect_title_en: String = ""
    
    
    var age_text_ar: String = ""
    var age_text_en: String = ""
    
    var  questions: [Question] = []

    var status: CHILD_STATUS = .NEED_TEST
    
    
    
    var isVisible = false
    
}



class Question: NSObject {
    var question_id: String  =  ""
    var survey_id: String  =  ""
    var quest_text_ar: String  =  ""
    var quest_text_en: String  =  ""
   
    var isVisible = false
    var answersItem: [Answer] = []
    
    var selectedAnswer: Answer? 
}
class Answer: NSObject {
    
    var answer_id: String?
    var answer_text_ar: String  = ""
    var answer_text_en: String  = ""
    var checkedString: String = ""

}
class Objective: NSObject {
    var objectiveId:String  = ""
    var objective_text_ar:String  = ""
    var objective_text_en:String  = ""
    
    var routine_ar:String  = ""
    var routine_en:String  = ""
    
    var result: String = ""
    var tasks: [Task] = []
}
class Task: NSObject {
    var taskId:String  = ""
    var objectiveId: String = ""
    var task_text_ar:String  = ""
    var task_text_en:String  = ""
    var result: String = ""
    var selectedTask: String  = ""
    
     var childItem = ChildObject()
}

class storyCategory {
    var categoryID = ""
    var category_title_ar = ""
    var category_title_en = ""
    var stories: [story] = []
    
}
class story: NSObject {
    
    var categoryId: String = ""
    var storyId: String = ""
    var cover: String = ""
    var link: String = ""
    var title_ar: String = ""
    var title_en: String = ""
    
}


class Routine: NSObject {
    var routine_id: String!
    var routine_ar: String!
    var routine_en: String!
}


class Aspect: NSObject {
    var aspect_id: String!
    var aspect_title_en: String!
    var aspect_title_ar: String!
    
    
    var objective_title_ar: String!
    var objective_title_en: String!
}
