//
//  CategoryListPresenter.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

typealias ScopeCategoryHandler = (Scope<CategoryViewModel>) -> Void
typealias TaskHandler = (Category) -> Void

class CategoryListPresenter: CategoryListPresenterProtocol {

	weak var view: CategoryListViewProtocol?
	let repository: AnyRepository<Category>

	private var categories: [Category] = [] {
		didSet {
			view?.reloadCategoriesList()
		}
	}

	var categoriesCount: Int {
		return categories.count
	}

	var onShowCategoryDetails: ScopeCategoryHandler?
	var onPresentTasks: TaskHandler?

	required init(view: CategoryListViewProtocol, repository: AnyRepository<Category>) {
		self.view = view
		self.repository = repository
	}

	func category(at index: Int) -> CategoryViewModel {
		return CategoryViewModel(model: categories[index])
	}

	func tasksCount(at index: Int) -> Int {
		return categories[index].tasksCount
	}

	func loadCategories() {
		repository.fetch { result in
			if case let .success(items) = result {
				self.categories = items
			}
		}
	}

	func didSelectCategory(with index: Int) {
		let category = categories[index]

		onPresentTasks?(category)
	}

	func deleteButtonPressed(with index: Int) {
		let task = categories[index]

		self.repository.delete(task) { success in
			if success {
				self.categories = self.categories.filter { task.id != $0.id }
			}
		}
	}

	func editButtonPressed(with index: Int) {
		let task = categories[index]
		let vm = CategoryViewModel(model: task)

		onShowCategoryDetails?(.edit(model: vm))
	}

	func addCategoryButtonPressed() {
		onShowCategoryDetails?(.create)
	}
}
