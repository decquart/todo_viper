//
//  SubTaskMO+CoreDataClass.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 01.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//
//

import Foundation
import CoreData

@objc(SubTaskMO)
public class SubTaskMO: NSManagedObject {

}

// MARK: - DomainModelMapping
extension SubTaskMO: DomainModelMapping {
	var domainModel: SubTask {
		return SubTask(uuid: id,
							 description: description_p,
							 completed: completed)
	}
}

// MARK: - Mappable
extension SubTaskMO: Mappable {
	func map(_ entity: SubTask) {
		self.id = entity.uuid
		self.description_p = entity.description
		self.completed = entity.completed
	}
}
