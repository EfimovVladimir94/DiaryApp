//
//  ViewController.swift
//  DiaryApp
//
//  Created by Пользователь on 23.01.2021.
//

import UIKit
import RealmSwift

class DateViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var datePicker: UIDatePicker!
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(DateViewController.handleRefresh), for: .valueChanged)
        refreshControl.tintColor = UIColor.gray
        return refreshControl
    }()
    
    var tasks: Results<DataTask>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.addSubview(self.refreshControl)
    }
    
    //MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.isEmpty ? 0 : tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DataTasksTableViewCell
        let taskByIndexPath = tasks[indexPath.row]
        cell.nameLabel.text = taskByIndexPath.name
        cell.dateLabel.text = taskByIndexPath.date
        cell.descriptionLabel.text = taskByIndexPath.descriptionTask
        cell.imageOfTasks.image = UIImage(data: taskByIndexPath.imageData!)
        cell.imageOfTasks.layer.cornerRadius = cell.imageOfTasks.frame.size.height / 2
        cell.imageOfTasks.clipsToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tasks = realm.objects(DataTask.self)
    }
    
    @objc func handleRefresh() {
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }

    @IBAction func changeDate(_ sender: UIDatePicker) {
    }
    
}


