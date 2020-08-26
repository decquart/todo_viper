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

	var onFinish: (() -> Void)?

	init(view: LoginViewProtocol) {
		self.view = view
	}
}

//MARK: - LoginPresenterProtocol
extension LoginPresenter: LoginPresenterProtocol {
	func loginButtonPressed(with username: String?, and password: String?) {
		
	}

	func skipButtonPressed() {
		onFinish?()
	}
}
