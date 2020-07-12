//
//  RealmTaskRepository.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 09.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmTaskRepository: RealmRepository<TaskObject, Task> {
	let categoryId: String

	init(categoryId: String) {
		self.categoryId = categoryId
		super.init()
	}

	override func fetch(completion: @escaping (Result<[Task], Error>) -> Void) {
		let objects = realm.objects(TaskObject.self)
			.filter(NSPredicate(format: "ANY owner.id == %@", categoryId))
			.sorted(by: [
				SortDescriptor(keyPath: "isCompleted", ascending: true),
				SortDescriptor(keyPath: "date", ascending: true),
				SortDescriptor(keyPath: "description_p", ascending: true)
			])

		let entities = Array(objects.map { $0.mapToModel })
		completion(.success(entities))
	}

	override func add(_ item: Task, completion: @escaping (Bool) -> Void) {
		guard let categoryObj = realm.object(ofType: CategoryObject.self, forPrimaryKey: categoryId) else {
			return
		}

		let taskObj = TaskObject()
		taskObj.map(item)

		try! realm.write {
			categoryObj.tasks.append(taskObj)
			realm.add(taskObj)
			completion(true)
		}
	}

	override func update(_ item: Task, completion: @escaping (Bool) -> Void) {
		guard let taskObj = realm.object(ofType: TaskObject.self, forPrimaryKey: item.uuid) else {
			return
		}

		try! realm.write {
			taskObj.map(item)
			completion(true)
		}
	}
}
