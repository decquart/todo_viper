//
//  SubTaskMO+CoreDataProperties.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 01.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//
//

import Foundation
import CoreData


extension SubTaskMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SubTaskMO> {
        return NSFetchRequest<SubTaskMO>(entityName: "SubTaskMO")
    }

	@NSManaged public var id: String
    @NSManaged public var completed: Bool
    @NSManaged public var description_p: String
    @NSManaged public var owner: TaskMO
}
