//
//  TaskListRouterProtocol.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 14.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol TaskListRouterProtocol {
	var view: TaskListViewProtocol! { get }
	func showSubTaskDetailsViewController(category: Category, scope: Scope<TaskViewModel>)
}
