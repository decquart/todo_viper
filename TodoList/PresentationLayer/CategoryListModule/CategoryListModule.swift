//
//  CategoryListModule.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 13.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

final class CategoryListModule {
	func build() -> UIViewController {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let view = storyboard.instantiateViewController(withIdentifier: CategoryListViewController.identifire) as! CategoryListViewController
		let router = CategoryListRouter()
		let coreDataStack = CoreDataStackHolder.shared.coreDataStack
		let repository = CDCategoryRepository(coreDataStack: coreDataStack)
		let presenter = CategoryListPresenter(view: view, repository: repository, router: router)
		router.view = view
		view.presenter = presenter
		view.tabBarItem = UITabBarItem(title: "Categories", image: UIImage(systemName: "pencil.circle.fill"), tag: 0)
		return view
	}
}
