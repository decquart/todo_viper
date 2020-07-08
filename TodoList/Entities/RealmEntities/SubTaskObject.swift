//
//  SubTaskObject.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 09.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import RealmSwift
import Foundation

final class SubTaskObject: Object {

	@objc dynamic var id = ""
	@objc dynamic var description_p = ""
	@objc dynamic var isCompleted = false
	@objc dynamic var date = Date()
	let owner = LinkingObjects(fromType: TaskObject.self, property: "subTasks")

	override class func primaryKey() -> String? {
		return "id"
	}
}

// MARK: - Mappable
extension SubTaskObject: Mappable {
	var mapToModel: SubTask {
		SubTask(uuid: id, description: description_p, completed: isCompleted, date: date)
	}

	func map(_ entity: SubTask) {
		if id.isEmpty {
			id = entity.uuid
		}
		description_p = entity.description
		isCompleted = entity.completed
		date = entity.date
	}
}
