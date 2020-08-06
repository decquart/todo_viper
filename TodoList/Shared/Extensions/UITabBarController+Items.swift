//
//  UITabBarController+Items.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 06.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

enum TabItem: Int {
	case categories
	case settings
}

extension UITabBarController {
	var items: [TabItem: UITabBarItem] {
		return [
			.categories: UITabBarItem(title: "Categories",
									  image: UIImage(systemName: "pencil.circle.fill"),
									  tag: TabItem.categories.rawValue),
			.settings: UITabBarItem(title: "Settings",
									image: UIImage(systemName: "gear"),
									tag: TabItem.settings.rawValue)
		]
	}
}
