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
		let result = try? coreDataStack.mainContext.fetch(fetchRequest)

		return result?.map { $0.domainModel } ?? []
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

		if let existingTask = get(by: task.id) {
			existingTask.map(task)
			coreDataStack.save(context: coreDataStack.mainContext)
			completion()
			return
		}

		let taskMO = Task(context: coreDataStack.mainContext)

		taskMO.map(task)
		coreDataStack.save(context: coreDataStack.mainContext)
		completion()

		//This part of code creates lots of NSManagedObjects inside a background context

//		coreDataStack.backgroundContext.perform {
//			for _ in 0...10000 {
//				let taskMO = Task(context: self.coreDataStack.backgroundContext)
//				taskMO.map(task)
//				taskMO.id = UUID().uuidString
//			}
//
//			self.coreDataStack.save(context: self.coreDataStack.backgroundContext)
//			DispatchQueue.main.async {
//				completion()
//			}
//		}

		return
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
