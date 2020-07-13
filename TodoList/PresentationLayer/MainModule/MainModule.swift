//
//  MainModule.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 13.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

final class MainModule {
	func build() -> UIViewController {
		let view = MainView()
		let presenter = MainPresenter()
		let router = MainRouter()
		view.presenter = presenter
		presenter.view = view
		presenter.router = router
		router.view = view
		return view
	}
}
