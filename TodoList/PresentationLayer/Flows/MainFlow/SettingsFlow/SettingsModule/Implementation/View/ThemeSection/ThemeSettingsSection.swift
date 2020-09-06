//
//  ThemeSettingsSection.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 07.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

class ThemeSettingsSection: SettingsSection {
	let type: SettingsSectionType = .theme
	let sectionTitle = "Theme"

	let cellDescription: String
	let isDarkModeEnabled: Bool
	let onSwitch: ((Bool) -> Void)?

	init(cellDescription: String, isDarkModeEnabled: Bool, onSwitch: @escaping ((Bool) -> Void)) {
		self.cellDescription = cellDescription
		self.isDarkModeEnabled = isDarkModeEnabled
		self.onSwitch = onSwitch
	}
}
