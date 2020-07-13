//
//  CategoryDetailsRouterProtocol.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 13.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol CategoryDetailsRouterProtocol {
	var view: CategoryDetailsViewProtocol! { get }
	func popToRoot()
}
