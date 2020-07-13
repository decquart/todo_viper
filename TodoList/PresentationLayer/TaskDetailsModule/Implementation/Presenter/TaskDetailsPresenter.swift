//
//  TaskDetailsPresenter.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 29.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//


class TaskDetailsPresenter: TaskDetailsPresenterProtocol {
	weak var view: TaskDetailsViewProtocol!
	let router: TaskDetailsRouterProtocol!
	let repository: AnyRepository<Task>

	private var category: Category
	private var subTask: Task?

	init(view: TaskDetailsViewProtocol, router: TaskDetailsRouterProtocol, repository: AnyRepository<Task>, category: Category) {
		self.view = view
		self.router = router
		self.repository = repository
		self.category = category
	}

	func sendButtonPressed(viewModel: TaskViewModel) {

		if view.isNewTask {
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
