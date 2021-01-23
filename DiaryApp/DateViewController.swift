//
//  ViewController.swift
//  DiaryApp
//
//  Created by Пользователь on 23.01.2021.
//

import UIKit

class DateViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
   
    let tasks = ["task1", "task2","task3"]

    @IBOutlet var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = tasks[indexPath.row]
        cell?.imageView?.image = UIImage(named: tasks[indexPath.row])
        return cell!
    }

    @IBAction func changeDate(_ sender: UIDatePicker) {
    }
    
    
}


