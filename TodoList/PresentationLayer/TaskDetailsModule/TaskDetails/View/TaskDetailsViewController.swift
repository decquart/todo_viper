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
	var presenter: TaskDetailsOutput!
	var scope: Scope<TaskViewModel>!

	private var viewModel: TaskViewModel {
		if case let .edit(task) = scope {
			return task
		}

		return TaskViewModel()
	}

	//todo: get rid
	private var imagePath: String = ""
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

// MARK: - IBActions
extension TaskDetailsViewController {
	@IBAction func sliderValueDidChange(_ sender: UISlider) {
		color = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1)
	}

	@IBAction func saveButtonPressed(_ sender: Any) {
		guard let name = titleTextField.text, !name.isEmpty else {
			return
		}

		var task = viewModel
		task.name = name
		task.imagePath = imagePath
		task.color = color
		presenter.saveButtonPressed(with: task)
	}
}

// MARK: - AddTaskInput
extension TaskDetailsViewController: TaskDetailsInput {
	var isNewTask: Bool {
		if case .create = scope {
			return true
		}

		return false
	}

	func refreshIcon(_ imagePath: String) {
		self.imagePath = imagePath
		taskIconImageView.image = UIImage(named: imagePath)?.withRenderingMode(.alwaysTemplate)
	}
}

// MARK: - Appearance
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
		self.imagePath = "shopping"
	}

	func setupAppearance(with existingTask: TaskViewModel) {
		titleTextField.text = existingTask.name
		taskIconImageView.image = existingTask.image
		color = existingTask.color

		redSlider.value = Float(CIColor(color: color).red)
		greenSlider.value = Float(CIColor(color: color).green)
		blueSlider.value = Float(CIColor(color: color).blue)

		self.imagePath = existingTask.imagePath
	}
}

// MARK: - GestureRecognizer
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
