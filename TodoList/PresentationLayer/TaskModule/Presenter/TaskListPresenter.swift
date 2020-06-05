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

	var tasks: [TaskEntity]? { get set }
	init(view: TaskListViewInput, dataProvider: TasksRepositoryType, router: RouterProtocol?)
	func loadTasks()
	func getSubTasksCount(for task: TaskEntity) -> Int
	func addTaskButtonPressed()
	func didSelectTask(with index: Int)
}

protocol TaskListViewInput: class {
	func didTaskFetch()
}

class TaskListPresenter: TaskListViewOutput {

	weak var view: TaskListViewInput?
	let dataProvider: TasksRepositoryType!
	let router: RouterProtocol?

	var tasks: [TaskEntity]? {
		didSet {
			view?.didTaskFetch()
		}
	}

	required init(view: TaskListViewInput, dataProvider: TasksRepositoryType, router: RouterProtocol?) {
		self.view = view
		self.dataProvider = dataProvider
		self.router = router
	}

	func loadTasks() {
		tasks = dataProvider.getAll()
	}

	func getSubTasksCount(for task: TaskEntity) -> Int {
		return dataProvider.getSubTasksCount(for: task)
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
