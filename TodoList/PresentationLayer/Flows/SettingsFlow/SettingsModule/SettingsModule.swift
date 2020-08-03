//
//  SettingsModule.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 14.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class SettingsModule {
	func build(onAccount: Completion?, onTheme: Completion?) -> UIViewController {
		let view = SettingsViewController.instantiate(storyboard: .settings)

		let viewModel = SettingsVM()
		viewModel.onAccount = onAccount
		viewModel.onTheme = onTheme
		view.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 1)
		view.viewModel = viewModel

		return view
	}
}
