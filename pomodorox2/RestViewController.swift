//
//  RestViewController.swift
//  pomodorox2
//
//  Created by Sean Le on 7/31/17.
//  Copyright © 2017 Sean Le. All rights reserved.
//

import Foundation
import UIKit
import AudioToolbox
import CoreGraphics
class RestViewController: UIViewController {
    
    var timer:Timer=Timer()
    var totalSeconds:Int=2
    var initialTime:Int=2
    var timerIsOn:Bool=false
    var minutesToDisplay:Int=0
    var secondsToDisplay:Int=0
  
   
    @IBOutlet weak var restTimeLabel: UILabel!
    
    
    @IBOutlet weak var restProgressBar: UIProgressView!
    
    
    @IBOutlet weak var roundLabel: UILabel!
   
    
    @IBAction func startButton(_ sender: Any) {
        
        if timerIsOn == false{
            timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(RestViewController.updateTimer)), userInfo: nil, repeats: true)
            timerIsOn=true
        }
    }
    
    
    
    @IBAction func pauseButton(_ sender: Any) {
        timer.invalidate()
        restTimeLabel.text="\(minutesToDisplay)"+":"+"\(secondsToDisplay)"
        timerIsOn=false
    }
    
    func updateTimer(){
        totalSeconds-=1
        secondsToDisplay=totalSeconds%60
        minutesToDisplay=totalSeconds/60
        
        if secondsToDisplay<10{
            restTimeLabel.text="\(minutesToDisplay)" + ":" + "0"+"\(secondsToDisplay)"
        }
        else{
            restTimeLabel.text="\(minutesToDisplay)"+":"+"\(secondsToDisplay)"
        }
        
        if totalSeconds==0{
            timer.invalidate()
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
            navigationController?.popToRootViewController(animated: true)
            
        }
        
        let toIncrementProgress:Float=1/(Float)(initialTime)
        restProgressBar.progress+=toIncrementProgress
        
        
    }
    
    private func didFinish() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundLabel.text = "\(RoundTracker.numberOfRounds%4)/4 "
        timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(FocusViewController.updateTimer)), userInfo: nil, repeats: true)
        timerIsOn=true
        
        let tint = UIColor(red: 254/255 , green: 100/255, blue: 25/255, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = tint
    }
    
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
       RoundTracker.numberOfRounds += 1
    }
    
    
    
}
