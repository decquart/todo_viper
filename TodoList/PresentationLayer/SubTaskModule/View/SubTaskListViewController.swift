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

	@IBOutlet weak var tableView: UITableView! {
		didSet {
			tableView.isEditing = true
		}
	}

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
		guard let cell = tableView.dequeueReusableCell(withIdentifier: SubTaskCell.identifire, for: indexPath) as? SubTaskCell else {
			return UITableViewCell()
		}

		configure(cell: cell, for: indexPath)
		return cell
	}
    
    func configure(cell: SubTaskCell, for indexPath: IndexPath) {
        let subTask = presenter.subTask(at: indexPath)
        cell.textField.text = subTask?.description
        cell.textField.returnKeyType = .next

        if subTask?.completed == true {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
		} else {
			tableView.deselectRow(at: indexPath, animated: false)
		}
    }

	func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
		presenter.didSelect(at: indexPath)
		return indexPath
	}

	func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
		presenter.didSelect(at: indexPath)
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

            let newSubTask = SubTaskEntity(description: name, completed: false)
            self.presenter.addSubTask(with: newSubTask)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .default)

        alert.addAction(cancelAction)
        alert.addAction(saveAction)

        present(alert, animated: true)
	}
}

extension SubTaskListViewController: SubTaskListAdapterView {
	func beginUpdates() {
		tableView.beginUpdates()
	}

	func endUpdates() {
		tableView.endUpdates()
	}

	func insertRow(at newIndexPath: IndexPath?) {
		tableView.insertRows(at: [newIndexPath!], with: .automatic)
	}

	func deleteRow(at indexPath: IndexPath?) {
		tableView.deleteRows(at: [indexPath!], with: .automatic)
	}

	func updateRow(at indexPath: IndexPath?) {
		let cell = tableView.cellForRow(at: indexPath!) as! SubTaskCell
		configure(cell: cell, for: indexPath!)
	}

	func moveRow(from indexPath: IndexPath?, to newIndexPath: IndexPath?) {
		tableView.deleteRows(at: [indexPath!], with: .automatic)
		tableView.insertRows(at: [newIndexPath!], with: .automatic)
	}
}
