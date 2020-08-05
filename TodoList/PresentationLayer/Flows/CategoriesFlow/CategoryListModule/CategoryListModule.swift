//
//  CategoryListModule.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 13.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

final class CategoryListModule {
	func build(onShowCategoryDetails: ScopeCategoryHandler?, onPresent: TaskHandler?) -> UIViewController {
		let view = CategoryListViewController.instantiate(storyboard: .main)
		let coreDataStack = CoreDataStackHolder.shared.coreDataStack
		let repository = CDCategoryRepository(coreDataStack: coreDataStack)
		let presenter = CategoryListPresenter(view: view, repository: repository)
		presenter.onShowCategoryDetails = onShowCategoryDetails
		presenter.onPresentTasks = onPresent
		view.presenter = presenter
		return view
	}
}
