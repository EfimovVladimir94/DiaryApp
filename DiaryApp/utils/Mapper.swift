//
//  Mapper.swift
//  DiaryApp
//
//  Created by Пользователь on 26.01.2021.
//

import Foundation

class Mapper {
    
    public static func dataTaskFirToDataTask (dataTask: DataTaskFir) -> DataTask {
        return DataTask(name: dataTask.name,
                        date: dataTask.date,
                        descriptionTask: dataTask.descriptionTask,
                        imageData: nil)
    }
    
}
