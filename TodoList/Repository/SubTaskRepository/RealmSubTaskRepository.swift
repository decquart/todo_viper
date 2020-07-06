//
//  RealmSubTaskRepository.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 09.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation
import RealmSwift

class RealmSubTaskRepository: SubTasksRepositoryType {
	let realm = try! Realm()

	func add(subtask: SubTask, to task: Task, completion: @escaping () -> Void) {
		guard let taskObj = realm.object(ofType: TaskObject.self, forPrimaryKey: task.id) else {
			return
		}

		let subTaskObj = SubTaskObject()
		subTaskObj.map(subtask)

		try! realm.write {
			taskObj.subTasks.append(subTaskObj)
			realm.add(subTaskObj)
			completion()
		}
	}

	func getAll(where task: Task, completion: @escaping ([SubTask]) -> Void) {
		let objects = realm.objects(SubTaskObject.self)
			.filter(NSPredicate(format: "ANY owner.id == %@", task.id))
			.sorted(by: [
				SortDescriptor(keyPath: "isCompleted", ascending: true),
				SortDescriptor(keyPath: "description_p", ascending: true)
			])

		let entities = Array(objects.map { $0.mapToModel })
		completion(entities)
	}

	func update(subtask: SubTask, completion: @escaping () -> Void) {
		guard let subTaskObj = realm.object(ofType: SubTaskObject.self, forPrimaryKey: subtask.uuid) else {
			return
		}

		try! realm.write {
			subTaskObj.map(subtask)
			completion()
		}
	}

	func markAsCompleted(where task: Task, completion: () -> Void) {
		fatalError("Need to implement")
	}
}
