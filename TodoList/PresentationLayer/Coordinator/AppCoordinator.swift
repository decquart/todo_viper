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
	private var tabBarController: TabBarController?

	let settingsCoordinator: SettingsCoordinator
	let categoryCoordinator: CategoiesCoordinator

	init(window: UIWindow) {
		self.window = window
		self.settingsCoordinator = SettingsCoordinator()
		self.categoryCoordinator = CategoiesCoordinator()
		super.init()

		let tabBarController = TabBarController()

		addDependency(categoryCoordinator)
		addDependency(settingsCoordinator)

		let categoryVC = categoryCoordinator.router.rootViewController
		let settingsVC = settingsCoordinator.router.rootViewController

		categoryVC.tabBarItem = tabBarController.items[.categories]
		settingsVC.tabBarItem = tabBarController.items[.settings]

		tabBarController.viewControllers = [categoryVC, settingsVC]
		self.tabBarController = tabBarController

		configureWindow(with: tabBarController)
	}

	override func start() {
		runMainFlow()
	}

	func handle(_ link: DeepLink) {
		switch link {
		case .createCategory:
			showCategories()
		}
	}

	private func runMainFlow() {
		categoryCoordinator.start()
		settingsCoordinator.start()
	}
}

private extension AppCoordinator {
	func showCategories() {
		self.tabBarController?.selectTab(.categories)
		categoryCoordinator.handle(.createCategory)
	}

	func configureWindow(with rootViewController: UIViewController) {
		window.rootViewController = rootViewController
		window.makeKeyAndVisible()
	}
}
