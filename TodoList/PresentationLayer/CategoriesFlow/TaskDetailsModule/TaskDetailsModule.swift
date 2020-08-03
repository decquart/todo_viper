//
//  TaskDetailsModule.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 14.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

final class TaskDetailsModule {
	func build(with category: Category, and scope: Scope<TaskViewModel>) -> UIViewController {
		let view = TaskDetailsViewController.instantiate(storyboard: .taskDetails)
		let router = TaskDetailsRouter(view: view)
		let repository = CDTaskRepository(categoryId: category.id, coreDataStack: CoreDataStackHolder.shared.coreDataStack)
		let presenter = TaskDetailsPresenter(view: view, router: router, repository: repository, category: category)

		view.presenter = presenter
		view.scope = scope
		return view
	}
}