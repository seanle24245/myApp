//
//  CoreDataHelper.swift
//  pomodorox2
//
//  Created by Sean Le on 8/1/17.
//  Copyright © 2017 Sean Le. All rights reserved.
//

import Foundation

import Foundation
import CoreData
import UIKit
import AVFoundation

class CoreDataHelper {
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let context = appDelegate.persistentContainer.viewContext
    
    //static methods will go here
    
    
    
    
    static func addLog(text:String?, id: String?, subject: String?){
        
        let dateToLog = Date()
        
        let newLog = NSEntityDescription.insertNewObject(forEntityName: "Log", into: context) as! Log
        
        ///newLog.setValue("dateToLog, forKey: "date")
        //newLog.setValue(audio, forKey: "audioLog")
        //newLog.setValue("text", forKey: "textLog")
        //newLog.setValue("subject", forKey: "subjectLine")
        
        newLog.audioUIUD = id
        newLog.subjectLine = subject
        newLog.date = dateToLog as NSDate
        newLog.textLog = text
        
        
            saveLog()
            print("saved")
        
        
        
    }
    static func getContents() -> [Log]{
        let fetchRequest = NSFetchRequest<Log>(entityName: "Log")
        do {
            let results = try context.fetch(fetchRequest)
            return results
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
        return []
    }
    
    static func saveLog() {
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save \(error)")
        }
    }
    
    static func delete(log: Log) {
        context.delete(log)
        saveLog()
    }
    
}



//static func getContents() -> [Log]{
//    
//    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Log")
//    request.returnsObjectsAsFaults=false
//    
//    
//    do{
//        let results = try context.fetch(request)
//        
//        var returnArray: [(date: Date, audio: AVAudioFile?, text: String?, subject: String?)] = []
//        
//        
//        if results.count > 0{
//            for result in results as! [NSManagedObject]{
//                let dateToSave: Date = result.value(forKey: "date") as! Date
//                let audioFileToSave: AVAudioFile? = (result.value(forKey: "audioLog") as! AVAudioFile?)!
//                let subjectLineToSave: String? = (result.value(forKey: "subjectLine") as! String?)!
//                let textToSave: String? = (result.value(forKey: "textLog") as! String?)!
//                
//                
//                let tupleToAdd = (date:dateToSave, audio: audioFileToSave, text: textToSave, subject: subjectLineToSave)
//                
//                returnArray.append(tupleToAdd)
//                
//                
//                
//            }
//        }
//        return returnArray
//    }
//    catch{
//        print("coredata retrieval fail")
//    }
//    
//    
//}
