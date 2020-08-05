//
//  CategoiesCoordinator.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 03.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

final class CategoiesCoordinator: BaseCoordinator {

	let router: Routable

	init(router: Routable) {
		self.router = router
	}

	override func start() {
		showCategoryListModule()
	}
}

// MARK: - Flows
private extension CategoiesCoordinator {
	func showCategoryListModule() {
		let module = CategoryListModule().build(onShowCategoryDetails: { [unowned self] in
			self.showCategoryDetails(scope: $0)
		}, onPresent: {
			self.showTasks(category: $0)
		})

		router.appendToTabBar(module)
	}

	func showCategoryDetails(scope: Scope<CategoryViewModel>) {
		let module = CategoryDetailsModule().build(scope: scope) { [unowned self] in
			self.router.pop()
		}

		self.router.push(module)
	}

	func showTasks(category: Category) {
		let module = TaskListModule().build(category: category) { [unowned self] in
			self.showTaskDetails(category: $0, scope: $1)
		}

		self.router.push(module)
	}

	func showTaskDetails(category: Category, scope: Scope<TaskViewModel>) {
		let module = TaskDetailsModule().build(with: category, and: scope) { [unowned self] in

			//todo: Refresh tasks after dismiss
			self.router.dismiss()
		}

		self.router.present(module)
	}
}
