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

	var numberOfTasks: Int { get }
	func task(at index: Int) -> TaskViewModel?

	func loadTasks()
	func addTaskButtonPressed()
	func didSelectTask(with index: Int)
}

protocol TaskListViewInput: class {
	var isEditMode: Bool { get }
	func didTaskFetch()
}

class TaskListPresenter: TaskListViewOutput {

	weak var view: TaskListViewInput?
	let repository: TasksRepositoryType
	let router: RouterProtocol

	var tasks: [TaskEntity]? {
		didSet {
			view?.didTaskFetch()
		}
	}

	var numberOfTasks: Int {
		return tasks?.count ?? 0
	}

	required init(view: TaskListViewInput, repository: TasksRepositoryType, router: RouterProtocol) {
		self.view = view
		self.repository = repository
		self.router = router
	}

	func task(at index: Int) -> TaskViewModel? {
		guard let task = tasks?[index] else {
			return nil
		}

		let count = repository.getSubTasksCount(for: task)

		return TaskViewModel(taskEntity: task, subTasksCount: count)
	}

	func loadTasks() {
		repository.getAll() {
			self.tasks = $0
		}
	}

	func didSelectTask(with index: Int) {
		guard let task = tasks?[index], let view = view else {
			return
		}

		if view.isEditMode {
			router.showEditTaskAlertViewController(editAction: {
				self.router.showTaskDetailsViewController(scope: .edit(task: task))
			}, deleteAction: {
				self.repository.delete(task: task)
				self.tasks = self.tasks?.filter { task.id != $0.id }
			})

			return
		}

		router.showSubTaskListViewController(task: task)
	}

	func addTaskButtonPressed() {
		router.showTaskDetailsViewController(scope: .create)
	}
}
