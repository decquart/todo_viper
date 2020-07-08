//
//  RealmTaskRepository.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 08.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmTaskRepository: RealmRepository<TaskObject, Task> {
	override func fetch(completion: @escaping (Result<[Task], Error>) -> Void) {
		let entities = realm.objects(TaskObject.self)
			.sorted(byKeyPath: "name", ascending: true)
			.compactMap { $0.mapToModel }

		completion(.success(Array(entities)))
	}

	override func add(_ item: Task, completion: @escaping (Bool) -> Void) {
		let taskObj = TaskObject()
		taskObj.map(item)

		do {
			try realm.write { realm.add(taskObj) }
			completion(true)
		} catch {
			print("Can not add: \(error.localizedDescription)")
			completion(false)
		}
	}

	override func update(_ item: Task, completion: @escaping (Bool) -> Void) {
		guard let existingTaskObj = realm.object(ofType: TaskObject.self, forPrimaryKey: item.id) else {
			completion(false)
			return
		}

		try! realm.write { existingTaskObj.map(item) }
		completion(true)
	}

	override func delete(_ item: Task, completion: @escaping (Bool) -> Void) {
		guard let taskToDelete = realm.object(ofType: TaskObject.self, forPrimaryKey: item.id) else {
			return
		}

		do {
			try realm.write { realm.delete(taskToDelete) }
			completion(true)
		} catch {
			print("Cannot delete: \(error.localizedDescription)")
			completion(false)
		}
	}
}
