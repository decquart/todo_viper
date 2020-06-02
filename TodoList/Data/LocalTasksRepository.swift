//
//  LocalTasksRepository.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 01.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

final class LocalTasksRepository: Repository {

	private let appDelegate = UIApplication.shared.delegate as! AppDelegate
	private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

	func getAll() -> [Task] {
		var tasks: [Task] = []
		do {
			tasks = try context.fetch(Task.fetchRequest())
		} catch let error as NSError {
			print("Could not fetch. \(error), \(error.userInfo)")
		}
		return tasks
	}

	func add(item: TaskTransportModel) -> Task {
		let task = Task(entity: Task.entity(), insertInto: context)
		task.name = item.name
		task.imagePath = item.imagePath
		appDelegate.saveContext()
		return task
	}
}
