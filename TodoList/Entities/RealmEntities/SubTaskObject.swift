//
//  SubTaskObject.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 09.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import RealmSwift

final class SubTaskObject: Object {

	@objc dynamic var isCompleted = false
	@objc dynamic var description_p = ""
	let owner = LinkingObjects(fromType: TaskObject.self, property: "subTasks")
}


extension SubTaskObject: StorableModel {
	var domainModel: SubTaskEntity {
		return SubTaskEntity(description: description_p, completed: isCompleted)
	}
}

extension SubTaskObject: EntityMappable {
	func map(_ entity: SubTaskEntity) {
		description_p = entity.description
		isCompleted = entity.completed
	}
}
