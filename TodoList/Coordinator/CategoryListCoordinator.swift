//
//  CategoryListCoordinator.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 03.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

final class CategoryListCoordinator: BaseCoordinator {

	let router: RouterType

	init(router: RouterType) {
		self.router = router
	}

	override func start() {
		let module = CategoryListModule().build()
		router.appendToTabBar(module)
	}
}
