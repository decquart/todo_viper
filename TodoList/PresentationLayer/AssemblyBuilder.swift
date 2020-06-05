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
	func createAddTaskModule(router: RouterProtocol) -> UIViewController
}

class AssemblyBuilder: AssemblyBuilderProtocol {

	lazy var coreDataStack: CoreDataStack = CoreDataStack(modelName: "TodoList")

	func createMainModule(router: RouterProtocol) -> UIViewController {

		guard let view = router.navigationController?.viewControllers.first as? TaskListViewController else {
			fatalError("Initial view controller should not be nil")
		}

		let dataProvider = CoreDataTaskRepository(coreDataStack: coreDataStack)
		let presrnter = TaskListPresenter(view: view, dataProvider: dataProvider, router: router)
		view.presenter = presrnter
		return view
	}

	func createSubTaskListModule(router: RouterProtocol, task: TaskEntity) -> UIViewController {

		let storyboard = UIStoryboard(name: "SubTask", bundle: nil)
		let view = storyboard.instantiateViewController(withIdentifier: SubTaskListViewController.identifire) as! SubTaskListViewController
		let dataProvider = CoreDataSubTaskRepository(coreDataStack: coreDataStack)

		let presenter = SubTaskListPresenter(view: view, dataProvider: dataProvider, task: task)
		view.presenter = presenter
		return view
	}

	func createAddTaskModule(router: RouterProtocol) -> UIViewController {
		let storyboard = UIStoryboard(name: "AddTask", bundle: nil)
		let view = storyboard.instantiateViewController(withIdentifier: AddTaskViewController.identifire) as! AddTaskViewController

		let dataProvider = CoreDataTaskRepository(coreDataStack: coreDataStack)

		let presenter = AddTaskPresenter(view: view, dataProvider: dataProvider, router: router)
		view.presenter = presenter
		return view
	}
}
