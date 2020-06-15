//
//  RealmSubTaskRepository.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 09.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import RealmSwift

class RealmSubTaskRepository: SubTasksRepositoryType {
	let realm = try! Realm()

	func add(subtask: SubTaskEntity, to task: TaskEntity, completion: () -> Void) {
		guard let taskObj = realm.object(ofType: TaskObject.self, forPrimaryKey: task.id) else {
			return
		}

		let subTaskObj = SubTaskObject()
		subTaskObj.map(subtask)

		try! realm.write {
			taskObj.subTasks.append(subTaskObj)
			realm.add(taskObj, update: .modified)
		}

		completion()
	}

	func getAll(where task: TaskEntity, completion: @escaping ([SubTaskEntity]) -> Void) {
		guard let entity = realm.object(ofType: TaskObject.self, forPrimaryKey: task.id)  else {
			return
		}

		let entities = Array(entity.subTasks.map { $0.domainModel })
		completion(entities)
	}
}
