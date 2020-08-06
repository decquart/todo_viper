//
//  AppCoordinator.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 02.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

final class AppCoordinator: BaseCoordinator {

	private let window: UIWindow

	init(window: UIWindow) {
		self.window = window
	}

	override func start() {
		runMainFlow()
	}

	private func runMainFlow() {
		let tabBarController = UITabBarController()

		let settingsCoordinator = SettingsCoordinator()
		let categoryCoordinator = CategoiesCoordinator()

		categoryCoordinator.start()
		settingsCoordinator.start()

		let categoryVC = categoryCoordinator.router.rootViewController
		let settingsVC = settingsCoordinator.router.rootViewController

		categoryVC.tabBarItem = tabBarController.items[.categories]
		settingsVC.tabBarItem = tabBarController.items[.settings]

		tabBarController.viewControllers = [categoryVC, settingsVC]

		configureWindow(with: tabBarController)
	}
}

private extension AppCoordinator {
	func configureWindow(with rootViewController: UIViewController) {
		window.rootViewController = rootViewController
		window.makeKeyAndVisible()
	}
}
