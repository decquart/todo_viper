//
//  LoginModule.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 21.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class LoginModule {
	func build() -> UIViewController {
		let view = LoginViewController.instantiate(storyboard: .login)
		let presenter = LoginPresenter(view: view)
		view.presenter = presenter
		
		return view
	}
}
