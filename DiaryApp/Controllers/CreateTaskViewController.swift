//
//  CreateTaskViewController.swift
//  DiaryApp
//
//  Created by Пользователь on 23.01.2021.
//

import UIKit

class CreateTaskViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initObjects()
    }
    
    private func initObjects() {
        let centrX = Int(self.view.center.x / 2) - 50
        let centrY = 0
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .save, target: self, action: nil), animated: true)
        self.navigationItem.setLeftBarButton(UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: nil), animated: true)
        
        self.view.addSubview(button(centrX: centrX, centrY: centrY))
        self.view.addSubview(textField(with: "task name", centrX: centrX, centrY: centrY))
        self.view.addSubview(textField(with: "date", centrX: centrX, centrY: centrY))
        self.view.addSubview(textField(with: "description", centrX: centrX, centrY: centrY))
        
    }
    
    private func button(centrX: Int, centrY: Int) -> UIButton {
        
        let saveImageButton: UIButton = UIButton(frame: CGRect(x: centrX, y: 100, width: 300, height: 50))
        saveImageButton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        saveImageButton.setTitle("Upload new image", for: .normal)
        saveImageButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        saveImageButton.addTarget(self, action: #selector(self.onTapped), for: .touchUpInside)
        return saveImageButton
    }
    
    private func textField(with placeholderName: String, centrX: Int, centrY: Int) -> UITextField {
        let textField: UITextField
        
        switch placeholderName {
        case "task name":
        textField = UITextField(frame: CGRect(x: centrX, y: centrY + 180, width: 300, height: 50))
        case "date":
        textField = UITextField(frame: CGRect(x: centrX, y: centrY + 260, width: 300, height: 50))
        case "description":
        textField = UITextField(frame: CGRect(x: centrX, y: centrY + 340, width: 300, height: 50))
        default:
            textField = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        }
        textField.placeholder = "Enter \(placeholderName)"
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.keyboardType = .default
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.textColor = .black
        textField.returnKeyType = UIReturnKeyType.done
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return textField
    }
    
    
    
    @objc private func onTapped() {
        print("pressed")
    }

}
