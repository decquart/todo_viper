//
//  RealmSubTaskRepository.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 09.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmSubTaskRepository: RealmRepository<SubTaskObject, SubTask> {
	let taskId: String

	init(taskId: String) {
		self.taskId = taskId
		super.init()
	}

	override func fetch(completion: @escaping (Result<[SubTask], Error>) -> Void) {
		let objects = realm.objects(SubTaskObject.self)
			.filter(NSPredicate(format: "ANY owner.id == %@", taskId))
			.sorted(by: [
				SortDescriptor(keyPath: "isCompleted", ascending: true),
				SortDescriptor(keyPath: "date", ascending: true),
				SortDescriptor(keyPath: "description_p", ascending: true)
			])

		let entities = Array(objects.map { $0.mapToModel })
		completion(.success(entities))
	}

	override func add(_ item: SubTask, completion: @escaping (Bool) -> Void) {
		guard let taskObj = realm.object(ofType: TaskObject.self, forPrimaryKey: taskId) else {
			return
		}

		let subTaskObj = SubTaskObject()
		subTaskObj.map(item)

		try! realm.write {
			taskObj.subTasks.append(subTaskObj)
			realm.add(subTaskObj)
			completion(true)
		}
	}

	override func update(_ item: SubTask, completion: @escaping (Bool) -> Void) {
		guard let subTaskObj = realm.object(ofType: SubTaskObject.self, forPrimaryKey: item.uuid) else {
			return
		}

		try! realm.write {
			subTaskObj.map(item)
			completion(true)
		}
	}
}
