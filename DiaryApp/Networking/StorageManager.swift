//
//  StorageManager.swift
//  DiaryApp
//
//  Created by Пользователь on 24.01.2021.
//

import RealmSwift
import Firebase

let realm = try! Realm()

class StorageManager {
    
    static func saveObjectIntoRealm(_ task: DataTask) {
        try! realm.write{
            realm.add(task)
        }
    }
    
    static func saveObjectIntoFire(_ task: DataTaskFir) {
        let data = ["name": task.name, "date": task.date, "description": task.descriptionTask]
        Database.database().reference().child("tasks").child(task.date).updateChildValues(data) { (error, _) in
            if let error = error {
                print("error data save into Firebase")
                return
            }
        }
    }
}


