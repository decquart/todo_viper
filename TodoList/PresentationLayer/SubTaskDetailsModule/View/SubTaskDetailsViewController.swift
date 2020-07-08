//
//  SubTaskDetailsViewController.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 29.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class SubTaskDetailsViewController: UIViewController {
	static let identifire = "subTaskDetailsVC"
	var presenter: SubTaskDetailsOutput!
	var scope: Scope<SubTaskViewModel>!

	private var viewModel: SubTaskViewModel {
		if case let .edit(subtask) = scope  {
			return subtask
		}

		return SubTaskViewModel()
	}

	@IBOutlet weak private var textField: UITextField!
	@IBOutlet weak private var sendButton: UIButton!
	@IBOutlet weak private var datePicker: UIDatePicker! {
		didSet {
			datePicker.timeZone = .current
		}
	}

	override func viewDidLoad() {
        super.viewDidLoad()

		initAppearance()
    }

	@IBAction private func sendButtonPressed(_ sender: Any) {
		guard let text = textField.text, !text.isEmpty else {
			return
		}

		var subtask = viewModel
		subtask.description = text
		subtask.date = datePicker.date.localDate
		presenter.sendButtonPressed(viewModel: subtask)
	}

	func initAppearance() {
		switch scope {
		case .edit(let subtask):
			textField.text = subtask.description
		default:
			break
		}
	}
}

extension SubTaskDetailsViewController: SubTaskDetailsInput {
	var isNewSubtask: Bool {
		if case .create = scope {
			return true
		}

		return false
	}

	func invalidateView() {
		textField.text = ""
	}

	func dismiss() {
		self.dismiss(animated: true)
	}
}
