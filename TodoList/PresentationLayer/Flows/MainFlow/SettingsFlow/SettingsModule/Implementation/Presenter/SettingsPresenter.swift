//
//  SettingsPresenter.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 04.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

final class SettingsPresenter: SettingsPresenterProtocol {
	var onAccount: (() -> Void)?
	var onTheme: (() -> Void)?
	var onLogOut: (() -> Void)?

	let interactor: SettingsInteractorInput!
	weak var view: SettingsViewProtocol!
	private var user: User?

	init(interactor: SettingsInteractorInput, view: SettingsViewProtocol) {
		self.interactor = interactor
		self.view = view
	}

	func viewDidLoad() {
		interactor.fetchCurrentUser()
	}

	private var sections: [SettingsSection] {
		return [
			UserInfoSettingsSection(items: [
				UserInfoCellModel(name: user?.name ?? "", imageData: user?.image)
			]),
			EmailSettingsSection(email: user?.email),
			ThemeSettingsSection(cellDescription: "Dark Mode", isDarkModeEnabled: interactor.isDarkModeEnabled, onSwitch: interactor.setDarkMode(_:)),
			LogOutCellSection(models: [
				SettingsCellModel(title: "Log Out", imageName: "lock")
			])

		]
	}

	var numberOfSections: Int {
		return sections.count
	}

	func numberOfRows(in section: Int) -> Int {
		return sections[section].rowCount
	}

	func sectionInfo(at index: Int) -> SettingsSection {
		return sections[index]
	}

	func titleForHeader(at index: Int) -> String {
		return sections[index].sectionTitle
	}

	func didSelectTableViewCell(at section: Int, and row: Int) {
		let section = sections[section]

		switch section.type {
		case .logOut:
			interactor.logOut()
		default:
			break
		}
	}
}

//MARK: - SettingsInteractorOutput
extension SettingsPresenter: SettingsInteractorOutput {
	func didUserFetch(_ user: User) {
		self.user = user
		view.reloadData()
	}

	func didLogOut() {
		onLogOut?()
	}
}
