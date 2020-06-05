//
//  CoreDataStack.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 05.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataStackType {
	var managedContext: NSManagedObjectContext { get }
	func saveContext()
}

final class CoreDataStack: CoreDataStackType {
	private let modelName: String

	init(modelName: String) {
		self.modelName = modelName
	}

	private lazy var storeContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: self.modelName)

		container.loadPersistentStores { (storeDescription, error) in
			if let error = error as NSError? {
				print("Unresolved error \(error), \(error.userInfo)")
			}
		}

		return container
	}()

	lazy var managedContext: NSManagedObjectContext = {
		return self.storeContainer.viewContext
	}()

	func saveContext() {
		guard managedContext.hasChanges else { return }

		do {
			try managedContext.save()
		} catch let error as NSError {
			print("Unresolved error \(error), \(error.userInfo)")
		}
	}
}

