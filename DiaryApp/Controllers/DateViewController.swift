//
//  ViewController.swift
//  DiaryApp
//
//  Created by Пользователь on 23.01.2021.
//

import UIKit
import RealmSwift
import Firebase

class DateViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var datePicker: UIDatePicker!
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(DateViewController.handleRefresh), for: .valueChanged)
        refreshControl.tintColor = UIColor.gray
        return refreshControl
    }()
    
    var tasksOfRealm: Results<DataTask>!
    var tasksOfFirebase = Set<DataTask>()
    var findDate: String!
    
    override func viewDidLoad() {
        datePicker.addTarget(self, action: #selector(DateViewController.dateChanged(datePicker: )), for: .valueChanged)
        super.viewDidLoad()
        self.tableView.addSubview(self.refreshControl)
    }
    
    //MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksOfRealm.isEmpty ? 0 : tasksOfRealm.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DataTasksTableViewCell
        let taskByIndexPath = tasksOfRealm[indexPath.row]
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
        //хочу сделать поиск по дате если есть то заполняем uniqueTasks. Далее проверка если у кого то нет элемента? то сейвить
        tasksOfRealm = realm.objects(DataTask.self)
        fetchDataTasks()
        
    }
    
    @objc func handleRefresh() {
        self.tableView.reloadData()
        synchronizationWithFirebase()
        print("----result------\(tasksOfFirebase)--------")
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
                    
                    print("----------DATA TASK----------: \(dataTask!.name) + \(dataTask!.descriptionTask!) + \(dataTask!.date)")
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
    
    @objc private func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        self.findDate = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
}


