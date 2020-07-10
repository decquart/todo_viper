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
	func createSubTaskListModule(router: RouterProtocol, task: Task) -> UIViewController
	func createTaskDetailsModule(router: RouterProtocol, scope: Scope<TaskViewModel>) -> UIViewController
	func createSubTaskDetailsModule(router: RouterProtocol, task: Task, scope: Scope<SubTaskViewModel>) -> UIViewController
}

class AssemblyBuilder: AssemblyBuilderProtocol {

	lazy var coreDataStack: CoreDataStack = CoreDataStack(modelName: "TodoList")

	func createMainModule(router: RouterProtocol) -> UIViewController {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let view = storyboard.instantiateViewController(withIdentifier: TaskListViewController.identifire) as! TaskListViewController

		let repository = CDTaskRepository(coreDataStack: coreDataStack)
		let presenter = TaskListPresenter(view: view, repository: repository, router: router)
		view.presenter = presenter
		return view
	}

	func createSubTaskListModule(router: RouterProtocol, task: Task) -> UIViewController {

		let storyboard = UIStoryboard(name: "SubTask", bundle: nil)
		let view = storyboard.instantiateViewController(withIdentifier: SubTaskListViewController.identifire) as! SubTaskListViewController
		let repository = CDSubTaskRepository(taskId: task.id, coreDataStack: coreDataStack)
		let presenter = SubTaskListPresenter(view: view, router: router, repository: repository, task: task)
		view.presenter = presenter
		return view
	}

	func createTaskDetailsModule(router: RouterProtocol, scope: Scope<TaskViewModel>) -> UIViewController {

		let iconPickerPresenter = IconPickerPresenter()
		let subview = IconPickerView.instantiate(presenter: iconPickerPresenter)
		iconPickerPresenter.view = subview

		let storyboard = UIStoryboard(name: "TaskDetails", bundle: nil)
		let view = storyboard.instantiateViewController(withIdentifier: TaskDetailsViewController.identifire) as! TaskDetailsViewController

		view.iconPickerView = subview
		let repository = CDTaskRepository(coreDataStack: coreDataStack)
		let presenter = TaskDetailsPresenter(view: view, repository: repository, router: router)
		iconPickerPresenter.detailsPresenter = presenter

		view.presenter = presenter
		view.scope = scope
		return view
	}

	func createSubTaskDetailsModule(router: RouterProtocol, task: Task, scope: Scope<SubTaskViewModel>) -> UIViewController {
		let storyboard = UIStoryboard(name: "SubTaskDetails", bundle: nil)
		let view = storyboard.instantiateViewController(withIdentifier: SubTaskDetailsViewController.identifire) as! SubTaskDetailsViewController
		let repository = CDSubTaskRepository(taskId: task.id, coreDataStack: coreDataStack)
		let presenter = SubTaskDetailsPresenter(view: view, router: router, repository: repository, task: task)

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
