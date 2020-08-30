//
//  SettingsModule.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 14.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class SettingsModule {
	func build(onAccount: Completion?, onTheme: Completion?, onLogOut: Completion?) -> UIViewController {
		let view = SettingsViewController.instantiate(storyboard: .settings)
		let viewModel = SettingsVM(session: UserSession.default)
		viewModel.onAccount = onAccount
		viewModel.onTheme = onTheme
		viewModel.onLogOut = onLogOut
		view.viewModel = viewModel
		return view
	}
}
