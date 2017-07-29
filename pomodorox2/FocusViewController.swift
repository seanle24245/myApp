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
class FocusViewController: UIViewController {

    var timer:Timer=Timer()
    var totalSeconds:Int=10
    var timerIsOn:Bool=false
    var minutesToDisplay:Int=0
    var secondsToDisplay:Int=0
    @IBOutlet weak var focusTimeLabel: UILabel!
    
    
    
    
    
    @IBAction func startButton(_ sender: Any) {
        
        if timerIsOn == false{
            
        
        
        timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(FocusViewController.updateTimer)), userInfo: nil, repeats: true)
            timerIsOn=true
        }
        
    }
    
    
    @IBAction func pauseButton(_ sender: Any) {
        timer.invalidate()
        
       
        focusTimeLabel.text="\(minutesToDisplay)"+":"+"\(secondsToDisplay)"
        timerIsOn=false
    }
    
    func updateTimer(){
        totalSeconds-=1
        secondsToDisplay=totalSeconds%60
        minutesToDisplay=totalSeconds/60
        
       
        
        if secondsToDisplay<10{
            focusTimeLabel.text="\(minutesToDisplay)" + ":" + "0"+"\(secondsToDisplay)"
        }
        else{
        focusTimeLabel.text="\(minutesToDisplay)"+":"+"\(secondsToDisplay)"
        }
        
        if totalSeconds==0{
            timer.invalidate()
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
            self.performSegue(withIdentifier: "focusToLog", sender: self)
        
        }
        
        
    }

override func viewDidLoad() {
    super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
    }

    
    
}
