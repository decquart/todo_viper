//
//  AssemblyBuilder.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 29.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

protocol AssemblyBuilderProtocol {
	func setupMainModule(view: TaskListViewController, router: RouterProtocol)
	func setupSubTaskListModule(view: SubTaskListViewController, router: RouterProtocol, task: Task)
}

class AssemblyBuilder: AssemblyBuilderProtocol {
	func setupMainModule(view: TaskListViewController, router: RouterProtocol) {
		let dataProvider = TaskDataProvider()
		let presrnter = TaskListPresenter(view: view, dataProvider: dataProvider, router: router)
		view.presenter = presrnter
		//return view
	}

	func setupSubTaskListModule(view: SubTaskListViewController, router: RouterProtocol, task: Task) {
		let dataProvider = TaskDataProvider()
		let presenter = SubTaskListPresenter(view: view, dataProvider: dataProvider, task: task)
		view.presenter = presenter
		//return view
	}
}
