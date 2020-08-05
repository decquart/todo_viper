//
//  SettingsCoordinator.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 31.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

final class SettingsCoordinator: BaseCoordinator {
	override func start() {
		showSettingsViewController()
	}
}

// MARK: - Flows
private extension SettingsCoordinator {
	func showSettingsViewController() {
		let module = SettingsModule().build(onAccount: showAccountViewController, onTheme: showThemeViewController)
		self.router.setRootModule(module, animated: true)
	}

	func showAccountViewController() {
		let vc = AccountInfoModule().build()
		router.push(vc, animated: true)
	}

	func showThemeViewController() {
		let vc = ThemesModule().build()
		router.push(vc, animated: true)
	}
}
