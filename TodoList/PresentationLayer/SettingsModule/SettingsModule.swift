//
//  SettingsModule.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 14.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class SettingsModule {
	//TODO: Reconsider, mb need to create factory
	func build() -> SettingsViewController {
		let view = SettingsViewController.instantiate(storyboard: .settings)
		let router = SettingsRouter(view: view)
		let viewModel = SettingsVM(router: router)
		view.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 1)
		view.viewModel = viewModel

		return view
	}
}
