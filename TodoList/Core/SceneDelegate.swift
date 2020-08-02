//
//  SceneDelegate.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }

		configureMainView(with: windowScene)
	}
}

private extension SceneDelegate {
	func configureMainView(with windowScene: UIWindowScene) {
		window = UIWindow(frame: windowScene.coordinateSpace.bounds)
		window?.windowScene = windowScene

		let navController = UINavigationController()
		let router = Router(navigationController: navController)
		let appCoordinator = AppCoordinator(router: router)
		appCoordinator.start()

		window?.rootViewController = appCoordinator.navController()
		window?.makeKeyAndVisible()

		SettingsService.shared.refreshDarkMode()
	}
}
