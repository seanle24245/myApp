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
    
    var focusVC: UIViewController!
    
    var timer:Timer=Timer()
    var totalSeconds:Int = 300
    var initialTime:Int = 300
    var timerIsOn:Bool=false
    var minutesToDisplay:Int=0
    var secondsToDisplay:Int=0
  
   
    @IBOutlet weak var restTimeLabel: UILabel!
    @IBOutlet weak var restProgressBar: UIProgressView!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
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
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            
            if RoundTracker.numberOfRounds < 4 {
                navigationController?.popToViewController(self.focusVC, animated: true)
            }
            else{
                navigationController?.popToRootViewController(animated: true)
            }
            
            
            
            
         

            
            
        }
        
        let toIncrementProgress:Float=1/(Float)(initialTime)
        restProgressBar.progress+=toIncrementProgress
        
        
    }
    
//    private func didFinish() {
//        navigationController?.popToRootViewController(animated: true)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(FocusViewController.updateTimer)), userInfo: nil, repeats: true)
        timerIsOn=true
        
        let tint = UIColor(red: 254/255 , green: 100/255, blue: 25/255, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = tint
        navigationItem.hidesBackButton = true
        roundLabel.text = "\(RoundTracker.numberOfRounds)/4"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM-dd"
        var formattedDate = dateFormatter.string(from: DateSetup.screenDate)
        dateLabel.text = formattedDate
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        
    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
       RoundTracker.numberOfRounds += 1
        if RoundTracker.numberOfRounds == 5
        {
            RoundTracker.numberOfRounds = 1
        }
    }
    
    
    
}


extension UINavigationController {
//    func pushViewController(viewController: UIViewController, animated: Bool, completion: () -> ()) {
//        pushViewController(viewController, animated: animated)
//        
//        if let coordinator = transitionCoordinator() where animated {
//            coordinator.animateAlongsideTransition(nil) { _ in
//                completion()
//            }
//        } else {
//            completion()
//        }
//    }
//    
    func popViewController(animated: Bool, completion: @escaping () -> ()) {
        popViewController(animated: animated)
        
        if let coordinator = transitionCoordinator  {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }
}
