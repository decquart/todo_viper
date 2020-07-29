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
		let router = MainRouter()
		let presenter = MainPresenter(router: router, view: view)
		view.presenter = presenter
		return view
	}
}
