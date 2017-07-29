//
//  Log.swift
//  pomodorox2
//
//  Created by Sean Le on 7/27/17.
//  Copyright © 2017 Sean Le. All rights reserved.
//

import Foundation
import AVFoundation

class Log{

    var textContent:String?
    var audioContent:AVAudioFile?
    var entryTime:Date
    var subject:String?

    init(logEntry:String?,logTime:Date, audio:AVAudioFile?, subjectEntry:String?){
        
        let emptyString:String = ""
        subject=subjectEntry ?? emptyString
        textContent=logEntry ?? emptyString
        entryTime=logTime
        audioContent=audio ?? nil
        
        
    }
    




}
