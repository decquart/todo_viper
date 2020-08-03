//
//  RouterType.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 29.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

typealias Completion = () -> Void

protocol RouterType: class, Presentable {
	func present(_ module: Presentable?)
	func present(_ module: Presentable?, animated: Bool)
	func present(_ module: Presentable?, animated: Bool, completion: Completion?)

	func push(_ module: Presentable?)
	func push(_ module: Presentable?, animated: Bool)
	func push(_ module: Presentable?, animated: Bool, completion: Completion?)

	func pop()
	func pop(animated: Bool)

	func dismiss()
	func dismiss(animated: Bool, completion: Completion?)

	func setRootModule(_ module: Presentable?, animated: Bool)
	func setRootModule(_ module: Presentable?, hideBar: Bool, animated: Bool)

	func popToRoot(animated: Bool)

	func appendToTabBar(_ vc: UIViewController)
}
