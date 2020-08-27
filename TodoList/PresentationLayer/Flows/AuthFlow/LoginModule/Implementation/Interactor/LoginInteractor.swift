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
	private let keychain: KeychainProtocol
	var output: LoginInteractorOutput?


	init(keychain: KeychainProtocol) {
		self.keychain = keychain
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

		validateCredentials(Credentials(name: userName, password: password))
	}
}


private extension LoginInteractor {

	func validateCredentials(_ credentials: Credentials) {

		//todo
		let repository: AnyRepository<User> = CDUserRepository(userName: credentials.name, coreDataStack: CoreDataStackHolder.shared.coreDataStack)

		repository.fetch { [weak self] result in
			guard let self = self else { return }

			if case let .success(users) = result, let user = users.first, user.name == credentials.name {
				let password = self.keychain.loadPassword(for: credentials.name)
				let isValidPassword = password == credentials.password

				isValidPassword
					? self.output?.loginSuccess()
					: self.output?.loginFailure(error: .invalidPassword(message: "Invalid Password!"))

				return
			}

			self.output?.loginFailure(error: .invalidUserName(message: "Invalid Username!"))
		}
	}
}
