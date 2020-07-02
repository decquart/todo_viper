//
//  IconPickerView.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 25.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class IconPickerView: UIView {

	//todo
	let images = [UIImage(named: "shopping"), UIImage(named: "todo"), UIImage(named: "work")]
	let imageNames = ["shopping", "todo", "work"]
	private var selectedCell: IconPickerCollectionViewCell? = nil
	private var presenter: IconPickerInput!

	@IBOutlet weak private var collectionView: UICollectionView! {
		didSet {
			collectionView.delegate = self
			collectionView.dataSource = self
			collectionView.register(UINib.init(nibName: "IconPickerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "IconPickerCollectionViewCell")
			collectionView.allowsSelection = true
		}
	}

	class func instantiate(presenter: IconPickerInput) -> IconPickerView {
		let view = Bundle.main.loadNibNamed("IconPickerView", owner: self, options: nil)?.first as! IconPickerView
		view.presenter = presenter

		return view
	}
}

extension IconPickerView: IconPickerOutput {
	func iconDidSelect(_ imageData: Data) {

	}
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension IconPickerView: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		images.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IconPickerCollectionViewCell", for: indexPath) as? IconPickerCollectionViewCell else {
			return UICollectionViewCell()
		}

		cell.imageView.image = images[indexPath.row]
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard let cell = collectionView.cellForItem(at: indexPath) as? IconPickerCollectionViewCell else {
			return
		}

		selectedCell?.layer.backgroundColor = UIColor.clear.cgColor
		cell.layer.backgroundColor = #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1)
		selectedCell = cell

		let img = UIImage(named: imageNames[indexPath.row])!
		presenter.updateIcon(img.pngData()!)
	}
}

// MARK: UICollectionViewDelegateFlowLayout
extension IconPickerView: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 40, height: 40)
	}
}
