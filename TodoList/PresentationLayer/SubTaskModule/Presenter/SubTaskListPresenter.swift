//
//  SubTaskListPresenter.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation
import CoreData

protocol SubTaskListViewOutput: class {
	var task: TaskEntity! { get set }
	var subTasks: [SubTaskEntity]? { get set }
	init(view: SubTaskListViewInput, repository: SubTasksRepositoryType, task: TaskEntity, coreDataStack: CoreDataStack)
	func addSubTask(with data: SubTaskEntity)
	func loadSubTasks()

	func didCompleteAll()
    
    func numberOfRows(in section: Int) -> Int
    func subTask(at indexPath: IndexPath) -> SubTaskEntity?
    func didSelect(at indexPath: IndexPath)
}

protocol SubTaskListViewInput: class {
	func refreshSubTasks()
}

class SubTaskListPresenter: SubTaskListViewOutput {

	let repository: SubTasksRepositoryType
	weak var view: SubTaskListViewInput?
    var coreDataStack: CoreDataStackType

	var task: TaskEntity!

	var subTasks: [SubTaskEntity]? {
		didSet {
			self.view?.refreshSubTasks()
		}
	}
    
    let fetchedResultsController: NSFetchedResultsController<SubTask>!

    required init(view: SubTaskListViewInput, repository: SubTasksRepositoryType, task: TaskEntity, coreDataStack: CoreDataStack) {
		self.view = view
		self.repository = repository
		self.task = task
        
        //todo: Move out
        
        self.coreDataStack = coreDataStack
        let fetchRequest: NSFetchRequest<SubTask> = SubTask.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: #keyPath(SubTask.description_p), ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                              managedObjectContext: coreDataStack.mainContext,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil)
        
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Fetching error: \(error), \(error.userInfo)")
        }
	}

	func addSubTask(with data: SubTaskEntity) {

		repository.add(subtask: data, to: task) {
			subTasks?.append(data)
		}
	}

	func loadSubTasks() {
		repository.getAll(where: task) {
			self.subTasks = $0
		}
	}

	func didCompleteAll() {
		repository.markAsCompleted(where: task) {
			//todo: reconsider
			loadSubTasks()
		}
	}
    
    func numberOfRows(in section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func subTask(at indexPath: IndexPath) -> SubTaskEntity? {
        fetchedResultsController.object(at: indexPath).domainModel
        
    }

    func didSelect(at indexPath: IndexPath) {
        let subTask = fetchedResultsController.object(at: indexPath)
        subTask.completed = !subTask.completed
        coreDataStack.save(context: coreDataStack.mainContext)
//        guard var subTask = subTasks?[index] else {
//            return
//        }
//
//        subTask.completed = !subTask.completed
//        repository.update(subtask: subTask) {
//            //apply refresh for custom layout
//            //view?.refreshSubTasks()
//        }
    }
}
