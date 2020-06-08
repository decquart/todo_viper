//
//  TaskListViewController.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController {
	@IBOutlet weak var tasksCollectionView: UICollectionView! {
		didSet {
			tasksCollectionView.delegate = self
			tasksCollectionView.dataSource = self
			tasksCollectionView.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
		}
	}

	var presenter: TaskListViewOutput!

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		presenter.loadTasks()
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(changeEditMode))
		isEditing = false
	}
}

//MARK: - TaskListViewInput
extension TaskListViewController: TaskListViewInput {
	func didTaskFetch() {
		self.tasksCollectionView.reloadData()
	}
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension TaskListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return presenter.tasks?.count ?? 0
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TaskCollectionViewCell.identifire, for: indexPath) as? TaskCollectionViewCell else {
			return UICollectionViewCell()
		}

		let task = presenter.tasks?[indexPath.row]
		cell.taskImageView.image = UIImage(named: task?.imagePath ?? "")
		cell.taskNameLabel.text = task?.name
		cell.subTaskCountLabel.text = String(presenter.getSubTasksCount(for: task!))

		return cell
	}
}

//MARK: - UICollectionViewDelegateFlowLayout
extension TaskListViewController: UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width = (collectionView.bounds.width / 2) - 16

		return CGSize(width: width, height: width / 3)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

		presenter.didSelectTask(with: indexPath.row, isEditing: isEditing)
	}
}

//MARK: - Actions
extension TaskListViewController {
	@IBAction func buttonAddPressed(_ sender: Any) {
		presenter.addTaskButtonPressed()
	}
}

//MARK: - Edit Mode
extension TaskListViewController {
	@objc func changeEditMode() {
		isEditing = !isEditing
		navigationItem.rightBarButtonItem!.title = isEditing ? "Cancel" : "Edit"
	}
}
