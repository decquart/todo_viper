//
//  SettingsVM.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 15.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

enum SettingCellType {
	case account
	case theme
	case logOut
}

struct SettingsCellViewModel {
	let title: String
	let imageUrl: String
	let cellType: SettingCellType
}

class SettingsVM: SettingsVMProtocol {
	var onAccount: (() -> Void)?
	var onTheme: (() -> Void)?
	var onLogOut: (() -> Void)?

	private let session: UserSessionProtocol

	init(session: UserSessionProtocol) {
		self.session = session
	}

	private lazy var cells: [SettingsCellViewModel] = {
		return [
			SettingsCellViewModel(title: "Account", imageUrl: "person", cellType: .account),
			SettingsCellViewModel(title: "Theme", imageUrl: "paintbrush", cellType: .theme),
			SettingsCellViewModel(title: "Log Out", imageUrl: "lock", cellType: .logOut)
		]
	}()

	var numberOfRows: Int {
		return cells.count
	}

	func viewModelCell(at index: Int) -> SettingsCellViewModel {
		return cells[index]
	}

	func didSelectTableViewCell(at index: Int) {
		let type = cells[index].cellType

		switch type {
		case .account:
			onAccount?()
		case .theme:
			onTheme?()
		case .logOut:
			session.logOut()
			onLogOut?()
		}
	}
}
