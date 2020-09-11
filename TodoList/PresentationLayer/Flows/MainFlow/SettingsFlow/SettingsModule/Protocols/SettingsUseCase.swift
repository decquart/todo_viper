//
//  SettingsUseCase.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 07.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol SettingsInteractorInput: class {
	var output: SettingsInteractorOutput? { get }

	var isCurrentUserExists: Bool { get }
	var isDarkModeEnabled: Bool { get }
	var applicationColor: Color { get }
	func setDarkMode(_ isOn: Bool)

	func fetchCurrentUser()
	func logOut()
}

protocol SettingsInteractorOutput: class {
	func didUserFetch(_ user: User)
	func didLogOut()
}
