//
//  AccountInfoViewModelProtocol.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 16.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

protocol AccountInfoViewModelProtocol: class {
	var router: AccountInfoRouterProtocol { get }
	var keychain: KeychainProtocol { get }
	var settings: AccountSettingsServiceProtocol { get }

	var username: Box<String> { get }
	var email: Box<String> { get }
	var userImage: Box<Data?> { get }

	func viewDidLoad()
	func saveName(_ name: String)
	func saveEmail(_ email: String)
	func saveUserImage(_ imageData: Data?)
}
