//
//  Router.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 29.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

final class Router: RouterType {
	var toPresent: UIViewController {
		return rootViewController
	}

	let rootViewController: UINavigationController

	init(navigationController: UINavigationController) {
		self.rootViewController = navigationController
	}

	func present(_ module: Presentable?) {
		self.present(module, animated: true)
	}

	func present(_ module: Presentable?, animated: Bool) {
		guard let controller = module?.toPresent else {
			return
		}

		self.rootViewController.present(controller, animated: animated, completion: nil)
	}

	func present(_ module: Presentable?, animated: Bool, completion: Completion?) {
		guard let controller = module?.toPresent else {
			return
		}

		self.rootViewController.present(controller, animated: animated, completion: completion)
	}

	func push(_ module: Presentable?) {
		self.push(module, animated: true)
	}

	func push(_ module: Presentable?, animated: Bool) {
		self.push(module, animated: animated, completion: nil)
	}

	func push(_ module: Presentable?, animated: Bool, completion: Completion?) {
		guard let controller = module?.toPresent, !(controller is UINavigationController) else {
			assertionFailure("Can not push navigation controller")
			return
		}

		self.rootViewController.pushViewController(controller, animated: animated)
	}

	func pop() {
		self.pop(animated: true)
	}

	func pop(animated: Bool) {
		self.rootViewController.popViewController(animated: animated)
	}

	func dismiss() {
		self.dismiss(animated: true, completion: nil)
	}

	func dismiss(animated: Bool, completion: Completion?) {
		self.rootViewController.dismiss(animated: animated, completion: completion)
	}

	func setRootModule(_ module: Presentable?, animated: Bool) {
		setRootModule(module, hideBar: false, animated: animated)
	}

	func setRootModule(_ module: Presentable?, hideBar: Bool, animated: Bool) {
		guard let controller = module?.toPresent else {
			return
		}

		self.rootViewController.setViewControllers([controller], animated: animated)
		self.rootViewController.isNavigationBarHidden = hideBar
	}

	func popToRoot(animated: Bool) {
		self.rootViewController.popViewController(animated: animated)
	}
}
