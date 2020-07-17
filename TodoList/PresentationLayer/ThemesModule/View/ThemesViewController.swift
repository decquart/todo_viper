//
//  ThemesViewController.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 16.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class ThemesViewController: UIViewController {
	static let identifire = "themesVC"
    override func viewDidLoad() {
        super.viewDidLoad()

		navigationItem.title = "Select Theme"
    }
	@IBAction func buttonPressed(_ sender: Any) {
		UIApplication.shared.windows.forEach { $0.tintColor = .red }
	}
}
