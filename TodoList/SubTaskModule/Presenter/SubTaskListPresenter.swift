//
//  SubTaskListPresenter.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

protocol SubTaskListViewOutput: class {
	var task: Task! { get set }
	var subTasks: [SubTask]? { get set }
	init(view: SubTaskListViewInput, dataProvider: LocalSubTasksRepository, task: Task)
	func addSubTask(with data: SubTaskTransportModel)
	func loadSubTasks()
}

protocol SubTaskListViewInput: class {
	func taskDidAdd()
	func subTaskDidLoad()
}

class SubTaskListPresenter: SubTaskListViewOutput {


	let dataProvider: LocalSubTasksRepository
	weak var view: SubTaskListViewInput?

	var task: Task!

	var subTasks: [SubTask]? {
		didSet {
			self.view?.subTaskDidLoad()
		}
	}

	required init(view: SubTaskListViewInput, dataProvider: LocalSubTasksRepository, task: Task) {
		self.view = view
		self.dataProvider = dataProvider
		self.task = task
	}

	func addSubTask(with data: SubTaskTransportModel) {

		let subTask = dataProvider.add(item: data, to: task)
		subTasks?.append(subTask)
	}

	func loadSubTasks() {
		self.subTasks = dataProvider.get(for: task)
	}
}
