//
//  LoginInteractor.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 26.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

enum LoginError {
	case emptyUserName
	case emptyPassword
	case invalidUserName
	case invalidPassword
}

class LoginInteractor {
	private let repository: AnyRepository<User>
	private let keychain: KeychainProtocol
	weak var output: LoginInteractorOutput?

	init(repository: AnyRepository<User>, keychain: KeychainProtocol) {
		self.repository = repository
		self.keychain = keychain
	}
}

//MARK: - LoginInteractorInput
extension LoginInteractor: LoginInteractorInput {
	func login(with userName: String?, and password: String?) {
		guard let userName = userName, !userName.isEmpty else {
			output?.loginFailure(error: .emptyUserName)
			return
		}

		guard let password = password, !password.isEmpty else {
			output?.loginFailure(error: .emptyPassword)
			return
		}

		validateCredentials(Credentials(name: userName, password: password))
	}
}


private extension LoginInteractor {

	func validateCredentials(_ credentials: Credentials) {
		let predicate = NSPredicate(format: "name = %@", credentials.name)

		repository.fetch(where: predicate) { [weak self] result in
			guard let self = self else { return }

			if case let .success(users) = result, let user = users.first, user.name == credentials.name {
				let password = self.keychain.loadPassword(for: credentials.name)
				let isValidPassword = password == credentials.password

				isValidPassword
					? self.output?.loginSuccess()
					: self.output?.loginFailure(error: .invalidPassword)

				return
			}

			self.output?.loginFailure(error: .invalidUserName)
		}
	}
}
