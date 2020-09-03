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
		let repository = CDUserRepository(coreDataStack: CoreDataStackHolder.shared.coreDataStack)
		let viewModel = AccountInfoViewModel(repository: repository, currentUserName: UserSession.default.currentUser!)
		view.viewModel = viewModel
		return view
	}
}
