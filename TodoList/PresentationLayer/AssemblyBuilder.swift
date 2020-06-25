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
}

class AssemblyBuilder: AssemblyBuilderProtocol {

	lazy var coreDataStack: CoreDataStack = CoreDataStack(modelName: "TodoList")

	func createMainModule(router: RouterProtocol) -> UIViewController {

		guard let view = router.navigationController?.viewControllers.first as? TaskListViewController else {
			fatalError("Initial view controller should not be nil")
		}

		let repository = RealmTaskRepository()//CoreDataTaskRepository(coreDataStack: coreDataStack)
		let presrnter = TaskListPresenter(view: view, repository: repository, router: router)
		view.presenter = presrnter
		return view
	}

	func createSubTaskListModule(router: RouterProtocol, task: TaskEntity) -> UIViewController {

		let storyboard = UIStoryboard(name: "SubTask", bundle: nil)
		let view = storyboard.instantiateViewController(withIdentifier: SubTaskListViewController.identifire) as! SubTaskListViewController
		let repository = CoreDataSubTaskRepository(coreDataStack: coreDataStack)
		let adapter = CoreDataSubTaskAdapter(coreDataStack: coreDataStack, taskId: task.id, view: view, repository: repository)

        let presenter = SubTaskListPresenter(view: view, task: task, adapter: adapter, repository: repository)
		view.presenter = presenter
		return view
	}

	func createTaskDetailsModule(router: RouterProtocol, scope: TaskDetailsScope) -> UIViewController {
		let storyboard = UIStoryboard(name: "TaskDetails", bundle: nil)
		let view = storyboard.instantiateViewController(withIdentifier: TaskDetailsViewController.identifire) as! TaskDetailsViewController
		let repository = RealmTaskRepository()//CoreDataTaskRepository(coreDataStack: coreDataStack)
		let presenter = AddTaskPresenter(view: view, repository: repository, router: router)

		view.presenter = presenter
		view.scope = scope
		return view
	}
}
