//
//  TaskDataProvider.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

class TaskDataProvider {
	private static var tasks: [TaskTransportModel] {

		let task1 = TaskTransportModel(
						 name: "ToDo",
						 imagePath: "todo")
		let task2 = TaskTransportModel(name: "Shopping", imagePath: "shopping")
		let task3 = TaskTransportModel(name: "Work", imagePath: "work")

		return [task1, task2, task3]
	}

	private static var subTasks: [SubTaskTransportModel] {
		let subTask1 = SubTaskTransportModel(description: "Make a dinner", completed: false)
		let subTask2 = SubTaskTransportModel(description: "Read a book", completed: false)
		let subTask3 = SubTaskTransportModel(description: "Buy some meat", completed: false)
		let subTask4 = SubTaskTransportModel(description: "Call to a client", completed: false)
		let subTask5 = SubTaskTransportModel(description: "Do something", completed: false)

		return [subTask1, subTask2, subTask3, subTask4, subTask5]
	}

	static var taskData: TaskTransportModel {
		return tasks[Int.random(in: 0...2)]
	}

	static var subTaskData: SubTaskTransportModel {
		return subTasks[Int.random(in: 0...4)]
	}
}
