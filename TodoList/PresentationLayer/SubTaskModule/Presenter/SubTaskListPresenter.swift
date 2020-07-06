//
//  SubTaskListPresenter.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

protocol SubTaskListViewOutput: class {
	func loadSubTasks()
	func numberOfRows() -> Int
	func subTask(at indexPath: IndexPath) -> SubTaskViewModel
	func buttonCompletePressed(at index: Int)
	func didCompleteAll()
	func didSelect(at indexPath: IndexPath)
	func addButtonPressed()
}

protocol SubTaskListViewInput: class {
	func refreshSubTasks()
}

class SubTaskListPresenter: SubTaskListViewOutput {
	weak var view: SubTaskListViewInput?
	let router: RouterProtocol
	let repository: SubTasksRepositoryType

	private var task: Task!
	private var subTasks: [SubTask] = [] {
		didSet {
			view?.refreshSubTasks()
		}
	}

	required init(view: SubTaskListViewInput, router: RouterProtocol, repository: SubTasksRepositoryType, task: Task) {
		self.view = view
		self.router = router
		self.repository = repository
		self.task = task
	}

	func loadSubTasks() {
		repository.getAll(where: task) { [weak self] in
			self?.subTasks = $0
		}
	}

	func numberOfRows() -> Int {
		return subTasks.count
	}

	func subTask(at indexPath: IndexPath) -> SubTaskViewModel {
		return SubTaskViewModel(model: subTasks[indexPath.row])
	}

	func buttonCompletePressed(at index: Int) {
		var subTask = subTasks[index]

		subTask.completed = !subTask.completed
		repository.update(subtask: subTask) { [weak self] in
			self?.loadSubTasks()
		}
	}

	func didCompleteAll() {

	}

	func didSelect(at indexPath: IndexPath) {
		let vm = SubTaskViewModel(model: subTasks[indexPath.row])
		router.showSubTaskDetailsViewController(task: task, scope: .edit(model: vm))
	}

	func addButtonPressed() {
		router.showSubTaskDetailsViewController(task: task, scope: .create)
	}
}
