//
//  SubTask+CoreDataClass.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 01.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//
//

import Foundation
import CoreData

@objc(SubTask)
public class SubTask: NSManagedObject {

}

// MARK: - DomainModelMapping
extension SubTask: DomainModelMapping {
	var domainModel: SubTaskEntity {
		return SubTaskEntity(uuid: id,
							 description: description_p,
							 completed: completed)
	}
}

// MARK: - Mappable
extension SubTask: Mappable {
	func map(_ entity: SubTaskEntity) {
		self.id = entity.uuid
		self.description_p = entity.description
		self.completed = entity.completed
	}
}
