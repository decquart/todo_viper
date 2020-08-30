//
//  ThemesViewController.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 16.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class ThemesViewController: UIViewController, ThemesViewProtocol {
	@IBOutlet weak var darkModeSwitch: UISwitch!
	@IBOutlet weak var darkModeStatusLabel: UILabel!

	var viewModel: ThemesViewModelProtocol! {
		didSet {
			viewModel.isDarkMode.bind { [unowned self] in
				self.darkModeSwitch?.setOn($0, animated: false)
				self.darkModeStatusLabel?.text = $0 ? "Enabled" : "Disabled"
			}
		}
	}

    override func viewDidLoad() {
        super.viewDidLoad()

		navigationItem.title = "Select Theme"
		viewModel.didLoad()
    }

	@IBAction func darkModeSwitchChanged(_ sender: UISwitch) {
		viewModel.setDarkMode(sender.isOn)
	}
}
