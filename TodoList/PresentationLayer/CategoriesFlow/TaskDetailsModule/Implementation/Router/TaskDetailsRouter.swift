//
//  TaskDetailsRouter.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 14.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

class TaskDetailsRouter: TaskDetailsRouterProtocol {
	private(set) weak var view: TaskDetailsViewProtocol?

	init(view: TaskDetailsViewProtocol) {
		self.view = view
	}

	func pop() {
		view?.navigationController?.popViewController(animated: true)
	}
}
