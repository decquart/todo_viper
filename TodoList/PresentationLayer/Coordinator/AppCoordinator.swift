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

	private var settingsCoordinator: SettingsCoordinator?
	private var categoryCoordinator: CategoiesCoordinator?

	private let userSession = UserSession.default

	init(window: UIWindow) {
		self.window = window

		super.init()
	}

	override func start() {
		if userSession.isAuthorized {
			runMainFlow()
		} else {
			runAuthFlow()
		}
	}

	func handle(_ link: DeepLink) {
		switch link {
		case .createCategory:
			showCategories()
		}
	}

	private func runMainFlow() {
		self.settingsCoordinator = SettingsCoordinator()
		self.categoryCoordinator = CategoiesCoordinator()

		let tabBarController = TabBarController()

		addDependency(categoryCoordinator!)
		addDependency(settingsCoordinator!)

		let categoryVC = categoryCoordinator!.router.rootViewController
		let settingsVC = settingsCoordinator!.router.rootViewController

		categoryVC.tabBarItem = tabBarController.items[.categories]
		settingsVC.tabBarItem = tabBarController.items[.settings]

		tabBarController.viewControllers = [categoryVC, settingsVC]
		self.tabBarController = tabBarController

		categoryCoordinator?.start()
		settingsCoordinator?.start()

		configureWindow(with: tabBarController)
	}

	private func runAuthFlow() {
		let authCoordinator = AuthCoordinator()
		authCoordinator.onFinish = { [weak self] in
			self?.removeDependency(authCoordinator)
			self?.start()
		}

		addDependency(authCoordinator)
		authCoordinator.start()
		configureWindow(with: authCoordinator.router.rootViewController)
	}
}

private extension AppCoordinator {
	func showCategories() {
		self.tabBarController?.selectTab(.categories)
		categoryCoordinator?.handle(.createCategory)
	}

	func configureWindow(with rootViewController: UIViewController) {
		window.rootViewController = rootViewController
		window.makeKeyAndVisible()
	}
}
