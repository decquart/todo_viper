//
//  SubTaskDetailsPresenter.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 29.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol SubTaskDetailsOutput: class {
	func sendButtonPressed(viewModel: SubTaskViewModel)
}

protocol SubTaskDetailsInput: class {
	var isNewSubtask: Bool { get }
	func invalidateView()
}

class SubTaskDetailsPresenter: SubTaskDetailsOutput {
	weak var view: SubTaskDetailsInput!
	let repository: SubTasksRepositoryType

	private var task: TaskEntity
	private var subTask: SubTaskEntity?

	init(view: SubTaskDetailsInput, repository: SubTasksRepositoryType, task: TaskEntity) {
		self.view = view
		self.repository = repository
		self.task = task
	}

	func sendButtonPressed(viewModel: SubTaskViewModel) {

		if view.isNewSubtask {
			repository.add(subtask: SubTaskEntity(description: viewModel.description, completed: false), to: task) { }
		} else {
			////todo: update
		}

		view.invalidateView()
	}
}
