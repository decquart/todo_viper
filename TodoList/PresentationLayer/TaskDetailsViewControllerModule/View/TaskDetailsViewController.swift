//
//  AddTaskViewController.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 01.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

enum TaskDetailsScope {
	case create
	case edit(task: TaskEntity)
}

class TaskDetailsViewController: UIViewController {

	static let identifire = "taskDetailsVC"
	var presenter: AddTaskOutput!
	var scope: TaskDetailsScope!

	@IBOutlet weak var taskIconImageView: UIImageView!
	@IBOutlet weak var titleTextField: UITextField!
	@IBOutlet weak var addButton: UIButton! {
		didSet {
			addButton.layer.cornerRadius = addButton.frame.height / 2
		}
	}

	@IBAction func saveButtonPressed(_ sender: Any) {

		var id = UUID().uuidString
		if case let .edit(task) = scope {
			id = task.id
		}

		let task = TaskEntity(id: id, name: titleTextField.text ?? "", imagePath: "shopping")
		presenter.saveButtonPressed(with: task)
	}

	override func viewDidLoad() {
        super.viewDidLoad()

		taskIconImageView.image = UIImage(named: "shopping")
		setupGestureRecognizer()
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		//todo
		switch scope {
		case .edit(let task): titleTextField.text = task.name
		default: break
		}
	}
}

extension TaskDetailsViewController: AddTaskInput {
//	func taskDidSave() {
//
//	}
}

extension TaskDetailsViewController {
	func setupGestureRecognizer() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
