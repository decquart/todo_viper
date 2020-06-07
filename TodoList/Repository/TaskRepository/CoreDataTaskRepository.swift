//
//  CoreDataTaskRepository.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 05.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import CoreData

class CoreDataTaskRepository: TasksRepositoryType, CoreDataRepositoryType {
	var coreDataStack: CoreDataStackType

	init(coreDataStack: CoreDataStackType) {
		self.coreDataStack = coreDataStack
	}

	func getAll() -> [TaskEntity] {
		let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()

		do {
			let result = try coreDataStack.managedContext.fetch(fetchRequest)
			return result.map { $0.domainModel }
		} catch {
			print(error.localizedDescription)
			return []
		}
	}

	func getSubTasksCount(for task: TaskEntity) -> Int {
		let predicate = NSPredicate(format: "id = %@", task.id)
		let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
		fetchRequest.predicate = predicate

		do {
			let result = try coreDataStack.managedContext.fetch(fetchRequest)
			return result.first?.subTasks.count ?? 0
		} catch {
			print(error.localizedDescription)
			return 0
		}

	}

	func create(task: TaskEntity) -> Bool {
		let name = String(describing: Task.self)
		guard let taskMO = NSEntityDescription.insertNewObject(forEntityName: name, into: coreDataStack.managedContext) as? Task else {
			return false
		}

		taskMO.map(task)
		coreDataStack.saveContext()
		return true
	}

	func delete(task: TaskEntity) {
		let predicate = NSPredicate(format: "id = %@", task.id)
		let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
		fetchRequest.predicate = predicate

		guard let taskMO = try? coreDataStack.managedContext.fetch(fetchRequest).first else {
			return
		}

		coreDataStack.managedContext.delete(taskMO)
		coreDataStack.saveContext()
	}
}
