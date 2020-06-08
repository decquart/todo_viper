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
		let result = try? coreDataStack.managedContext.fetch(fetchRequest)

		return result?.map { $0.domainModel } ?? []
	}

	func getSubTasksCount(for task: TaskEntity) -> Int {
		guard let taskMO = get(by: task.id) else {
			return 0
		}

		return taskMO.subTasks.count
	}

	//todo: reconsider
	func create(task: TaskEntity) -> Bool {

		if let existingTask = get(by: task.id) {
			existingTask.map(task)
			coreDataStack.saveContext()
			return true
		}

		let name = String(describing: Task.self)
		guard let taskMO = NSEntityDescription.insertNewObject(forEntityName: name, into: coreDataStack.managedContext) as? Task else {
			return false
		}

		taskMO.map(task)
		coreDataStack.saveContext()
		return true
	}

	func delete(task: TaskEntity) {
		guard let taskMO = get(by: task.id) else {
			return
		}

		coreDataStack.managedContext.delete(taskMO)
		coreDataStack.saveContext()
	}

	private func get(by id: String) -> Task? {
		let predicate = NSPredicate(format: "id = %@", id)
		let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
		fetchRequest.predicate = predicate

		return try? coreDataStack.managedContext.fetch(fetchRequest).first
	}
}
