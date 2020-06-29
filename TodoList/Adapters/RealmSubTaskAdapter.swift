//
//  RealmSubTaskAdapter.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 25.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation
import RealmSwift

class RealmSubTaskAdapter: NSObject, SubTaskListAdapterType {

	let taskId: String
	let repository: SubTasksRepositoryType
	weak var view: SubTaskListAdapterView?

	private var realm = try! Realm()
	private var results: Results<SubTaskObject>!
	private var token: NotificationToken?

	required init(taskId: String, view: SubTaskListAdapterView, repository: SubTasksRepositoryType) {
		self.taskId = taskId
		self.repository = repository
		self.view = view
		super.init()

		self.setup()
	}

	func setup() {
		results = realm.objects(SubTaskObject.self)//.filter("owner.id == %@", taskId)
		observe()
	}

	func subTask(at indexPath: IndexPath) -> SubTaskEntity? {
		return results[indexPath.row].domainModel
	}

	func numberOfRows(in section: Int) -> Int {
		return results.count
	}

	func update(subtask: SubTaskEntity) {
		repository.update(subtask: subtask)
	}

	func add(subtask: SubTaskEntity, to task: TaskEntity) {
		repository.add(subtask: subtask, to: task)
	}

	deinit {
		token?.invalidate()
	}
}

extension RealmSubTaskAdapter {
	func observe() {
		token = results.observe { [weak self] (changes: RealmCollectionChange) in
			guard let view = self?.view else { return }

			switch changes {
			case .initial:
				print("reloa ")
			case .update(_, let deletions, let insertions, let modifications):
				view.beginUpdates()
				view.deleteRows(at: deletions.map { IndexPath(row: $0, section: 0) })
				view.insertRows(at: insertions.map { IndexPath(row: $0, section: 0) })
				view.updateRows(at: modifications.map { IndexPath(row: $0, section: 0) })
				view.endUpdates()
			case .error(let err):
				print(err.localizedDescription)
			}
		}
	}
}
