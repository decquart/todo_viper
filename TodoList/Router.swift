//
//  Router.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 29.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

protocol RouterMain {
	//var navigationController: UINavigationController? { get set }
	var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
	func configureTaskListViewController(view: TaskListViewController)
	func configureSubTaskListViewController(view: SubTaskListViewController, task: Task)
}

class Router: RouterProtocol {
	//var navigationController: UINavigationController?
	var assemblyBuilder: AssemblyBuilderProtocol?

	init(assemblyBuilder: AssemblyBuilder?) {
		//self.navigationController = navigationController
		self.assemblyBuilder = assemblyBuilder
	}

	func configureTaskListViewController(view: TaskListViewController) {
		assemblyBuilder?.setupMainModule(view: view, router: self)
	}

	func configureSubTaskListViewController(view: SubTaskListViewController, task: Task) {
		assemblyBuilder?.setupSubTaskListModule(view: view, router: self, task: task)
	}
}
