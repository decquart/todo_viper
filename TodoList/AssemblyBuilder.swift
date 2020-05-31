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
}

class AssemblyBuilder: AssemblyBuilderProtocol {
	func createMainModule(router: RouterProtocol) -> UIViewController {

		guard let view = router.navigationController?.viewControllers.first as? TaskListViewController else {
			fatalError("Initial view controller should not be nil")
		}

		let dataProvider = TaskDataProvider()
		let presrnter = TaskListPresenter(view: view, dataProvider: dataProvider, router: router)
		view.presenter = presrnter
		return view
	}

	func createSubTaskListModule(router: RouterProtocol, task: Task) -> UIViewController {

		let storyboard = UIStoryboard(name: "SubTask", bundle: nil)
		let view = storyboard.instantiateViewController(withIdentifier: SubTaskListViewController.identifire) as! SubTaskListViewController
		let dataProvider = TaskDataProvider()

		let presenter = SubTaskListPresenter(view: view, dataProvider: dataProvider, task: task)
		view.presenter = presenter
		return view
	}
}
