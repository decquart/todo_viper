//
//  LoginInteractor.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 26.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation
import GoogleSignIn

enum LoginError {
	case emptyUserName
	case emptyPassword
	case invalidUserName
	case invalidPassword
}

final class LoginInteractor: NSObject {
	private let repository: AnyRepository<User>
	private let keychain: KeychainProtocol
	weak var output: LoginInteractorOutput?
	private let userSession: UserSessionProtocol
	var googleSignInService: GoogleSignInServiceProtocol?

	init(repository: AnyRepository<User>, keychain: KeychainProtocol, userSession: UserSessionProtocol) {
		self.repository = repository
		self.keychain = keychain
		self.userSession = userSession
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

	func signInWithGoogle() {
		googleSignInService?.signIn()
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

				if isValidPassword {
					self.userSession.logIn(credentials.name)
					self.output?.loginSuccess()
				} else {
					self.output?.loginFailure(error: .invalidPassword)
				}

				return
			}

			self.output?.loginFailure(error: .invalidUserName)
		}
	}
}

//MARK: - GIDSignInDelegate
extension LoginInteractor: GIDSignInDelegate {
	func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
		if let error = error {
			print("\(error.localizedDescription)")
			return
		}

		//todo: Handle duplicates
		repository.add(User(name: user.profile.name, email: user.profile.email)) { [weak self] success in
			guard let self = self else { return }

			if success {
				self.userSession.logIn(user.profile.name)
				self.output?.loginSuccess()
			}
		}
	}
}
