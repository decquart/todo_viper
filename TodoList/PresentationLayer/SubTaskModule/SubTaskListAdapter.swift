//
//  SubTaskListAdapter.swift
//  TodoList
//
//  Created by volodymyr on 19.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import CoreData

protocol SubTaskListAdapterType: class {
    init(coreDataStack: CoreDataStackType, taskId: String, delegate: NSFetchedResultsControllerDelegate?, repository: SubTasksRepositoryType)
    func subTask(at indexPath: IndexPath) -> SubTaskEntity?
    func numberOfRows(in section: Int) -> Int

    func update(subtask: SubTaskEntity)
    func add(subtask: SubTaskEntity, to task: TaskEntity)
}

class SubTaskListAdapter: SubTaskListAdapterType {
    let coreDataStack: CoreDataStackType
    let repository: SubTasksRepositoryType
    private var fetchedResultsController: NSFetchedResultsController<SubTask>!

    required init(coreDataStack: CoreDataStackType, taskId: String, delegate: NSFetchedResultsControllerDelegate?, repository: SubTasksRepositoryType) {
        self.coreDataStack = coreDataStack
        self.repository = repository
        self.fetchedResultsController = self.setup(with: taskId)
        self.fetchedResultsController.delegate = delegate
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
        let sortDescriptor = NSSortDescriptor(key: #keyPath(SubTask.description_p), ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                              managedObjectContext: coreDataStack.mainContext,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil)

        try? fetchedResultsController.performFetch()
        return fetchedResultsController
    }
}
