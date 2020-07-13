//
//  MainPresenterProtocol.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 13.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol MainPresenterProtocol: class {
	var router: MainRouterProtocol! { get set }
	var view: MainViewProtocol! { get set }

	func viewDidAppear()
}
