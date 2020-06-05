//
//  AddTaskViewController.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 01.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

	static let identifire = "addTaskVC"
	var presenter: AddTaskOutput!

	@IBOutlet weak var taskIconImageView: UIImageView!
	@IBOutlet weak var titleTextField: UITextField!
	@IBOutlet weak var addButton: UIButton! {
		didSet {
			addButton.layer.cornerRadius = addButton.frame.height / 2
		}
	}

	override func viewDidLoad() {
        super.viewDidLoad()

		taskIconImageView.image = UIImage(named: "shopping")
		setupGestureRecognizer()
    }

	@IBAction func saveButtonPressed(_ sender: Any) {
		let task = TaskEntity(id: UUID().uuidString, name: titleTextField.text ?? "", imagePath: "shopping")
		presenter.saveButtonPressed(with: task)
	}
}

extension AddTaskViewController: AddTaskInput {
	func taskDidSave() {

	}
}

extension AddTaskViewController {
	func setupGestureRecognizer() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
