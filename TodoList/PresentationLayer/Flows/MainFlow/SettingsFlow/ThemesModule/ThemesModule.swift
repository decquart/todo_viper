//
//  ThemesModule.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 17.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class ThemesModule {
	func build() -> UIViewController {
		let view = ThemesViewController.instantiate(storyboard: .themes)
		let interactor = ThemesInteractor(themeService: SettingsService.shared)
		let presenter = ThemesPresenter(view: view, interactor: interactor)

		view.presenter = presenter
		interactor.output = presenter
		return view
	}
}
