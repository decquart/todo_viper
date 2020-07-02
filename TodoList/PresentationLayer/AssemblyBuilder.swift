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
	func createSubTaskListModule(router: RouterProtocol, task: TaskEntity) -> UIViewController
	func createTaskDetailsModule(router: RouterProtocol, scope: TaskDetailsScope) -> UIViewController
	func createSubTaskDetailsModule(router: RouterProtocol, task: TaskEntity, subTask: SubTaskEntity?) -> UIViewController
}

class AssemblyBuilder: AssemblyBuilderProtocol {

	lazy var coreDataStack: CoreDataStack = CoreDataStack(modelName: "TodoList")

	func createMainModule(router: RouterProtocol) -> UIViewController {

		guard let view = router.navigationController?.viewControllers.first as? TaskListViewController else {
			fatalError("Initial view controller should not be nil")
		}

		let repository = CoreDataTaskRepository(coreDataStack: coreDataStack)
		let presenter = TaskListPresenter(view: view, repository: repository, router: router)
		view.presenter = presenter
		return view
	}

	func createSubTaskListModule(router: RouterProtocol, task: TaskEntity) -> UIViewController {

		let storyboard = UIStoryboard(name: "SubTask", bundle: nil)
		let view = storyboard.instantiateViewController(withIdentifier: SubTaskListViewController.identifire) as! SubTaskListViewController
		let repository = CoreDataSubTaskRepository(coreDataStack: coreDataStack)
		let presenter = SubTaskListPresenter(view: view, router: router, repository: repository, task: task)
		view.presenter = presenter
		return view
	}

	func createTaskDetailsModule(router: RouterProtocol, scope: TaskDetailsScope) -> UIViewController {

		let iconPickerPresenter = IconPickerPresenter()
		let subview = IconPickerView.instantiate(presenter: iconPickerPresenter)
		iconPickerPresenter.view = subview

		let storyboard = UIStoryboard(name: "TaskDetails", bundle: nil)
		let view = storyboard.instantiateViewController(withIdentifier: TaskDetailsViewController.identifire) as! TaskDetailsViewController

		view.iconPickerView = subview
		let repository = CoreDataTaskRepository(coreDataStack: coreDataStack)
		let presenter = AddTaskPresenter(view: view, repository: repository, router: router)
		iconPickerPresenter.detailsPresenter = presenter

		view.presenter = presenter
		view.scope = scope
		return view
	}

	func createSubTaskDetailsModule(router: RouterProtocol, task: TaskEntity, subTask: SubTaskEntity?) -> UIViewController {
		let storyboard = UIStoryboard(name: "SubTaskDetails", bundle: nil)
		let view = storyboard.instantiateViewController(withIdentifier: SubTaskDetailsViewController.identifire) as! SubTaskDetailsViewController
		let repository = CoreDataSubTaskRepository(coreDataStack: coreDataStack)
		let presenter = SubTaskDetailsPresenter(view: view, repository: repository, task: task, subTask: subTask)
		view.presenter = presenter
		return view
	}
}
