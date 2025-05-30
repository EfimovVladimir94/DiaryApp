//
//  ViewController.swift
//  DiaryApp
//
//  Created by Пользователь on 23.01.2021.
//

import UIKit
import RealmSwift
import Firebase

class DateViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var datePicker: UIDatePicker!
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(DateViewController.handleRefresh), for: .valueChanged)
        refreshControl.tintColor = UIColor.gray
        return refreshControl
    }()
    
    var taskResult: [DataTask] = []
    var uniqueTaskResult = Set<DataTask>()
    var tasksOfRealm: Results<DataTask>!
    var tasksOfFirebase = Set<DataTask>()
    var findDate: String?
    var taskDetails: DataTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.addSubview(self.refreshControl)
    }
    
    //MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureCell(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tasksOfRealm = realm.objects(DataTask.self)
        fetchDataTasks()
    }
    
    private func configureCell(tableView: UITableView, indexPath: IndexPath) -> DataTasksTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DataTasksTableViewCell
        let taskByIndexPath = taskResult[indexPath.row]
        
        cell.nameLabel.text = taskByIndexPath.name
        cell.dateLabel.text = taskByIndexPath.date
        cell.descriptionLabel.text = taskByIndexPath.descriptionTask
        if let imageByPath = taskByIndexPath.imageData {
            cell.imageOfTasks.image = UIImage(data: imageByPath)
        }
        cell.imageOfTasks.layer.cornerRadius = cell.imageOfTasks.frame.size.height / 2
        cell.imageOfTasks.clipsToBounds = true
        return cell
    }
    
    @objc func handleRefresh() {
        synchronizationWithFirebase()
        taskResult.removeAll()
        uniqueTaskResult.removeAll()
        fetchTaskByDate()
        taskResult = Array(uniqueTaskResult)
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    private func fetchDataTasks() {
        Database.database().reference()
            .child("tasks")
            .observe(.childAdded) { (snapshot) in
                guard let taskData = snapshot.value as? [String: Any] else { return }
                let dataTask = DataTaskFir(data: taskData)
                if dataTask != nil {
                    self.tasksOfFirebase.insert(Mapper.dataTaskFirToDataTask(dataTask: dataTask!))
                }
            }
    }
    
    
    private func synchronizationWithFirebase() {
        tasksOfRealm.forEach { dataTask in
            tasksOfFirebase.first(where: { $0.date == dataTask.date
                let newData = DataTaskFir(name: dataTask.name, date: dataTask.date, descriptionTask: dataTask.descriptionTask)
                StorageManager.saveObjectIntoFire(newData)
                return true
            })
        }
    }
    
    private func fetchTaskByDate() {
        guard let date = findDate else { return }
        tasksOfRealm.forEach { dataTask in
            if dataTask.date.hasPrefix(date) {
                uniqueTaskResult.insert(dataTask)
            }
        }
    }
    
    @IBAction func changeDate(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH"
        findDate = dateFormatter.string(from: sender.date)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let task = taskResult[indexPath.row]
            let newTaskVC = segue.destination as! DetailsViewController
            newTaskVC.currentTask = task
        }
    }
}

extension DateViewController: UITableViewDataSource, UITableViewDelegate {
    
}
