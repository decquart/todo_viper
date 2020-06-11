//
//  RealmTaskRepository.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 08.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation
import RealmSwift
//todo: Extend with new Fields
//
//class RealmTaskRepository: TasksRepositoryType {
//	let realm = try! Realm()
//
//	func getAll() -> [TaskEntity] {
//		let entities = realm.objects(TaskObject.self)
//			.sorted(byKeyPath: "name", ascending: true)
//			.compactMap { $0.domainModel }
//
//		return Array(entities)
//	}
//
//	func getSubTasksCount(for task: TaskEntity) -> Int {
//		return realm.object(ofType: TaskObject.self, forPrimaryKey: task.id)?.subTasks.count ?? 0
//	}
//
//	func create(task: TaskEntity, completion: () -> Void) {
//
//		if let existingTaskObj = realm.object(ofType: TaskObject.self, forPrimaryKey: task.id) {
//			try! realm.write {
//				existingTaskObj.map(task)
//			}
//			completion()
//			return
//		}
//
//		let taskObj = TaskObject()
//		taskObj.map(task)
//
//		do {
//			try realm.write { realm.add(taskObj) }
//			completion()
//			return
//		} catch {
//			print("Can not add: \(error.localizedDescription)")
//			return
//		}
//
//	}
//
//	func delete(task: TaskEntity) {
//		guard let taskToDelete = realm.object(ofType: TaskObject.self, forPrimaryKey: task.id) else {
//			return
//		}
//
//		do {
//			try realm.write { realm.delete(taskToDelete) }
//		} catch {
//			print("Cannot delete: \(error.localizedDescription)")
//		}
//	}
//}
