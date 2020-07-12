//
//  AssemblyBuilder.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 29.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

protocol AssemblyBuilderProtocol {
	func createMainModule(router: RouterProtocol) -> UIViewController
	func createTaskListModule(router: RouterProtocol, category: Category) -> UIViewController
	func createCategoryDetailsModule(router: RouterProtocol, scope: Scope<CategoryViewModel>) -> UIViewController
	func createTaskDetailsModule(router: RouterProtocol, category: Category, scope: Scope<TaskViewModel>) -> UIViewController
}

class AssemblyBuilder: AssemblyBuilderProtocol {

	lazy var coreDataStack: CoreDataStack = CoreDataStack(modelName: "TodoList")

	func createMainModule(router: RouterProtocol) -> UIViewController {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let view = storyboard.instantiateViewController(withIdentifier: CategoryListViewController.identifire) as! CategoryListViewController
		let repository = CDCategoryRepository(coreDataStack: coreDataStack)
		let presenter = CategoryListPresenter(view: view, repository: repository, router: router)
		view.presenter = presenter
		return view
	}

	func createTaskListModule(router: RouterProtocol, category: Category) -> UIViewController {

		let storyboard = UIStoryboard(name: "Task", bundle: nil)
		let view = storyboard.instantiateViewController(withIdentifier: TaskListViewController.identifire) as! TaskListViewController
		let repository = CDTaskRepository(categoryId: category.id, coreDataStack: coreDataStack)
		let presenter = TaskListPresenter(view: view, router: router, repository: repository, task: category)
		view.presenter = presenter
		return view
	}

	func createCategoryDetailsModule(router: RouterProtocol, scope: Scope<CategoryViewModel>) -> UIViewController {

		let iconPickerPresenter = IconPickerPresenter()
		let subview = IconPickerView.instantiate(presenter: iconPickerPresenter)
		iconPickerPresenter.view = subview

		let storyboard = UIStoryboard(name: "CategoryDetails", bundle: nil)
		let view = storyboard.instantiateViewController(withIdentifier: CategoryDetailsViewController.identifire) as! CategoryDetailsViewController

		view.iconPickerView = subview
		let repository = CDCategoryRepository(coreDataStack: coreDataStack)
		let presenter = CategoryDetailsPresenter(view: view, repository: repository, router: router)
		iconPickerPresenter.detailsPresenter = presenter

		view.presenter = presenter
		view.scope = scope
		return view
	}

	func createTaskDetailsModule(router: RouterProtocol, category: Category, scope: Scope<TaskViewModel>) -> UIViewController {
		let storyboard = UIStoryboard(name: "TaskDetails", bundle: nil)
		let view = storyboard.instantiateViewController(withIdentifier: TaskDetailsViewController.identifire) as! TaskDetailsViewController
		let repository = CDTaskRepository(categoryId: category.id, coreDataStack: coreDataStack)
		let presenter = TaskDetailsPresenter(view: view, router: router, repository: repository, category: category)

		view.presenter = presenter
		view.scope = scope
		return view
	}

	func createSettingsModule(router: RouterProtocol) -> UIViewController {
		let storyboard = UIStoryboard(name: "Settings", bundle: nil)
		let view = storyboard.instantiateViewController(withIdentifier: SettingsViewController.identifire) as! SettingsViewController

		//todo: add view model
		return view
	}
}
