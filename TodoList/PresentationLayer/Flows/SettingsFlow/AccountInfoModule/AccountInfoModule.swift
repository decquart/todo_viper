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
		let view = AccountInfoViewController.instantiate(storyboard: .accountInfo)
		let viewModel = AccountInfoViewModel(keychain: Keychain(),
											 settings: SettingsService.shared)
		view.viewModel = viewModel
		return view
	}
}
