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
	@objc dynamic var isCompleted = false
	@objc dynamic var description_p = ""
	let owner = LinkingObjects(fromType: TaskObject.self, property: "subTasks")

	override class func primaryKey() -> String? {
		return "id"
	}
}

// MARK: - DomainModelMapping
extension SubTaskObject: DomainModelMapping {
	var domainModel: SubTask {
		return SubTask(uuid: id,
							 description: description_p,
							 completed: isCompleted)
	}
}

// MARK: - Mappable
extension SubTaskObject: Mappable {
	func map(_ entity: SubTask) {
		if id.isEmpty {
			id = entity.uuid
		}
		description_p = entity.description
		isCompleted = entity.completed
	}
}
