//
//  Task+CoreDataProperties.swift
//  
//
//  Created by Volodymyr Mykhailiuk on 11.06.2020.
//
//

import Foundation
import CoreData


extension TaskMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskMO> {
        return NSFetchRequest<TaskMO>(entityName: "TaskMO")
    }

    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var imagePath: String
    @NSManaged public var iconColor: NSObject
    @NSManaged public var subTasks: NSSet

}

// MARK: Generated accessors for subTasks
extension TaskMO {

    @objc(addSubTasksObject:)
    @NSManaged public func addToSubTasks(_ value: SubTaskMO)

    @objc(removeSubTasksObject:)
    @NSManaged public func removeFromSubTasks(_ value: SubTaskMO)

    @objc(addSubTasks:)
    @NSManaged public func addToSubTasks(_ values: NSSet)

    @objc(removeSubTasks:)
    @NSManaged public func removeFromSubTasks(_ values: NSSet)

}
