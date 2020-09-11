//
//  SettingsCoordinator.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 31.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

final class SettingsCoordinator: BaseCoordinator {

	var onLogOut: (() -> Void)?

	override func start() {
		showSettingsViewController()
	}
}

// MARK: - Flows
private extension SettingsCoordinator {
	func showSettingsViewController() {
		let module = SettingsModule().build(onAccount: showAccountViewController,
											onTheme: showThemeViewController,
											onLogOut: onLogOut)
		self.router.setRootModule(module, animated: true)
	}

	func showAccountViewController() {
		let vc = AccountInfoModule().build()
		router.push(vc, animated: true)
	}

	func showThemeViewController() {
		let vc = ThemesModule().build(onDismiss: router.pop)
		router.push(vc, animated: true)
	}
}
