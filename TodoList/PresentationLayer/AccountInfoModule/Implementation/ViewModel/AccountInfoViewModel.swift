//
//  AccountInfoViewModel.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 16.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

class AccountInfoViewModel: AccountInfoViewModelProtocol {
	var router: AccountInfoRouterProtocol!
	var keychain: KeychainProtocol!

	func saveName(_ name: String) {
		let data = Data(name.utf8)
		_ = keychain.save(data: data, for: .username)
	}

	func saveEmail(_ email: String) {
		let data = Data(email.utf8)
		_ = keychain.save(data: data, for: .password)
	}
}
