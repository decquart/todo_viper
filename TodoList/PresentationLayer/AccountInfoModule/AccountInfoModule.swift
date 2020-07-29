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
		let router = AccountInfoRouter()
		let viewModel = AccountInfoViewModel(router: router,
											 keychain: Keychain(),
											 settings: SettingsService.shared)
		view.viewModel = viewModel
		router.view = view
		return view
	}
}
