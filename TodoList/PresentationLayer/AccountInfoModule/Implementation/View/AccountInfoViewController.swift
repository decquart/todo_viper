//
//  AccountInfoViewController.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 16.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class AccountInfoViewController: UIViewController, AccountInfoViewProtocol {
	static let identifire = "accountInfo"
	var viewModel: AccountInfoViewModelProtocol! {
		didSet {
			viewModel.username.bind { [unowned self] in
				self.usernameLabel?.text = $0
			}

			viewModel.email.bind { [unowned self] in
				self.emailLabel?.text = $0
			}
		}
	}

	@IBOutlet weak var profileImageView: UIImageView! {
		didSet {
			profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
			profileImageView.layer.borderColor = UIColor.systemGray.cgColor
			profileImageView.layer.borderWidth = 2
		}
	}

	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var usernameLabel: UILabel!
	@IBOutlet weak var emailLabel: UILabel!

	@IBOutlet weak var saveNameButton: UIButton! {
		didSet {
			saveNameButton.layer.cornerRadius = 6
		}
	}

	@IBOutlet weak var saveEmailButton: UIButton! {
		didSet {
			saveEmailButton.layer.cornerRadius = 6
		}
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		viewModel.viewDidLoad()
    }

	@IBAction func saveNameButtonPressed(_ sender: Any) {
		guard let name = nameTextField.text else {
			return
		}

		viewModel.saveName(name)
	}

	@IBAction func saveEmailButtonPressed(_ sender: Any) {
		guard let email = emailTextField.text else {
			return
		}

		viewModel.saveEmail(email)
	}
}
