//
//  AddTaskPresenter.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 02.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

protocol TaskDetailsOutput: class {
	func saveButtonPressed(with viewModel: TaskViewModel)
	func updateIcon(_ imagePath: String)
}

protocol TaskDetailsInput: class {
	var isNewTask: Bool { get }
	func refreshIcon(_ imagePath: String)
}

final class TaskDetailsPresenter: TaskDetailsOutput {

	weak var view: TaskDetailsInput!
	let repository: TasksRepositoryType!
	let router: RouterProtocol?

	init(view: TaskDetailsInput, repository: TasksRepositoryType, router: RouterProtocol) {
		self.view = view
		self.repository = repository
		self.router = router
	}

	func saveButtonPressed(with viewModel: TaskViewModel) {
		guard view.isNewTask else {
			repository.update(task: viewModel.mapToModel) {
				self.router?.popToRoot()
			}

			return
		}

		repository.create(task: viewModel.mapToModel) {
			self.router?.popToRoot()
		}
	}

	func updateIcon(_ imagePath: String) {
		view?.refreshIcon(imagePath)
	}
}
