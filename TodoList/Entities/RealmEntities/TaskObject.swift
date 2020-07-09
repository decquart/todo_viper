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

// MARK: - Mappable
extension TaskObject: Mappable {
	var mapToModel: Task {
		Task(id: id,
			 name: name,
			 imagePath: imagePath,
			 color: UIColor.green,
			 subtasksCount: subTasks.count)
	}

	func map(_ entity: Task) {
		if id.isEmpty {
			id = entity.id
		}

		name = entity.name
		imagePath = entity.imagePath
		color = entity.imageColor as? Data
	}
}
