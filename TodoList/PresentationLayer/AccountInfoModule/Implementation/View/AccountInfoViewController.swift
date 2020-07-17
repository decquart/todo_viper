//
//  AccountInfoViewController.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 16.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class AccountInfoViewController: UIViewController {
	static let identifire = "accountInfo"
	var viewModel: AccountInfoViewModelProtocol!
	@IBOutlet weak var profileImageView: UIImageView! {
		didSet {
			profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
			profileImageView.layer.borderColor = UIColor.systemGray.cgColor
			profileImageView.layer.borderWidth = 2
		}
	}

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
    }

	@IBAction func saveNameButtonPressed(_ sender: Any) {
		//TODO
		viewModel.saveName("some name")
	}

	@IBAction func saveEmailButtonPressed(_ sender: Any) {
		//TODO
		viewModel.saveName("some email")
	}
}

extension AccountInfoViewController: AccountInfoViewProtocol {

}
