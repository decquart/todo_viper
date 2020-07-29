//
//  CategoryDetailsModule.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 13.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

final class CategoryDetailsModule {
	func build(scope: Scope<CategoryViewModel>) -> UIViewController {
		let storyboard = UIStoryboard(name: "CategoryDetails", bundle: nil)
		let view = storyboard.instantiateViewController(withIdentifier: CategoryDetailsViewController.identifire) as! CategoryDetailsViewController
		let router = CategoryDetailsRouter()
		let repository = CDCategoryRepository(coreDataStack: CoreDataStackHolder.shared.coreDataStack)
		let presenter = CategoryDetailsPresenter(view: view, repository: repository, router: router)
		let iconsSubview = IconPickerModule().build(presenter)
		let colorsSubview = ColorPickerModule().build(presenter, selectedColor: scope.model?.color)
		view.colorPickerView = colorsSubview
		view.iconPickerView = iconsSubview
		view.presenter = presenter
		view.scope = scope
		router.view = view
		return view
	}
}
