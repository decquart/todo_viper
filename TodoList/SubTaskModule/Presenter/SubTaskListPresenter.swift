//
//  SubTaskListPresenter.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol SubTaskListViewOutput: class {
	var task: Task! { get set }
	var subTasks: [SubTask]? { get set }
	init(view: SubTaskListViewInput, dataProvider: TaskDataProvider, task: Task)
	func addSubTask()
	func loadSubTasks()
}

protocol SubTaskListViewInput: class {
	func taskDidAdd()
	func subTaskDidLoad()
}

class SubTaskListPresenter: SubTaskListViewOutput {


	let dataProvider: TaskDataProvider
	var view: SubTaskListViewInput?

	var task: Task!

	var subTasks: [SubTask]?

	required init(view: SubTaskListViewInput, dataProvider: TaskDataProvider, task: Task) {
		self.view = view
		self.dataProvider = dataProvider
		self.task = task
	}

	func addSubTask() {
		//todo
	}

	func loadSubTasks() {
		subTasks = task.subTasks
		view?.subTaskDidLoad()
	}
}
