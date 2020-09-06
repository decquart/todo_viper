//
//  SettingsSection.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 07.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

enum SettingsSectionType {
	case userInfo
	case email
	case theme
}

protocol SettingsSection {
	var type: SettingsSectionType { get }
	var rowCount: Int { get }
	var sectionTitle: String { get }
}

extension SettingsSection {
	var rowCount: Int {
		return 1
	}
}
