//
//  AccountInfoViewController.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 16.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class AccountInfoViewController: UIViewController, AccountInfoViewProtocol {
	var viewModel: AccountInfoViewModelProtocol! {
		didSet {
			viewModel.username.bind { [unowned self] in
				self.usernameLabel?.text = $0
			}

			viewModel.email.bind { [unowned self] in
				self.emailLabel?.text = $0
			}

			viewModel.userImage.bind { [unowned self] in
				guard let data = $0 else {
					self.profileImageView?.image = UIImage(named: "default_placeholder")
					return
				}

				self.profileImageView?.image = UIImage(data: data)
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

	var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
		viewModel.viewDidLoad()
    }

	@IBAction func selectImageButtonPressed() {

        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            present(imagePicker, animated: true, completion: nil)
        }
    }
}

// MARK: - UINavigationControllerDelegate, UIImagePickerControllerDelegate
extension AccountInfoViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

		if let image = info[.originalImage] as? UIImage {
			self.viewModel.saveUserImage(image.pngData())
		}

		self.dismiss(animated: true)
	}
}
