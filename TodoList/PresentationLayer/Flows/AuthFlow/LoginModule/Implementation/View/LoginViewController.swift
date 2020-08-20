//
//  LoginViewController.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 21.08.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
	var presenter: LoginPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension LoginViewController: LoginViewProtocol {
	
}
