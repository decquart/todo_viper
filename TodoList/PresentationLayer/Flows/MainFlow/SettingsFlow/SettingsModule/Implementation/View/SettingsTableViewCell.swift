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

	func configure(with sectionData: SettingsSection, and index: Int) {
		guard let section = sectionData as? LogOutCellSection else {
			return
		}

		self.descriptionLabel.text = section.models[index].title
		self.icon.image = UIImage(systemName: section.models[index].imageName)
	}
}
