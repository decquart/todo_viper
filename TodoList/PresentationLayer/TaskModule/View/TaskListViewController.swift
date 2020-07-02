//
//  TaskListViewController.swift
//  TodoList
//
//  Created by Volodymyr Mykhailiuk on 28.05.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController {
	@IBOutlet weak private var collectionView: UICollectionView! {
		didSet {
			collectionView.delegate = self
			collectionView.dataSource = self
			collectionView.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
		}
	}

	var presenter: TaskListViewOutput!
	let inset: CGFloat = 8.0

	override func viewDidLoad() {
		super.viewDidLoad()

		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(changeEditMode))
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		presenter.loadTasks()
	}

	@objc func changeEditMode() {
		isEditing = !isEditing
		navigationItem.rightBarButtonItem!.title = isEditing ? "Cancel" : "Edit"
	}
}

//MARK: - TaskListViewInput
extension TaskListViewController: TaskListViewInput {
	var isEditMode: Bool {
		return isEditing
	}

	func didTaskFetch() {
		self.collectionView.reloadData()
	}
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension TaskListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return presenter.numberOfTasks
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TaskCollectionViewCell.identifire, for: indexPath) as? TaskCollectionViewCell, let vm = presenter.task(at: indexPath.row) else {
			return UICollectionViewCell()
		}

		cell.configure(with: vm)
		return cell
	}
}

//MARK: - UICollectionViewDelegateFlowLayout
extension TaskListViewController: UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width = (collectionView.bounds.width / 2) - inset * 2

		return CGSize(width: width, height: width / 3)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

		presenter.didSelectTask(with: indexPath.row)
	}
}

//MARK: - Actions
extension TaskListViewController {
	@IBAction func buttonAddPressed(_ sender: Any) {
		presenter.addTaskButtonPressed()
	}
}
