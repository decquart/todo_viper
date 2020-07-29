//
//  SettingsRouter.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 16.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class SettingsRouter: SettingsRouterProtocol {
	private(set) weak var view: SettingsViewProtocol?

	init(view: SettingsViewProtocol) {
		self.view = view
	}

	func showAccountInfoViewController() {
		let vc = AccountInfoModule().build()
		view?.navigationController?.pushViewController(vc, animated: true)
	}

	func showThemesViewController() {
		let vc = ThemesModule().build()
		view?.navigationController?.pushViewController(vc, animated: true)
	}
}
