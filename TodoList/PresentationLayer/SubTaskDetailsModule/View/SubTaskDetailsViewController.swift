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

	@IBOutlet weak private var textField: UITextField!
	@IBOutlet weak private var closeButton: UIButton!
	@IBOutlet weak private var sendButton: UIButton!

	override func viewDidLoad() {
        super.viewDidLoad()
    }

	@IBAction private func closeButtonPressed(_ sender: Any) {
		dismiss(animated: true)
	}

	@IBAction private func sendButtonPressed(_ sender: Any) {
		guard let text = textField.text, !text.isEmpty else {
			return
		}

		presenter.sendButtonPressed(viewModel: SubTaskViewModel(description: text))
	}
}

extension SubTaskDetailsViewController: SubTaskDetailsInput {
	func invalidateView() {
		textField.text = ""
	}
}
