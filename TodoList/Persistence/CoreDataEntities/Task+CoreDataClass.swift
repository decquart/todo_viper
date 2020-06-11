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

@objc(Task)
public class Task: NSManagedObject {

}

extension Task: StorableModel {
	var domainModel: TaskEntity {
		TaskEntity(id: id, name: name, image: image, color: iconColor)
	}
}

extension Task: EntityMappable {
	func map(_ entity: TaskEntity) {
		id = entity.id
		name = entity.name
		image = entity.imageData
		iconColor = entity.imageColor
	}
}
