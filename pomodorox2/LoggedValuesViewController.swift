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
    
//    @IBAction func unwindToListNotesViewController(_ segue: UIStoryboardSegue){
//        self.logs = CoreDataHelper.getContents()
//    }
//    
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
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let identifier = segue.identifier {
//            if identifier == "displayLog" {
//                print("Table view cell tapped")
//                let indexPath = tableView.indexPathForSelectedRow!
//                // 2
//                let log = logs[indexPath.row]
//                // 3
//                let displayLogViewController = segue.destination as! StoredViewController
//                // 4
//                displayLogViewController.log = log
//            }
//        }
//    }
    
    
    
}

extension LoggedValuesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Stored", bundle: nil).instantiateInitialViewController() as! StoredViewController
        vc.log = self.logs[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}






