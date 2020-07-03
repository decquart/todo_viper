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
	func showSubTaskListViewController(task: TaskEntity)
	func showTaskDetailsViewController(scope: Scope<TaskEntity>)
	func showSubTaskDetailsViewController(task: TaskEntity, scope: Scope<SubTaskEntity>)
	func popToRoot()
	func showEditTaskAlertViewController(editAction: @escaping () -> Void, deleteAction: @escaping () -> Void)
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

	func showSubTaskListViewController(task: TaskEntity) {
		let vc = assemblyBuilder.createSubTaskListModule(router: self, task: task)

		navigationController.pushViewController(vc, animated: true)
	}

	func showTaskDetailsViewController(scope: Scope<TaskEntity>) {
		let vc = assemblyBuilder.createTaskDetailsModule(router: self, scope: scope)
		navigationController.pushViewController(vc, animated: true)
	}

	func showSubTaskDetailsViewController(task: TaskEntity, scope: Scope<SubTaskEntity>) {
		let vc = assemblyBuilder.createSubTaskDetailsModule(router: self, task: task, scope: scope)
		vc.modalPresentationStyle = .formSheet
		navigationController.present(vc, animated: true)
	}

	func popToRoot() {
		navigationController.popToRootViewController(animated: true)
	}

	//Should Router hold this method?
	func showEditTaskAlertViewController(editAction: @escaping () -> Void, deleteAction: @escaping () -> Void) {
		let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
		let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
			deleteAction()
		}
		let editAction = UIAlertAction(title: "Edit", style: .default) { _ in
			editAction()
		}
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

		alert.addAction(deleteAction)
		alert.addAction(editAction)
		alert.addAction(cancelAction)
		navigationController.present(alert, animated: true)
	}
}
