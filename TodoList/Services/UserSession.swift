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
	func skipAuthorization()
}

final class UserSession: UserSessionProtocol {
	private init() {}
	static let `default` = UserSession()

	private enum SessionState {
		case notAuthorized
		case loggedIn
		case skipped
	}

	private var state: SessionState = .notAuthorized

	var isAuthorized: Bool {
		return state == .loggedIn || state == .skipped
	}

	func logIn(_ userName: String) {
		state = .loggedIn
		currentUser = userName
	}

	func logOut() {
		state = .notAuthorized
		currentUser = nil
	}

	func skipAuthorization() {
		state = .skipped
	}

	var currentUser: String? {
		get { UserDefaults.standard[#function] }
		set { UserDefaults.standard[#function] = newValue }
	}
}
