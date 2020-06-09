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
	init(view: TaskListViewInput, repository: TasksRepositoryType, router: RouterProtocol?)
	func loadTasks()
	func getSubTasksCount(for task: TaskEntity) -> Int
	func addTaskButtonPressed()
	func didSelectTask(with index: Int, isEditing: Bool)
}

protocol TaskListViewInput: class {
	func didTaskFetch()
}

class TaskListPresenter: TaskListViewOutput {

	weak var view: TaskListViewInput?
	let repository: TasksRepositoryType!
	let router: RouterProtocol?

	var tasks: [TaskEntity]? {
		didSet {
			view?.didTaskFetch()
		}
	}

	required init(view: TaskListViewInput, repository: TasksRepositoryType, router: RouterProtocol?) {
		self.view = view
		self.repository = repository
		self.router = router
	}

	func loadTasks() {
		tasks = repository.getAll()
	}

	func getSubTasksCount(for task: TaskEntity) -> Int {
		return repository.getSubTasksCount(for: task)
	}

	func didSelectTask(with index: Int, isEditing: Bool) {
		guard let task = tasks?[index] else {
			return
		}

		if isEditing {
			router?.showEditTaskAlertViewController(editAction: {
				self.router?.showTaskDetailsViewController(scope: .edit(task: task))
			}, deleteAction: {
				self.repository.delete(task: task)
				self.tasks = self.tasks?.filter { task.id != $0.id }
			})

			return
		}

		router?.showSubTaskListViewController(task: task)
	}

	func addTaskButtonPressed() {
		router?.showTaskDetailsViewController(scope: .create)
	}
}
