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
		let tabBarController = TabBarController.setup()
		configureWindow(with: tabBarController)
	}
}

private extension AppCoordinator {
	func configureWindow(with rootViewController: UIViewController) {
		window.rootViewController = rootViewController
		window.makeKeyAndVisible()
	}
}
