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

		let iconPickerPresenter = IconPickerPresenter()
		let subview = IconPickerView.instantiate(presenter: iconPickerPresenter)
		iconPickerPresenter.view = subview

		let storyboard = UIStoryboard(name: "CategoryDetails", bundle: nil)
		let view = storyboard.instantiateViewController(withIdentifier: CategoryDetailsViewController.identifire) as! CategoryDetailsViewController
		view.iconPickerView = subview

		let router = CategoryDetailsRouter()
		let repository = CDCategoryRepository(coreDataStack: CoreDataStackHolder.shared.coreDataStack)
		let presenter = CategoryDetailsPresenter(view: view, repository: repository, router: router)
		iconPickerPresenter.detailsPresenter = presenter

		view.presenter = presenter
		view.scope = scope
		return view
	}
}
