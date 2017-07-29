
//
//  LogViewController.swift
//  pomodorox2
//
//  Created by Sean Le on 7/29/17.
//  Copyright © 2017 Sean Le. All rights reserved.
//


//
//  focusView.swift
//  pomodorox2
//
//  Created by Sean Le on 7/28/17.
//  Copyright © 2017 Sean Le. All rights reserved.
//

import Foundation
import UIKit
import AudioToolbox
class LogViewController: UIViewController {
    
    var timer:Timer=Timer()
    var totalSeconds:Int=5
    var initialTime:Int=5
    var timerIsOn:Bool=false
    var minutesToDisplay:Int=0
    var secondsToDisplay:Int=0
    
    
    @IBOutlet weak var logTimeLabel: UILabel!
    
    @IBOutlet weak var logProgressBar: UIProgressView!
    
    
    
    @IBAction func logStartButton(_ sender: Any) {
        if timerIsOn == false{
            
            
            
            timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(FocusViewController.updateTimer)), userInfo: nil, repeats: true)
            timerIsOn=true
        
    }
    }
    
    
        
    @IBAction func logPauseButton(_ sender: Any) {
        timer.invalidate()
        
        
        logTimeLabel.text="\(minutesToDisplay)"+":"+"\(secondsToDisplay)"
        timerIsOn=false
    }

    
    
    func updateTimer(){
        totalSeconds-=1
        secondsToDisplay=totalSeconds%60
        minutesToDisplay=totalSeconds/60
        
        
        
        if secondsToDisplay<10{
            logTimeLabel.text="\(minutesToDisplay)" + ":" + "0"+"\(secondsToDisplay)"
        }
        else{
            logTimeLabel.text="\(minutesToDisplay)"+":"+"\(secondsToDisplay)"
        }
        
        if totalSeconds==0{
            timer.invalidate()
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
            
        }
        
        let toIncrementProgress:Float=1/(Float)(initialTime)
        logProgressBar.progress+=toIncrementProgress
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
    }
    
    
    
}
