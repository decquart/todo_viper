//
//  AssemblyBuilder.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 29.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

protocol AssemblyBuilderProtocol {
	func createTaskListModule(category: Category) -> UIViewController
	func createTaskDetailsModule(category: Category, scope: Scope<TaskViewModel>) -> UIViewController
}

class AssemblyBuilder: AssemblyBuilderProtocol {

	lazy var coreDataStack: CoreDataStack = CoreDataStack(modelName: "TodoList")


	func createTaskListModule(category: Category) -> UIViewController {

		let router = Router(assemblyBuilder: self)
		let storyboard = UIStoryboard(name: "Task", bundle: nil)
		let view = storyboard.instantiateViewController(withIdentifier: TaskListViewController.identifire) as! TaskListViewController
		let repository = CDTaskRepository(categoryId: category.id, coreDataStack: coreDataStack)
		let presenter = TaskListPresenter(view: view, router: router, repository: repository, task: category)
		view.presenter = presenter
		return view
	}


	func createTaskDetailsModule(category: Category, scope: Scope<TaskViewModel>) -> UIViewController {
		let router = Router(assemblyBuilder: self)
		let storyboard = UIStoryboard(name: "TaskDetails", bundle: nil)
		let view = storyboard.instantiateViewController(withIdentifier: TaskDetailsViewController.identifire) as! TaskDetailsViewController
		let repository = CDTaskRepository(categoryId: category.id, coreDataStack: coreDataStack)
		let presenter = TaskDetailsPresenter(view: view, router: router, repository: repository, category: category)

		view.presenter = presenter
		view.scope = scope
		return view
	}

	func createSettingsModule() -> UIViewController {
		let storyboard = UIStoryboard(name: "Settings", bundle: nil)
		let view = storyboard.instantiateViewController(withIdentifier: SettingsViewController.identifire) as! SettingsViewController
		view.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 0)
		//todo: add view model
		return view
	}
}
