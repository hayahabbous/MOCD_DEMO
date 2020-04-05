//
//  FileHelper.swift
//  MOCD_DEMO
//
//  Created by macbook pro on 11/13/19.
//  Copyright © 2019 Datacellme. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

class FileHelper: NSObject {
    
    static let fileTypes = ["com.adobe.pdf","com.microsoft.word.docx","com.microsoft.word.doc","com.microsoft.word.docx",
                            "com.microsoft.powerpoint.ppt","com.microsoft.powerpoint.ppt","com.microsoft.excel.xls","com.microsoft.excel.xlsx",
                            "com.pkware.zip-archive","com.pkware.zip-archive", String(kUTTypePlainText),String(kUTTypeUTF8PlainText),String(kUTTypeUTF16PlainText),"com.apple.traditional-mac-​plain-text",String(kUTTypeRTF)]
    
    static func mimeTypeForPath(path: String) -> String {
        let url = NSURL(fileURLWithPath: path)
        let pathExtension = url.pathExtension
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension! as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return "application/octet-stream"
        //return pathExtension!
    }
    
    static func extensionForPath(path: String) -> String {
        let url = NSURL(fileURLWithPath: path)
        return url.pathExtension!
    }
    
    
    static func documentsPathForImages(filename: String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsPath: String = paths[0]
        
        var url = URL(fileURLWithPath: documentsPath)
        
        url.appendPathComponent(filename, isDirectory: false)
        print(url.pathComponents)
        return url.path
    }
    

    
    static func isDirectoryExists(directory: String) -> Bool {
        let fileManager = FileManager.default
        var isDir : ObjCBool = true
        if fileManager.fileExists(atPath: directory, isDirectory:&isDir) {
            if isDir.boolValue {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    static func createDirectory(forUser userId: String) {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentsDirectory = paths[0]
        let url = URL(string: documentsDirectory)!
        let userPath = url.appendingPathComponent(userId)
        
        do {
            try FileManager.default.createDirectory(atPath: userPath.path, withIntermediateDirectories: false, attributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription);
        }
    }
    
    static func extractUserIdFromJID(jid: String) -> String {
        let firstStep = jid.components(separatedBy: "@").first!
        //let secondStep = firstStep.components(separatedBy: "a").last!
        return firstStep
    }
    static func extractGroupIdFromJID(jid: String) -> String {
        return jid.components(separatedBy: "@").first!
    }
    
    static func getImage(fromUrl url: URL) -> UIImage? {
        let data = try? Data(contentsOf: url)
        if data == nil {
            return nil
        }
        return UIImage(data: data!)
    }
    
    static func getFiles() {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL.appendingPathComponent("12345"), includingPropertiesForKeys: nil)
            print(fileURLs)
            for item in fileURLs {
                let relativePath = FileHelper.getRelatedPath(forFileURL: item)
                print("relativePath: " + relativePath)
                let image = FileHelper.getImage(fromUrl: item)
                let i = image?.description
                print(i)
            }
            // process files
        } catch {
            print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
        }
    }
    
    static func getRelatedPath(forFileURL url : URL) -> String {
        let components = url.pathComponents
        let file = components.last!
        let dir = components[components.count - 2]
        
        return dir + "/" + file
    }
    
    static func getFullPath(forRelativeURL relativeUrl: String) -> URL {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        //print(documentsURL.appendingPathComponent(relativeUrl))
        return documentsURL.appendingPathComponent(relativeUrl)
    }
    
    static func isImageExtension(ext: String) -> Bool {
        let extLower = ext.lowercased()
        if extLower == "jpeg" || extLower == "jpg" || extLower == "png" || extLower == "gif" || extLower == "bmp" {
            return true
        }
        else {
            return false
        }
    }
    
}

