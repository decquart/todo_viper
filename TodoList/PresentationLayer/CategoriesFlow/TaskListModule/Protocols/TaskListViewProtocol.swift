//
//  TaskListViewProtocol.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 14.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

protocol TaskListViewProtocol: class {
	var navigationController: UINavigationController? { get }
	var presenter: TaskListPresenterProtocol! { get }
	func refreshTasks()
}
