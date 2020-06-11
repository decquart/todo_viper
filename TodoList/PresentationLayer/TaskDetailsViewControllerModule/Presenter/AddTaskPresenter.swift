//
//  AddTaskPresenter.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 02.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol AddTaskOutput: class {
	init(view: AddTaskInput, repository: TasksRepositoryType, router: RouterProtocol)
	func saveButtonPressed(with data: TaskEntity)
}

protocol AddTaskInput: class {
	//func taskDidSave()
}

final class AddTaskPresenter: AddTaskOutput {

	weak var view: AddTaskInput?
	let repository: TasksRepositoryType!
	let router: RouterProtocol?

	init(view: AddTaskInput, repository: TasksRepositoryType, router: RouterProtocol) {
		self.view = view
		self.repository = repository
		self.router = router
	}

	func saveButtonPressed(with data: TaskEntity) {
		repository.create(task: data) {
			self.router?.popToRoot()
		}
		
	}
}
