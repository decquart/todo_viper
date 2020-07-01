//
//  CoreDataSubTaskAdapter.swift
//  TodoList
//
//  Created by volodymyr on 19.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import CoreData

class CoreDataSubTaskAdapter: NSObject, SubTaskListAdapterType {
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
		repository.add(subtask: subtask, to: task)
	}
}

private extension CoreDataSubTaskAdapter {
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
extension CoreDataSubTaskAdapter: NSFetchedResultsControllerDelegate {

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
		view?.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {

        switch type {
        case .insert:
			view?.insertRows(at: [newIndexPath!])
        case .delete:
			view?.deleteRows(at: [indexPath!])
        case .update:
			view?.updateRows(at: [indexPath!])
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

