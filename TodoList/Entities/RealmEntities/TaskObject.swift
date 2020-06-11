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

	let subTasks = List<SubTaskObject>()

	override class func primaryKey() -> String? {
		return "id"
	}
}



extension TaskObject: StorableModel {
	var domainModel: TaskEntity {
		//todo add new fields
		return TaskEntity(id: id, name: name, image: Data(), color: NSCoder())
	}
}

extension TaskObject: EntityMappable {
	func map(_ entity: TaskEntity) {

		//Workaround since primary key can't be changed after an object is inserted
		if id.isEmpty {
			id = entity.id
		}

		name = entity.name
		imagePath = ""//entity.imagePath
	}
}
