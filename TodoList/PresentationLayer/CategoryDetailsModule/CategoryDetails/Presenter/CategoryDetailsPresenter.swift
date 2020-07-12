//
//  CategoryDetailsPresenter.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 02.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

protocol CategoryDetailsOutput: class {
	func saveButtonPressed(with viewModel: CategoryViewModel)
	func updateIcon(_ imagePath: String)
}

protocol CategoryDetailsInput: class {
	var isNewCategory: Bool { get }
	func refreshIcon(_ imagePath: String)
}

final class CategoryDetailsPresenter: CategoryDetailsOutput {

	weak var view: CategoryDetailsInput!
	let repository: AnyRepository<Category>
	let router: RouterProtocol?

	init(view: CategoryDetailsInput, repository: AnyRepository<Category>, router: RouterProtocol) {
		self.view = view
		self.repository = repository
		self.router = router
	}

	func saveButtonPressed(with viewModel: CategoryViewModel) {
		//todo: resolve duplicate
		guard view.isNewCategory else {
			repository.update(viewModel.mapToModel) { _ in
				self.router?.popToRoot()
			}

			return
		}

		repository.add(viewModel.mapToModel) { _ in
			self.router?.popToRoot()
		}
	}

	func updateIcon(_ imagePath: String) {
		view?.refreshIcon(imagePath)
	}
}
