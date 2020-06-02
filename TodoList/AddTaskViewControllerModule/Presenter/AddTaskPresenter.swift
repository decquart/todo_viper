//
//  AddTaskPresenter.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 02.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol AddTaskOutput: class {
	init(view: AddTaskInput, dataProvider: LocalTasksRepository, router: RouterProtocol)
	func saveButtonPressed(with data: TaskTransportModel)
}

protocol AddTaskInput: class {
	func taskDidSave()
}

final class AddTaskPresenter: AddTaskOutput {

	weak var view: AddTaskInput?
	let dataProvider: LocalTasksRepository!
	let router: RouterProtocol?

	init(view: AddTaskInput, dataProvider: LocalTasksRepository, router: RouterProtocol) {
		self.view = view
		self.dataProvider = dataProvider
		self.router = router
	}

	func saveButtonPressed(with data: TaskTransportModel) {
		_ = dataProvider.add(item: data)
		router?.popToRoot()
		//TODO: Need to notify task list about this update
	}
}
