//
//  DataTaskModel.swift
//  DiaryApp
//
//  Created by Пользователь on 23.01.2021.
//


import RealmSwift

class DataTask: Object {
    @objc dynamic var name = ""
    @objc dynamic var date: String = ""
    @objc dynamic var descriptionTask: String?
    @objc dynamic var imageData: Data?
    
    convenience init(name: String,
                     date: String,
                     descriptionTask: String?,
                     imageData: Data?) {
        self.init()
        self.name = name
        self.date = date
        self.descriptionTask = descriptionTask
        self.imageData = imageData
    }
}
