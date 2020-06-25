//
//  SubTaskListAdapter.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 19.06.2020.
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
	func subTask(at indexPath: IndexPath) -> SubTaskEntity?
	func numberOfRows(in section: Int) -> Int
	func update(subtask: SubTaskEntity)
	func add(subtask: SubTaskEntity, to task: TaskEntity)
}
