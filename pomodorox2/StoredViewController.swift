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
    
    var soundPlayer : AVAudioPlayer?
    var audioForLog: AVAudioFile?
    var fileName:String?
    var isPlaying: Bool = false
    var minutesToDisplay:Int=0
    var secondsToDisplay:Int=0
    var timer:Timer=Timer()
    var totalSeconds: Int = 0
    var timeOfAudio: TimeInterval?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 1
        
            // 2
            dateLabel.text = "\(String(describing: log?.date!))"
            storedTextView.text = log?.textLog ?? ""
            subjectLabel.text = log?.subjectLine ?? "no subject"
            
           
            
            
            
            
        
    }

    
    
    
    @IBAction func storedPlayButton(_ sender: Any) {
        
        preparePlayer()
        if isPlaying == false{
            soundPlayer?.play()
            isPlaying = true
        }
        else{
            soundPlayer?.play(atTime: timeOfAudio!)
            isPlaying = true
        }
        timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(StoredViewController.updateTimer)), userInfo: nil, repeats: true)
        
        
        
    }
    
    func updateTimer(){
        totalSeconds += 1
        secondsToDisplay=totalSeconds%60
        minutesToDisplay=totalSeconds/60
        
        if totalSeconds >= Int((soundPlayer?.duration)!)+1{
            timer.invalidate()
            soundPlayer?.stop()
            isPlaying = false
        }
        
        if secondsToDisplay<10{
            storedTimeLabel.text="\(minutesToDisplay)" + ":" + "0"+"\(secondsToDisplay)"
        }
        else{
            storedTimeLabel.text="\(minutesToDisplay)"+":"+"\(secondsToDisplay)"
        }
        
        
        let toIncrementProgress:Float=1/(Float)((soundPlayer?.duration)!)
        storedAudioSlider.value+=toIncrementProgress
        
        
    }

    
    
    
    @IBAction func storedPauseButton(_ sender: Any) {
        timer.invalidate()
        timeOfAudio = soundPlayer?.currentTime
        soundPlayer?.pause()
        isPlaying = false
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fileName = "\(log!.audioUIUD!).m4a"
        print(fileName)
        
        // Do any addit\ional setup after loading the view.
        
    }
    
    
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
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

    @IBAction func changeAudioTime(_ sender: Any) {
        let value = storedAudioSlider.value
        
        
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("done")
    }

    
}
