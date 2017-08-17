//
//  StoredViewController.swift
//  pomodorox2
//
//  Created by Sean Le on 8/3/17.
//  Copyright © 2017 Sean Le. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AudioToolbox


class StoredViewController: UIViewController,AVAudioPlayerDelegate,AVAudioRecorderDelegate{
    
    var log: Log?
    @IBOutlet weak var storedAudioSlider: UISlider!
    @IBOutlet weak var storedTextView: UITextView!
    @IBOutlet weak var storedTimeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    
    var soundPlayer : AVAudioPlayer?
    var audioForLog: AVAudioFile?
    var fileName:String?
    var isPlaying: Bool = false
    var minutesToDisplay:Int=0
    var secondsToDisplay:Int=0
    var timer:Timer=Timer()
    var totalSeconds: Double = 0.00
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        super.viewWillAppear(animated)
        // 1
        
            // 2
        let date:Date = (log!.date)! as Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM-dd-yyyy"
        var formattedDate = dateFormatter.string(from: date)
        
        
        
        
        let calendar = Calendar.current
        
        var hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        var amOrPm = ""
        if hour > 12{
            hour -= 12
            amOrPm = "PM"
        }else{
            amOrPm = "AM"
        }
        
        
        dateLabel.text = "\(formattedDate) \(hour):\(minutes) \(amOrPm)"
        storedTextView.text = log?.textLog ?? ";"
            subjectLabel.text = log?.subjectLine ?? "no subject"
            storedAudioSlider.isEnabled = false
        
            preparePlayer()
        
        if soundPlayer?.duration == 0.0{
            playButton.isEnabled = false
            pauseButton.isEnabled = false
            storedTimeLabel.text = "0:00"
        }
            
            
            
            
        
    }

    
    
    
    @IBAction func storedPlayButton(_ sender: Any) {
        
        
        if isPlaying == false {
        storedAudioSlider.isEnabled = false
        
        soundPlayer?.play()
       
       
        isPlaying = true
       timer=Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: (#selector(StoredViewController.updateTimer)), userInfo: nil, repeats: true)
        
        }
        
        
        
    }
    
    func updateTimer(){
        totalSeconds += 0.001
       
        secondsToDisplay=Int(totalSeconds) % 60
        minutesToDisplay=Int(totalSeconds/60)
        
        if totalSeconds >= (soundPlayer?.duration)!{
            timer.invalidate()
            soundPlayer?.stop()
            isPlaying = false
            totalSeconds=0
            storedAudioSlider.value = 0.00
        }
        
        if secondsToDisplay<10{
            
            storedTimeLabel.text="\(minutesToDisplay)" + ":" + "0"+"\(secondsToDisplay)"
        } else{
            storedTimeLabel.text="\(minutesToDisplay)"+":"+"\(secondsToDisplay)"
        }
        
        
        let toIncrementProgress:Float=1/(Float)((((soundPlayer?.duration)! * 1000)))
        storedAudioSlider.value+=toIncrementProgress
        
        
       
        
    }

    
    
    
    @IBAction func storedPauseButton(_ sender: Any) {
        
        if isPlaying == true{
        timer.invalidate()
        
        
        soundPlayer?.pause()
        isPlaying = false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fileName = "\(log!.audioUIUD!).m4a"
        print(fileName)
        
        
        
        
        
        // Do any addit\ional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        fileName = "\(log!.audioUIUD!).m4a"
        print(fileName)
        storedTextView.layer.borderWidth = 1
        storedTextView.layer.borderColor = UIColor.black.cgColor
       
        
        
        
    }
    
    
   
    
    //audiowork
    

    func preparePlayer(){
        soundPlayer = try! AVAudioPlayer(contentsOf: getFileUrl())
        soundPlayer?.delegate = self as! AVAudioPlayerDelegate
        soundPlayer?.prepareToPlay()
        soundPlayer?.volume = 1.0
    }
    
    func getFileUrl() -> URL{
        var url = URL(string: getCacheDirectory())!
        url = url.appendingPathComponent(fileName!)
        return url
    }
    
    func getCacheDirectory() -> String{
        let paths=NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        return paths[0]
    }

    @IBAction func changeAudioTime(_ sender: UISlider) {
//        if isPlaying == true{
//            sender.isEnabled = false
//        }
//        
//        
//        if isPlaying == false{
//        sender.isEnabled = true
//        soundPlayer?.pause()
//        let value = Double(storedAudioSlider.value)
//        let audioLength = soundPlayer?.duration
//        
//        
//        let correspondingTime = audioLength! * value
//       
//        
//        totalSeconds = correspondingTime
//        secondsToDisplay=Int(totalSeconds) % 60
//        minutesToDisplay=Int(totalSeconds/60)
//        soundPlayer?.play(atTime: totalSeconds)
//        if secondsToDisplay<10{
//            storedTimeLabel.text="\(minutesToDisplay)" + ":" + "0"+"\(secondsToDisplay)"
//        }
//        else{
//            storedTimeLabel.text="\(minutesToDisplay)"+":"+"\(secondsToDisplay)"
//        }
//
//        
//        
//        
        
        
        
//        }
        
        
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("playing")
        }

    
}
