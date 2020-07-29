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
}

struct SettingsCellViewModel {
	let title: String
	let imageUrl: String
	let cellType: SettingCellType
}

class SettingsVM: SettingsVMProtocol {
	let router: SettingsRouterProtocol?

	init(router: SettingsRouterProtocol) {
		self.router = router
	}

	private lazy var cells: [SettingsCellViewModel] = {
		return [
			SettingsCellViewModel(title: "Account", imageUrl: "person", cellType: .account),
			SettingsCellViewModel(title: "Theme", imageUrl: "paintbrush", cellType: .theme)
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
			router?.showAccountInfoViewController()
		case .theme:
			router?.showThemesViewController()
		}
	}
}
