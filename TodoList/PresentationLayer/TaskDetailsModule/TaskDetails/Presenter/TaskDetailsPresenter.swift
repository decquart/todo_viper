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
	let repository: AnyRepository<Task>
	let router: RouterProtocol?

	init(view: TaskDetailsInput, repository: AnyRepository<Task>, router: RouterProtocol) {
		self.view = view
		self.repository = repository
		self.router = router
	}

	func saveButtonPressed(with viewModel: TaskViewModel) {
		//todo: resolve duplicate
		guard view.isNewTask else {
			repository.update(viewModel.mapToModel) { _ in
				self.router?.popToRoot()
			}

			return
		}

		repository.add(viewModel.mapToModel) { _ in
			self.router?.popToRoot()
		}
	}

	func updateIcon(_ imagePath: String) {
		view?.refreshIcon(imagePath)
	}
}
