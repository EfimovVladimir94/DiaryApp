//
//  StorageManager.swift
//  DiaryApp
//
//  Created by Пользователь on 24.01.2021.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveObject(_ task: DataTask){
        try! realm.write{
            realm.add(task)
        }
    }
    
}


