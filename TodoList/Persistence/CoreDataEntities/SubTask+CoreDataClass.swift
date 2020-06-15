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

extension SubTask: StorableModel {
	var domainModel: SubTaskEntity {
		return SubTaskEntity(description: description_p, completed: completed)
	}
}
