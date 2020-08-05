//
//  RouterType.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 29.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

typealias Completion = () -> Void

protocol Routable: class, Presentable {
	func present(_ module: Presentable?, animated: Bool, completion: Completion?)
	func push(_ module: Presentable?, animated: Bool, completion: Completion?)
	func pop(animated: Bool)
	func dismiss(animated: Bool, completion: Completion?)
	func setRootModule(_ module: Presentable?, hideBar: Bool, animated: Bool)
	func popToRoot(animated: Bool)
	func appendToTabBar(_ vc: UIViewController)
}

extension Routable {
	func present(_ module: Presentable?) {
		self.present(module, animated: true)
	}

	func present(_ module: Presentable?, animated: Bool) {
		self.present(module, animated: animated, completion: nil)
	}

	func push(_ module: Presentable?) {
		self.push(module, animated: true)
	}

	func push(_ module: Presentable?, animated: Bool) {
		self.push(module, animated: animated, completion: nil)
	}

	func pop() {
		self.pop(animated: true)
	}

	func dismiss() {
		self.dismiss(animated: true, completion: nil)
	}

	func setRootModule(_ module: Presentable?, animated: Bool) {
		self.setRootModule(module, hideBar: false, animated: animated)
	}
}
