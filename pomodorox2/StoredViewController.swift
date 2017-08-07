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


class StoredViewController: UIViewController{
    
    var log: Log?
    @IBOutlet weak var storedAudioSlider: UISlider!
    @IBOutlet weak var storedTextView: UITextView!
    @IBOutlet weak var storedTimeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    
     var soundPlayer : AVAudioPlayer!
    var audioForLog: AVAudioFile?
    var fileName:String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 1
        if let note = log {
            // 2
            dateLabel.text = "\(log?.date)"
            storedTextView.text = log?.textLog ?? ""
            subjectLabel.text = log?.subjectLine ?? "no subject"
            
            if let uiud = log?.audioUIUD{
             fileName = "\(uiud) +.m4a"
            }
            
            
            
            
            
        } else {
            // 3
            
        }
    }

    
    
    
    @IBAction func storedPlayButton(_ sender: Any) {
    }
    
    @IBAction func storedPauseButton(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        preparePlayer()
        soundPlayer.play()
    }
    
    
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
    }

    
    //audiowork
    

    func preparePlayer(){
        soundPlayer = try! AVAudioPlayer(contentsOf: getFileUrl())
        soundPlayer.delegate = self as! AVAudioPlayerDelegate
        soundPlayer.prepareToPlay()
        soundPlayer.volume = 1.0
    }
    
    func getFileUrl() -> URL{
        var url = URL(string: getCacheDirectory())!
        url = url.appendingPathComponent(fileName)
        return url
    }
    
    func getCacheDirectory() -> String{
        let paths=NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        return paths[0]
    }

    @IBAction func changeAudioTime(_ sender: Any) {
        let value = storedAudioSlider.value
        
        
    }

    
}
