//
//  SubTaskListPresenter.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

protocol SubTaskListViewOutput: class {
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

    let adapter: SubTaskListAdapterType
	let router: RouterProtocol
	weak var view: SubTaskListViewInput?

	private var task: TaskEntity!

	required init(view: SubTaskListViewInput, task: TaskEntity, adapter: SubTaskListAdapterType, router: RouterProtocol) {
		self.view = view
		self.task = task
        self.adapter = adapter
		self.router = router
	}

	func numberOfRows(in section: Int) -> Int {
        return adapter.numberOfRows(in: section)
    }

	func subTask(at indexPath: IndexPath) -> SubTaskViewModel? {
		guard let subTask = adapter.subTask(at: indexPath) else {
			return nil
		}

		return SubTaskViewModel(subTaskEntity: subTask)
    }

    func buttonCompletePressed(at indexPath: IndexPath) {
		guard var subTask = adapter.subTask(at: indexPath) else {
			return
		}

		subTask.completed = !subTask.completed
        adapter.update(subtask: subTask)
    }

	func didCompleteAll() {

	}

	func didSelect(at indexPath: IndexPath) {
		guard let subTask = adapter.subTask(at: indexPath) else {
			return
		}

		router.showSubTaskDetailsViewController(task: task, subTask: subTask)
	}

	func addButtonPressed() {
		router.showSubTaskDetailsViewController(task: task, subTask: nil)
	}
}
