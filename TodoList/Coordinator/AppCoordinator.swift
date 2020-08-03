//
//  AppCoordinator.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 02.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

final class AppCoordinator: BaseCoordinator {

	private let router: RouterType
	private let window: UIWindow

	init(window: UIWindow) {
		let navController = UINavigationController()
		self.router = Router(navigationController: navController)
		self.window = window

		window.rootViewController = navController
		window.makeKeyAndVisible()
	}

	override func start() {
		runMainFlow()
	}

	private func runMainFlow() {
		let tabBarController = UITabBarController()

		let settingsCoordinator = SettingsCoordinator(router: router, tabBarController: tabBarController)
		let categoryCoordinator = CategoryListCoordinator(router: router)

		self.router.setRootModule(tabBarController, animated: false)

		categoryCoordinator.start()
		settingsCoordinator.start()
	}
}
