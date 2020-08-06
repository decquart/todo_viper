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

	init(window: UIWindow) {
		self.window = window
	}

	override func start() {
		runMainFlow()
	}

	override func start(with option: DeepLink) {
		switch option {
		case .createCategory:
			showCategories()
		}
	}

	private func runMainFlow() {
		let tabBarController = TabBarController()

		let settingsCoordinator = SettingsCoordinator()
		let categoryCoordinator = CategoiesCoordinator()

		categoryCoordinator.start()
		settingsCoordinator.start()

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
}

private extension AppCoordinator {
	func showCategories() {

		#warning("Reconsider this ugly solution")
		guard let coordinator = childCoordinators.first(where: { $0 is CategoiesCoordinator }) as? CategoiesCoordinator else {
			return
		}

		self.tabBarController?.makeCurrent(.categories)
		coordinator.start(with: .createCategory)
	}

	func configureWindow(with rootViewController: UIViewController) {
		window.rootViewController = rootViewController
		window.makeKeyAndVisible()
	}
}
