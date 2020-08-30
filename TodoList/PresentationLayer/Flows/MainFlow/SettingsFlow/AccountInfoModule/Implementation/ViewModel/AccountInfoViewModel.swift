//
//  AccountInfoViewModel.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 16.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

class AccountInfoViewModel: AccountInfoViewModelProtocol {
	private(set) var keychain: KeychainProtocol
	private(set) var settings: AccountSettingsServiceProtocol

	private(set) var username: Box<String> = Box("")
	private(set) var email: Box<String> = Box("")
	private(set) var userImage: Box<Data?> = Box(nil)

	init(keychain: KeychainProtocol, settings: AccountSettingsServiceProtocol) {
		self.keychain = keychain
		self.settings = settings
	}

	func viewDidLoad() {
//		username.value = keychain.load(for: .username) ?? ""
//		email.value = keychain.load(for: .email) ?? ""
		userImage.value = settings.userImage
	}

	func saveName(_ name: String) {
//		if keychain.save(name, for: .username) {
//			username.value = name
//		}
	}

	func saveEmail(_ value: String) {
//		if keychain.save(value, for: .email) {
//			email.value = value
//		}
	}

	func saveUserImage(_ imageData: Data?) {
		settings.userImage = imageData
		userImage.value = settings.userImage
	}
}
