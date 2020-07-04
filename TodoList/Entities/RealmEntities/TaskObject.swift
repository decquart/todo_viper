//
//  TaskObject.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 08.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import RealmSwift
import Foundation
import UIKit

class TaskObject: Object {

	@objc dynamic var id = ""
	@objc dynamic var name = ""
	@objc dynamic var imagePath = ""
	@objc dynamic var color: Data?

	let subTasks = List<SubTaskObject>()

	override class func primaryKey() -> String? {
		return "id"
	}
}

extension TaskObject: StorableModel {
	var domainModel: TaskEntity {
		return TaskEntity(id: id, name: name, imagePath: imagePath, color: UIColor.green)//todo
	}
}

extension TaskObject: EntityMappable {
	func map(_ entity: TaskEntity) {
		if id.isEmpty {
			id = entity.id
		}

		name = entity.name
		//image = entity.imageData
		color = entity.imageColor as? Data
	}
}
