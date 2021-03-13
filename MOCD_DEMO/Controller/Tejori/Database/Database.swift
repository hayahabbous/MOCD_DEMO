//
//  Database.swift
//  test
//
//  Created by indianic on 27/12/16.
//  Copyright © 2016 manish. All rights reserved.
//

import UIKit

let aStrDBName = "Edkhar.sqlite"
let aStrDBTitle = "Edkhar"
let aStrDBExtenstion = "sqlite"

class DatabaseEdkhar: NSObject {
    
    var db: OpaquePointer? = nil
    
    var statement: OpaquePointer? = nil
    
    // MARK: Shared Utility
    class var sharedInstance: DatabaseEdkhar {
        struct Static {
            static var instance = DatabaseEdkhar()
        }
        
        return Static.instance
    }
    
    class func createPath(dbname: String) -> String {
        
        let doumentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let destinationPath = doumentDirectoryPath.appendingPathComponent(dbname)
        
        return destinationPath
    }
    
    func createEditableCopyOfDatabaseIfNeeded(failure complitionFailure: (()-> Void)) {
        let fileManger = FileManager.default
        
        let sourcePath = Bundle.main.path(forResource: aStrDBTitle, ofType: aStrDBExtenstion)
        
        let dbPath = DatabaseEdkhar.createPath(dbname: aStrDBName)
        
        print("dbPath = \(dbPath)")
        
        if fileManger.fileExists(atPath: dbPath) {
            //Success
            let successBackup = addSkipBackupAttributeToItem(at: URL(fileURLWithPath: dbPath))
            print(successBackup)
            
        }else{
            //Failure
            
            do {
                try fileManger.copyItem(atPath: sourcePath!, toPath: dbPath)
            }catch{
                print(error.localizedDescription)
                
                // Alert if file is not exist
                if !error.localizedDescription.contains("already exists") {
                    print(error.localizedDescription)
                    
                    complitionFailure()
                    
                }else{
                    
                    print(error.localizedDescription)
                    
                }
            }
        }
    }
    
