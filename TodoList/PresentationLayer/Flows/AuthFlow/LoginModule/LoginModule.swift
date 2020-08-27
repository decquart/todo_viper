//
//  LoginModule.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 21.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class LoginModule {
	func build(onFinish: (() -> Void)?) -> UIViewController {
		let view = LoginViewController.instantiate(storyboard: .login)
		let interactor = LoginInteractor(keychain: Keychain())
		let presenter = LoginPresenter(view: view, interactor: interactor)
		view.presenter = presenter
		presenter.onFinish = onFinish
		interactor.output = presenter

		return view
	}
}
