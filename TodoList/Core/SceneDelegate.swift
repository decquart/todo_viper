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
	private var appCoordinator: AppCoordinator?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }

		configureMainView(with: windowScene)
	}

	func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
		guard let deepLink = DeepLink(rawValue: shortcutItem.type) else {
			return
		}

		appCoordinator?.handle(deepLink)
	}
}

private extension SceneDelegate {
	func configureMainView(with windowScene: UIWindowScene) {
		window = UIWindow(frame: windowScene.coordinateSpace.bounds)
		window!.windowScene = windowScene

		appCoordinator = AppCoordinator(window: window!)
		appCoordinator?.start()
		SettingsService.shared.refreshDarkMode()
	}
}
