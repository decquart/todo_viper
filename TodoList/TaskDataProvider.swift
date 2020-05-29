//
//  TaskDataProvider.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

class TaskDataProvider {
	var tasks: [Task] {
		let subTask1 = SubTask(description: "Make a dinner", completed: false)
		let subTask2 = SubTask(description: "Read a book", completed: false)
		let subTask3 = SubTask(description: "Buy some meat", completed: false)
		let subTask4 = SubTask(description: "Call to a client", completed: false)
		let task1 = Task(id: 1,
						 name: "ToDo",
						 imageParh: "todo",
						 subTasks: [subTask1, subTask2])
		let task2 = Task(id: 2, name: "Shopping", imageParh: "shopping", subTasks: [subTask3])
		let task3 = Task(id: 3, name: "Work", imageParh: "work", subTasks: [subTask4])

		return [task1, task2, task3]
	}

}
