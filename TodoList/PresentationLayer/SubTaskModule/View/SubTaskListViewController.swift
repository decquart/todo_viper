//
//  SubTaskViewController.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit
import CoreData

class SubTaskListViewController: UIViewController {

	static let identifire = "subTaskVC"
	var presenter: SubTaskListViewOutput!
	var tempSubTask: String?

	@IBOutlet weak private var tableView: UITableView! {
		didSet {
			tableView.delegate = self
			tableView.dataSource = self
		}
	}

	override func viewDidLoad() {
        super.viewDidLoad()

		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Complete All", style: .plain, target: self, action: #selector(completeAll))
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		presenter.loadSubTasks()
	}
}

// MARK: - SubTaskListViewInput
extension SubTaskListViewController: SubTaskListViewInput {
	func refreshSubTasks() {
		tableView.reloadData()
	}
}

// MARK: - Selectors
extension SubTaskListViewController {
	@objc func completeAll() {
		presenter.didCompleteAll()
	}
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SubTaskListViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows()
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeue(cellType: SubTaskCell.self, for: indexPath)
		let subTask = presenter.subTask(at: indexPath)

		cell.configure(with: subTask)
		cell.buttonPressedClosure = { [weak self] in
			self?.presenter.buttonCompletePressed(at: indexPath.row)
		}

		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		presenter.didSelect(at: indexPath)
	}
}

extension SubTaskListViewController {
	@IBAction func addButtonPressed(_ sender: UIButton) {
		presenter.addButtonPressed()
	}
}
