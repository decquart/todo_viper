//
//  TaskListPresenter.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol TaskListViewOutput: class {
	var tasks: [Task]? { get set }
	init(view: TaskListViewInput, dataProvider: TaskDataProvider, router: RouterProtocol?)
	func loadTasks()
}

protocol TaskListViewInput: class {
	func didTaskFetch()
}

class TaskListPresenter: TaskListViewOutput {
	weak var view: TaskListViewInput?
	let dataProvider: TaskDataProvider!
	let router: RouterProtocol?

	var tasks: [Task]? {
		didSet {
			view?.didTaskFetch()
		}
	}

	required init(view: TaskListViewInput, dataProvider: TaskDataProvider, router: RouterProtocol?) {
		self.view = view
		self.dataProvider = dataProvider
		self.router = router
	}

	func loadTasks() {
		self.tasks = dataProvider.tasks
	}
}
