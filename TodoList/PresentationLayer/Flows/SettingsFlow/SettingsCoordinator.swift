//
//  SettingsCoordinator.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 31.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

final class SettingsCoordinator: BaseCoordinator {
	var finishFlow: (() -> Void)?

	private let router: Routable
	let tabBarController: UITabBarController

	init(router: Routable, tabBarController: UITabBarController) {
		self.router = router
		self.tabBarController = tabBarController
	}

	override func start() {
		showSettingsViewController()
	}
}

// MARK: - Flows
private extension SettingsCoordinator {
	func showSettingsViewController() {
		let settingsViewController = SettingsModule().build(onAccount: {
			self.showAccountViewController()
		}, onTheme: {
			self.showThemeViewController()
		})

		self.router.appendToTabBar(settingsViewController)
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
