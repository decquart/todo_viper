//
//  AddTaskViewController.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 01.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

enum Scope<Model> {
	case create
	case edit(model: Model)
}

class TaskDetailsViewController: UIViewController {

	static let identifire = "taskDetailsVC"
	var presenter: AddTaskOutput!
	var scope: Scope<TaskEntity>!

	private var color: UIColor! {
		didSet {
			taskIconImageView.tintColor = color
		}
	}

	@IBOutlet weak private var redSlider: UISlider!
	@IBOutlet weak private var greenSlider: UISlider!
	@IBOutlet weak private var blueSlider: UISlider!

	@IBOutlet weak private var taskIconImageView: UIImageView!
	@IBOutlet weak private var titleTextField: UITextField!
	@IBOutlet weak private var addButton: UIButton! {
		didSet {
			addButton.layer.cornerRadius = addButton.frame.height / 2
		}
	}

	var iconPickerView: UIView! {
		didSet {
			self.view.addSubview(iconPickerView)

			iconPickerView.translatesAutoresizingMaskIntoConstraints = false

			iconPickerView.topAnchor.constraint(equalTo: blueSlider.bottomAnchor, constant: 20).isActive = true
			iconPickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
			iconPickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
			iconPickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -160).isActive = true
		}
	}

	override func viewDidLoad() {
        super.viewDidLoad()
		setupGestureRecognizer()
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		initAppearance()
	}
}

//MARK: - IBActions
extension TaskDetailsViewController {
	@IBAction func sliderValueDidChange(_ sender: UISlider) {
		color = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1)
	}

	@IBAction func saveButtonPressed(_ sender: Any) {

		let name = titleTextField.text ?? ""
		let image = taskIconImageView.image?.pngData() ?? Data()

		if case let .edit(task) = scope {
			let task = TaskEntity(id: task.id, name: name, image: image, color: color)
			presenter.saveButtonPressed(with: task)
			return
		}

		let task = TaskEntity(name: name, image: image, color: color)
		presenter.saveButtonPressed(with: task)
	}
}

//MARK: - AddTaskInput
extension TaskDetailsViewController: AddTaskInput {
	var isNewTask: Bool {
		if case .create = scope {
			return true
		}

		return false
	}

	func refreshIcon(_ image: Data) {
		taskIconImageView.image = UIImage(data: image)?.withRenderingMode(.alwaysTemplate)
	}
}

//MARK: - Appearance
extension TaskDetailsViewController {
	func initAppearance() {
		switch scope {
		case .edit(let task):
			setupAppearance(with: task)
		default:
			setupDefaultAppearance()
		}
	}

	func setupDefaultAppearance() {
		taskIconImageView.image = UIImage(named: "shopping")
		color = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
	}

	func setupAppearance(with existingTask: TaskEntity) {
		titleTextField.text = existingTask.name
		taskIconImageView.image = UIImage(data: existingTask.imageData)?.withRenderingMode(.alwaysTemplate)
		color = existingTask.imageColor as? UIColor
	}
}

//MARK: - GestureRecognizer
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

