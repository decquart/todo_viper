//
//  Task+CoreDataClass.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 04.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//
//

import Foundation
import CoreData

@objc(TaskMO)
public class TaskMO: NSManagedObject {

}

// MARK: - Mappable
extension TaskMO: Mappable {
	var mapToModel: Task {
		return Task(id: id,
					name: name,
					imagePath: imagePath,
					color: iconColor,
					subtasksCount: subTasks.count)
	}

	func map(_ entity: Task) {
		id = entity.id
		name = entity.name
		imagePath = entity.imagePath
		iconColor = entity.imageColor
	}
}
