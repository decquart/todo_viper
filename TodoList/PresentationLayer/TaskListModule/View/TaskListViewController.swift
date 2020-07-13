//
//  TaskListViewController.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController {

	static let identifire = "taskVC"
	var presenter: TaskListViewOutput!

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

		presenter.loadTasks()
	}
}

// MARK: - TaskListViewInput
extension TaskListViewController: TaskListViewInput {
	func refreshTasks() {
		tableView.reloadData()
	}
}

// MARK: - Selectors
extension TaskListViewController {
	@objc func completeAll() {
		presenter.didCompleteAll()
	}
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows()
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeue(cellType: TaskCell.self, for: indexPath)
		let task = presenter.task(at: indexPath)

		cell.configure(with: task) { [weak self] in
			self?.presenter.buttonCompletePressed(at: indexPath.row)
		}

		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		presenter.didSelect(at: indexPath)
	}
}

extension TaskListViewController {
	@IBAction func addButtonPressed(_ sender: UIButton) {
		presenter.addButtonPressed()
	}
}
