//
//  LocalSubTasksRepository.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 01.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit
import CoreData

final class LocalSubTasksRepository: Repository {

	private let appDelegate = UIApplication.shared.delegate as! AppDelegate
	private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

	func getAll() -> [SubTask] {
		var subTasks: [SubTask] = []
		do {
			subTasks = try context.fetch(SubTask.fetchRequest())
		} catch let error as NSError {
			print("Could not fetch. \(error), \(error.userInfo)")
		}
		return subTasks
	}

	func get(for owner: Task) -> [SubTask] {

		let request = SubTask.fetchRequest() as NSFetchRequest<SubTask>
		request.predicate = NSPredicate(format: "owner = %@", owner)

		let sortDescriptor = NSSortDescriptor(key: #keyPath(SubTask.description_p), ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
		request.sortDescriptors = [sortDescriptor]

		let fetchedRC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)

		do {
			try fetchedRC.performFetch()
		} catch let error {
			print("\(error.localizedDescription)")
		}

		return fetchedRC.fetchedObjects ?? []
	}

	func add(item: SubTaskTransportModel, to task: Task) -> SubTask {
		let subTask = SubTask(entity: SubTask.entity(), insertInto: context)
		subTask.description_p = item.description
		subTask.completed = item.completed
		subTask.owner = task
		appDelegate.saveContext()
		return subTask
	}
}
