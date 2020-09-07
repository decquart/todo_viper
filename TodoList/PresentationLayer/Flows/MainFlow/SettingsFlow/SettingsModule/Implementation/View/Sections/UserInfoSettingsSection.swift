//
//  UserInfoSettingsSection.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 07.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

class UserInfoSettingsSection: SettingsSection {
	let type: SettingsSectionType = .userInfo
	let sectionTitle = "User Info"

	var rowCount: Int {
		return items.count
	}

	let items: [UserInfoCellModel]

	init(items: [UserInfoCellModel]) {
		self.items = items
	}
}
