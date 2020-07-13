//
//  CategoryListPresenter.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

class CategoryListPresenter: CategoryListPresenterProtocol {

	weak var view: CategoryListViewProtocol?
	let repository: AnyRepository<Category>
	let router: CategoryListRouterProtocol

	private var categories: [Category] = [] {
		didSet {
			view?.reloadCategoriesList()
		}
	}

	var categoriesCount: Int {
		return categories.count
	}

	required init(view: CategoryListViewProtocol, repository: AnyRepository<Category>, router: CategoryListRouterProtocol) {
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
		router.showTaskListViewController(category: category)
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
		self.router.showCategoryDetailsViewController(scope: .edit(model: vm))
	}

	func addCategoryButtonPressed() {
		router.showCategoryDetailsViewController(scope: .create)
	}
}
