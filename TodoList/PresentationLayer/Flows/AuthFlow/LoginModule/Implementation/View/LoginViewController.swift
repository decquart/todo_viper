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

	@IBOutlet weak var loginView: UIView! {
		didSet {
			loginView.layer.cornerRadius = loginView.frame.width / 8
		}
	}

	@IBOutlet weak var loginButton: UIButton! {
		didSet {
			loginButton.layer.cornerRadius = loginButton.frame.height / 2
		}
	}

	@IBOutlet weak var skipButton: UIButton! {
		didSet {
			skipButton.layer.cornerRadius = skipButton.frame.height / 2
		}
	}

	@IBOutlet weak var usernameTextField: UITextField!
	@IBOutlet weak var passwordTexrField: UITextField!

	override func viewDidLoad() {
        super.viewDidLoad()

		view.applyGradient(for: .login(startPoint: .zero, endPoint: CGPoint(x: 0.8, y: 0.8)))
    }

	@IBAction func loginButtonPressed(_ sender: Any) {
		presenter.loginButtonPressed(with: usernameTextField.text, and: passwordTexrField.text)
	}

	@IBAction func skipButtonPressed(_ sender: Any) {
		presenter.skipButtonPressed()
	}
}

extension LoginViewController: LoginViewProtocol {
	
}
