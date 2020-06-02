//
//  TaskListPresenter.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation
import UIKit

protocol TaskListViewOutput: class {
	var tasks: [Task]? { get set }
	init(view: TaskListViewInput, dataProvider: LocalTasksRepository, router: RouterProtocol?)
	func loadTasks()
	func addTaskButtonPressed()
	func didSelectTask(with index: Int)
}

protocol TaskListViewInput: class {
	func didTaskFetch()
}

class TaskListPresenter: TaskListViewOutput {

	weak var view: TaskListViewInput?
	let dataProvider: LocalTasksRepository!
	let router: RouterProtocol?

	var tasks: [Task]? {
		didSet {
			view?.didTaskFetch()
		}
	}

	required init(view: TaskListViewInput, dataProvider: LocalTasksRepository, router: RouterProtocol?) {
		self.view = view
		self.dataProvider = dataProvider
		self.router = router
	}

	func loadTasks() {
		tasks = dataProvider.getAll()
	}

	func didSelectTask(with index: Int) {
		guard let task = tasks?[index] else {
			return
		}

		router?.showSubTaskListViewController(task: task)
	}

	func addTaskButtonPressed() {
		router?.showAddTaskViewController()
	}
}
