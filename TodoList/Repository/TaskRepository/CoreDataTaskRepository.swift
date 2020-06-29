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

	func getAll(completion: @escaping ([TaskEntity]) -> ()) {
		let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
		let asyncFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { result in
			let entities = result.finalResult?.map { $0.domainModel } ?? []
			completion(entities)
		}

		do {
			try coreDataStack.mainContext.execute(asyncFetchRequest)
		} catch let error {
			print(error.localizedDescription)
		}
	}

	func getSubTasksCount(for task: TaskEntity) -> Int {
		let predicate = NSPredicate(format: "owner.id = %@", task.id)
		let fetchRequest = NSFetchRequest<NSNumber>(entityName: "SubTask")

		fetchRequest.predicate = predicate
		fetchRequest.resultType = .countResultType

		do {
			let count = try coreDataStack.mainContext.fetch(fetchRequest)
			return count.first?.intValue ?? 0
		} catch let error {
			print(error.localizedDescription)
			return 0
		}
	}

	func create(task: TaskEntity, completion: @escaping () -> Void) {
		let taskMO = Task(context: coreDataStack.mainContext)

		taskMO.map(task)
		coreDataStack.save(context: coreDataStack.mainContext)
		completion()
	}

	func update(task: TaskEntity, completion: @escaping () -> Void) {
		guard let existingTask = get(by: task.id) else {
			return
		}

		existingTask.map(task)
		coreDataStack.save(context: coreDataStack.mainContext)
		completion()
	}

	func delete(task: TaskEntity) {
		guard let taskMO = get(by: task.id) else {
			return
		}

		coreDataStack.mainContext.delete(taskMO)
		coreDataStack.save(context: coreDataStack.mainContext)
	}

	private func get(by id: String) -> Task? {
		let predicate = NSPredicate(format: "id = %@", id)
		let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
		fetchRequest.predicate = predicate

		return try? coreDataStack.mainContext.fetch(fetchRequest).first
	}
}
