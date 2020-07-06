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
	let repository: AnyRepository<SubTask>

	private var task: Task
	private var subTask: SubTask?

	init(view: SubTaskDetailsInput, router: RouterProtocol, repository: AnyRepository<SubTask>, task: Task) {
		self.view = view
		self.router = router
		self.repository = repository
		self.task = task
	}

	func sendButtonPressed(viewModel: SubTaskViewModel) {

		if view.isNewSubtask {
			repository.add(viewModel.mapToModel) { [weak self] _ in
				self?.view.invalidateView()
			}
		} else {
			repository.update(viewModel.mapToModel) { [weak self] _ in
				self?.router.pop()
			}
		}
	}
}
