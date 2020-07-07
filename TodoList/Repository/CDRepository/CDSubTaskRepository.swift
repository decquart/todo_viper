//
//  CDSubTaskRepository.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 06.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import CoreData

final class CDSubTaskRepository: CDRepository<SubTaskMO, SubTask> {
	let taskId: String

	init(taskId: String, coreDataStack: CoreDataStackType) {
		self.taskId = taskId
		super.init(coreDataStack: coreDataStack)
	}

	override func fetch(completion: @escaping (Result<[SubTask], Error>) -> Void) {
		let fetchRequest: NSFetchRequest<SubTaskMO> = SubTaskMO.fetchRequest()
		fetchRequest.predicate = NSPredicate(format: "owner.id = %@", taskId)
		fetchRequest.sortDescriptors = [
			NSSortDescriptor(key: "completed", ascending: true),
			NSSortDescriptor(key: "description_p", ascending: true)
		]

		let asyncFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { result in
			let entities = result.finalResult?.map { $0.mapToModel } ?? []
			completion(.success(entities))
		}

		do {
			try coreDataStack.mainContext.execute(asyncFetchRequest)
		} catch {
			completion(.failure(error))
		}
	}

	override func add(_ item: SubTask, completion: @escaping (Bool) -> Void) {
		let taskFetchRequest: NSFetchRequest<TaskMO> = TaskMO.fetchRequest()
		taskFetchRequest.predicate = NSPredicate(format: "id = %@", taskId)

		let subTaskName = String(describing: SubTaskMO.self)

		guard let subTaskMO = NSEntityDescription.insertNewObject(forEntityName: subTaskName, into: coreDataStack.mainContext) as? SubTaskMO else {
			return
		}

		guard let taskMO = try? coreDataStack.mainContext.fetch(taskFetchRequest).first else {
			return
		}

		subTaskMO.map(item)
		taskMO.addToSubTasks(subTaskMO)
		coreDataStack.save(context: coreDataStack.mainContext)
		completion(true)
	}

	override func update(_ item: SubTask, completion: @escaping (Bool) -> Void) {
		guard let storedSubTask = get(by: item.uuid) else {
			return
		}

		storedSubTask.map(item)
		coreDataStack.save(context: coreDataStack.mainContext)
		completion(true)
	}

//	func markAsCompleted(where task: Task, completion: () -> Void) {
//		let batchUpdate = NSBatchUpdateRequest(entityName: "SubTaskMO")
//		batchUpdate.propertiesToUpdate = [#keyPath(SubTaskMO.completed) : true]
//		batchUpdate.affectedStores = coreDataStack.mainContext.persistentStoreCoordinator?.persistentStores
//		//todo: look for a solution to use predicate
//		//batchUpdate.predicate = NSPredicate(format: "%K = %@", #keyPath(SubTask.owner.id), task.id)
//
//		do {
//			try coreDataStack.mainContext.execute(batchUpdate)
//			completion()
//		} catch {
//			print(error.localizedDescription)
//		}
//	}

	private func get(by id: String) -> SubTaskMO? {
		let fetchRequest: NSFetchRequest<SubTaskMO> = SubTaskMO.fetchRequest()
		fetchRequest.predicate = NSPredicate(format: "id = %@", id)

		return try? coreDataStack.mainContext.fetch(fetchRequest).first
	}
}
