//
//  CategoryListRouterProtocol.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 13.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol CategoryListRouterProtocol: class {
	var view: CategoryListViewProtocol! { get }
	func showCategoryDetailsViewController(scope: Scope<CategoryViewModel>)
	func showTaskListViewController(category: Category)
}
