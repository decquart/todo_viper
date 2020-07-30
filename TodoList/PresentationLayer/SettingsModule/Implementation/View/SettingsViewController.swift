//
//  SettingsViewController.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 10.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
	var viewModel: SettingsVMProtocol!

	@IBOutlet weak var tableView: UITableView! {
		didSet {
			tableView.delegate = self
			tableView.dataSource = self
			tableView.registerNib(cellType: SettingsTableViewCell.self)
		}
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		navigationItem.title = "Settings"
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.numberOfRows
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeue(cellType: SettingsTableViewCell.self, for: indexPath)
		let vm = viewModel.viewModelCell(at: indexPath.row)
		cell.configure(with: vm)
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		viewModel?.didSelectTableViewCell(at: indexPath.row)
		tableView.deselectRow(at: indexPath, animated: true)
	}
}

// MARK: - SettingsViewProtocol
extension SettingsViewController: SettingsViewProtocol {

}
