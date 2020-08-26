//
//  LoginPresenter.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 21.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

class LoginPresenter {
	weak var view: LoginViewProtocol!
	private var interactor: LoginInteractorInput

	var onFinish: (() -> Void)?

	init(view: LoginViewProtocol, interactor: LoginInteractorInput) {
		self.view = view
		self.interactor = interactor
	}
}

//MARK: - LoginPresenterProtocol
extension LoginPresenter: LoginPresenterProtocol {
	func loginButtonPressed(with username: String?, and password: String?) {
		interactor.login(with: username, and: password)
	}

	func skipButtonPressed() {
		onFinish?()
	}
}

//MARK: - LoginInteractorOutput
extension LoginPresenter: LoginInteractorOutput {
	func loginSuccess() {

	}

	func loginFailure(error: LoginError) {
		switch error {
		case .emptyUserName(let message):
			view.refreshUserNameTextField(with: message)
		case .emptyPassword(let message):
			view.refreshPasswordTextField(with: message)
		}
	}
}
