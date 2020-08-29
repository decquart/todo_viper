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

	@IBOutlet private weak var loginView: UIView! {
		didSet {
			loginView.layer.cornerRadius = loginView.frame.width / 8
		}
	}

	@IBOutlet private weak var loginButton: UIButton! {
		didSet {
			loginButton.clipsToBounds = true
			loginButton.layer.cornerRadius = loginButton.frame.height / 2
			loginButton.applyGradient(for: .login(startPoint: .zero, endPoint: CGPoint(x: 0.6, y: 0.6)))
		}
	}

	@IBOutlet private weak var skipButton: UIButton! {
		didSet {
			skipButton.clipsToBounds = true
			skipButton.layer.cornerRadius = skipButton.frame.height / 2
			skipButton.applyGradient(for: .login(startPoint: .zero, endPoint: CGPoint(x: 0.6, y: 0.6)))
		}
	}

	@IBOutlet weak var signUpButton: UIButton! {
		didSet {
			signUpButton.layer.cornerRadius = signUpButton.frame.height / 2
			signUpButton.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
			signUpButton.setTitleColor(UIColor(red: 25/255, green: 104/255, blue: 231/255, alpha: 1), for: .normal)
		}
	}

	@IBOutlet private weak var usernameTextField: UITextField! {
		didSet {
			usernameTextField.delegate = self
			usernameTextField.addTarget(self, action: #selector(removePlaceholderMessage(_:)), for: .editingChanged)

		}
	}

	@IBOutlet private weak var passwordTexrField: UITextField! {
		didSet {
			passwordTexrField.delegate = self
			passwordTexrField.addTarget(self, action: #selector(removePlaceholderMessage(_:)), for: .editingChanged)
		}
	}

	override func viewDidLoad() {
        super.viewDidLoad()

		view.applyGradient(for: .login(startPoint: .zero, endPoint: CGPoint(x: 0.8, y: 0.8)))
    }

	@IBAction func loginButtonPressed(_ sender: Any) {
		presenter.login(with: usernameTextField.text, and: passwordTexrField.text)
	}

	@IBAction func skipButtonPressed(_ sender: Any) {
		presenter.skipLogin()
	}

	@IBAction func signUpButtonPressed(_ sender: Any) {
		presenter.register()
	}

	@objc func removePlaceholderMessage(_ textField: UITextField) {
		textField.placeholder = nil
	}

	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		view.endEditing(true)
	}
}

//MARK: - LoginViewProtocol
extension LoginViewController: LoginViewProtocol {
	func refreshUserNameTextField(with errorMessage: String) {
		usernameTextField.setErrorMessage(errorMessage)
	}

	func refreshPasswordTextField(with errorMessage: String) {
		passwordTexrField.setErrorMessage(errorMessage)
	}
}

//MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
	func textFieldDidBeginEditing(_ textField: UITextField) {
		removePlaceholderMessage(textField)
	}
}
