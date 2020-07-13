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
		// Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
		// If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
		// This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
		guard let windowScene = (scene as? UIWindowScene) else { return }

		configureMainView(with: windowScene)
	}
}

private extension SceneDelegate {
	func configureMainView(with windowScene: UIWindowScene) {
		window = UIWindow(frame: windowScene.coordinateSpace.bounds)
		window?.windowScene = windowScene


		window?.rootViewController = MainModule().build()
		window?.makeKeyAndVisible()
	}
}
