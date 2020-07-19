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

	var username: Box<String> = Box("")
	var email: Box<String> = Box("")

	func viewDidLoad() {
		username.value = keychain.load(for: .username) ?? ""
		email.value = keychain.load(for: .email) ?? ""
	}

	func saveName(_ name: String) {
		if keychain.save(name, for: .username) {
			username.value = name
		}
	}

	func saveEmail(_ value: String) {
		if keychain.save(value, for: .email) {
			email.value = value
		}
	}
}
