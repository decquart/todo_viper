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

	static let identifire = "subTaskCell"
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var checkButton: UIButton!

	@IBAction func checkButtonPressed(_ sender: UIButton) {
		buttonPressedClosure?()
	}

	func configure(witn subTaskEntity: SubTaskEntity) {
		self.descriptionLabel.text = subTaskEntity.description
		let image = subTaskEntity.completed ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "circle")
		self.checkButton.setImage(image, for: .normal)
	}
}
