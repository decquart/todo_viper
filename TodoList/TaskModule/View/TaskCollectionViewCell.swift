//
//  TaskCollectionViewCell.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class TaskCollectionViewCell: UICollectionViewCell {
	static var identifire = "TaskCell"
	@IBOutlet weak var taskImageView: UIImageView!
	@IBOutlet weak var taskNameLabel: UILabel!

	override func layoutSubviews() {
		super.layoutSubviews()

		layer.borderWidth = 0.5
		layer.borderColor = UIColor.lightGray.cgColor
		layer.cornerRadius = frame.height / 2
		layer.backgroundColor = UIColor.white.cgColor
	}
}
