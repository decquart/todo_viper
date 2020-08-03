//
//  SettingsCoordinator.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 31.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

final class SettingsCoordinator: BaseCoordinator, SettingsCoordinatorProtocol {
	var finishFlow: (() -> Void)?

	private let router: RouterType
	let tabBarController: UITabBarController

	init(router: RouterType, tabBarController: UITabBarController) {
		self.router = router
		self.tabBarController = tabBarController
	}

	override func start() {
		showSettingsViewController()
	}

	private func showSettingsViewController() {
		let settingsViewController = SettingsModule().build(onAccount: {
			self.showAccountViewController()
		}, onTheme: {
			self.showThemeViewController()
		})

		self.router.appendToTabBar(settingsViewController)
	}

	private func showAccountViewController() {
		let vc = AccountInfoModule().build()
		router.push(vc, animated: true)
	}

	private func showThemeViewController() {
		let vc = ThemesModule().build()
		router.push(vc, animated: true)
	}
}
