//
//  Router.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 29.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

protocol RouterMain {
	//var navigationController: UINavigationController! { get set }
	var mainNavigationController: UINavigationController! { get set }
	var settingsNavigationController: UINavigationController! { get set }
	var assemblyBuilder: AssemblyBuilderProtocol! { get set }
}

protocol RouterProtocol: RouterMain {
	func showSubTaskListViewController(category: Category)
	func showSubTaskDetailsViewController(category: Category, scope: Scope<TaskViewModel>)

	func popToRoot()
	func pop()
}

class Router: RouterProtocol {
	var mainNavigationController: UINavigationController!
	var settingsNavigationController: UINavigationController!
	var assemblyBuilder: AssemblyBuilderProtocol!

	init(assemblyBuilder: AssemblyBuilder?) {
		//self.navigationController = navigationController
		self.assemblyBuilder = assemblyBuilder
	}

	func showSubTaskListViewController(category: Category) {
		let vc = assemblyBuilder.createTaskListModule(category: category)
		mainNavigationController.pushViewController(vc, animated: true)
	}

	func showSubTaskDetailsViewController(category: Category, scope: Scope<TaskViewModel>) {
		let vc = assemblyBuilder.createTaskDetailsModule(category: category, scope: scope)
		mainNavigationController.pushViewController(vc, animated: true)
	}

	func popToRoot() {
		mainNavigationController.popToRootViewController(animated: true)
	}

	func pop() {
		mainNavigationController.popViewController(animated: true)
	}
}
