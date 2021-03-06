
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
import AVFoundation

class LogViewController: UIViewController,AVAudioPlayerDelegate,AVAudioRecorderDelegate {
    
    var timer:Timer=Timer()
    var totalSeconds:Int=180
    var initialTime:Int=180
    var timerIsOn:Bool=false
    var minutesToDisplay:Int=0
    var secondsToDisplay:Int=0
    var isRecording:Bool=false
    var recordHasBeenTapped = false
    @IBOutlet weak var logTimeLabel: UILabel!
    @IBOutlet weak var logProgressBar: UIProgressView!
    
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var logTextView: UITextView!
    @IBOutlet weak var logRecordButton: UIButton!
    
    @IBOutlet weak var playTestButton: UIButton!
    var soundRecorder : AVAudioRecorder!
    var soundPlayer : AVAudioPlayer!
    
    var uiud:String = ""
    
    var focusVC: UIViewController!
    
    @IBAction func logStartButton(_ sender: Any) {
        if timerIsOn == false{
            timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(FocusViewController.updateTimer)), userInfo: nil, repeats: true)
            timerIsOn=true
        
        }
    }
    
    
        
    @IBAction func logPauseButton(_ sender: Any) {
        timer.invalidate()
        if secondsToDisplay<10{
            logTimeLabel.text="\(minutesToDisplay)" + ":" + "0"+"\(secondsToDisplay)"
        }
        else{
            logTimeLabel.text="\(minutesToDisplay)"+":"+"\(secondsToDisplay)"
        }
        
        timerIsOn=false

    }

    
    
    func updateTimer() {
        totalSeconds -= 1
        secondsToDisplay=totalSeconds%60
        minutesToDisplay=totalSeconds/60
        if totalSeconds==1 {
            
            
                let filename = "\(uiud).m4a"
                soundRecorder.stop()
            
                
                print(uiud)
                var subjectOfSession: String = subjectTextField.text!
            if subjectOfSession.characters.count == 0 {
                subjectOfSession = "no subject"
            }
            
            
            if logTextView.text.characters.count > 0 || recordHasBeenTapped{
                CoreDataHelper.addLog(text: logTextView.text, idForIt: uiud, subject: subjectOfSession)
            }
        
            
            
            
                
            
            
        }

        if secondsToDisplay<10{
            logTimeLabel.text="\(minutesToDisplay)" + ":" + "0"+"\(secondsToDisplay)"
        }
        else{
            logTimeLabel.text="\(minutesToDisplay)"+":"+"\(secondsToDisplay)"
        }
        
        if totalSeconds==0{
            timer.invalidate()
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
            self.performSegue(withIdentifier: "logToRest", sender: self)
        }
        let toIncrementProgress:Float=1/(Float)(initialTime)
        logProgressBar.progress+=toIncrementProgress
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logTextView.layer.borderWidth = 1
        logTextView.layer.borderColor = UIColor.black.cgColor
        uiud = UUID().uuidString
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(FocusViewController.updateTimer)), userInfo: nil, repeats: true)
        timerIsOn=true
        setUpRecorder()
        navigationItem.hidesBackButton = true
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM-dd"
        var formattedDate = dateFormatter.string(from: DateSetup.screenDate)
        dateLabel.text = formattedDate

        
        
        
       
        
    }
    
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
    }
    
    //recording stuff
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    //
    
    
    
    
    
    func setUpRecorder(){
        let recordSettings=[AVFormatIDKey:kAudioFormatAppleLossless,
                            AVEncoderAudioQualityKey:AVAudioQuality.max.rawValue,
                            AVEncoderBitRateKey:320000,
                            AVNumberOfChannelsKey:2,
                            AVSampleRateKey:44100.0 ] as [String : Any]
        
        
        
        
        
        soundRecorder = try! AVAudioRecorder(url: getFileUrl(), settings: recordSettings)
        
        
        
            soundRecorder.delegate=self
            soundRecorder.prepareToRecord()
        
    }
    
    func getCacheDirectory() -> String{
        let paths=NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        return paths[0]
    }
    
    func getFileUrl() -> URL{
        
        let filename = "\(uiud).m4a"
        
        var url = URL(string: getCacheDirectory())!
        url = url.appendingPathComponent(filename)
        print(filename)
        print(url)
        return url
    }
    
    @IBAction func recordAudio(_ sender: UIButton) {
        recordHasBeenTapped = true
        if sender.titleLabel?.text == "Record" {
            
            soundRecorder.record()
            isRecording=true
            sender.setTitle("Stop", for:.normal)
            logRecordButton.setImage(UIImage(named: "StopButton.png"), for: .normal)
            logRecordButton.isEnabled=true
        }
        else{
            logRecordButton.setImage(UIImage(named: "BlueRecordButton.png"), for: .normal)
            soundRecorder.stop()
            sender.setTitle("Record", for:.normal)
            logRecordButton.isEnabled=false
            isRecording=false
        }
    }
    
    
    @IBAction func playTestAudio(_ sender: UIButton) {
        if sender.titleLabel?.text == "Play" {
             logRecordButton.isEnabled = false
            sender.setTitle("Stop", for:.normal)
            preparePlayer()
            soundPlayer.play()
            
        }
        else{
            soundPlayer.stop()
             sender.setTitle("Play", for:.normal)
        }
    }
    
    func preparePlayer(){
        soundPlayer = try! AVAudioPlayer(contentsOf: getFileUrl())
        soundPlayer.delegate=self
        soundPlayer.prepareToPlay()
        soundPlayer.volume = 1.0
    }
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        playTestButton.isEnabled=true
        let recording = try? AVAudioFile(forReading: getFileUrl())
        
        
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        logRecordButton.isEnabled=true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        let nextVC = segue.destination as! RestViewController
        nextVC.focusVC = focusVC
    }
    
}
