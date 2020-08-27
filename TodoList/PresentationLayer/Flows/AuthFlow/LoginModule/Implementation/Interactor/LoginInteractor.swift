//
//  LoginInteractor.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 26.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

enum LoginError {
	case emptyUserName(message: String)
	case emptyPassword(message: String)
	case invalidUserName(message: String)
	case invalidPassword(message: String)
}

class LoginInteractor {
	private let userManager: UserManager
	var output: LoginInteractorOutput?

	init(userManager: UserManager) {
		self.userManager = userManager
	}
}

//MARK: - LoginInteractorInput
extension LoginInteractor: LoginInteractorInput {
	func login(with userName: String?, and password: String?) {
		guard let userName = userName, !userName.isEmpty else {
			output?.loginFailure(error: .emptyUserName(message: "Empty Login!"))
			return
		}

		guard let password = password, !password.isEmpty else {
			output?.loginFailure(error: .emptyPassword(message: "Empty Password!"))
			return
		}

		output?.loginSuccess()
	}
}
