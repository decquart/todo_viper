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
	private let repository: AnyRepository<Category>

	var onDismiss: (() -> Void)?

	init(view: CategoryDetailsViewProtocol, repository: AnyRepository<Category>) {
		self.view = view
		self.repository = repository
	}

	func saveButtonPressed(with viewModel: CategoryViewModel) {
		guard view.isNewCategory else {
			repository.update(viewModel.mapToModel) { [weak self] _ in
				self?.onDismiss?()
			}

			return
		}

		repository.add(viewModel.mapToModel) { [weak self] _ in
			self?.onDismiss?()
		}
	}

	func updateIcon(_ imagePath: String) {
		view.refreshIcon(imagePath)
	}

	func updateColor(_ color: Color) {
		view.refreshColor(color)
	}
}
