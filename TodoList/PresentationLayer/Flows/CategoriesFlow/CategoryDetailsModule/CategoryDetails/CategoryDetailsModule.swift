//
//  CategoryDetailsModule.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 13.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

final class CategoryDetailsModule {
	func build(scope: Scope<CategoryViewModel>, onDismiss: (() -> Void)?) -> UIViewController {
		let view = CategoryDetailsViewController.instantiate(storyboard: .categoryDetails)
		let repository = CDCategoryRepository(coreDataStack: CoreDataStackHolder.shared.coreDataStack)
		let presenter = CategoryDetailsPresenter(view: view, repository: repository)
		let iconsSubview = IconPickerModule().build(presenter)
		let colorsSubview = ColorPickerModule().build(presenter, selectedColor: scope.model?.color)
		presenter.onDismiss = onDismiss
		view.colorPickerView = colorsSubview
		view.iconPickerView = iconsSubview
		view.presenter = presenter
		view.scope = scope
		return view
	}
}
