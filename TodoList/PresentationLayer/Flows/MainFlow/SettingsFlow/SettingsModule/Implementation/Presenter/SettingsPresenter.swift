//
//  SettingsPresenter.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 04.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

enum SettingsCellType {
	case photo(PhotoCellModel, type: PhotoCellType)
	case regular(RegularSettingsCellModel, type: RegularCellType)
	case icon(SettingsCellModel, type: IconCellType)
	case `switch`(SwitchCellModel, type: SwitchCellType)
	case color(ColorCellModel)

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

struct SettingsSection {
	let title: String
	let cells: [SettingsCellType]
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

	private var sectionsForAuthorizedUser: [SettingsSection] {
		return [
			SettingsSection(title: "User Info", cells: [.photo(PhotoCellModel(name: user?.name ?? "", imageData: user?.image), type: .profile)]),
			SettingsSection(title: "Email", cells: [.regular(RegularSettingsCellModel(title: user?.email ?? ""), type: .email)]),
			SettingsSection(title: "Theme", cells: [
				.switch(SwitchCellModel(title: "Dark Mode", isOn: interactor.isDarkModeEnabled, onSwitch: interactor.setDarkMode(_:)), type: .darkMode),
				.color(ColorCellModel(title: "Application color", color: .customGreen))
			]),
			SettingsSection(title: "", cells: [.icon(SettingsCellModel(title: "Log Out", imageName: "lock"), type: .logOut)])
		]
	}

	private var sectionsForUnAuthorizedUser: [SettingsSection] {
		return [
			SettingsSection(title: "Theme", cells: [.switch(SwitchCellModel(title: "Dark Mode", isOn: interactor.isDarkModeEnabled, onSwitch: interactor.setDarkMode(_:)), type: .darkMode)]),
			SettingsSection(title: "", cells: [.icon(SettingsCellModel(title: "Log In", imageName: "person"), type: .logOut)])
		]
	}

	var sections: [SettingsSection] {
		return interactor.isCurrentUserExists
			? sectionsForAuthorizedUser
			: sectionsForUnAuthorizedUser
	}

	var numberOfSections: Int {
		return sections.count
	}

	func numberOfRows(in section: Int) -> Int {
		return sections[section].cells.count
	}

	func cellModel(at section: Int, and row: Int) -> SettingsCellType {
		return sections[section].cells[row]
	}

	func titleForHeader(at index: Int) -> String {
		return sections[index].title
	}

	func didSelectTableViewCell(at section: Int, and row: Int) {
		let cellType = sections[section].cells[row]

		switch cellType {
		case .icon(_, let type):
			if type == .logOut {
				interactor.logOut()
			}
		case .color(_):
			onTheme?()
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
