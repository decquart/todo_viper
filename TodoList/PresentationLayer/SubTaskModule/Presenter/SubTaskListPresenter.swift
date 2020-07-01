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
    func numberOfRows(in section: Int) -> Int
    func subTask(at indexPath: IndexPath) -> SubTaskViewModel?
	func buttonCompletePressed(at indexPath: IndexPath)
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

	private var task: TaskEntity!
	private var subTasks: [SubTaskEntity] = [] {
		didSet {
			view?.refreshSubTasks()
		}
	}

	required init(view: SubTaskListViewInput, router: RouterProtocol, repository: SubTasksRepositoryType, task: TaskEntity) {
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

	func numberOfRows(in section: Int) -> Int {
		return subTasks.count
    }

	func subTask(at indexPath: IndexPath) -> SubTaskViewModel? {
		return SubTaskViewModel(subTaskEntity: subTasks[indexPath.row])
    }

    func buttonCompletePressed(at indexPath: IndexPath) {
		var subTask = subTasks[indexPath.row]

		subTask.completed = !subTask.completed
		repository.update(subtask: subTask) {
			subTasks[indexPath.row] = subTask
			view?.refreshSubTasks()
		}
    }

	func didCompleteAll() {

	}

	func didSelect(at indexPath: IndexPath) {
		let subTask = subTasks[indexPath.row]
		router.showSubTaskDetailsViewController(task: task, subTask: subTask)
	}

	func addButtonPressed() {
		router.showSubTaskDetailsViewController(task: task, subTask: nil)
	}
}
