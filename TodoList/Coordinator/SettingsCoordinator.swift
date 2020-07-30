//
//  SettingsCoordinator.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 31.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

final class SettingsCoordinator: BaseCoordinator, SettingsCoordinatorProtocol {
	var finishFlow: (() -> Void)?

	private let router: RouterType

	init(router: RouterType) {
		self.router = router
	}

	override func start() {
		showSettingsViewController()
	}

	private func showSettingsViewController() {
		let settingsViewController = SettingsModule().build()

		settingsViewController.onAccount = { [unowned self] in
			self.showAccountViewController()
		}

		settingsViewController.onTheme = { [unowned self] in
			self.showThemeViewController()
		}

		self.router.setRootModule(settingsViewController, animated: false)
	}

	func showAccountViewController() {
		//todo
	}

	func showThemeViewController() {
		//todo
	}
}
