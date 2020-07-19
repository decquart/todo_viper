//
//  SettingsService.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 20.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

protocol AccountSettingsServiceProtocol {
	var userImage: Data? { get set }
}

final class SettingsService: AccountSettingsServiceProtocol {
	var userImage: Data? {
		get { return UserDefaults.standard[#function] }
		set { UserDefaults.standard[#function] = newValue }
	}
}
