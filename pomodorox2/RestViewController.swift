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
    var totalSeconds:Int=10
    var initialTime:Int=10
    var timerIsOn:Bool=false
    var minutesToDisplay:Int=0
    var secondsToDisplay:Int=0
  
   
    @IBOutlet weak var restTimeLabel: UILabel!
    
    
    @IBOutlet weak var restProgressBar: UIProgressView!
    
    
   
    
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
            
        }
        
        let toIncrementProgress:Float=1/(Float)(initialTime)
        restProgressBar.progress+=toIncrementProgress
        
        
    }
    
    private func didFinish() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(FocusViewController.updateTimer)), userInfo: nil, repeats: true)
        timerIsOn=true
        
        let tint = UIColor(red: 254/255 , green: 100/255, blue: 25/255, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = tint
    }
    
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
    }
    
    
    
}
