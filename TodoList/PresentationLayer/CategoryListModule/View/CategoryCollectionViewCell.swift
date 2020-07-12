//
//  TaskCollectionViewCell.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
	@IBOutlet weak private var taskImageView: UIImageView!
	@IBOutlet weak private var taskNameLabel: UILabel!
	@IBOutlet weak private var subTaskCountLabel: UILabel!
	
	override func layoutSubviews() {
		super.layoutSubviews()

		layer.cornerRadius = 12.0
		layer.backgroundColor = UIColor.white.cgColor

		layer.shadowOffset = CGSize(width: 0, height: 2)
		layer.shadowRadius = 5.0
		layer.shadowOpacity = 0.4
		layer.masksToBounds = false
		clipsToBounds = false

	}

	func configure(with viewModel: CategoryViewModel, tasksCount: Int) {
		taskImageView.image = viewModel.image
		taskImageView.tintColor = viewModel.color
		taskNameLabel.text = viewModel.name
		subTaskCountLabel.text = String(tasksCount)
	}
}
