//
//  DataTaskFir.swift
//  DiaryApp
//
//  Created by Пользователь on 25.01.2021.
//

import Foundation

class DataTaskFir: NSObject {
    var name = ""
    var date: String = ""
    var descriptionTask: String?
    
    init(name: String, date: String, descriptionTask: String?) {
        self.name = name
        self.date = date
        self.descriptionTask = descriptionTask
    }
    
    init?(data: [String: Any]) {
        guard
            let name = data["name"] as? String,
            let description = data["description"] as? String,
            let date = data["date"] as? String
            else { return nil }
        self.name = name
        self.descriptionTask = description
        self.date = date
    }
}
