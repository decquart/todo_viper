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
	func task(at index: Int) -> TaskViewModel
	func subTasksCount(at index: Int) -> Int
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

	var tasks: [TaskEntity] = [] {
		didSet {
			view?.didTaskFetch()
		}
	}

	var numberOfTasks: Int {
		return tasks.count
	}

	required init(view: TaskListViewInput, repository: TasksRepositoryType, router: RouterProtocol) {
		self.view = view
		self.repository = repository
		self.router = router
	}

	func task(at index: Int) -> TaskViewModel {
		return tasks[index].viewModel
	}

	func subTasksCount(at index: Int) -> Int {
		return repository.getSubTasksCount(for: tasks[index])
	}

	func loadTasks() {
		repository.getAll() {
			self.tasks = $0
		}
	}

	func didSelectTask(with index: Int) {
		guard let view = view else {
			return
		}

		let taskEntity = tasks[index]

		if view.isEditMode {
			router.showEditTaskAlertViewController(editAction: {
				self.router.showTaskDetailsViewController(scope: .edit(model: taskEntity.viewModel))
			}, deleteAction: {
				self.repository.delete(task: taskEntity)
				self.tasks = self.tasks.filter { taskEntity.id != $0.id }
			})

			return
		}

		router.showSubTaskListViewController(task: taskEntity)
	}

	func addTaskButtonPressed() {
		router.showTaskDetailsViewController(scope: .create)
	}
}
