//
//  TaskDataProvider.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

class TaskDataProvider {

	private static var subTasks: [SubTaskEntity] {
		let subTask1 = SubTaskEntity(description: "Make a dinner", completed: false)
		let subTask2 = SubTaskEntity(description: "Read a book", completed: false)
		let subTask3 = SubTaskEntity(description: "Buy some meat", completed: false)
		let subTask4 = SubTaskEntity(description: "Call to a client", completed: false)
		let subTask5 = SubTaskEntity(description: "Do something", completed: false)

		return [subTask1, subTask2, subTask3, subTask4, subTask5]
	}

	static var subTaskData: SubTaskEntity {
		return subTasks[Int.random(in: 0...4)]
	}
}
