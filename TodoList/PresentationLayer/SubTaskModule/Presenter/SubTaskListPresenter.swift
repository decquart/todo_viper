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
    init(view: SubTaskListViewInput, task: TaskEntity, adapter: SubTaskListAdapterType)
	func addSubTask(with data: SubTaskEntity)

	func didCompleteAll()
    
    func numberOfRows(in section: Int) -> Int
    func subTask(at indexPath: IndexPath) -> SubTaskEntity?
	func didSelect(subTaskEntity: SubTaskEntity)
}

protocol SubTaskListViewInput: class {
	func refreshSubTasks()
}

class SubTaskListPresenter: SubTaskListViewOutput {

    let adapter: SubTaskListAdapterType
	weak var view: SubTaskListViewInput?

	var task: TaskEntity!

	var subTasks: [SubTaskEntity]? {
		didSet {
			self.view?.refreshSubTasks()
		}
	}

    required init(view: SubTaskListViewInput, task: TaskEntity, adapter: SubTaskListAdapterType) {
		self.view = view
		self.task = task
        self.adapter = adapter
	}

	func addSubTask(with data: SubTaskEntity) {
        adapter.add(subtask: data, to: task)
	}

	func didCompleteAll() {
		
	}
    
    func numberOfRows(in section: Int) -> Int {
        return adapter.numberOfRows(in: section)
    }
    
    func subTask(at indexPath: IndexPath) -> SubTaskEntity? {
        return adapter.subTask(at: indexPath)

    }

    func didSelect(subTaskEntity: SubTaskEntity) {

        //replace with vm
		let subTask = SubTaskEntity(uuid: subTaskEntity.uuid, description: subTaskEntity.description, completed: !subTaskEntity.completed)
        adapter.update(subtask: subTask)
    }
}
