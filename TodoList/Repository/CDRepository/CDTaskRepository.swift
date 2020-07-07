//
//  CDTaskRepository.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 06.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import CoreData

final class CDTaskRepository: CDRepository<TaskMO, Task> {
	override func fetch(completion: @escaping (Result<[Task], Error>) -> Void) {
		let fetchRequest: NSFetchRequest<TaskMO> = TaskMO.fetchRequest()
		let asyncFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { result in
			let data = result.finalResult?.map { $0.mapToModel } ?? []
			completion(.success(data))
		}

		do {
			try coreDataStack.mainContext.execute(asyncFetchRequest)
		} catch let error {
			completion(.failure(error))
		}
	}

	override func add(_ item: Task, completion: @escaping (Bool) -> Void) {
		let taskMO = TaskMO(context: coreDataStack.mainContext)

		taskMO.map(item)
		coreDataStack.save(context: coreDataStack.mainContext)
		completion(true)
	}

	override func update(_ item: Task, completion: @escaping (Bool) -> Void) {
		guard let existingTask = get(by: item.id) else {
			return
		}

		existingTask.map(item)
		coreDataStack.save(context: coreDataStack.mainContext)
		completion(true)
	}

	override func delete(_ item: Task, completion: @escaping (Bool) -> Void) {
		guard let taskMO = get(by: item.id) else {
			return
		}

		coreDataStack.mainContext.delete(taskMO)
		coreDataStack.save(context: coreDataStack.mainContext)
		completion(true)
	}

	private func get(by id: String) -> TaskMO? {
		let predicate = NSPredicate(format: "id = %@", id)
		let fetchRequest: NSFetchRequest<TaskMO> = TaskMO.fetchRequest()
		fetchRequest.predicate = predicate

		return try? coreDataStack.mainContext.fetch(fetchRequest).first
	}
}

