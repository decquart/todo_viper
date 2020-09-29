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

		guard let user = fetchUser(by: userName) else {
			self.output?.loginFailure(error: .invalidUserName)
			return
		}

		if isValid(password, for: user) {
			self.userSession.logIn(user.name)
			self.output?.loginSuccess()
		} else {
			self.output?.loginFailure(error: .invalidPassword)
		}
	}

	func signInWithGoogle() {
		googleSignInService?.signIn()
	}

	func skipLogin() {
		userSession.skipAuthorization()
		output?.loginSuccess()
	}
}

//MARK: - Helpers
private extension LoginInteractor {

	func isValid(_ password: String, for user: User) -> Bool {
		guard let validPassword = self.keychain.loadPassword(for: user.name) else {
			return false
		}

		return password == validPassword
	}

	func fetchUser(by name: String) -> User? {
		var user: User?

		let predicate = NSPredicate(format: "name = %@", name)
		let semaphore = DispatchSemaphore(value: 0)

		repository.fetch(where: predicate) { result in
			if case let .success(users) = result, let fetchedUser = users.first, fetchedUser.name == name {
				user = fetchedUser
			}

			semaphore.signal()
		}

		_ = semaphore.wait(timeout: .distantFuture)
		return user
	}

	func addNewUser(_ user: User) {
		self.repository.add(user) { [weak self] success in
			if success {
				self?.userSession.logIn(user.name)
				self?.output?.loginSuccess()
			}
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

		guard let fetchedUser = fetchUser(by: user.profile.name) else {
			addNewUser(user.profile.mapToModel)
			return
		}

		self.userSession.logIn(fetchedUser.name)
		self.output?.loginSuccess()
	}
}
