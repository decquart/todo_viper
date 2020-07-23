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
	
	private let inset: CGFloat = 12.0
	private let minimumInteritemSpacing: CGFloat = 24

	@IBOutlet weak var collectionView: UICollectionView! {
		didSet {
			collectionView.delegate = self
			collectionView.dataSource = self
			collectionView.register(cellType: ColorPickerCollectionViewCell.self)
		}
	}
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ColorPickerView: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return presenter.colors.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeue(cellType: ColorPickerCollectionViewCell.self, for: indexPath)
		cell.backgroundColor = presenter.colors[indexPath.row].uiColor
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		presenter.didSelectColor(at: indexPath.row)
		//TODO: Add selection animation
	}
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ColorPickerView: UICollectionViewDelegateFlowLayout {
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