//
//  SettingsModule.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 14.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class SettingsModule {
	func build() -> UIViewController {
		let storyboard = UIStoryboard(name: "Settings", bundle: nil)
		let view = storyboard.instantiateViewController(withIdentifier: SettingsViewController.identifire) as! SettingsViewController
		view.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 0)
		return view
	}
}
