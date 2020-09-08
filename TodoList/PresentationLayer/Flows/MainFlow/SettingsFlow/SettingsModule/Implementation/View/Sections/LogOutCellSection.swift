//
//  LogOutCellSection.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 07.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

class LogOutCellSection: SettingsSection {
	var type: SettingsSectionType = .logOut
	var sectionTitle: String = ""

	var rowCount: Int {
		return models.count
	}

	let models: [SettingsCellModel]

	init(models: [SettingsCellModel]) {
		self.models = models
	}
}
