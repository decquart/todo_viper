//
//  SwitchTableViewCell.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 07.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var cellSwitch: UISwitch!

	var onSwitch: ((Bool) -> Void)?

	@IBAction func valueChanged(_ sender: UISwitch) {
		onSwitch?(sender.isOn)
	}

	func configure(with sectionData: SettingsSection, and index: Int) {
		guard let themeSection = sectionData as? ThemeSettingsSection else {
			return
		}

		descriptionLabel.text = themeSection.cellDescription
		cellSwitch.isOn = themeSection.isDarkModeEnabled
		onSwitch = themeSection.onSwitch
	}
}
