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
		guard userSession.isAuthorized else {
			runAuthFlow()
			return
		}

		switch link {
		case .createCategory:
			let coordinator = runMainFlow()
			coordinator.handle(link)
		}
	}

	@discardableResult
	private func runMainFlow() -> MainCoordinator {
		let mainCoordinator = MainCoordinator()
		mainCoordinator.onFinish = { [unowned self, unowned mainCoordinator] in
			self.removeDependency(mainCoordinator)
			self.start()
		}

		addDependency(mainCoordinator)
		mainCoordinator.start()
		configureWindow(with: mainCoordinator.tabBarController)
		return mainCoordinator
	}

	private func runAuthFlow() {
		let authCoordinator = AuthCoordinator()
		authCoordinator.onFinish = { [unowned self, unowned authCoordinator] in
			self.removeDependency(authCoordinator)
			self.start()
		}

		addDependency(authCoordinator)
		authCoordinator.start()
		configureWindow(with: authCoordinator.router.rootViewController)
	}
}

private extension AppCoordinator {
	func configureWindow(with rootViewController: UIViewController) {
		window.rootViewController = rootViewController
		window.makeKeyAndVisible()
	}
}
