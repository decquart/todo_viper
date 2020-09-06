//
//  SettingsViewController.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 10.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, SettingsViewProtocol {
	var presenter: SettingsPresenterProtocol!

	var onAccount: (() -> Void)?
	var onTheme: (() -> Void)?

	@IBOutlet weak var tableView: UITableView! {
		didSet {
			tableView.delegate = self
			tableView.dataSource = self
			tableView.registerNib(cellType: SettingsTableViewCell.self)
			tableView.registerNib(cellType: UserInfoTableViewCell.self)
			tableView.registerNib(cellType: EmailTableViewCell.self)
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		presenter.viewDidLoad()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.navigationController?.navigationBar.topItem?.title = "Settings"
	}
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return presenter.numberOfRows(in: section)
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return presenter.numberOfSections
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let section = presenter.sectionInfo(at: indexPath.section)

		switch section.type {
		case .userInfo:
			let cell = tableView.dequeue(cellType: UserInfoTableViewCell.self, for: indexPath)
			cell.configure(with: section, and: indexPath.row)
			return cell
		case .email:
			let cell = tableView.dequeue(cellType: EmailTableViewCell.self, for: indexPath)
			cell.configure(with: section, and: indexPath.row)
			return cell
		default:
			return UITableViewCell()
		}

		return UITableViewCell()
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		presenter.didSelectTableViewCell(at: indexPath.row)
		tableView.deselectRow(at: indexPath, animated: true)
	}

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return presenter.titleForHeader(at: section)
	}

	func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
		let header = view as? UITableViewHeaderFooterView
		header?.textLabel?.text = presenter.titleForHeader(at: section)
	}
}
