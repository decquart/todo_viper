//
//  CategoryListRouter.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 13.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

class CategoryListRouter: CategoryListRouterProtocol {
	var view: CategoryListViewProtocol!

	func showCategoryDetailsViewController(scope: Scope<CategoryViewModel>) {
		//TODO: get rid of AssemblyBuilder
		let bldr = AssemblyBuilder()
		let vc = bldr.createCategoryDetailsModule(scope: scope)
		view.navigationController?.pushViewController(vc, animated: true)
	}

	func showTaskListViewController(category: Category) {
		//TODO: get rid of AssemblyBuilder
		let bldr = AssemblyBuilder()
		let vc = bldr.createTaskListModule(category: category)
		view.navigationController?.pushViewController(vc, animated: true)
	}
}
