//
//  AppDelegate.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		seedInitialDataIfNeeded()
		return true
	}
}

private extension AppDelegate {
	func seedInitialDataIfNeeded() {
		let setting = SettingsService.shared
		let repo = CDCategoryRepository(coreDataStack: CoreDataStackHolder.shared.coreDataStack)

		guard setting.isFirstLaunch else {
			return
		}

		if let url = Bundle.main.url(forResource: "Categories", withExtension: "json") {
			do {
				let data = try Data(contentsOf: url)
				let categories = try JSONDecoder().decode(Array<Category>.self, from: data)
				repo.add(categories) { success in
					if success { setting.isFirstLaunch = false }
				}
			} catch {
				print("error in \(#function): \(error)")
			}
		}
	}
}
