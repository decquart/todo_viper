//
//  SubTaskViewController.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class SubTaskListViewController: UIViewController {

	static let identifire = "subTaskVC"
	var presenter: SubTaskListViewOutput!
	var tempSubTask: String?

	@IBOutlet weak var tableView: UITableView! {
		didSet {
			tableView.isEditing = true
		}
	}

	private var selectedCell: SubTaskCell? {
		didSet {
			selectedCell?.textField.becomeFirstResponder()
		}
	}

	override func viewDidLoad() {
        super.viewDidLoad()

		presenter.loadSubTasks()
    }
}

//MARK: - SubTaskListViewInput
extension SubTaskListViewController: SubTaskListViewInput {
	func refreshSubTasks() {
		tableView.reloadData()
	}
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension SubTaskListViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return presenter.subTasks?.count ?? 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: SubTaskCell.identifire, for: indexPath) as? SubTaskCell else {
			return UITableViewCell()
		}

		let subTask = presenter.subTasks?[indexPath.row]
		cell.textField.delegate = self
		cell.textField.text = subTask?.description
		cell.textField.returnKeyType = .next
	
		if subTask?.completed == true {
			tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
		}

		return cell
	}

	func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
		guard let cell = tableView.cellForRow(at: indexPath) as? SubTaskCell else {
			return nil
		}

		if (cell.textField.text ?? "").isEmpty {
			return nil
		}

		presenter.didSelect(index: indexPath.row)
		return indexPath
	}

	func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
		presenter.didSelect(index: indexPath.row)
	}
}

extension SubTaskListViewController {
	@objc func addEmptyCell() {
		presenter.subTasks?.append(SubTaskEntity(description: "", completed: false))

		let lastRowIndex = self.tableView.numberOfRows(inSection: 0) - 1
		let indexPath = IndexPath(row: lastRowIndex, section: 0)
		selectedCell = tableView.cellForRow(at: indexPath) as? SubTaskCell
	}

	func removeEmptyCell() {
		presenter.subTasks = presenter.subTasks?.filter { !$0.description.isEmpty }
		selectedCell = nil
	}

	@IBAction func addButtonPressed(_ sender: UIButton) {
		addEmptyCell()
	}
}

//MARK: - UITextFieldDelegate
extension SubTaskListViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		removeEmptyCell()

		guard let text = textField.text, !text.isEmpty else {
			return false
		}

		presenter.addSubTask(with: SubTaskEntity(description: text, completed: false))
		addEmptyCell()
		return true
	}
}
