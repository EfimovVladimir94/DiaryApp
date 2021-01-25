//
//  DataTaskFir.swift
//  DiaryApp
//
//  Created by Пользователь on 25.01.2021.
//

import Foundation

class DataTaskFir {
    var name = ""
    var date: String = ""
    var descriptionTask: String?
//    var imageData: Data?
    
    init(name: String,
         date: String,
         descriptionTask: String?) {
        self.name = name
        self.date = date
        self.descriptionTask = descriptionTask
//        self.imageData = imageData
    }
}
