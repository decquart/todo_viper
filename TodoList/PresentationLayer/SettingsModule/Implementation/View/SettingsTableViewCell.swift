//
//  SettingsTableViewCell.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 10.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var icon: UIImageView!

	func configure(with viewModel: SettingsCellViewModel) {
		descriptionLabel.text = viewModel.title
		icon.image = UIImage(systemName: viewModel.imageUrl)
	}
}
