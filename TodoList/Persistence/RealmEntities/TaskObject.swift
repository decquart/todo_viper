//
//  TaskObject.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 08.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import RealmSwift

class TaskObject: Object {

	@objc dynamic var id = ""
	@objc dynamic var name = ""
	@objc dynamic var imagePath = ""

	override class func primaryKey() -> String? {
		return "id"
	}
}

extension TaskObject: StorableModel {
	var domainModel: TaskEntity {
		return TaskEntity(id: id, name: name, imagePath: imagePath)
	}
}

extension TaskObject: EntityMappable {
	func map(_ entity: TaskEntity) {
		id = entity.id
		name = entity.name
		imagePath = entity.imagePath
	}
}
