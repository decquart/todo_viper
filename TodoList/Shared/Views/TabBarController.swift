//
//  TabBarController.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 06.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

final class TabBarController: UITabBarController {
	enum TabItem: Int {
		case categories
		case settings
	}

	private static var items: [TabItem: UITabBarItem] {
		return [
			.categories: UITabBarItem(title: "Categories",
									  image: UIImage(systemName: "pencil.circle.fill"),
									  tag: TabItem.categories.rawValue),
			.settings: UITabBarItem(title: "Settings",
									image: UIImage(systemName: "gear"),
									tag: TabItem.settings.rawValue)
		]
	}

	static func setup() -> TabBarController {
		let tabBar = TabBarController()

		let settingsCoordinator = SettingsCoordinator()
		let categoryCoordinator = CategoiesCoordinator()

		categoryCoordinator.start()
		settingsCoordinator.start()

		let coordinatorVC = categoryCoordinator.router.rootViewController
		let settingsVC = settingsCoordinator.router.rootViewController

		coordinatorVC.tabBarItem = items[.categories]
		settingsVC.tabBarItem = items[.settings]

		tabBar.viewControllers = [coordinatorVC, settingsVC]
		return tabBar
	}
}
