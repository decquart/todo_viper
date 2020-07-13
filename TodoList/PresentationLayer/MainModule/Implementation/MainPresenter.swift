//
//  MainPresenter.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 13.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

class MainPresenter: MainPresenterProtocol {
	var router: MainRouterProtocol!
	weak var view: MainViewProtocol!

	func viewDidAppear() {
		view.viewControllers = router.viewControllers()
	}
}
