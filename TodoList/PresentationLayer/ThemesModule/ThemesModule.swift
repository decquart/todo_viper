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
		let viewModel = ThemesViewModel(themeService: SettingsService.shared)
		view.viewModel = viewModel
		return view
	}
}
