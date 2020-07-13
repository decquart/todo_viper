//
//  MainRouter.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 13.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class MainRouter: MainRouterProtocol {
	weak var view: MainViewProtocol!

	func viewControllers() -> [UIViewController] {
		//TODO: move to module builders
		let builder = AssemblyBuilder()

		return [builder.createCategoryListModule(), builder.createSettingsModule()]
			.map { UINavigationController(rootViewController: $0) }
	}
}
