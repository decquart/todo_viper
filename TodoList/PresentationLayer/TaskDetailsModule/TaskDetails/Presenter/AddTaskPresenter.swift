//
//  AddTaskPresenter.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 02.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol AddTaskOutput: class {
	func saveButtonPressed(with data: TaskEntity)
	func updateIcon(_ imagePath: String)
}

protocol AddTaskInput: class {
	var isNewTask: Bool { get }
	func refreshIcon(_ imagePath: String)
}

final class AddTaskPresenter: AddTaskOutput {

	weak var view: AddTaskInput!
	let repository: TasksRepositoryType!
	let router: RouterProtocol?

	init(view: AddTaskInput, repository: TasksRepositoryType, router: RouterProtocol) {
		self.view = view
		self.repository = repository
		self.router = router
	}

	func saveButtonPressed(with data: TaskEntity) {
		guard view.isNewTask else {
			repository.update(task: data) {
				self.router?.popToRoot()
			}

			return
		}

		repository.create(task: data) {
			self.router?.popToRoot()
		}
	}

	func updateIcon(_ imagePath: String) {
		view?.refreshIcon(imagePath)
	}
}