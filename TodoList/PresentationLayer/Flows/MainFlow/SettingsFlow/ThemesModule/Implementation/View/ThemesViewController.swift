//
//  ThemesViewController.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 16.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class ThemesViewController: UIViewController {
	@IBOutlet weak var darkModeSwitch: UISwitch!
	@IBOutlet weak var darkModeStatusLabel: UILabel!

	var presenter: ThemesPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

		navigationItem.title = "Select Theme"
		presenter.didLoad()
    }

	@IBAction func darkModeSwitchChanged(_ sender: UISwitch) {
		presenter.setDarkMode(sender.isOn)
	}
}

//MARK: - ThemesViewProtocol
extension ThemesViewController: ThemesViewProtocol {
	func updateDarkModeSwitch(_ isOn: Bool) {
		self.darkModeSwitch?.setOn(isOn, animated: false)
		self.darkModeStatusLabel?.text = isOn ? "Enabled" : "Disabled"
	}
}
