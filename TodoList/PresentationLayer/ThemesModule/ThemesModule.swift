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
		let storyboard = UIStoryboard(name: "Themes", bundle: nil)
		let view = storyboard.instantiateViewController(withIdentifier: ThemesViewController.identifire) as! ThemesViewController
		let viewModel = ThemesViewModel(themeService: SettingsService.shared)
		view.viewModel = viewModel
		return view
	}
}
