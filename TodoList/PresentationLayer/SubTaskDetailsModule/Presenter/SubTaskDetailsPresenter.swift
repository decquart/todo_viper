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
	func invalidateView()
}

class SubTaskDetailsPresenter: SubTaskDetailsOutput {
	weak var view: SubTaskDetailsInput!
	let repository: SubTasksRepositoryType

	private var task: TaskEntity
	private var subTask: SubTaskEntity?

	init(view: SubTaskDetailsInput, repository: SubTasksRepositoryType, task: TaskEntity, subTask: SubTaskEntity?) {
		self.view = view
		self.repository = repository
		self.task = task
		self.subTask = subTask
	}

	func sendButtonPressed(viewModel: SubTaskViewModel) {

		if var existingSubTask = subTask {
			existingSubTask.description = viewModel.description // todo
			repository.update(subtask: existingSubTask){}
		} else {
			repository.add(subtask: SubTaskEntity(description: viewModel.description, completed: false), to: task)
		}

		view.invalidateView()
	}
}
