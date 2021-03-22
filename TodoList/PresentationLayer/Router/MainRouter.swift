//
//  Router.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 29.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

final class MainRouter: Routable {

	lazy var rootViewController: UINavigationController = {
		let navigationController = UINavigationController()
		navigationController.navigationBar.prefersLargeTitles = true
		return navigationController
	}()

	func present(_ module: UIViewController, animated: Bool, completion: Completion?) {
		self.rootViewController.present(module, animated: animated, completion: completion)
	}

	func push(_ module: UIViewController, animated: Bool, completion: Completion?) {
		if module is UINavigationController {
			assertionFailure("Can not push navigation controller")
			return
		}

		self.rootViewController.pushViewController(module, animated: animated)
	}

	func pop(animated: Bool) {
		self.rootViewController.popViewController(animated: animated)
	}

	func dismiss(animated: Bool, completion: Completion?) {
		self.rootViewController.dismiss(animated: animated, completion: completion)
	}

	func setRootModule(_ module: UIViewController, hideBar: Bool, animated: Bool) {
		self.rootViewController.setViewControllers([module], animated: animated)
		self.rootViewController.isNavigationBarHidden = hideBar
	}

	func popToRoot(animated: Bool) {
		self.rootViewController.popViewController(animated: animated)
	}
}
