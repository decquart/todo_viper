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

extension Task: DomainModelMapping {
	var domainModel: TaskEntity {
		TaskEntity(id: id, name: name, imagePath: imagePath, color: iconColor)
	}
}

extension Task: Mappable {
	func map(_ entity: TaskEntity) {
		id = entity.id
		name = entity.name
		imagePath = entity.imagePath
		iconColor = entity.imageColor
	}
}
