//
//  TaskListPresenter.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

protocol TaskListViewOutput: class {
	func loadTasks()
	func numberOfRows() -> Int
	func task(at indexPath: IndexPath) -> TaskViewModel
	func buttonCompletePressed(at index: Int)
	func didCompleteAll()
	func didSelect(at indexPath: IndexPath)
	func addButtonPressed()
}

protocol TaskListViewInput: class {
	func refreshTasks()
}

class TaskListPresenter: TaskListViewOutput {
	weak var view: TaskListViewInput?
	let router: RouterProtocol
	let repository: AnyRepository<Task>

	private var category: Category!
	private var tasks: [Task] = [] {
		didSet {
			view?.refreshTasks()
		}
	}

	required init(view: TaskListViewInput, router: RouterProtocol, repository: AnyRepository<Task>, task: Category) {
		self.view = view
		self.router = router
		self.repository = repository
		self.category = task
	}

	func loadTasks() {
		repository.fetch { [weak self] result in
			if case let .success(items) = result {
				self?.tasks = items
			}
		}
	}

	func numberOfRows() -> Int {
		return tasks.count
	}

	func task(at indexPath: IndexPath) -> TaskViewModel {
		return TaskViewModel(model: tasks[indexPath.row])
	}

	func buttonCompletePressed(at index: Int) {
		var task = tasks[index]
		task.completed.toggle()

		repository.update(task) { [weak self] success in
			if success {
				self?.loadTasks()
			}
		}
	}

	func didCompleteAll() {
		let unfinished = tasks.filter { !$0.completed }
		if unfinished.isEmpty { return }

		let modified = unfinished.map { task -> Task in
			var item = task
			item.completed.toggle()
			return item
		}

		repository.update(modified) { [weak self] _ in
			self?.loadTasks()
		}
	}

	func didSelect(at indexPath: IndexPath) {
		let vm = TaskViewModel(model: tasks[indexPath.row])
		router.showSubTaskDetailsViewController(category: category, scope: .edit(model: vm))
	}

	func addButtonPressed() {
		router.showSubTaskDetailsViewController(category: category, scope: .create)
	}
}
