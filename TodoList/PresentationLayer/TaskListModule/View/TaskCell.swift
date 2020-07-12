//
//  TaskCell.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 08.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {

	var buttonPressedClosure: (() -> Void)?
	@IBOutlet weak private var descriptionLabel: UILabel!
	@IBOutlet weak private var checkButton: UIButton!
	@IBOutlet weak var dateLabel: UILabel!

	@IBAction private func checkButtonPressed(_ sender: UIButton) {
		buttonPressedClosure?()
	}

	func configure(with viewModel: TaskViewModel) {
		self.descriptionLabel.text = viewModel.description
		self.checkButton.setImage(viewModel.checkmarkIcon, for: .normal)
		self.dateLabel.text = viewModel.dateText
	}
}
