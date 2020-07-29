//
//  MainPresenter.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 13.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

class MainPresenter: MainPresenterProtocol {
	private(set) var router: MainRouterProtocol
	private(set) unowned var view: MainViewProtocol

	init(router: MainRouterProtocol, view: MainViewProtocol) {
		self.router = router
		self.view = view
	}

	func viewDidAppear() {
		view.setViewControllers(router.viewControllers())
	}
}
