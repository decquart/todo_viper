//
//  Router.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 29.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

protocol RouterMain {
	var navigationController: UINavigationController! { get set }
	var assemblyBuilder: AssemblyBuilderProtocol! { get set }
}

protocol RouterProtocol: RouterMain {
	func showTaskListViewController()
	func showSubTaskListViewController(task: Task)
	func showAddTaskViewController()
	func popToRoot()
}

class Router: RouterProtocol {
	var navigationController: UINavigationController!
	var assemblyBuilder: AssemblyBuilderProtocol!

	init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilder?) {
		self.navigationController = navigationController
		self.assemblyBuilder = assemblyBuilder
	}

	func showTaskListViewController() {
		let mainVC = assemblyBuilder.createMainModule(router: self)

		navigationController.viewControllers = [mainVC]
	}

	func showSubTaskListViewController(task: Task) {
		let vc = assemblyBuilder.createSubTaskListModule(router: self, task: task)

		navigationController.pushViewController(vc, animated: true)
	}

	func showAddTaskViewController() {
		let vc = assemblyBuilder.createAddTaskModule(router: self)
		navigationController.pushViewController(vc, animated: true)
	}

	func popToRoot() {
		navigationController.popToRootViewController(animated: true)
	}
}