    func insert(query: String, success complition: (()-> Void), failure complitionFailure: (()-> Void)) {
        
        let dbPath = DatabaseEdkhar.createPath(dbname: aStrDBName)
        
        print("dbPath = \(dbPath)")
        
        if sqlite3_open(URL(fileURLWithPath: dbPath).path, &db) == SQLITE_OK {
            
            if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
                
                if sqlite3_step(statement) == SQLITE_DONE {
                    
                    if sqlite3_finalize(statement) == SQLITE_OK {
                        
                        if sqlite3_close(db) == SQLITE_OK {
                            sqlite3_close(db)
                            complition()
                            
                        }else{
                            sqlite3_errmsg(db)
                            let errmsg = String(cString: sqlite3_errmsg(db))
                            print("error preparing insert: \(errmsg)")
                        }
                    }else{
                        sqlite3_errmsg(db)
                        let errmsg = String(cString: sqlite3_errmsg(db))
                        print("error preparing insert: \(errmsg)")
                    }
                }else{
                    let errmsg = String(cString: sqlite3_errmsg(db))
                    print("error preparing insert: \(errmsg)")
                    complitionFailure()
                    
                }
            }else{
                let errmsg = String(cString: sqlite3_errmsg(db))
                print("error preparing insert: \(errmsg)")
                complitionFailure()
                
            }
        }else{
            sqlite3_errmsg(db)
            
        }
        
    }
    
    
    func update(query: String, success complition: (()-> Void), failure complitionFailure: (()-> Void)) {
        
        
        let dbPath = DatabaseEdkhar.createPath(dbname: aStrDBName)
        
        print("dbPath = \(dbPath)")
        
        if sqlite3_open(URL(fileURLWithPath: dbPath).path, &db) == SQLITE_OK {
            
            if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
                
                if sqlite3_step(statement) == SQLITE_DONE {
                    
                    if sqlite3_finalize(statement) == SQLITE_OK {
                        
                        if sqlite3_close(db) == SQLITE_OK {
                            sqlite3_close(db)
                            complition()
                            
                        }else{
                            sqlite3_errmsg(db)
                            
                        }
                    }else{
                        sqlite3_errmsg(db)
                        
                    }
                }
                
                
            }else{
                let errmsg = String(cString: sqlite3_errmsg(db))
                print("error preparing insert: \(errmsg)")
                complitionFailure()
            }
        }else{
            sqlite3_errmsg(db)
            
        }
        
        
        
    }
    
    func delete(query: String, success complition: ((Bool)-> Void), failure complitionFailure: ((Bool)-> Void)) {
        
        var aDeleteStatus : Bool
        
        let dbPath = DatabaseEdkhar.createPath(dbname: aStrDBName)
        
        print("dbPath = \(dbPath)")
        
        if sqlite3_open(URL(fileURLWithPath: dbPath).path, &db) == SQLITE_OK {
            
            if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
                
                if sqlite3_step(statement) == SQLITE_DONE {
                    if sqlite3_finalize(statement) == SQLITE_OK {
                        
                        if sqlite3_close(db) == SQLITE_OK {
                            sqlite3_close(db)
                            aDeleteStatus = true
                            complition(aDeleteStatus)
                            
                        }else{
                            sqlite3_errmsg(db)
                            
                        }
                    }else{
                        sqlite3_errmsg(db)
                    }
                }
                
                
            }else{
                let errmsg = String(cString: sqlite3_errmsg(db))
                print("error preparing insert: \(errmsg)")
                aDeleteStatus = false
                complitionFailure(aDeleteStatus)
                
            }
        }else{
            sqlite3_errmsg(db)
            
        }
        
        
        
        
    }
    
    
    func getRecordCount(query: String, success complition: ((Int)-> Void), failure complitionFailure: (()-> Void)) {
        
        var count: Int = 0
        
        let dbPath = DatabaseEdkhar.createPath(dbname: aStrDBName)
        
        print("dbPath = \(dbPath)")
        
        if sqlite3_open(URL(fileURLWithPath: dbPath).path, &db) == SQLITE_OK {
            
            if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
                
                if sqlite3_step(statement) == SQLITE_ROW {
                    count = Int(sqlite3_column_int(statement, 0))
                    
                    if sqlite3_finalize(statement) == SQLITE_OK {
                        
                        if sqlite3_close(db) == SQLITE_OK {
                            
                            sqlite3_close(db)
                            complition(count)
                        }else{
                            sqlite3_errmsg(db)
                            let errmsg = String(cString: sqlite3_errmsg(db))
                            print("error preparing insert: \(errmsg)")
                        }
                    }else{
                        
                        sqlite3_errmsg(db)
                        let errmsg = String(cString: sqlite3_errmsg(db))
                        print("error preparing insert: \(errmsg)")
                        
                    }
                    
                }
                
            }else{
                let errmsg = String(cString: sqlite3_errmsg(db))
                print("error preparing insert: \(errmsg)")
                complitionFailure()
                
            }
        }else{
            sqlite3_errmsg(db)
            
        }
        
        
        
        
    }
    
    
    func createTable(query: String, success complition: (()-> Void), failure complitionFailure: (()-> Void)) {
        
        
        let dbPath = DatabaseEdkhar.createPath(dbname: aStrDBName)
        
        print("dbPath = \(dbPath)")
        
        if sqlite3_open(URL(fileURLWithPath: dbPath).path, &db) == SQLITE_OK {
            
            if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
                
                if sqlite3_step(statement) == SQLITE_DONE {
                    if sqlite3_finalize(statement) == SQLITE_OK {
                        if sqlite3_close(db) == SQLITE_OK {
                            sqlite3_close(db)
                            complition()
                        }else{
                            sqlite3_errmsg(db)
                            
                        }
                    }else{
                        sqlite3_errmsg(db)
                        
                    }
                }
                
            }else{
                let errmsg = String(cString: sqlite3_errmsg(db))
                print("error preparing insert: \(errmsg)")
                complitionFailure()
                
            }
        }else{
            sqlite3_errmsg(db)
            
        }
        
        
        
        
    }
    
    func selectAllfromTable1( query: String) -> [[String : AnyObject]] {
        var result = [[String:AnyObject]]()
        let dbPath = DatabaseEdkhar.createPath(dbname: aStrDBName)
        
        var alldata: [[String : AnyObject]]
        alldata = [[String : AnyObject]]()
        
        if sqlite3_open(URL(fileURLWithPath: dbPath).path, &db) == SQLITE_OK {
            if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
                
                while(sqlite3_step(statement) == SQLITE_ROW) {
                    
                    let count: Int32 = sqlite3_column_count(statement)
                    print(count)
                    
                    var columnNAme: String = ""
                    
                    var aDict = [AnyHashable: Any]()
                    
                    for i in 0..<count {
                        
                        
                        /*
                         #define SQLITE_INTEGER  1
                         #define SQLITE_FLOAT    2
                         #define SQLITE_BLOB     4
                         #define SQLITE_NULL     5
                         #ifdef SQLITE_TEXT
                         # undef SQLITE_TEXT
                         #else
                         # define SQLITE_TEXT     3
                         #endif
                         #define SQLITE3_TEXT     3
                         
                         
                         */
                        
                        let columnName = sqlite3_column_name(statement, i)
                        columnNAme = String(cString: columnName!)
                        
                        if sqlite3_column_type(statement, i) == SQLITE_TEXT  {
                            
                            let name = sqlite3_column_text(statement, i)
                            
                            aDict[columnNAme] = String(cString: name!)
                            
                        }else if sqlite3_column_type(statement, 1) == SQLITE_INTEGER {
                            
                            let aintValue = sqlite3_column_int(statement, i)
                            
                            aDict[columnNAme] = String(aintValue)
                            
                        }else if sqlite3_column_type(statement, i) == SQLITE_BLOB {
                            
                            let len = sqlite3_column_bytes(statement, i)
                            
                            let aBolbValue = sqlite3_column_blob(statement, i)
                            
                            aDict[columnNAme] = NSData(bytes: aBolbValue, length: Int(len))
                            
                        }else if sqlite3_column_type(statement, i) == SQLITE_FLOAT {
                            
                            let aFloatValue = sqlite3_column_double(statement, i)
                            
                            aDict[columnNAme] = Float(aFloatValue)
                            
                        }else if sqlite3_column_type(statement, i) == SQLITE_NULL {
                            
                            
                        }
                    }
                    result.append(aDict as! [String : AnyObject])
                    
                }
            }
            sqlite3_finalize(statement)
        }
        
        sqlite3_close(db)
        let ary = alldata
        return ary
    }
    
    func selectAllfromTable(query: String, fail complitionFailure: ((String)-> Void)) -> [[String:AnyObject]] {
        
        var result = [[String:AnyObject]]()
        
        let dbPath = DatabaseEdkhar.createPath(dbname: aStrDBName)
        
        print("dbPath = \(dbPath)")
        
        if sqlite3_open(URL(fileURLWithPath: dbPath).path, &db) == SQLITE_OK {
            
            if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
                
                
                while(sqlite3_step(statement) == SQLITE_ROW) {
                    
                    let count: Int32 = sqlite3_column_count(statement)
                    print(count)
                    
                    var columnNAme: String = ""
                    
                    var aDict = [AnyHashable: Any]()
                    
                    for i in 0..<count {
                        
                        
                        /*
                         #define SQLITE_INTEGER  1
                         #define SQLITE_FLOAT    2
                         #define SQLITE_BLOB     4
                         #define SQLITE_NULL     5
                         #ifdef SQLITE_TEXT
                         # undef SQLITE_TEXT
                         #else
                         # define SQLITE_TEXT     3
                         #endif
                         #define SQLITE3_TEXT     3
                         
                         
                         */
                        
                        let columnName = sqlite3_column_name(statement, i)
                        columnNAme = String(cString: columnName!)
                        
                        if sqlite3_column_type(statement, i) == SQLITE_TEXT  {
                            
                            let name = sqlite3_column_text(statement, i)
                            
                            aDict[columnNAme] = String(cString: name!)
                            
                        }else if sqlite3_column_type(statement, i) == SQLITE_INTEGER {
                            
                            let aintValue = sqlite3_column_int(statement, i)
                            
                            aDict[columnNAme] = String(aintValue)
                            
                        }else if sqlite3_column_type(statement, i) == SQLITE_BLOB {
                            
                            let len = sqlite3_column_bytes(statement, i)
                            
                            let aBolbValue = sqlite3_column_blob(statement, i)
                            
                            aDict[columnNAme] = NSData(bytes: aBolbValue, length: Int(len))
                            
                        }else if sqlite3_column_type(statement, i) == SQLITE_FLOAT {
                            
                            let aFloatValue = sqlite3_column_double(statement, i)
                            
                            aDict[columnNAme] = Float(aFloatValue)
                            
                        }
                        else if sqlite3_column_type(statement, i) == SQLITE_FLOAT {
                            
                            let aFloatValue = sqlite3_column_double(statement, i)
                            
                            aDict[columnNAme] = Float(aFloatValue)
                            
                        }
                        else if sqlite3_column_type(statement, i) == SQLITE_NULL {
                            
                            
                        }else{
                            let name = sqlite3_column_text(statement, i)
                            
                            aDict[columnNAme] = String(cString: name!)
                        }
                    }
                    result.append(aDict as! [String : AnyObject])
                    
                }
                
            }else{
                let errmsg = String(cString: sqlite3_errmsg(db))
                complitionFailure(errmsg)
                
            }
        }else{
            let errmsg = String(cString: sqlite3_errmsg(db))
            complitionFailure(errmsg)
        }
        
        return result
        
    }
    
    func addSkipBackupAttributeToItem(at URL: URL) -> Bool {
        do {
            if FileManager.default.fileExists(atPath: URL.path) {
                let error: Error? = nil
                let success = try NSURL(string: URL.absoluteString)?.setResourceValue(Int(true), forKey: .isExcludedFromBackupKey)
                if success == nil {
                    print("Error excluding \(URL.lastPathComponent) from backup \(error)")
                }
                return (success != nil)
            }
        }
        catch {
        }
        return false
    }
}
