//
//  LoginPresenter.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 21.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

class LoginPresenter: LoginPresenterProtocol {
	weak var view: LoginViewProtocol!

	init(view: LoginViewProtocol) {
		self.view = view
	}
}
