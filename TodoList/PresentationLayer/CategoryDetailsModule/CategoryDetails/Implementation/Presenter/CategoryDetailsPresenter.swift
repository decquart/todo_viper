//
//  CategoryDetailsPresenter.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 02.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

final class CategoryDetailsPresenter: CategoryDetailsPresenterProtocol {
	weak var view: CategoryDetailsViewProtocol!
	let repository: AnyRepository<Category>
	let router: CategoryDetailsRouterProtocol!

	init(view: CategoryDetailsViewProtocol, repository: AnyRepository<Category>, router: CategoryDetailsRouterProtocol) {
		self.view = view
		self.repository = repository
		self.router = router
	}

	func saveButtonPressed(with viewModel: CategoryViewModel) {
		//todo: resolve duplicate
		guard view.isNewCategory else {
			repository.update(viewModel.mapToModel) { [weak self] _ in
				self?.router.popToRoot()
			}

			return
		}

		repository.add(viewModel.mapToModel) { [weak self] _ in
			self?.router.popToRoot()
		}
	}

	func updateIcon(_ imagePath: String) {
		view.refreshIcon(imagePath)
	}

	func updateColor(_ color: Color) {
		view.refreshColor(color)
	}
}
