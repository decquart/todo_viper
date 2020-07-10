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

		let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
		let tabBarController = mainStoryboard.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController

		let builder = AssemblyBuilder()
		let router = Router(assemblyBuilder: builder)

		let settingsVC = builder.createSettingsModule(router: router)
		let tasksVC = builder.createMainModule(router: router)


		settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 0)
		tasksVC.tabBarItem =  UITabBarItem(title: "Tasks", image: UIImage(systemName: "pencil.circle.fill"), tag: 1)

		let tasksNavigationController = UINavigationController(rootViewController: tasksVC)
		let settingsNavigationController = UINavigationController(rootViewController: settingsVC)
		tabBarController.viewControllers = [tasksNavigationController, settingsNavigationController]

		router.mainNavigationController = tasksNavigationController
		router.settingsNavigationController = settingsNavigationController

		window?.rootViewController = tabBarController
		window?.makeKeyAndVisible()
	}
}
