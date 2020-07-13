//
//  CategoryListRouter.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 13.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

class CategoryListRouter: CategoryListRouterProtocol {
	weak var view: CategoryListViewProtocol!

	func showCategoryDetailsViewController(scope: Scope<CategoryViewModel>) {
		let vc = CategoryDetailsModule().build(scope: scope)
		view.navigationController?.pushViewController(vc, animated: true)
	}

	func showTaskListViewController(category: Category) {
		let vc = TaskListModule().build(category: category)
		view.navigationController?.pushViewController(vc, animated: true)
	}
}
