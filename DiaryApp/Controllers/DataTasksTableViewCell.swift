//
//  DataTasksViewCell.swift
//  DiaryApp
//
//  Created by Пользователь on 23.01.2021.
//

import UIKit

class DataTasksTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var imageOfTasks: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
