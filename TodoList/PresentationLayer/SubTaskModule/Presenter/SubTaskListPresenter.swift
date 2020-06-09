//
//  SubTaskListPresenter.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

protocol SubTaskListViewOutput: class {
	var task: TaskEntity! { get set }
	var subTasks: [SubTaskEntity]? { get set }
	init(view: SubTaskListViewInput, repository: SubTasksRepositoryType, task: TaskEntity)
	func addSubTask(with data: SubTaskEntity)
	func loadSubTasks()
}

protocol SubTaskListViewInput: class {
	func taskDidAdd()
	func subTaskDidLoad()
}

class SubTaskListPresenter: SubTaskListViewOutput {

	let repository: SubTasksRepositoryType
	weak var view: SubTaskListViewInput?

	var task: TaskEntity!

	var subTasks: [SubTaskEntity]? {
		didSet {
			self.view?.subTaskDidLoad()
		}
	}

	required init(view: SubTaskListViewInput, repository: SubTasksRepositoryType, task: TaskEntity) {
		self.view = view
		self.repository = repository
		self.task = task
	}

	func addSubTask(with data: SubTaskEntity) {

		repository.add(subtask: data, to: task) {
			subTasks?.append(data)
		}
	}

	func loadSubTasks() {
		self.subTasks = repository.getAll(where: task)
	}
}
