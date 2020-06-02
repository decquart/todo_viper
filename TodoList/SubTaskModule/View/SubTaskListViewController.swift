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
	
	@IBOutlet weak var subCategoriesCollectionView: UICollectionView! {
		didSet {
			subCategoriesCollectionView.delegate = self
			subCategoriesCollectionView.dataSource = self
		}
	}
	override func viewDidLoad() {
        super.viewDidLoad()

		presenter.loadSubTasks()
    }
}

extension SubTaskListViewController: SubTaskListViewInput {
	func subTaskDidLoad() {
		subCategoriesCollectionView.reloadData()
	}

	func taskDidAdd() {
		//todo
	}
}

extension SubTaskListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return presenter.subTasks?.count ?? 0
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubTaskCollectionViewCell.identifire, for: indexPath) as? SubTaskCollectionViewCell else {
			return UICollectionViewCell()
		}

		let subTask = presenter.subTasks?[indexPath.row]
		cell.descriptionLabel.text = subTask?.description_p
		return cell
	}
}

extension SubTaskListViewController {
	@IBAction func addRandomPressed(_ sender: Any) {
		let data = TaskDataProvider.subTaskData
		presenter.addSubTask(with: data)
		subCategoriesCollectionView.reloadData()
	}
}
