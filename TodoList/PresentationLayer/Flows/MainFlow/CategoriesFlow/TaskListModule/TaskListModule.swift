//
//  TaskListModule.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 14.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

final class TaskListModule {
	func build(category: Category, onPresent: TaskDetailsHandler?) -> UIViewController {
		let view = TaskListViewController.instantiate(storyboard: .task)
		let repository = CDTaskRepository(categoryId: category.id, coreDataStack: CoreDataStackHolder.shared.coreDataStack)
		let presenter = TaskListPresenter(view: view, repository: repository, task: category)
		presenter.onPresentDetails = onPresent
		view.presenter = presenter
		return view
	}
}
