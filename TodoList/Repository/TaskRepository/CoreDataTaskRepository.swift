//
//  CoreDataTaskRepository.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 05.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import CoreData

class CoreDataTaskRepository: TasksRepositoryType {

	let managedObjectContext: NSManagedObjectContext

	init(context: NSManagedObjectContext) {
		self.managedObjectContext = context
	}

	func getAll() -> [TaskEntity] {
		let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()

		do {
			let result = try managedObjectContext.fetch(fetchRequest)
			return result.map { $0.domainModel }
		} catch {
			print(error.localizedDescription)
			return []
		}
	}

	func getSubTasksCount(for task: TaskEntity) -> Int {
		let predicate = NSPredicate(format: "id = %@", task.id)
		let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
		fetchRequest.predicate = predicate

		do {
			let result = try managedObjectContext.fetch(fetchRequest)
			return result.first?.subTasks.count ?? 0
		} catch {
			print(error.localizedDescription)
			return 0
		}

	}

	func create(task: TaskEntity) -> Bool {
		let name = String(describing: Task.self)
		guard let taskMO = NSEntityDescription.insertNewObject(forEntityName: name, into: managedObjectContext) as? Task else {
			return false
		}

		taskMO.id = task.id
		taskMO.name = task.name
		taskMO.imagePath = task.imagePath
		saveContext()
		return true
	}

	//todo: call from core data stack
	private func saveContext() {
        let context = managedObjectContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
