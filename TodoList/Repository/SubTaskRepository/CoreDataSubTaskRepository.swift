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

	func add(subtask: SubTask, to task: Task, completion: @escaping () -> Void) {
		let taskFetchRequest: NSFetchRequest<TaskMO> = TaskMO.fetchRequest()
		taskFetchRequest.predicate = NSPredicate(format: "id = %@", task.id)

		let subTaskName = String(describing: SubTaskMO.self)

		guard let subTaskMO = NSEntityDescription.insertNewObject(forEntityName: subTaskName, into: coreDataStack.mainContext) as? SubTaskMO else {
			return
		}

		guard let taskMO = try? coreDataStack.mainContext.fetch(taskFetchRequest).first else {
			return
		}

		subTaskMO.map(subtask)
		taskMO.addToSubTasks(subTaskMO)
		coreDataStack.save(context: coreDataStack.mainContext)
		completion()
	}

	func getAll(where task: Task, completion: @escaping ([SubTask]) -> Void) {
		let fetchRequest: NSFetchRequest<SubTaskMO> = SubTaskMO.fetchRequest()
		fetchRequest.predicate = NSPredicate(format: "owner.id = %@", task.id)
		fetchRequest.sortDescriptors = [
			NSSortDescriptor(key: "completed", ascending: true),
			NSSortDescriptor(key: "description_p", ascending: true)
		]

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

	func update(subtask: SubTask, completion: @escaping () -> Void) {
		guard let storedSubTask = get(by: subtask.uuid) else {
			return
		}

		storedSubTask.map(subtask)
		coreDataStack.save(context: coreDataStack.mainContext)
		completion()
	}

	func markAsCompleted(where task: Task, completion: () -> Void) {
		let batchUpdate = NSBatchUpdateRequest(entityName: "SubTaskMO")
		batchUpdate.propertiesToUpdate = [#keyPath(SubTaskMO.completed) : true]
		batchUpdate.affectedStores = coreDataStack.mainContext.persistentStoreCoordinator?.persistentStores
		//todo: look for a solution to use predicate
		//batchUpdate.predicate = NSPredicate(format: "%K = %@", #keyPath(SubTask.owner.id), task.id)

		do {
			try coreDataStack.mainContext.execute(batchUpdate)
			completion()
		} catch {
			print(error.localizedDescription)
		}
	}

	private func get(by id: String) -> SubTaskMO? {
		let fetchRequest: NSFetchRequest<SubTaskMO> = SubTaskMO.fetchRequest()
		fetchRequest.predicate = NSPredicate(format: "id = %@", id)

		return try? coreDataStack.mainContext.fetch(fetchRequest).first
	}
}
