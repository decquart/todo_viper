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
		let repository = CDUserRepository(coreDataStack: CoreDataStackHolder.shared.coreDataStack)
		let presenter = SettingsPresenter(repository: repository, session: UserSession.default)
		presenter.onAccount = onAccount
		presenter.onTheme = onTheme
		presenter.onLogOut = onLogOut
		view.presenter = presenter
		return view
	}
}
