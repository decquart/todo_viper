//
//  SubTaskListAdapter.swift
//  TodoList
//
//  Created by volodymyr on 19.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import CoreData

protocol SubTaskListAdapterView: class {
	func beginUpdates()
	func endUpdates()
	func insertRow(at newIndexPath: IndexPath?)
	func deleteRow(at indexPath: IndexPath?)
	func updateRow(at indexPath: IndexPath?)
	func moveRow(from indexPath: IndexPath?, to newIndexPath: IndexPath?)
}

protocol SubTaskListAdapterType: class {
	init(coreDataStack: CoreDataStackType, taskId: String, view: SubTaskListAdapterView, repository: SubTasksRepositoryType)
	func subTask(at indexPath: IndexPath) -> SubTaskEntity?
	func numberOfRows(in section: Int) -> Int

	func update(subtask: SubTaskEntity)
	func add(subtask: SubTaskEntity, to task: TaskEntity)
}

class SubTaskListAdapter: NSObject, SubTaskListAdapterType {
	let coreDataStack: CoreDataStackType
	let repository: SubTasksRepositoryType
	private var fetchedResultsController: NSFetchedResultsController<SubTask>!
	weak var view: SubTaskListAdapterView?

	required init(coreDataStack: CoreDataStackType, taskId: String, view: SubTaskListAdapterView, repository: SubTasksRepositoryType) {
		self.coreDataStack = coreDataStack
		self.repository = repository
		self.view = view
		super.init()

		self.fetchedResultsController = self.setup(with: taskId)
		self.fetchedResultsController.delegate = self
	}

	func subTask(at indexPath: IndexPath) -> SubTaskEntity? {
		return fetchedResultsController.object(at: indexPath).domainModel
	}

	func numberOfRows(in section: Int) -> Int {
		return fetchedResultsController.sections?[section].numberOfObjects ?? 0
	}

	func update(subtask: SubTaskEntity) {
		repository.update(subtask: subtask) {}
	}
	func add(subtask: SubTaskEntity, to task: TaskEntity) {
		repository.add(subtask: subtask, to: task) {}
	}
}

private extension SubTaskListAdapter {
	func setup(with taskId: String) -> NSFetchedResultsController<SubTask> {
		let fetchRequest: NSFetchRequest<SubTask> = SubTask.fetchRequest()
		fetchRequest.predicate = NSPredicate(format: "owner.id = %@", taskId)

		let nameSortDescriptor = NSSortDescriptor(key: #keyPath(SubTask.description_p), ascending: true)
		let statusSortDescriptor = NSSortDescriptor(key: #keyPath(SubTask.completed), ascending: true)
		fetchRequest.sortDescriptors = [statusSortDescriptor, nameSortDescriptor]
		let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
																  managedObjectContext: coreDataStack.mainContext,
																  sectionNameKeyPath: nil,
																  cacheName: nil)

		try? fetchedResultsController.performFetch()
		return fetchedResultsController
	}
}

//MARK: - NSFetchedResultsControllerDelegate
extension SubTaskListAdapter: NSFetchedResultsControllerDelegate {

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
		view?.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {

        switch type {
        case .insert:
			view?.insertRow(at: newIndexPath)
        case .delete:
			view?.deleteRow(at: indexPath)
        case .update:
			view?.updateRow(at: indexPath)
        case .move:
			view?.moveRow(from: indexPath, to: newIndexPath)
        @unknown default:
            break
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
		view?.endUpdates()
    }
}
