//
//  ViewController.swift
//  DiaryApp
//
//  Created by Пользователь on 23.01.2021.
//

import UIKit

class DateViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tasks = [DataTask(name: "task1", date: "24.11.1994", description: "что то сделать надо", image: "task1")]

    @IBOutlet var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DataTasksTableViewCell
        cell.nameLabel.text = tasks[indexPath.row].name
        cell.imageOfPlace.image = UIImage(named: tasks[indexPath.row].image)
        cell.dateLabel.text = tasks[indexPath.row].date
        cell.descriptionLabel.text = tasks[indexPath.row].description
        cell.imageOfPlace.layer.cornerRadius = cell.imageOfPlace.frame.size.height / 2
        cell.imageOfPlace.clipsToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    @IBAction func changeDate(_ sender: UIDatePicker) {
    }
    
    
}


