//
//  SettingsPresenter.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 04.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

enum SettingsCellType {
	case photo(UserInfoCellModel, type: PhotoCellType)
	case regular(RegularSettingsCellModel, type: RegularCellType)
	case icon(SettingsCellModel, type: IconCellType)
	case `switch`(SwitchCellModel, type: SwitchCellType)

	enum IconCellType {
		case logOut
	}

	enum PhotoCellType {
		case profile
	}

	enum RegularCellType {
		case email
	}

	enum SwitchCellType {
		case darkMode
	}
}

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
		if interactor.isCurrentUserExists {
			interactor.fetchCurrentUser()
		}
	}

	private var sectionsForAuthorizedUser: [[SettingsCellType]] {
		return [
			[.photo(UserInfoCellModel(name: user?.name ?? "", imageData: user?.image), type: .profile)],
			[.regular(RegularSettingsCellModel(title: user?.email ?? ""), type: .email)],
			[.switch(SwitchCellModel(title: "Dark Mode", isOn: interactor.isDarkModeEnabled, onSwitch: interactor.setDarkMode(_:)), type: .darkMode)],
			[.icon(SettingsCellModel(title: "Log Out", imageName: "lock"), type: .logOut)]
		]
	}

	private var sectionsForUnAuthorizedUser: [[SettingsCellType]] {
		return [
			[.switch(SwitchCellModel(title: "Dark Mode", isOn: interactor.isDarkModeEnabled, onSwitch: interactor.setDarkMode(_:)), type: .darkMode)],
			[.icon(SettingsCellModel(title: "Log In", imageName: "person"), type: .logOut)]
		]
	}

	var sections: [[SettingsCellType]] {
		return interactor.isCurrentUserExists
			? sectionsForAuthorizedUser
			: sectionsForUnAuthorizedUser
	}

	var numberOfSections: Int {
		return sections.count
	}

	func numberOfRows(in section: Int) -> Int {
		return sections[section].count
	}


	func titleForHeader(at index: Int) -> String {
		return ""//sections[index].sectionTitle
	}

	func didSelectTableViewCell(at section: Int, and row: Int) {
		let cellType = sections[section][row]

		switch cellType {
		case .icon(_, let type):
			if type == .logOut {
				interactor.logOut()
			}
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
