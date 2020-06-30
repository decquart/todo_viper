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
	func insertRows(at newIndexPaths: [IndexPath])
	func deleteRows(at indexPaths: [IndexPath])
	func updateRows(at indexPaths: [IndexPath])
	func moveRow(from indexPath: IndexPath?, to newIndexPath: IndexPath?)
	func reloadData()
}

protocol SubTaskListAdapterType: class {
	func subTask(at indexPath: IndexPath) -> SubTaskEntity?
	func numberOfRows(in section: Int) -> Int
	func update(subtask: SubTaskEntity)
	func add(subtask: SubTaskEntity, to task: TaskEntity)
}
