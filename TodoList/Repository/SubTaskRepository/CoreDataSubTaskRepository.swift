//
//  CoreDataSubTaskRepository.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 05.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import CoreData

class CoreDataSubTaskRepository: SubTasksRepositoryType, CoreDataRepositoryType {

	var coreDataStack: CoreDataStackType

	init(coreDataStack: CoreDataStackType) {
		self.coreDataStack = coreDataStack
	}
	
	func add(subtask: SubTaskEntity, to task: TaskEntity, completion: () -> Void) {
		let taskFetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
		taskFetchRequest.predicate = NSPredicate(format: "id = %@", task.id)

		let subTaskName = String(describing: SubTask.self)

		guard let subTaskMO = NSEntityDescription.insertNewObject(forEntityName: subTaskName, into: coreDataStack.mainContext) as? SubTask else {
			return
		}

		guard let taskMO = try? coreDataStack.mainContext.fetch(taskFetchRequest).first else {
			return
		}

		subTaskMO.description_p = subtask.description
		subTaskMO.completed = subtask.completed
		taskMO.addToSubTasks(subTaskMO)
		coreDataStack.save(context: coreDataStack.mainContext)
		completion()
	}

	func getAll(where task: TaskEntity) -> [SubTaskEntity] {
		let fetchRequest: NSFetchRequest<SubTask> = SubTask.fetchRequest()
		fetchRequest.predicate = NSPredicate(format: "owner.id = %@", task.id)

		guard let subTasksMO = try? coreDataStack.mainContext.fetch(fetchRequest) else {
			return []
		}

		return subTasksMO.map { $0.domainModel }
	}
}
