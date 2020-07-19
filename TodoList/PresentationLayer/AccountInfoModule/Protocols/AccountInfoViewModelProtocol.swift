//
//  AccountInfoViewModelProtocol.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 16.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol AccountInfoViewModelProtocol: class {
	var router: AccountInfoRouterProtocol! { get }
	var keychain: KeychainProtocol! { get }

	var username: Box<String> { get }
	var email: Box<String> { get }

	func viewDidLoad()
	func saveName(_ name: String)
	func saveEmail(_ email: String)
}
