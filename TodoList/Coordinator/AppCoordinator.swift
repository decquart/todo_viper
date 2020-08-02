//
//  AppCoordinator.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 02.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

final class AppCoordinator: BaseCoordinator {

	private let router: Router

	init(router: Router) {
		self.router = router
	}

	func navController() -> UIViewController {
		return router.rootViewController
	}

	override func start() {
		let tabBarController = UITabBarController()
		let navControllers = [
			CategoryListModule().build(),
			SettingsModule().build()
		]

		tabBarController.viewControllers = navControllers


		self.router.setRootModule(tabBarController, animated: false)
	}
}
