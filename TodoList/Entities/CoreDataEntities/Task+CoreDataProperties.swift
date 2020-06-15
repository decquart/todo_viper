//
//  Task+CoreDataProperties.swift
//  
//
//  Created by Volodymyr Mykhailiuk on 11.06.2020.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var image: Data
    @NSManaged public var iconColor: NSObject
    @NSManaged public var subTasks: NSSet

}

// MARK: Generated accessors for subTasks
extension Task {

    @objc(addSubTasksObject:)
    @NSManaged public func addToSubTasks(_ value: SubTask)

    @objc(removeSubTasksObject:)
    @NSManaged public func removeFromSubTasks(_ value: SubTask)

    @objc(addSubTasks:)
    @NSManaged public func addToSubTasks(_ values: NSSet)

    @objc(removeSubTasks:)
    @NSManaged public func removeFromSubTasks(_ values: NSSet)

}
