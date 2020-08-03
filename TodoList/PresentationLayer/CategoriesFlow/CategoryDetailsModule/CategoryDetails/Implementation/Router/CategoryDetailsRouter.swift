//
//  CategoryDetailsRouter.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 13.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

class CategoryDetailsRouter: CategoryDetailsRouterProtocol {
	weak var view: CategoryDetailsViewProtocol!

	func popToRoot() {
		view.navigationController?.popToRootViewController(animated: true)
	}
}
