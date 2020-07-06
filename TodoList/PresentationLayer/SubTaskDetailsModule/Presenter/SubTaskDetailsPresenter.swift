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
	func dismiss()
}

class SubTaskDetailsPresenter: SubTaskDetailsOutput {
	weak var view: SubTaskDetailsInput!
	let router: RouterProtocol
	let repository: SubTasksRepositoryType

	private var task: Task
	private var subTask: SubTask?

	init(view: SubTaskDetailsInput, router: RouterProtocol, repository: SubTasksRepositoryType, task: Task) {
		self.view = view
		self.router = router
		self.repository = repository
		self.task = task
	}

	func sendButtonPressed(viewModel: SubTaskViewModel) {

		if view.isNewSubtask {
			repository.add(subtask: viewModel.mapToModel, to: task) { [weak self] in
				self?.view.invalidateView()
			}
		} else {
			repository.update(subtask: viewModel.mapToModel) { [weak self] in
				self?.router.pop()
			}
		}
	}
}
