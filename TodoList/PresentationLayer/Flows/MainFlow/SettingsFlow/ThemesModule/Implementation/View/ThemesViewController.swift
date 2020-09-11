//
//  ThemesViewController.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 16.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class ThemesViewController: UIViewController {
	var presenter: ThemesPresenterProtocol!
	var colorPickerView: UIView!

	@IBOutlet weak private var colorPickerContainerView: UIView!
	lazy var applyButton = {
		UIBarButtonItem(title: "Apply", style: .done, target: self, action: #selector(apply))
	}()

    override func viewDidLoad() {
        super.viewDidLoad()

		navigationItem.title = "Select Theme"
		navigationItem.rightBarButtonItem = applyButton

		if let colorView = colorPickerView {
			colorPickerContainerView.add(colorView)
		}
    }

	@objc func apply() {
		presenter.applyTheme()
	}
}

//MARK: - ThemesViewProtocol
extension ThemesViewController: ThemesViewProtocol {
	func updateButtonState() {
		//todo
	}
}
