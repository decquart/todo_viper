//
//  CategoryDetailsViewController.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 01.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class CategoryDetailsViewController: UIViewController {
	var presenter: CategoryDetailsPresenterProtocol!
	var scope: Scope<CategoryViewModel>!

	private var viewModel: CategoryViewModel {
		if case let .edit(category) = scope {
			return category
		}

		return CategoryViewModel()
	}

	//todo: get rid
	private var imagePath: String = ""
	private var color: Color! {
		didSet {
			categoryIconImageView.tintColor = color?.uiColor
		}
	}

	private lazy var saveBarButton: UIBarButtonItem = {
		return UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonPressed))
	}()

	@IBOutlet weak private var categoryIconImageView: UIImageView!
	@IBOutlet weak private var titleTextField: UITextField!

	var colorPickerView: UIView! {
		didSet {
			self.view.addSubview(colorPickerView)

			colorPickerView.translatesAutoresizingMaskIntoConstraints = false
			colorPickerView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20).isActive = true
			colorPickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
			colorPickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
			//TODO
			colorPickerView.heightAnchor.constraint(lessThanOrEqualToConstant: 120).isActive = true
		}
	}

	var iconPickerView: UIView! {
		didSet {
			self.view.addSubview(iconPickerView)

			iconPickerView.translatesAutoresizingMaskIntoConstraints = false
			iconPickerView.topAnchor.constraint(equalTo: colorPickerView.bottomAnchor, constant: 20).isActive = true
			iconPickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
			iconPickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
			iconPickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
		}
	}

	override func viewDidLoad() {
        super.viewDidLoad()
		setupGestureRecognizer()
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		initAppearance()
	}
}

// MARK: - Handlers
extension CategoryDetailsViewController {
	@objc func saveButtonPressed() {
		guard let name = titleTextField.text, !name.isEmpty else {
			return
		}

		var category = viewModel
		category.name = name
		category.imagePath = imagePath
		category.colorName = color.rawValue

		presenter.saveButtonPressed(with: category)
	}
}

// MARK: - CategoryDetailsInput
extension CategoryDetailsViewController: CategoryDetailsViewProtocol {
	var isNewCategory: Bool {
		if case .create = scope {
			return true
		}

		return false
	}

	func refreshIcon(_ imagePath: String) {
		self.imagePath = imagePath
		categoryIconImageView.image = UIImage(named: imagePath)?.withRenderingMode(.alwaysTemplate)
	}

	func refreshColor(_ color: Color) {
		self.color = color
	}
}

// MARK: - Appearance
extension CategoryDetailsViewController {
	func initAppearance() {
		navigationItem.rightBarButtonItem = saveBarButton

		switch scope {
		case .edit(let category):
			setupAppearance(with: category)
		default:
			setupDefaultAppearance()
		}
	}

	func setupDefaultAppearance() {
		categoryIconImageView.image = UIImage(named: "shopping")
		self.imagePath = "shopping"
	}

	func setupAppearance(with existingCategory: CategoryViewModel) {
		titleTextField.text = existingCategory.name
		categoryIconImageView.image = existingCategory.image

		self.color = existingCategory.color
		self.imagePath = existingCategory.imagePath
	}
}

// MARK: - GestureRecognizer
extension CategoryDetailsViewController {
	func setupGestureRecognizer() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
