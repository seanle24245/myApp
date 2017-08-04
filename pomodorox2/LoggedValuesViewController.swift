//
//  LoggedValuesViewController.swift
//  pomodorox2
//
//  Created by Sean Le on 7/31/17.
//  Copyright © 2017 Sean Le. All rights reserved.
//

import UIKit

class LoggedValuesViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    var logs = [Log]() {
        didSet {
            tableView.reloadData()
        }
    }

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logs = CoreDataHelper.getContents()
        // Do any additional setup after loading the view.
   
        
    }

    
    
    
    
    
}


extension LoggedValuesViewController: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return logs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LoggedCell", for: indexPath) as! LoggedCell
        
        let row = indexPath.row
        let logForCell = logs[row]
        
        if let titleSetting = logForCell.subjectLine{
            cell.subjectLabel.text = titleSetting
        } else {
            cell.subjectLabel.text = "No subject"
        }
        
        
        let timeOfLog = logForCell.date
        cell.timeLabel.text = "\(timeOfLog)"
        
        return cell
        
    }
    
    
    
    
}







