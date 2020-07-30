//
//  TaskListModule.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 14.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

final class TaskListModule {
	func build(category: Category) -> UIViewController {
		let view = TaskListViewController.instantiate(storyboard: .task)
		let router = TaskListRouter(view: view)
		let repository = CDTaskRepository(categoryId: category.id, coreDataStack: CoreDataStackHolder.shared.coreDataStack)
		let presenter = TaskListPresenter(view: view, router: router, repository: repository, task: category)
		view.presenter = presenter
		return view
	}
}
