//
//  TaskListPresenter.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

typealias TaskDetailsHandler = ((Category, Scope<TaskViewModel>) -> Void)

final class TaskListPresenter: TaskListPresenterProtocol {
	private(set) weak var view: TaskListViewProtocol?
	private let repository: AnyRepository<Task>

	private var category: Category!
	private var tasks: [Task] = [] {
		didSet {
			view?.refreshTasks()
		}
	}

	var onPresentDetails: TaskDetailsHandler?

	required init(view: TaskListViewProtocol, repository: AnyRepository<Task>, task: Category) {
		self.view = view
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
		onPresentDetails?(category, .edit(model: vm))
	}

	func addButtonPressed() {
		onPresentDetails?(category, .create)
	}
}