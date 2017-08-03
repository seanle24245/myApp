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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 1
        if let note = log {
            // 2
            dateLabel.text = "\(log?.date)"
            storedTextView.text = log?.textLog ?? ""
            subjectLabel.text = log?.subjectLine ?? "no subject"
            
            
            
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
    }
    
    
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
    }


    
}
