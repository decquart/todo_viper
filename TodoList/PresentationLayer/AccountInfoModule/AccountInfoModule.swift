//
//  AccountInfoModule.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 16.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class AccountInfoModule {
	func build() -> UIViewController {
		let storyboard = UIStoryboard(name: "AccountInfo", bundle: nil)
		let view = storyboard.instantiateViewController(withIdentifier: AccountInfoViewController.identifire) as! AccountInfoViewController
		let viewModel = AccountInfoViewModel()
		let router = AccountInfoRouter()
		let keychainService = Keychain()
		let settingsService = SettingsService()
		view.viewModel = viewModel
		viewModel.router = router
		viewModel.keychain = keychainService
		viewModel.settings = settingsService
		router.view = view
		return view
	}
}
