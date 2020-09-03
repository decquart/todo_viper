//
//  AccountInfoViewModelProtocol.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 16.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

protocol AccountInfoViewModelProtocol: class {
	var repository: AnyRepository<User> { get }

	var username: Box<String> { get }
	var email: Box<String> { get }
	var userImage: Box<Data?> { get }

	func viewDidLoad()
	func saveUserImage(_ imageData: Data?)
}
