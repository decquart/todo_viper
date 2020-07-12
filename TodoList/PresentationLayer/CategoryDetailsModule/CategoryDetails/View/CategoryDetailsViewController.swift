//
//  CategoryDetailsViewController.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 01.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

enum Scope<Model> {
	case create
	case edit(model: Model)
}

class CategoryDetailsViewController: UIViewController {
	static let identifire = "categoryDetailsVC"
	var presenter: CategoryDetailsOutput!
	var scope: Scope<CategoryViewModel>!

	private var viewModel: CategoryViewModel {
		if case let .edit(category) = scope {
			return category
		}

		return CategoryViewModel()
	}

	//todo: get rid
	private var imagePath: String = ""
	private var color: UIColor! {
		didSet {
			categoryIconImageView.tintColor = color
		}
	}

	private lazy var saveBarButton: UIBarButtonItem = {
		return UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonPressed))
	}()

	@IBOutlet weak private var redSlider: UISlider!
	@IBOutlet weak private var greenSlider: UISlider!
	@IBOutlet weak private var blueSlider: UISlider!

	@IBOutlet weak private var categoryIconImageView: UIImageView!
	@IBOutlet weak private var titleTextField: UITextField!

	var iconPickerView: UIView! {
		didSet {
			self.view.addSubview(iconPickerView)

			iconPickerView.translatesAutoresizingMaskIntoConstraints = false

			iconPickerView.topAnchor.constraint(equalTo: blueSlider.bottomAnchor, constant: 20).isActive = true
			iconPickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
			iconPickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
			iconPickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -160).isActive = true
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

// MARK: - IBActions
extension CategoryDetailsViewController {
	@IBAction func sliderValueDidChange(_ sender: UISlider) {
		color = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1)
	}

	@objc func saveButtonPressed() {
		guard let name = titleTextField.text, !name.isEmpty else {
			return
		}

		var category = viewModel
		category.name = name
		category.imagePath = imagePath
		category.color = color
		presenter.saveButtonPressed(with: category)
	}
}

// MARK: - CategoryDetailsInput
extension CategoryDetailsViewController: CategoryDetailsInput {
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
		color = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
		self.imagePath = "shopping"
	}

	func setupAppearance(with existingCategory: CategoryViewModel) {
		titleTextField.text = existingCategory.name
		categoryIconImageView.image = existingCategory.image
		color = existingCategory.color

		redSlider.value = Float(CIColor(color: color).red)
		greenSlider.value = Float(CIColor(color: color).green)
		blueSlider.value = Float(CIColor(color: color).blue)

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
