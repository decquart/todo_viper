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
		let module = CategoryListModule().build(onEdit: {
			self.showCategoryDetails(scope: $0)
		}, onCreate: {
			self.showCategoryDetails(scope: $0)
		}, onPresent: {
			self.showTasks(category: $0)
		})

		router.appendToTabBar(module)
	}

	private func showCategoryDetails(scope: Scope<CategoryViewModel>) {
		let module = CategoryDetailsModule().build(scope: scope)
		self.router.push(module)
	}

	private func showTasks(category: Category) {
		let module = TaskListModule().build(category: category)
		self.router.push(module)
	}
}
