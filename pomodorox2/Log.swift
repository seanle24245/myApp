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

    init(logEntry:String?,logTime:Date, audio:AVAudioFile?){
        
        textContent=logEntry
        entryTime=logTime
        audioContent=audio
        
        
    }
    




}
