//
//  AppCoordinator.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 02.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

final class AppCoordinator: BaseCoordinator {

	private let router: Routable
	private let window: UIWindow

	init(window: UIWindow) {
		let navController = UINavigationController()
		self.router = MainRouter(navigationController: navController)
		self.window = window

		window.rootViewController = navController
		window.makeKeyAndVisible()
	}

	override func start() {
		runMainFlow()
	}

	private func runMainFlow() {
		let tabBarController = UITabBarController()

		let settingsCoordinator = SettingsCoordinator(router: router)
		let categoryCoordinator = CategoiesCoordinator(router: router)

		self.router.setRootModule(tabBarController, hideBar: true, animated: false)

		categoryCoordinator.start()
		settingsCoordinator.start()
	}
}
