//
//  UserSession.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 30.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

protocol UserSessionProtocol {
	var isAuthorized: Bool { get }
	var currentUser: String? { get }
	func logIn(_ userName: String)
	func logOut()
}

final class UserSession: UserSessionProtocol {
	private init() {}
	static let `default` = UserSession()

	var isAuthorized: Bool {
		guard let user = currentUser else {
			return false
		}

		return !user.isEmpty
	}

	func logIn(_ userName: String) {
		currentUser = userName
	}

	func logOut() {
		currentUser = nil
	}

	var currentUser: String? {
		get { UserDefaults.standard[#function] }
		set { UserDefaults.standard[#function] = newValue }
	}
}
