//
//  EmailSettingsSection.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 07.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

class EmailSettingsSection: SettingsSection {
	let type: SettingsSectionType = .email
	let sectionTitle = "Email"

	var rowCount: Int {
		return 1
	}

	let email: String?

	init(email: String?) {
		self.email = email
	}
}
