//
//  TaskListRouter.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 14.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

class TaskListRouter: TaskListRouterProtocol {
	private(set) weak var view: TaskListViewProtocol?

	init(view: TaskListViewProtocol) {
		self.view = view
	}

	func showSubTaskDetailsViewController(category: Category, scope: Scope<TaskViewModel>) {
		let vc = TaskDetailsModule().build(with: category, and: scope)
		view?.navigationController?.pushViewController(vc, animated: true)
	}
}
