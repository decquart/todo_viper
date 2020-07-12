//
//  CategoryListPresenter.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

protocol CategoryListViewOutput: class {
	var categoriesCount: Int { get }

	func category(at index: Int) -> CategoryViewModel
	func tasksCount(at index: Int) -> Int
	func loadCategories()
	func addCategoryButtonPressed()
	func didSelectCategory(with index: Int)
	func deleteButtonPressed(with index: Int)
	func editButtonPressed(with index: Int)
}

protocol CategoryListViewInput: class {
	func didCategoriesFetch()
}

class CategoryListPresenter: CategoryListViewOutput {

	weak var view: CategoryListViewInput?
	let repository: AnyRepository<Category>
	let router: RouterProtocol

	private var categories: [Category] = [] {
		didSet {
			view?.didCategoriesFetch()
		}
	}

	var categoriesCount: Int {
		return categories.count
	}

	required init(view: CategoryListViewInput, repository: AnyRepository<Category>, router: RouterProtocol) {
		self.view = view
		self.repository = repository
		self.router = router
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
		router.showSubTaskListViewController(category: category)
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
		self.router.showTaskDetailsViewController(scope: .edit(model: vm))
	}

	func addCategoryButtonPressed() {
		router.showTaskDetailsViewController(scope: .create)
	}
}
