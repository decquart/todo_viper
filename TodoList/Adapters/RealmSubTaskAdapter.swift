//
//  RealmSubTaskAdapter.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 25.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

class RealmSubTaskAdapter: NSObject, SubTaskListAdapterType {

	let repository: SubTasksRepositoryType
	weak var view: SubTaskListAdapterView?

	required init(taskId: String, view: SubTaskListAdapterView, repository: SubTasksRepositoryType) {
		self.repository = repository
		self.view = view
		super.init()

		self.setup()
	}

	func setup() {
		
	}

	func subTask(at indexPath: IndexPath) -> SubTaskEntity? {
		return nil
	}

	func numberOfRows(in section: Int) -> Int {
		return 0
	}

	func update(subtask: SubTaskEntity) {

	}

	func add(subtask: SubTaskEntity, to task: TaskEntity) {

	}
}
