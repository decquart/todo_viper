//
//  TaskDetailsRouterProtocol.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 14.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol TaskDetailsRouterProtocol {
	var view: TaskDetailsViewProtocol? { get }
	func pop()
}
