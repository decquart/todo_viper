//
//  RealmTaskRepository.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 08.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation
import RealmSwift

class RealmTaskRepository: TasksRepositoryType {
	let realm = try! Realm()

	func getAll(completion: @escaping ([TaskEntity]) -> ()) {
		let entities = realm.objects(TaskObject.self)
			.sorted(byKeyPath: "name", ascending: true)
			.compactMap { $0.domainModel }

		completion(Array(entities))
	}

	func getSubTasksCount(for task: TaskEntity) -> Int {
		return realm.object(ofType: TaskObject.self, forPrimaryKey: task.id)?.subTasks.count ?? 0
	}

	func create(task: TaskEntity, completion: () -> Void) {
		let taskObj = TaskObject()
		taskObj.map(task)

		do {
			try realm.write { realm.add(taskObj) }
			completion()
			return
		} catch {
			print("Can not add: \(error.localizedDescription)")
			return
		}

	}

	func update(task: TaskEntity, completion: @escaping () -> Void) {
		guard let existingTaskObj = realm.object(ofType: TaskObject.self, forPrimaryKey: task.id) else {
			return
		}

		try! realm.write { existingTaskObj.map(task) }
		completion()
	}

	func delete(task: TaskEntity) {
		guard let taskToDelete = realm.object(ofType: TaskObject.self, forPrimaryKey: task.id) else {
			return
		}

		do {
			try realm.write { realm.delete(taskToDelete) }
		} catch {
			print("Cannot delete: \(error.localizedDescription)")
		}
	}
}
