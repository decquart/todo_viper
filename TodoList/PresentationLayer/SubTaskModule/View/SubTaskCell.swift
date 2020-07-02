//
//  SubTaskCell.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 08.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class SubTaskCell: UITableViewCell {

	var buttonPressedClosure: (() -> Void)?
	@IBOutlet weak private var descriptionLabel: UILabel!
	@IBOutlet weak private var checkButton: UIButton!

	@IBAction private func checkButtonPressed(_ sender: UIButton) {
		buttonPressedClosure?()
	}

	func configure(with viewModel: SubTaskViewModel) {
		self.descriptionLabel.text = viewModel.description
		self.checkButton.setImage(viewModel.checkmarkIcon, for: .normal)
	}
}
