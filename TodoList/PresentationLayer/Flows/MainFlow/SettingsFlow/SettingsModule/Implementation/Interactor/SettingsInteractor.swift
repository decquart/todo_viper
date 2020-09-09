//
//  SettingsInteractor.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 07.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

final class SettingsInteractor {
	weak var output: SettingsInteractorOutput?
	private let session: UserSessionProtocol
	private let themeService: ThemeSettingsServiceProtocol
	private let repository: AnyRepository<User>

	init(session: UserSessionProtocol, themeService: ThemeSettingsServiceProtocol, repository: AnyRepository<User>) {
		self.session = session
		self.themeService = themeService
		self.repository = repository
	}
}

//MARK: - SettingsInteractorInput
extension SettingsInteractor: SettingsInteractorInput {
	var isCurrentUserExists: Bool {
		return session.currentUser != nil
	}

	var isDarkModeEnabled: Bool {
		return themeService.isDarkModeEnabled
	}

	func setDarkMode(_ isOn: Bool) {
		themeService.setDarkModeVisble(isOn)
	}

	func fetchCurrentUser() {
		let predicate = NSPredicate(format: "name = %@", session.currentUser!)

		repository.fetch(where: predicate) { [weak self] result in
			if case let .success(users) = result, let fetchedUser = users.first {
				self?.output?.didUserFetch(fetchedUser)
			}
		}
	}

	func logOut() {
		session.logOut()
		output?.didLogOut()
	}
}
