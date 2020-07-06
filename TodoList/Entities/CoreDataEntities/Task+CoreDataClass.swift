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

extension TaskMO: DomainModelMapping {
	var domainModel: Task {
		Task(id: id, name: name, imagePath: imagePath, color: iconColor)
	}
}

extension TaskMO: Mappable {
	func map(_ entity: Task) {
		id = entity.id
		name = entity.name
		imagePath = entity.imagePath
		iconColor = entity.imageColor
	}
}
