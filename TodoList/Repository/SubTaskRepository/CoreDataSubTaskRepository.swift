//
//  CoreDataSubTaskRepository.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 05.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import CoreData

class CoreDataSubTaskRepository: SubTasksRepositoryType {

	let managedObjectContext: NSManagedObjectContext

	init(context: NSManagedObjectContext) {
		self.managedObjectContext = context
	}
	
	func add(subtask: SubTaskEntity, to task: TaskEntity, completion: () -> Void) {
		let taskFetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
		taskFetchRequest.predicate = NSPredicate(format: "id = %@", task.id)

		let subTaskName = String(describing: SubTask.self)

		guard let subTaskMO = NSEntityDescription.insertNewObject(forEntityName: subTaskName, into: managedObjectContext) as? SubTask else {
			return
		}

		guard let taskMO = try? managedObjectContext.fetch(taskFetchRequest).first else {
			return
		}

		subTaskMO.description_p = subtask.description
		subTaskMO.completed = subtask.completed
		taskMO.addToSubTasks(subTaskMO)
		saveContext()
		completion()
	}

	func getAll(where task: TaskEntity) -> [SubTaskEntity] {
		let fetchRequest: NSFetchRequest<SubTask> = SubTask.fetchRequest()
		fetchRequest.predicate = NSPredicate(format: "owner.id = %@", task.id)

		guard let subTasksMO = try? managedObjectContext.fetch(fetchRequest) else {
			return []
		}

		return subTasksMO.map { $0.domainModel }
	}

	//todo: call from core data stack
	private func saveContext() {
        let context = managedObjectContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
