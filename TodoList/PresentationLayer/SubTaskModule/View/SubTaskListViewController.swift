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

	@IBOutlet weak var tableView: UITableView!

	override func viewDidLoad() {
        super.viewDidLoad()

		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Complete All", style: .plain, target: self, action: #selector(completeAll))
        tableView.reloadData()
    }
}

//MARK: - SubTaskListViewInput
extension SubTaskListViewController: SubTaskListViewInput {
	func refreshSubTasks() {
		tableView.reloadData()
	}
}

//MARK: - Selectors
extension SubTaskListViewController {
	@objc func completeAll() {
		presenter.didCompleteAll()
	}
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension SubTaskListViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows(in: section)
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: SubTaskCell.identifire, for: indexPath) as? SubTaskCell, let subTask = presenter.subTask(at: indexPath) else {
			return UITableViewCell()
		}

		cell.configure(with: subTask)
		cell.buttonPressedClosure = { [weak self] in
			self?.presenter.buttonCompletePressed(at: indexPath)
		}
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		presenter.didSelect()
	}
}

//MARK: - UIAlertController
extension SubTaskListViewController {

	@IBAction func addButtonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: "Add new sub task", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Name"
        }

        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            guard let name = alert.textFields?.first?.text, !name.isEmpty else {
                return
            }

			let viewModel = SubTaskViewModel(description: name)
			self.presenter.addSubTask(with: viewModel)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .default)

        alert.addAction(cancelAction)
        alert.addAction(saveAction)

        present(alert, animated: true)
	}
}

//MARK: - SubTaskListAdapterView
extension SubTaskListViewController: SubTaskListAdapterView {
	func beginUpdates() {
		tableView.beginUpdates()
	}

	func endUpdates() {
		tableView.endUpdates()
	}

	func insertRows(at newIndexPaths: [IndexPath]) {
		tableView.insertRows(at: newIndexPaths, with: .automatic)
	}

	func deleteRows(at indexPaths: [IndexPath]) {
		tableView.deleteRows(at: indexPaths, with: .automatic)
	}

	func updateRows(at indexPaths: [IndexPath]) {
		tableView.reloadRows(at: indexPaths, with: .automatic)
	}

	func moveRow(from indexPath: IndexPath?, to newIndexPath: IndexPath?) {
		tableView.deleteRows(at: [indexPath!], with: .fade)
		tableView.insertRows(at: [newIndexPath!], with: .fade)
		tableView.reloadData()
	}
}
