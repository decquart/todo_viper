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

// MARK: - Mappable
extension SubTaskMO: Mappable {
	var mapToModel: SubTask {
		return SubTask(uuid: id,
					   description: description_p,
					   completed: completed)
	}

	func map(_ model: SubTask) {
		self.id = model.uuid
		self.description_p = model.description
		self.completed = model.completed
	}
}
