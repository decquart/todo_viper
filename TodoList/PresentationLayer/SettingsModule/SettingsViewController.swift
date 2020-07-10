//
//  SettingsViewController.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 10.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
	static let identifire = "settingsVC"
	@IBOutlet weak var tableView: UITableView! {
		didSet {
			tableView.delegate = self
			tableView.dataSource = self
			tableView.register(cellType: SettingsTableViewCell.self)
		}
	}

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		1
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeue(cellType: SettingsTableViewCell.self, for: indexPath)
		cell.textLabel?.text = "Theme"
		return cell
	}
}
