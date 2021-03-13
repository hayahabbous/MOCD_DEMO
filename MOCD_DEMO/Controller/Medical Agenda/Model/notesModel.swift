//
//  Notes_Model.swift
//  SwiftDatabase
//
//  Created by indianic on 31/12/16.
//  Copyright © 2016 demo. All rights reserved.
//

import UIKit

class notesModel: NSObject {
    
    var identifier : Int!
    var title : String!
    var date : String!
    var time: String!
    var comments: String!
    
    
    var aMutArrNotes = [notesModel]()
    
    func getAllNotes() -> [notesModel] {
        
        let aTempObj: [[String: AnyObject]] = Database().selectAllfromTable(query: "SELECT * FROM notes") { (result: String) in}
        
        if aMutArrNotes.count > 0 {
            aMutArrNotes.removeAll()
            
        }
        
        for objNote in aTempObj {
            
            let aObjNote = notesModel()
            
            aObjNote.identifier = objNote["note_id"] as? Int
            aObjNote.title = objNote["note_title"] as? String
            aObjNote.date = objNote["note_date"] as? String
            aObjNote.time = objNote["note_time"] as? String
            aObjNote.comments = objNote["note_comments"] as? String
            
            self.aMutArrNotes.append(aObjNote)
            
        }
        
        return self.aMutArrNotes.reversed()
    }
    
    func addNewNotes(objNoteModel: notesModel, complition: ((_ success: Bool)  -> Void)){
        
        // Insert into appointment table
//        let aStrInsert = "INSERT INTO notes (note_title, note_date, note_time, note_comments) VALUES ('\(objNoteModel.title!)', '\(objNoteModel.date!)', '\(objNoteModel.time!)', '\(objNoteModel.comments!)')"
        let aStrInsert = "INSERT INTO notes (note_title, note_date, note_comments) VALUES ('\(objNoteModel.title!)','\(objNoteModel.date!)','\(objNoteModel.comments!)')"

        
        print(aStrInsert)
        
        Database.sharedInstance.insert(query: aStrInsert, success: {
            complition(true)
        }, failure: {
            // failure.
            complition(false)
        })
    }
    
    func updateNotes(objNoteModel: notesModel, complition: ((_ success: Bool)  -> Void)){
        
        // Insert into appointment table
//        let aStrInsert = "UPDATE notes SET note_title = '\(objNoteModel.title!)', note_date = '\(objNoteModel.date!)', note_time = '\(objNoteModel.time!)', note_comments = '\(objNoteModel.comments!)' WHERE note_id = '\(objNoteModel.identifier!)'"
        let aStrInsert = "UPDATE notes SET note_title = '\(objNoteModel.title!)',note_date = '\(objNoteModel.date!)', note_comments = '\(objNoteModel.comments!)' WHERE note_id = '\(objNoteModel.identifier!)'"
        
        print(aStrInsert)
        
        Database.sharedInstance.update(query: aStrInsert, success: {
            complition(true)
        }, failure: {
            // failure.
            complition(false)
        })
    }
    
    
    
    func deleteNotes(deleteID: Int, complition: ((Bool)  -> Void)) {
        
        let sqlDeleteNotes =  "DELETE FROM notes WHERE note_id='\(deleteID)'"
        //        let sqlDeleteReminder =  "DELETE FROM reminder WHERE type_id='\(deleteID)'"
        
        Database().delete(query: sqlDeleteNotes, success: { (success: Bool) in
            // Delete from Appointment table
            complition(true)
            
            //            Database().delete(query: sqlDeleteReminder, success: { (success: Bool) in
            //                // Delete from reminder table
            //
            //                complition(true)
            //            }) { (failure: Bool) in
            //                complition(false)
            //            }
            
        }) { (failure: Bool) in
            complition(false)
        }
    }
    
    
}
