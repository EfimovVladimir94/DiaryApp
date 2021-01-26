//
//  DetailsViewController.swift
//  DiaryApp
//
//  Created by Пользователь on 27.01.2021.
//

import UIKit

class DetailsViewController: UIViewController {

    var currentTask: DataTask?
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var taskNameTextField: UILabel!
    @IBOutlet var dateFieldTextField: UILabel!
    @IBOutlet var descriptionTextField: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageData = currentTask?.imageData
        if imageData != nil {
            imageView.image = UIImage(data: imageData!)
        }
        taskNameTextField.text = currentTask?.name
        dateFieldTextField.text = currentTask?.date
        descriptionTextField.text = currentTask?.descriptionTask
    }
}
