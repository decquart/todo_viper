//
//  ColorPickerView.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 14.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class ColorPickerView: UIView, ColorPickerViewProtocol {
	var presenter: ColorPickerPresenterProtocol!
	
	let inset: CGFloat = 12.0
	let minimumInteritemSpacing: CGFloat = 24

	@IBOutlet weak var collectionView: UICollectionView! {
		didSet {
			collectionView.delegate = self
			collectionView.dataSource = self
			collectionView.register(cellType: ColorPickerCollectionViewCell.self)
		}
	}
}

extension ColorPickerView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		9
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeue(cellType: ColorPickerCollectionViewCell.self, for: indexPath)
		cell.backgroundColor = .red
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

		 let noOfCellsInRow = 6
		 let totalSpace = (minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1)) + inset * 2
		 let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

		 return CGSize(width: size, height: size)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return minimumInteritemSpacing
	}
}
