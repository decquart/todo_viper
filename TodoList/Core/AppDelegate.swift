//
//  AppDelegate.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		return true
	}

	func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
		return GIDSignIn.sharedInstance().handle(url)
	}
}


extension AppDelegate {
	func seedInitialDataIfNeeded(completion: @escaping () -> Void) {
		let application = UIApplication.shared
		let repo = CDCategoryRepository(coreDataStack: CoreDataStackHolder.shared.coreDataStack)

		guard application.isFirstLaunch else {
			completion()
			return
		}

		guard let url = Bundle.main.url(forResource: "Categories", withExtension: "json") else {
			completion()
			return
		}

		do {
			let data = try Data(contentsOf: url)
			let categories = try JSONDecoder().decode(Array<Category>.self, from: data)
			repo.add(categories) { success in
				if success { application.isFirstLaunch = false }
				completion()
			}
		} catch {
			completion()
			print("error in \(#function): \(error)")
		}
	}
}
