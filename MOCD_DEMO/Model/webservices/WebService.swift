 //
//  WebService.swift
//  JSON
//
//  Created by haya habbous on 2/25/18.
//  Copyright © 2018 haya habbous. All rights reserved.
//

import Foundation



public class WebService{
    
    
    
    
    //User endpoint
    
    static func signup(firstName: String ,lastName: String , email: String , username: String ,
                       emiratesId: String ,phone: String ,emirate: String , password: String ,address:String ,gender: String ,nationality: String  ,completeion: @escaping ([String:Any]) -> Void  ) {
    
     
        let webResource = "signup"
        var parametersArray:[[String:Any]] = [[:]]
        
        parametersArray.append(["first_name":firstName]);
        parametersArray.append(["last_name":lastName]);
        parametersArray.append(["emirates_id":emiratesId]);
        parametersArray.append(["phone":phone]);
        parametersArray.append(["email":email]);
        parametersArray.append(["password":password]);
        parametersArray.append(["username":username]);
        parametersArray.append(["emirate":emirate]);
        parametersArray.append(["address":address]);
        parametersArray.append(["gender":gender]);
        parametersArray.append(["nationality":nationality]);
        
        
        
        
        RequestResponseWebServices.requestByPOST(WebServiceUrl: webResource, params: &parametersArray, endpoint: "parent", completion: { (json) in
            
            completeion(json)
            
        })

        
    }
    
    
    static func login(username: String ,password: String , completetion: @escaping ([String:Any]) -> Void) {
     
        let webResource = "login"
        var parametersArray: [[String:Any]] = [[:]]
        
        parametersArray.append(["username": username])
        parametersArray.append(["password": password])
        
        
        RequestResponseWebServices.requestByPOST(WebServiceUrl: webResource, params: &parametersArray, endpoint: "parent") { (json) in
            completetion(json)
        }
    }
    static func getPersonalProfile(id: String , completetion: @escaping ([String:Any]) -> Void) {
     
        let webResource = "getPersonProfile"
        var parametersArray: [[String:Any]] = [[:]]
        
        parametersArray.append(["id": id])

        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "user") { (json) in
            completetion(json)
        }
    }
    static func generateOTP(mobileNumber: String , completetion: @escaping ([String:Any]) -> Void) {
     
        let webResource = "generateOTP"
        var parametersArray: [[String:Any]] = [[:]]
        
        parametersArray.append(["mobilenumber": mobileNumber])

        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "otp") { (json) in
            completetion(json)
        }
    }
    static func validateOTP(otp: String , mobileNumber: String , completetion: @escaping ([String:Any]) -> Void) {
     
        let webResource = "validateOTP"
        var parametersArray: [[String:Any]] = [[:]]
        
        parametersArray.append(["mobilenumber": mobileNumber])
        parametersArray.append(["otp": otp])

        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "otp") { (json) in
            completetion(json)
        }
    }
    static func RetrieveUAEPassUser(email: String ,uaePassUserId: String , completetion: @escaping ([String:Any]) -> Void) {
     
        let webResource = "RetrieveUAEPassUser"
        var parametersArray: [[String:Any]] = [[:]]
        
        parametersArray.append(["email": email])
        parametersArray.append(["uaePassUserId": uaePassUserId])
        
        
        RequestResponseWebServices.requestByPOST(WebServiceUrl: webResource, params: &parametersArray, endpoint: "user") { (json) in
            completetion(json)
        }
    }
    
    static func CreateUAEPassUserMapping(uaePassUserId: String ,uaePassUserType: String ,userId: String , completetion: @escaping ([String:Any]) -> Void) {
     
        let webResource = "CreateUAEPassUserMapping"
        var parametersArray: [[String:Any]] = [[:]]
        
        parametersArray.append(["uaePassUserId": uaePassUserId])
        parametersArray.append(["uaePassUserType": uaePassUserType])
        parametersArray.append(["userId": userId])
        
        
        RequestResponseWebServices.requestByPOST(WebServiceUrl: webResource, params: &parametersArray, endpoint: "user") { (json) in
            completetion(json)
        }
    }
    
    static func logout(username: String ,completetion: @escaping ([String:Any]) -> Void) {
     
        let webResource = "logout"
        var parametersArray: [[String:Any]] = [[:]]
        
        parametersArray.append(["username": username])

        
        
        RequestResponseWebServices.requestByPOST(WebServiceUrl: webResource, params: &parametersArray, endpoint: "parent") { (json) in
            completetion(json)
        }
    }
    
    static func getGenders(completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "getGenders"
        var parametersArray: [[String:Any]] = [[:]]
        
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "parent") { (json) in
            completetion(json)
        }
        
    }
    
    static func getToken(completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "getToken"
        var parametersArray: [[String:Any]] = [[:]]
        
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "user") { (json) in
            completetion(json)
        }
        
    }
    static func getCountries(completetion: @escaping ([String:Any]) -> Void) {
        let webResource = "getCountries"
        var parametersArray: [[String:Any]] = [[:]]
        
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "user") { (json) in
            completetion(json)
        }
    }
    static func getTokenJson(completetion: @escaping ([String:Any]) -> Void) {
        let webResource = "getTokenJson"
        var parametersArray: [[String:Any]] = [[:]]
        
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "user") { (json) in
            completetion(json)
        }
    }
    
    static func getEmirates(completetion: @escaping ([String:Any]) -> Void) {
        let webResource = "getEmirates"
        var parametersArray: [[String:Any]] = [[:]]
        
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "parent") { (json) in
            completetion(json)
        }
    }
    
    
    static func createChild(parent_id: String ,first_name: String ,
                            last_name: String ,nationality: String ,
                            gender: String ,mobile: String ,
                            email: String ,emirates_id: String ,
                            emirate: String ,address: String ,
                            data_of_birth: String ,child_picture: String ,completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "createChild"
        var parametersArray: [[String:Any]] = [[:]]
        
        parametersArray.append(["parent_id":parent_id ])
        parametersArray.append(["first_name": first_name])
        parametersArray.append(["last_name": last_name])
        parametersArray.append(["nationality": nationality])
        parametersArray.append(["gender": gender])
        parametersArray.append(["mobile": mobile])
        parametersArray.append(["email": email])
        parametersArray.append(["emirates_id": emirates_id])
        parametersArray.append(["emirate": emirate])
        parametersArray.append(["address": address])
        
        parametersArray.append(["data_of_birth": data_of_birth])
        parametersArray.append(["child_picture": child_picture])
       
        
        RequestResponseWebServices.requestByPOST(WebServiceUrl: webResource, params: &parametersArray, endpoint: "child") { (json) in
            completetion(json)
        }
    }
    
    static func insertNewObjective(objective_text_ar: String ,objective_text_en: String ,min_age: String , max_age: String ,user_id
        :String ,child_id: String ,aspect_id: String,routine_id: String,task: String ,completetion: @escaping ([String:Any]) -> Void) {
     
        let webResource = "insertObjective"
        var parametersArray: [[String:Any]] = [[:]]
        
        parametersArray.append(["objective_text_ar": objective_text_ar])
        parametersArray.append(["objective_text_en": objective_text_en])
        parametersArray.append(["min_age": min_age])
        parametersArray.append(["max_age": max_age])
        parametersArray.append(["user_id": user_id])
        parametersArray.append(["child_id": child_id])
        parametersArray.append(["aspect_id": aspect_id])
        parametersArray.append(["task": task])
        parametersArray.append(["routine_id": routine_id])
        RequestResponseWebServices.requestByPOST(WebServiceUrl: webResource, params: &parametersArray, endpoint: "survey") { (json) in
            completetion(json)
        }
    }
    static func insertCenetrChild(centerId: String ,child_id: String , completetion: @escaping ([String:Any]) -> Void) {
     
        let webResource = "insertCenterChild"
        var parametersArray: [[String:Any]] = [[:]]
        
        parametersArray.append(["center_id": centerId])
        parametersArray.append(["child_id": child_id])
        
        
        RequestResponseWebServices.requestByPOST(WebServiceUrl: webResource, params: &parametersArray, endpoint: "survey") { (json) in
            completetion(json)
        }
    }
    static func getChildsForParent(isCenter: Bool ,completetion: @escaping ([String:Any]) -> Void) {
        
        var webResource = ""
        if isCenter {
            webResource = "getChildrenForCenter"
        }else {
            webResource = "getChildsForParent"
        }
     
        var parametersArray: [[String:Any]] = [[:]]
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "child") { (json) in
            completetion(json)
        }
    }
    
    static func searchChild(emiratesId:String , completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "searchChild"
        var parametersArray: [[String:Any]] = [[:]]
        
        parametersArray.append(["emiratesId":emiratesId])
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "child") { (json) in
            completetion(json)
        }
    }
    static func getCenters( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "getCenters"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "child") { (json) in
            completetion(json)
        }
    }
    
    static func getChild(childId:String , completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "getChildfull"
        var parametersArray: [[String:Any]] = [[:]]
        
        parametersArray.append(["childId":childId])
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "child") { (json) in
            completetion(json)
        }
    }
    
    
    static func getRoutines(completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "getRoutines"
        var parametersArray: [[String:Any]] = [[:]]
        
       
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "survey") { (json) in
            completetion(json)
        }
    }
    
    static func getAspects( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "getAspects"
        var parametersArray: [[String:Any]] = [[:]]
        
        
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "survey") { (json) in
            completetion(json)
        }
    }
    
    static func deleteChild(childId:String , completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "deleteChild"
        var parametersArray: [[String:Any]] = [[:]]
        parametersArray.append(["childId":childId])
        
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "child") { (json) in
            completetion(json)
        }
    }
    
    
    
    static func getSurveysList(completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "getSurveysList"
        var parametersArray: [[String:Any]] = [[:]]
        
        parametersArray.append(["age": "2"])
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "survey") { (json) in
            completetion(json)
        }
    }
    
    static func getQuestions(surveyId: String , completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "getQuestions"
        var parametersArray: [[String:Any]] = [[:]]
        
        
        parametersArray.append(["survey_id":surveyId])
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "survey", completion: { (json) in
            completetion(json)
        })
    }
    
    static func submitAnswers(survey_id: String ,child_id:String ,answers: NSMutableArray ,completetion: @escaping ([String:Any]) -> Void) {
        
        
        guard let answersJson = try? JSONSerialization.data(withJSONObject: answers, options: []) else {return }
        
        guard let answersString = String(data: answersJson, encoding: String.Encoding.utf8) else {return}
        
        let webResource = "submitAnswers"
        var parametersArray: [[String:Any]] = [[:]]
        parametersArray.append(["survey_id":survey_id])
        parametersArray.append(["child_id":child_id])
        
        
        parametersArray.append(["answers":answersString])
        
        
        
        RequestResponseWebServices.requestByPOST(WebServiceUrl: webResource, params: &parametersArray, endpoint: "survey") { (json) in
            completetion(json)
        }
    }
    static func submitObjective(objectiveId: String ,taskId:String ,childId:String ,result: String  ,completetion: @escaping ([String:Any]) -> Void) {
        
        
       
        
        let webResource = "insertObjectiveChild"
        var parametersArray: [[String:Any]] = [[:]]
        parametersArray.append(["objective_id":objectiveId])
        parametersArray.append(["task_id":taskId])
        parametersArray.append(["child_id":childId])
        parametersArray.append(["result":result])
        
        
        
        
        
        
        RequestResponseWebServices.requestByPOST(WebServiceUrl: webResource, params: &parametersArray, endpoint: "survey") { (json) in
            completetion(json)
        }
    }
    
    static func updateTask(taskId: String ,new_task:String ,completetion: @escaping ([String:Any]) -> Void) {
        
        
       
        
        let webResource = "updateTask"
        var parametersArray: [[String:Any]] = [[:]]
        parametersArray.append(["task_id":taskId])
        parametersArray.append(["new_task":new_task])
 
        
        
        
        
        
        
        RequestResponseWebServices.requestByPOST(WebServiceUrl: webResource, params: &parametersArray, endpoint: "survey") { (json) in
            completetion(json)
        }
    }
    static func answerObjectiveChild(objectiveId: String ,childId:String ,result: String  ,completetion: @escaping ([String:Any]) -> Void) {
        
        
       
        
        let webResource = "answerObjectiveChild"
        var parametersArray: [[String:Any]] = [[:]]
        parametersArray.append(["objective_id":objectiveId])
        parametersArray.append(["child_id":childId])
        parametersArray.append(["result":result])
        
        
        
        
        
        
        RequestResponseWebServices.requestByPOST(WebServiceUrl: webResource, params: &parametersArray, endpoint: "survey") { (json) in
            completetion(json)
        }
    }
    static func getStories( completetion: @escaping ([String:Any]) -> Void) {
        
        
       
        
        let webResource = "getStories"
        var parametersArray: [[String:Any]] = [[:]]
        
        
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "stories") { (json) in
            completetion(json)
        }
    }
    static func getServices( completetion: @escaping ([String:Any]) -> Void) {
        
        
       
        
        let webResource = "getServices"
        var parametersArray: [[String:Any]] = [[:]]
        
        
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "Eservices") { (json) in
            completetion(json)
        }
    }
    
    
    //New Api's
    
    
    static func authenticateUser(username:String ,password:String , completetion: @escaping ([String:Any]) -> Void) {
        
        
       
        
        let webResource = "authenticate"
        var parametersArray: [[String:Any]] = [[:]]
        parametersArray.append(["username":username])
        parametersArray.append(["password":password])
        
        RequestResponseWebServices.requestByPOST(WebServiceUrl: webResource, params: &parametersArray, endpoint: "user") { (json) in
            completetion(json)
        }
    }
    
    static func forgetPassword(emailAddress:String, completetion: @escaping ([String:Any]) -> Void) {
        
        
       
        
        let webResource = "forgetPassword"
        var parametersArray: [[String:Any]] = [[:]]
        parametersArray.append(["email_address":emailAddress])

        
        RequestResponseWebServices.requestByPOST(WebServiceUrl: webResource, params: &parametersArray, endpoint: "user") { (json) in
            completetion(json)
        }
    }
    
    static func getSecurityQuestions( completetion: @escaping ([String:Any]) -> Void) {
        
        
       
        
        let webResource = "getSecurityQuestions"
        var parametersArray: [[String:Any]] = [[:]]
        

        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "user") { (json) in
            completetion(json)
        }
    }
    
    static func RetrieveGender( completetion: @escaping ([String:Any]) -> Void) {
        
        
       
        
        let webResource = "getGenders"
        var parametersArray: [[String:Any]] = [[:]]
        

        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "user") { (json) in
            completetion(json)
        }
    }
    
    
    
    ////new card
    
    
    static func RetrieveOrganizations( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "RetrieveOrganizations"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "RetrieveOrganizations" , serviceType: "newCard") { (json) in
            completetion(json)
        }
    }
    static func RetrieveDisabledCardReplacementRequestTypes( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "RetrieveDisabledCardReplacementRequestTypes"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "RetrieveDisabledCardReplacementRequestTypes" , serviceType: "newCard") { (json) in
            completetion(json)
        }
    }
    
    
    static func RetrieveNewDisabledCardDocumentTypes( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "RetrieveNewDisabledCardDocumentTypes"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "RetrieveNewDisabledCardDocumentTypes" , serviceType: "newCard") { (json) in
            completetion(json)
        }
    }
    
    static func RetrieveRenewDisabledCardDocumentTypes( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "RetrieveRenewDisabledCardDocumentTypes"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "RetrieveRenewDisabledCardDocumentTypes" , serviceType: "newCard") { (json) in
            completetion(json)
        }
    }
    
    static func loadOfficialLetterDocumentsTypes( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "loadOfficialLetterDocumentsTypes"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "loadOfficialLetterDocumentsTypes" , serviceType: "social") { (json) in
            completetion(json)
        }
    }
    
    static func RetrieveReplaceDisabledCardDocumentTypes( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "RetrieveReplaceDisabledCardDocumentTypes"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "RetrieveReplaceDisabledCardDocumentTypes" , serviceType: "newCard") { (json) in
            completetion(json)
        }
    }
    static func RetrieveEmirate( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "RetrieveEmirate"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "RetrieveEmirate" , serviceType: "newCard") { (json) in
            completetion(json)
        }
    }
    
    static func RetrieveEmirateSocial( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "RetrieveEmirate"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "RetrieveEmirate" , serviceType: "social") { (json) in
            completetion(json)
        }
    }



    static func RetrieveMaritalStatus( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "RetrieveMaritalStatus"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "RetrieveMaritalStatus" , serviceType: "newCard") { (json) in
            completetion(json)
        }
    }
    
    static func RetrieveAccommodationType( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "RetrieveAccommodationType"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "RetrieveAccommodationType" , serviceType: "newCard") { (json) in
            completetion(json)
        }
    }
    
    static func RetrieveQualification( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "RetrieveQualification"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "RetrieveQualification" , serviceType: "newCard") { (json) in
            completetion(json)
        }
    }
    
    
    static func RetrieveDiagnosisAuthority( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "RetrieveDiagnosisAuthority"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "RetrieveDiagnosisAuthority" , serviceType: "newCard") { (json) in
            completetion(json)
        }
    }
    
    static func SearchDisabledCardsForRenewal(card_number: String, completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "SearchDisabledCardsForRenewal"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        parametersArray.append(["card_number":card_number])
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "SearchDisabledCardsForRenewal" , serviceType: "newCard") { (json) in
            completetion(json)
        }
    }
    
    static func SearchDisabledCardsForReplacement(card_number: String, completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "SearchDisabledCardsForReplacement"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        parametersArray.append(["card_number":card_number])
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "SearchDisabledCardsForReplacement" , serviceType: "newCard") { (json) in
            completetion(json)
        }
    }
    
    static func RetrieveDisabilityLevel( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "RetrieveDisabilityLevel"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "RetrieveDisabilityLevel" , serviceType: "newCard") { (json) in
            completetion(json)
        }
    }
    
    static func RetrieveDisabilityTypes( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "RetrieveDisabilityTypes"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "RetrieveDisabilityTypes" , serviceType: "newCard") { (json) in
            completetion(json)
        }
    }
    
    static func RetrieveSupportingEquipment( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "RetrieveSupportingEquipment"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "RetrieveSupportingEquipment" , serviceType: "newCard") { (json) in
            completetion(json)
        }
    }
    
    static func RetrieveStudentInstituteType( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "RetrieveStudentInstituteType"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "RetrieveStudentInstituteType" , serviceType: "newCard") { (json) in
            completetion(json)
        }
    }
    
    static func RetrieveWorkField( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "RetrieveWorkField"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "RetrieveWorkField" , serviceType: "newCard") { (json) in
            completetion(json)
        }
    }
    static func RetrieveCenters( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "RetrieveCenters"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "RetrieveCenters" , serviceType: "social") { (json) in
            completetion(json)
        }
    }
    
    static func RetrieveMaritalStatusSocial( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "RetrieveMaritalStatus"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "RetrieveMaritalStatus" , serviceType: "social") { (json) in
            completetion(json)
        }
    }
    static func RetrieveNationalitySocial( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "RetrieveNationality"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "RetrieveNationality" , serviceType: "social") { (json) in
            completetion(json)
        }
    }
    
    static func RetrieveEducationLevelSocial( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "RetrieveEducationLevel"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "RetrieveEducationLevel" , serviceType: "social") { (json) in
            completetion(json)
        }
    }
    
    static func RetrieveAccommodationTypesSocial( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "RetrieveAccommodationTypes"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "RetrieveAccommodationTypes" , serviceType: "social") { (json) in
            completetion(json)
        }
    }
    
    static func RetrieveOwnershipTypesSocial( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "RetrieveOwnershipTypes"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "RetrieveOwnershipTypes" , serviceType: "social") { (json) in
            completetion(json)
        }
    }
    
    static func RetrievePersonAccommodatedTypesSocial( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "RetrievePersonAccommodatedTypes"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "RetrievePersonAccommodatedTypes" , serviceType: "social") { (json) in
            completetion(json)
        }
    }
    
    static func RetrieveHouseConditionTypesSocial( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "RetrieveHouseConditionTypes"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "RetrieveHouseConditionTypes" , serviceType: "social") { (json) in
            completetion(json)
        }
    }
    
    
    static func RetrieveIncomeSourceTypeSocial( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "RetrieveIncomeSourceType"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "RetrieveIncomeSourceType" , serviceType: "social") { (json) in
            completetion(json)
        }
    }
    
    static func RetrieveGenderSocial( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "RetrieveGender"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "RetrieveGender" , serviceType: "social") { (json) in
            completetion(json)
        }
    }
    
    
    static func RetrieveFamilyMemberRelationship( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "RetrieveFamilyMemberRelationship"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "RetrieveFamilyMemberRelationship" , serviceType: "social") { (json) in
            completetion(json)
        }
    }
    static func RetrieveRequestTypeSocial( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "RetrieveRequestType"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "RetrieveRequestType" , serviceType: "social") { (json) in
            completetion(json)
        }
    }
    static func RetrieveDiseaseTypeSocial( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "RetrieveDiseaseType"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "RetrieveDiseaseType" , serviceType: "social") { (json) in
            completetion(json)
        }
    }
    
    static func RetrieveFinancialAssistanceDocumentTypes( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "RetrieveFinancialAssistanceDocumentTypes"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "RetrieveFinancialAssistanceDocumentTypes" , serviceType: "social") { (json) in
            completetion(json)
        }
    }
    
    
    
    static func loadOfficialLetterType( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "loadOfficialLetterType"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "loadOfficialLetterType" , serviceType: "social") { (json) in
            completetion(json)
        }
    }
    static func applyForOfficialLetterWithCaseID(userId: String,mobileNo: String,caseID: String ,email: String  ,entityAddressed: String ,  completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "applyForOfficialLetterWithCaseID"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        parametersArray.append(["userId":userId])
        parametersArray.append(["mobileNo":mobileNo])
        parametersArray.append(["caseID":caseID])
        parametersArray.append(["email":email])
        parametersArray.append(["entityAddressed":entityAddressed])
        
        
       
        RequestResponseWebServices.requestByPOST(WebServiceUrl: webResource, params: &parametersArray, endpoint: "social") { (json) in
            completetion(json)
        }
    }

    static func ValidateNationalID(userId: String, nationalId: String, completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "validateNationalIdForAssistance"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        //parametersArray.append(["userId":userId])
        parametersArray.append(["nationalId":nationalId])
        
      
        
       
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "social" , serviceType: "social") { (json) in
            completetion(json)
        }
    }
    
    static func RetrieveRejectedRequest(nationalId: String, ref: String , completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "RetrieveRejectedRequest"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        parametersArray.append(["userId":nationalId])
        parametersArray.append(["nationalId":ref])
      
        
       
        RequestResponseWebServices.requestByPOST(WebServiceUrl: webResource, params: &parametersArray, endpoint: "social") { (json) in
            completetion(json)
        }
    }
    
    static func GetCountryMaster( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "GetCountry"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "GetCountry" , serviceType: "master") { (json) in
            completetion(json)
        }
    }
    static func GetEmiratesMaster( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "GetEmirates"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "GetEmirates" , serviceType: "master") { (json) in
            completetion(json)
        }
    }
    
    
    static func GetCourtMaster( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "GetCourt"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "GetCourt" , serviceType: "master") { (json) in
            completetion(json)
        }
    }
    
    static func GetFamilyBookIssuePlaceMaster( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "GetFamilyBookIssuePlace"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "GetFamilyBookIssuePlace" , serviceType: "master") { (json) in
            completetion(json)
        }
    }
    static func GetEmployerTypeMaster( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "GetEmployerType"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "GetEmployerType" , serviceType: "master") { (json) in
            completetion(json)
        }
    }
    
    static func GetBankListMaster( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "GetBankList"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "GetBankList" , serviceType: "master") { (json) in
            completetion(json)
        }
    }
    static func GetEducationLevelMaster( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "GetEducationLevel"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "GetEducationLevel" , serviceType: "master") { (json) in
            completetion(json)
        }
    }
    
    static func GetChannelMaster( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "GetChannel"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "GetChannel" , serviceType: "master") { (json) in
            completetion(json)
        }
    }
    
    static func GetRequestTypeMaster( completetion: @escaping ([String:Any]) -> Void) {
           
           let webResource = "GetRequestType"
           var parametersArray: [[String:Any]] = [[:]]
           
       
           
           
           RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "GetRequestType" , serviceType: "master") { (json) in
               completetion(json)
           }
       }
    static func GetRequestingServiceMaster( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "GetRequestingService"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "GetRequestingService" , serviceType: "master") { (json) in
            completetion(json)
        }
    }
    
    static func GetDocumentListByServiceMaster(ServiceId: String,ServiceTypeId: String,  completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "Services/GetDocumentListByService"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        parametersArray.append(["ServiceId":ServiceId])
        parametersArray.append(["ServiceTypeId":ServiceTypeId])
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "GetDocumentListByService" , serviceType: "master") { (json) in
            completetion(json)
        }
    }
    
    //Elderly
    
    static func GetMaritalStatus( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "GetMaritalStatus"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "GetMaritalStatus" , serviceType: "master") { (json) in
            completetion(json)
        }
    }
    static func GetRelationsMaster( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "GetRelations"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "GetRelations" , serviceType: "master") { (json) in
            completetion(json)
        }
    }
    
    static func GetElderlyServiceType( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "GetElderlyServiceType"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "GetElderlyServiceType" , serviceType: "master") { (json) in
            completetion(json)
        }
    }
    
    static func GetElderlyApplicantType( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "GetElderlyApplicantType"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "GetElderlyApplicantType" , serviceType: "master") { (json) in
            completetion(json)
        }
    }
    static func GetHasChildrens( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "GetHasChildrens"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "GetHasChildrens" , serviceType: "master") { (json) in
            completetion(json)
        }
    }
    static func GetElderlyHobby( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "GetElderlyHobby"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "GetElderlyHobby" , serviceType: "master") { (json) in
            completetion(json)
        }
    }
    static func GetElderlyGender( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "GetGender"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "GetGender" , serviceType: "master") { (json) in
            completetion(json)
        }
    }
    static func GetElderlyProfession( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "GetElderlyProfession"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "GetElderlyProfession" , serviceType: "master") { (json) in
            completetion(json)
        }
    }
    static func GetElderlyActivity( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "GetElderlyActivity"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "GetElderlyActivity" , serviceType: "master") { (json) in
            completetion(json)
        }
    }
    static func GetGender( completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "GetGender"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        
        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "GetGender" , serviceType: "master") { (json) in
            completetion(json)
        }
    }
    
    static func SubmitMassWeddingRequest(HusbandNationalId: String ,WifeNationalId: String , MarriageContractDate: String , Court: String ,
                       HusbandFullNameArabic: String ,HusbandFullNameEnglish: String ,HusbandBirthDate: String , HusbandEducationLevel: String ,HusbandMobile1:String ,HusbandMobile2: String ,HusbandEmail: String ,WifeFullNameArabic: String,WifeFullNameEnglish: String,WifeBirthDate: String,WifeEducationLevel: String,WifeMobile1: String,WifeEmail: String,FamilyBookIssuePlace: String,ReasonForNotRecievinggrant: String,completeion: @escaping ([String:Any]) -> Void  ) {
    
     
        let webResource = "Services/SubmitMassWeddingRequest"
        var parametersArray:[[String:Any]] = [[:]]
        
        parametersArray.append(["HusbandNationalId":HusbandNationalId]);
        parametersArray.append(["WifeNationalId":WifeNationalId]);
        parametersArray.append(["MarriageContractDate":MarriageContractDate]);
        parametersArray.append(["Court":Court]);
        parametersArray.append(["HusbandFullNameArabic":HusbandFullNameArabic]);
        parametersArray.append(["HusbandFullNameEnglish":HusbandFullNameEnglish]);
        parametersArray.append(["HusbandBirthDate":HusbandBirthDate]);
        //parametersArray.append(["HusbandEducationLevel":HusbandEducationLevel]);
        parametersArray.append(["HusbandMobile1":HusbandMobile1]);
        parametersArray.append(["HusbandMobile2":HusbandMobile2]);
        parametersArray.append(["HusbandEmail":HusbandEmail]);
        
        parametersArray.append(["WifeFullNameArabic":WifeFullNameArabic]);
        parametersArray.append(["WifeFullNameEnglish":WifeFullNameEnglish]);
        parametersArray.append(["WifeBirthDate":WifeBirthDate]);
        //parametersArray.append(["WifeEducationLevel":WifeEducationLevel]);
        parametersArray.append(["WifeMobile1":WifeMobile1]);
        parametersArray.append(["WifeEmail":WifeEmail]);
        parametersArray.append(["FamilyBookIssuePlace":FamilyBookIssuePlace]);
        parametersArray.append(["ReasonForNotRecievinggrant":ReasonForNotRecievinggrant]);
        parametersArray.append(["RequestingService":AppConstants.RequestingServiceMassWeddingDEV]);
        parametersArray.append(["TypeOfRequest":AppConstants.TypeOfRequestMassWeddingDEV]);
        parametersArray.append(["ChannelType":AppConstants.ChannelType]);
        
        
        
        
        RequestResponseWebServices.requestByPOST(WebServiceUrl: webResource, params: &parametersArray, endpoint: "masterService", completion: { (json) in
            
            completeion(json)
            
        })

        
    }
    
    static func SaveElderlyRegistartionInMobileUnit(mocd_applicantemiratesid: String = "784190928512228" ,
                                 mocd_applicantname: String = "Test",
                                 mocd_servicetype: String = "2" ,
                                 mocd_elderlyemiratesid: String = "784190928573338",
                                 mocd_fullnameen: String  = "Test1",
                                 mocd_fullnamear: String  = "Test1",
                                 mocd_firstnameen: String  = "Test1",
                                 mocd_secondnameen: String = "Test1",
                                 mocd_thirdnameen:String = "Test1",
                                 mocd_fourthnameen: String  = "Test1",
                                 mocd_firstnamear: String = "Test1",
                                 mocd_secondnamear: String = "Test1",
                                 mocd_thirdnamear: String = "Test1",
                                 mocd_fourthnamear: String = "Test1",
                                 mocd_gender: String = "1",
                                 mocd_dateofbirth: String = "1973-10-30T20:00:00Z",
                                 mocd_nationality: String = "1c725133-12b0-ea11-a2c7-00155d138354",
                                 mocd_residenceemirate: String = "a19fa49b-a39c-e911-a2b6-00155d138354",
                                 mocd_mobilenumber: String = "0555319789" ,
                                 mocd_telephonenumber: String = "042562323" ,
                                 mocd_address: String = "test" ,
                                 mocd_email: String = "test@test.com" ,
                                 mocd_pobox: String = "1234" ,
                                 mocd_placeofbirth: String = "India" ,
                                 mocd_maritalstatus: String = "662410000" ,
                                 mocd_noofmarriages: String = "1" ,
                                 mocd_noofdivorced: String = "0" ,
                                 mocd_noofdaughters: String = "1" ,
                                 mocd_noofsons: String = "1" ,
                                 mocd_noofwidowness: String = "0" ,
                                 mocd_applicanttype: String = "1" ,
                                 mocd_establishmentdetail: String = "TEST" ,
                                 mocd_applicantrelationship: String = "0cfdfccd-9d2c-eb11-a2c2-00155d138370" ,
                                 mocd_responsibleemiratesid: String = "784198128670673" ,
                                 mocd_responsiblepersonname: String = "Test" ,
                                 mocd_responsiblemobilenumber: String = "0555319789" ,
                                 mocd_responsibleaddress: String = "Test" ,
                                 mocd_responsiblerelationship: String = "0cfdfccd-9d2c-eb11-a2c2-00155d138370" ,
                                 mocd_profession: String = "1" ,
                                 mocd_emergencypersonemiratesid: String = "784198128670673" ,
                                 mocd_emergencyrelationship: String = "0cfdfccd-9d2c-eb11-a2c2-00155d138370" ,
                                 mocd_emergencyprofession: String = "1" ,
                                 mocd_emergencypersonaddress: String = "test" ,
                                 mocd_transferparty: String = "Test" ,
                                 mocd_transferreason: String = "Test" ,
                                 mocd_requestingservice: String = "4D1CEAC0-4105-EB11-A2C2-00155D138370" ,
                                 mocd_servicerequesttype: String = "C2F82A93-582D-EB11-A2C2-00155D138370" ,
                                 mocd_formgroup: String = "1" ,
                                 mocd_serviceprocess: String = "2" ,
                                 mocd_profileid: String = "6567878978978789" ,
                                 mocd_profilename: String = "test" ,
                                 mocd_profileemail: String = "test" ,
                                 mocd_profilemobilenumber: String = "test" ,
                                 
                                 completeion: @escaping ([String:Any]) -> Void  ) {
    
     
        let webResource = "Services/SaveElderlyRegistartionInMobileUnit"
        var parametersArray:[[String:Any]] = [[:]]
        
        parametersArray.append(["mocd_applicantemiratesid":mocd_applicantemiratesid]);
        parametersArray.append(["mocd_applicantname":mocd_applicantname]);
        parametersArray.append(["mocd_servicetype":mocd_servicetype]);
        parametersArray.append(["mocd_elderlyemiratesid":mocd_elderlyemiratesid]);
        parametersArray.append(["mocd_fullnameen":mocd_fullnameen]);
        parametersArray.append(["mocd_fullnamear":mocd_fullnamear]);
        parametersArray.append(["mocd_firstnameen":mocd_firstnameen]);
        parametersArray.append(["mocd_secondnameen":mocd_secondnameen]);
        
        
        
        
        
        parametersArray.append(["mocd_thirdnameen":mocd_thirdnameen]);
        parametersArray.append(["mocd_thirdnameen":mocd_thirdnameen]);
        parametersArray.append(["mocd_fourthnameen":mocd_fourthnameen]);
        parametersArray.append(["mocd_firstnamear":mocd_firstnamear]);
        parametersArray.append(["mocd_secondnamear":mocd_secondnamear]);
        parametersArray.append(["mocd_thirdnamear":mocd_thirdnamear]);
        parametersArray.append(["mocd_fourthnamear":mocd_fourthnamear]);
        parametersArray.append(["mocd_gender":mocd_gender]);
        parametersArray.append(["mocd_dateofbirth":mocd_dateofbirth]);
        parametersArray.append(["mocd_nationality":mocd_nationality]);
        parametersArray.append(["mocd_residenceemirate":mocd_residenceemirate]);
        parametersArray.append(["mocd_mobilenumber":mocd_mobilenumber]);
        parametersArray.append(["mocd_telephonenumber":mocd_telephonenumber]);
        parametersArray.append(["mocd_address":mocd_address]);
        parametersArray.append(["mocd_email":mocd_email]);
        parametersArray.append(["mocd_pobox":mocd_pobox]);
        parametersArray.append(["mocd_placeofbirth":mocd_placeofbirth]);
        parametersArray.append(["mocd_maritalstatus":mocd_maritalstatus]);
        parametersArray.append(["mocd_noofmarriages":mocd_noofmarriages]);
        parametersArray.append(["mocd_noofdivorced":mocd_noofdivorced]);
        parametersArray.append(["mocd_noofdaughters":mocd_noofdaughters]);
        parametersArray.append(["mocd_noofsons":mocd_noofsons]);
        parametersArray.append(["mocd_noofwidowness":mocd_noofwidowness]);
        parametersArray.append(["mocd_applicanttype":mocd_applicanttype]);
        parametersArray.append(["mocd_establishmentdetail":mocd_establishmentdetail]);
        parametersArray.append(["mocd_applicantrelationship":mocd_applicantrelationship]);
        parametersArray.append(["mocd_responsiblepersonname":mocd_responsiblepersonname]);
        parametersArray.append(["mocd_responsiblemobilenumber":mocd_responsiblemobilenumber]);
        parametersArray.append(["mocd_responsibleaddress":mocd_responsibleaddress]);
        parametersArray.append(["mocd_responsiblerelationship":mocd_responsiblerelationship]);
        parametersArray.append(["mocd_profession":mocd_profession]);
        parametersArray.append(["mocd_emergencypersonemiratesid":mocd_emergencypersonemiratesid]);
        
        
        parametersArray.append(["mocd_emergencyrelationship":mocd_emergencyrelationship]);
        parametersArray.append(["mocd_emergencyprofession":mocd_emergencyprofession]);
        parametersArray.append(["mocd_emergencypersonaddress":mocd_emergencypersonaddress]);
        parametersArray.append(["mocd_transferparty":mocd_transferparty]);
        parametersArray.append(["mocd_transferreason":mocd_transferreason]);
        parametersArray.append(["mocd_requestingservice":mocd_requestingservice]);
        parametersArray.append(["mocd_servicerequesttype":mocd_servicerequesttype]);
        parametersArray.append(["mocd_formgroup":mocd_formgroup]);
        parametersArray.append(["mocd_serviceprocess":mocd_serviceprocess]);
        parametersArray.append(["mocd_profileid":mocd_profileid]);
        parametersArray.append(["mocd_profilename":mocd_profilename]);
        parametersArray.append(["mocd_profileemail":mocd_profileemail]);
        parametersArray.append(["mocd_profilemobilenumber":mocd_profilemobilenumber]);
        parametersArray.append(["channelId":"4"]);
        
        /*
        parametersArray.append(["RequestingService":AppConstants.RequestingServiceElderly]);
        parametersArray.append(["TypeOfRequest":AppConstants.TypeOfRequestMobileUnit]);
        parametersArray.append(["ChannelType":AppConstants.ChannelType]);
        
        */
        
        
        RequestResponseWebServices.requestByPOST(WebServiceUrl: webResource, params: &parametersArray, endpoint: "masterService", completion: { (json) in
            
            completeion(json)
            
        })

        
    }
    
    static func SaveElderlyRegistrationInNursingHome(mocd_applicantemiratesid: String = "784190928512227" ,
                                                     mocd_applicantname: String = "Test",
                                                     mocd_applicanthomeaddress: String = "test" ,
                                                     mocd_applicantworkphoneno: String = "13232",
                                                     mocd_applicantworkaddress: String  = "Test1",
                                                     mocd_applicantphoneno: String  = "042562323",
                                                     mocd_servicetype: String  = "1",
                                                     mocd_elderlyemiratesid: String = "784190928573337",
                                                     mocd_fullnameen:String = "Test1",
                                                     mocd_fullnamear: String  = "Test1",
                                                     mocd_firstnameen: String = "Test1",
                                                     mocd_secondnameen: String = "Test1",
                                                     mocd_thirdnameen: String = "Test1",
                                                     mocd_fourthnameen: String = "Test1",
                                                     mocd_firstnamear: String = "test1",
                                                     mocd_secondnamear: String = "Test1",
                                                     mocd_thirdnamear: String = "test1",
                                                     mocd_fourthnamear: String = "test1",
                                                     mocd_gender: String = "1",
                                                     mocd_dateofbirth: String = "1973-10-30T20:00:00Z" ,
                                                     mocd_nationality: String = "1c725133-12b0-ea11-a2c7-00155d138354" ,
                                                     mocd_residenceemirate: String = "a19fa49b-a39c-e911-a2b6-00155d138354" ,
                                                     mocd_mobilenumber: String = "0555319789" ,
                                                     mocd_telephonenumber: String = "042562323" ,
                                                     mocd_address: String = "test" ,
                                                     mocd_email: String = "test@test.com" ,
                                                     mocd_haschildrens: String = "1" ,
                                                     mocd_describechildrens: String = "Childrens have been described" ,
                                                     mocd_placeofshelter: String = "It is in place of shelter" ,
                                                     mocd_applicantrelationship: String = "0cfdfccd-9d2c-eb11-a2c2-00155d138370" ,
                                                     
                                                     mocd_formgroup: String = "1" ,
                                                     mocd_serviceprocess: String = "2" ,
                                                     mocd_profileid: String = "6567878978978789" ,
                                                     mocd_profilename: String = "784198128670673" ,
                                                     mocd_profileemail: String = "Test" ,
                                                     mocd_profilemobilenumber: String = "0555319789" ,
                                
                                
                                                     completeion: @escaping ([String:Any]) -> Void  ) {
    
     
        let webResource = "Services/SaveElderlyRegistrationInNursingHome"
        var parametersArray:[[String:Any]] = [[:]]
        
        parametersArray.append(["mocd_applicantemiratesid":mocd_applicantemiratesid]);
        parametersArray.append(["mocd_applicantname":mocd_applicantname]);
        parametersArray.append(["mocd_applicanthomeaddress":mocd_applicanthomeaddress]);
        parametersArray.append(["mocd_applicantworkphoneno":mocd_applicantworkphoneno]);
        parametersArray.append(["mocd_applicantworkaddress":mocd_applicantworkaddress]);
        parametersArray.append(["mocd_applicantphoneno":mocd_applicantphoneno]);
        parametersArray.append(["mocd_servicetype":mocd_servicetype]);
        parametersArray.append(["mocd_elderlyemiratesid":mocd_elderlyemiratesid]);
        
        
        
        
        
        parametersArray.append(["mocd_fullnameen":mocd_fullnameen]);
        parametersArray.append(["mocd_fullnamear":mocd_fullnamear]);
        parametersArray.append(["mocd_firstnameen":mocd_firstnameen]);
        parametersArray.append(["mocd_secondnameen":mocd_secondnameen]);
        parametersArray.append(["mocd_thirdnameen":mocd_thirdnameen]);
        parametersArray.append(["mocd_fourthnameen":mocd_fourthnameen]);
        parametersArray.append(["mocd_firstnamear":mocd_firstnamear]);
        parametersArray.append(["mocd_secondnamear":mocd_secondnamear]);
        parametersArray.append(["mocd_thirdnamear":mocd_thirdnamear]);
        parametersArray.append(["mocd_fourthnamear":mocd_fourthnamear]);
        parametersArray.append(["mocd_gender":mocd_gender]);
        parametersArray.append(["mocd_dateofbirth":mocd_dateofbirth]);
        parametersArray.append(["mocd_nationality":mocd_nationality]);
        parametersArray.append(["mocd_residenceemirate":mocd_residenceemirate]);
        parametersArray.append(["mocd_mobilenumber":mocd_mobilenumber]);
        parametersArray.append(["mocd_telephonenumber":mocd_telephonenumber]);
        parametersArray.append(["mocd_address":mocd_address]);
        parametersArray.append(["mocd_email":mocd_email]);
        parametersArray.append(["mocd_haschildrens":mocd_haschildrens]);
        parametersArray.append(["mocd_describechildrens":mocd_describechildrens]);
        parametersArray.append(["mocd_placeofshelter":mocd_placeofshelter]);
        parametersArray.append(["mocd_applicantrelationship":mocd_applicantrelationship]);
        parametersArray.append(["mocd_requestingservice":AppConstants.RequestingServiceElderly]);
        parametersArray.append(["mocd_servicerequesttype":AppConstants.TypeOfRequestNursinghome]);
        parametersArray.append(["mocd_formgroup":mocd_formgroup]);
        parametersArray.append(["mocd_serviceprocess":mocd_serviceprocess]);
        parametersArray.append(["mocd_profileid":mocd_profileid]);
        parametersArray.append(["mocd_profilename":mocd_profilename]);
        parametersArray.append(["mocd_profileemail":mocd_profileemail]);
        parametersArray.append(["mocd_profilemobilenumber":mocd_profilemobilenumber]);
        
    
        /*
        parametersArray.append(["RequestingService":AppConstants.RequestingServiceElderly]);
        parametersArray.append(["TypeOfRequest":AppConstants.TypeOfRequestMobileUnit]);
        parametersArray.append(["ChannelType":AppConstants.ChannelType]);
        */
        parametersArray.append(["channelId":"4"]);
        
        
        
        RequestResponseWebServices.requestByPOST(WebServiceUrl: webResource, params: &parametersArray, endpoint: "masterService", completion: { (json) in
            
            completeion(json)
            
        })

        
    }
    
    static func SaveElderlyAppointment(mocd_applicantemiratesid: String = "784190928512229" ,
                                       mocd_applicantname: String = "Test",
                                       mocd_applicantphoneno: String = "0555319789" ,
                                       mocd_elderlyemiratesid: String = "784190928573339",
                                       mocd_servicetype: String  = "3",
                                       mocd_fullnameen: String  = "Test",
                                       mocd_fullnamear: String  = "Test",
                                       mocd_firstnameen: String = "Test",
                                       mocd_secondnameen:String = "Test1",
                                       mocd_thirdnameen: String  = "Test1",
                                       mocd_fourthnameen: String = "Test1",
                                       mocd_firstnamear: String = "Test1",
                                       mocd_secondnamear: String = "Test1",
                                       mocd_thirdnamear: String = "Test1",
                                       mocd_fourthnamear: String = "test1",
                                       mocd_gender: String = "1",
                                       mocd_dateofbirth: String = "1973-10-30T20:00:00Z",
                                       mocd_nationality: String = "1c725133-12b0-ea11-a2c7-00155d138354",
                                       mocd_residenceemirate: String = "a19fa49b-a39c-e911-a2b6-00155d138354",
                                       mocd_mobilenumber: String = "0555319789" ,
                                       mocd_telephonenumber: String = "042562323" ,
                                       mocd_address: String = "test" ,
                                       mocd_email: String = "test@test.com" ,
                                       mocd_hobby: String = "1" ,
                                       mocd_typeofactivity: String = "1" ,
                                       mocd_appointmentdate: String = "2020-11-30T20:00:00Z" ,
                                       mocd_otherphonenumber: String = "042562323" ,
                                       mocd_formgroup: String = "1" ,
                                       mocd_serviceprocess: String = "2" ,
                                       mocd_profileid: String = "6567878978978789" ,
                                                     
                                       mocd_profilename: String = "6567878978978789" ,
                                       mocd_profileemail: String = "6567878978978789" ,
                                       mocd_profilemobilenumber: String = "6567878978978789" ,
                                                    
                                
                                                     
                                       completeion: @escaping ([String:Any]) -> Void  ) {
    
     
        let webResource = "Services/SaveElderlyAppointment"
        var parametersArray:[[String:Any]] = [[:]]
        
        parametersArray.append(["mocd_applicantemiratesid":mocd_applicantemiratesid]);
        parametersArray.append(["mocd_applicantname":mocd_applicantname]);
        parametersArray.append(["mocd_applicantphoneno":mocd_applicantphoneno]);
        parametersArray.append(["mocd_servicetype":mocd_servicetype]);
        parametersArray.append(["mocd_elderlyemiratesid":mocd_elderlyemiratesid]);
        parametersArray.append(["mocd_fullnameen":mocd_fullnameen]);
        parametersArray.append(["mocd_fullnamear":mocd_fullnamear]);
        parametersArray.append(["mocd_firstnameen":mocd_firstnameen]);
        
        
        
        
        
        parametersArray.append(["mocd_secondnameen":mocd_secondnameen]);
        parametersArray.append(["mocd_thirdnameen":mocd_thirdnameen]);
        parametersArray.append(["mocd_fourthnameen":mocd_fourthnameen]);
        parametersArray.append(["mocd_firstnamear":mocd_firstnamear]);
        parametersArray.append(["mocd_secondnamear":mocd_secondnamear]);
        parametersArray.append(["mocd_thirdnamear":mocd_thirdnamear]);
        parametersArray.append(["mocd_fourthnamear":mocd_fourthnamear]);
        parametersArray.append(["mocd_gender":mocd_gender]);
        parametersArray.append(["mocd_dateofbirth":mocd_dateofbirth]);
        parametersArray.append(["mocd_nationality":mocd_nationality]);
        parametersArray.append(["mocd_residenceemirate":mocd_residenceemirate]);
        parametersArray.append(["mocd_mobilenumber":mocd_mobilenumber]);
        parametersArray.append(["mocd_telephonenumber":mocd_telephonenumber]);
        parametersArray.append(["mocd_address":mocd_address]);
        parametersArray.append(["mocd_email":mocd_email]);
        parametersArray.append(["mocd_hobby":mocd_hobby]);
        parametersArray.append(["mocd_typeofactivity":mocd_typeofactivity]);
        parametersArray.append(["mocd_appointmentdate":mocd_appointmentdate]);
        parametersArray.append(["mocd_otherphonenumber":mocd_otherphonenumber]);
        parametersArray.append(["mocd_requestingservice":AppConstants.RequestingServiceElderly]);
        parametersArray.append(["mocd_servicerequesttype":AppConstants.TypeOfRequestAppointmentservice]);
        parametersArray.append(["mocd_formgroup":mocd_formgroup]);
        parametersArray.append(["mocd_serviceprocess":mocd_serviceprocess]);
        parametersArray.append(["mocd_profileid":mocd_profileid]);
        parametersArray.append(["mocd_profilename":mocd_profilename]);
        parametersArray.append(["mocd_profileemail":mocd_profileemail]);
        parametersArray.append(["mocd_profilemobilenumber":mocd_profilemobilenumber]);
        
        
    
        //parametersArray.append(["RequestingService":AppConstants.RequestingServiceElderly]);
        //parametersArray.append(["TypeOfRequest":AppConstants.TypeOfRequestMobileUnit]);
        parametersArray.append(["channelId":"4"]);
        
        
        
        
        RequestResponseWebServices.requestByPOST(WebServiceUrl: webResource, params: &parametersArray, endpoint: "masterService", completion: { (json) in
            
            completeion(json)
            
        })

        
    }
    
    static func SubmitGrantRequest(HusbandNationalId: String,WifeNationalId: String,MarriageContractDate: String,
                                   Court: String,
                                   EmployerCategory: String,
                                   HusbandFullNameArabic: String,
                                   HusbandFullNameEnglish: String,
                                   HusbandBirthDate: String,
                                   HusbandEducationLevel: String,
                                   HusbandMobile1: String,
                                   HusbandMobile2: String,
                                   HusbandEmail: String,
                                   WifeFullNameArabic: String,
                                   WifeFullNameEnglish: String,
                                   WifeBirthDate: String,
                                   WifeEducationLevel: String,
                                   WifeMobile1: String,
                                   WifeEmail: String,
                                   FamilyBookNumber: String,
                                   TownNumber: String,
                                   FamilyNumber: String,
                                   
                                   FamilyBookIssueDate: String,
                                   FamilyBookIssuePlace: String,
                                   Employer: String,
                                   WorkPlace: String,
                                   Totalmonthlyincome: String,
                                   BankName: String,
                                   IBAN: String,completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "Services/MFSubmitGrantRequest"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        parametersArray.append(["HusbandNationalId":HusbandNationalId])
        parametersArray.append(["WifeNationalId":WifeNationalId])
        
        parametersArray.append(["MarriageContractDate":MarriageContractDate])
        parametersArray.append(["Court":Court])
        parametersArray.append(["EmployerCategory":EmployerCategory])
        parametersArray.append(["HusbandFullNameArabic":HusbandFullNameArabic])
        parametersArray.append(["HusbandFullNameEnglish":HusbandFullNameEnglish])
        parametersArray.append(["HusbandBirthDate":HusbandBirthDate])
        parametersArray.append(["HusbandEducationLevel":HusbandEducationLevel])
        parametersArray.append(["HusbandMobile1":HusbandMobile1])
        parametersArray.append(["HusbandMobile2":HusbandMobile2])
        parametersArray.append(["HusbandEmail":HusbandEmail])
        parametersArray.append(["WifeFullNameArabic":WifeFullNameArabic])
        parametersArray.append(["WifeFullNameEnglish":WifeFullNameEnglish])
        parametersArray.append(["WifeBirthDate":WifeBirthDate])
        parametersArray.append(["WifeEducationLevel":WifeEducationLevel])
        parametersArray.append(["WifeMobile1":WifeMobile1])
        parametersArray.append(["WifeEmail":WifeEmail])
        parametersArray.append(["FamilyBookNumber":FamilyBookNumber])
        parametersArray.append(["TownNumber":TownNumber])
        parametersArray.append(["FamilyNumber":FamilyNumber])
        parametersArray.append(["FamilyBookIssueDate":FamilyBookIssueDate])
        
        parametersArray.append(["FamilyBookIssuePlace":FamilyBookIssuePlace])
        parametersArray.append(["Employer":Employer])
        parametersArray.append(["WorkPlace":WorkPlace])
        parametersArray.append(["Totalmonthlyincome":Totalmonthlyincome])
        
        parametersArray.append(["BankName":BankName])
        parametersArray.append(["IBAN":IBAN])
        parametersArray.append(["TypeOfRequest":AppConstants.TypeOfRequestGrantRequestDEV])
        parametersArray.append(["RequestingService":AppConstants.RequestingServiceGrantRequestDEV])
        parametersArray.append(["ChannelType":AppConstants.ChannelType])

        
        RequestResponseWebServices.requestByPOST(WebServiceUrl: webResource, params: &parametersArray, endpoint: "masterService" ) { (json) in
            completetion(json)
        }
    }
    
    static func SubmitEdaadRequest(HusbandNationalId: String,WifeNationalId: String,MarriageContractDate: String,
                                   
                                  
                                 
                                   HusbandFullNameEnglish: String,
                                   HusbandEmail: String,
                                   WifeFullNameEnglish: String,
                                   
                                   
                                
                                   FamilyBookIssuePlace: String,
                                   completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "Services/SubmitEdaadRequest"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        parametersArray.append(["HusbandNationalId":HusbandNationalId])
        parametersArray.append(["WifeNationalId":WifeNationalId])
        
        parametersArray.append(["MarriageContractDate":MarriageContractDate])
        parametersArray.append(["HusbandFullNameEnglish":HusbandFullNameEnglish])
        parametersArray.append(["WifeFullNameEnglish":WifeFullNameEnglish])
        parametersArray.append(["HusbandEmail":HusbandEmail])
        
        
        
        parametersArray.append(["FamilyBookIssuePlace":FamilyBookIssuePlace])
        
        parametersArray.append(["TypeOfRequest":AppConstants.TypeOfRequestEdaadDEV])
        parametersArray.append(["RequestingService":AppConstants.RequestingServiceEdaadDEV])
        parametersArray.append(["ChannelType":AppConstants.ChannelType])

        
        RequestResponseWebServices.requestByPOST(WebServiceUrl: webResource, params: &parametersArray, endpoint: "masterService" ) { (json) in
            completetion(json)
        }
    }
    
    static func ServiceRequestSubmit(RequestId: String,
                                   completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "Services/ServiceRequestSubmit"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        parametersArray.append(["RequestId":RequestId])
       
        
        RequestResponseWebServices.requestByPOST(WebServiceUrl: webResource, params: &parametersArray, endpoint: "masterService" ) { (json) in
            completetion(json)
        }
    }
    static func SubmitElderlyRequest(RequestId: String,AppReference: String , IsUpdate: String ,
                                   completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "Services/SubmitElderlyRequest"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        parametersArray.append(["RequestId":RequestId])
        parametersArray.append(["AppReference":RequestId])
        parametersArray.append(["IsUpdate":RequestId])
       
        
        RequestResponseWebServices.requestByPOST(WebServiceUrl: webResource, params: &parametersArray, endpoint: "masterService" ) { (json) in
            completetion(json)
        }
    }
    static func UploadDocumentByServiceRequest(ServiceRequestId: String,
                                               FileName: String,
                                               FileContent: String,
                                               DocumentType: String,
                                               DocumentId: String,
                                               FileSize: String,
                                               FileExtenstion: String,
                                               DocumentName: String,
                                               
                                   completetion: @escaping ([String:Any]) -> Void) {
        
        let webResource = "Services/UploadDocumentByServiceRequest"
        var parametersArray: [[String:Any]] = [[:]]
        
    
        parametersArray.append(["ServiceRequestId":ServiceRequestId])
        parametersArray.append(["FileName":FileName])
        parametersArray.append(["FileContent":FileContent])
        parametersArray.append(["DocumentType":DocumentType])
        parametersArray.append(["DocumentId":DocumentId])
        parametersArray.append(["FileSize":FileSize])
        parametersArray.append(["FileExtenstion":FileExtenstion])
        parametersArray.append(["DocumentName":DocumentName])
        
       
        
        RequestResponseWebServices.requestByPOST(WebServiceUrl: webResource, params: &parametersArray, endpoint: "masterService" ) { (json) in
            completetion(json)
        }
    }
    /*
    static func getCountries( completetion: @escaping ([String:Any]) -> Void) {
        
        
       
        
        let webResource = "getCountries"
        var parametersArray: [[String:Any]] = [[:]]
        

        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "user") { (json) in
            completetion(json)
        }
    }
    */
    static func getNationalities( completetion: @escaping ([String:Any]) -> Void) {
        
        
       
        
        let webResource = "getNationalities"
        var parametersArray: [[String:Any]] = [[:]]
        

        
        RequestResponseWebServices.requestByGET(WebServiceUrl: webResource, params: &parametersArray, endpoint: "parent") { (json) in
            completetion(json)
        }
    }
    
}
