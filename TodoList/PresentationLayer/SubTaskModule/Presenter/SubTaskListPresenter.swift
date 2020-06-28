//
//  SubTaskListPresenter.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation
import CoreData

protocol SubTaskListViewOutput: class {
    func numberOfRows(in section: Int) -> Int
    func subTask(at indexPath: IndexPath) -> SubTaskViewModel?
	func addSubTask(with viewModel: SubTaskViewModel)
	func buttonCompletePressed(at indexPath: IndexPath)
	func didCompleteAll()
	func didSelect()//todo: add params
}

protocol SubTaskListViewInput: class {
	func refreshSubTasks()
}

class SubTaskListPresenter: SubTaskListViewOutput {

    let adapter: SubTaskListAdapterType
	let repository: SubTasksRepositoryType
	let router: RouterProtocol
	weak var view: SubTaskListViewInput?

	private var task: TaskEntity!

	required init(view: SubTaskListViewInput, task: TaskEntity, adapter: SubTaskListAdapterType, repository: SubTasksRepositoryType, router: RouterProtocol) {
		self.view = view
		self.task = task
        self.adapter = adapter
		self.repository = repository
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

	func addSubTask(with viewModel: SubTaskViewModel) {
		let entity = SubTaskEntity(description: viewModel.description, completed: false)
        adapter.add(subtask: entity, to: task)
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

	func didSelect() {
		router.showSubTaskDetailsViewController()
	}
}
