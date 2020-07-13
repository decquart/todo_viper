//
//  IconPickerPresenter.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 26.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

protocol IconPickerOutput: class {
	func iconDidSelect(_ imagePath: String)
}

protocol IconPickerInput: class {
	var imageNames: [String] { get }
	func updateIcon(at index: Int)
}

class IconPickerPresenter: IconPickerInput {
	weak var view: IconPickerOutput?
	weak var detailsPresenter: CategoryDetailsPresenterProtocol?
	
	let imageNames = ["shopping", "todo", "work"]

	func updateIcon(at index: Int) {
		detailsPresenter?.updateIcon(imageNames[index])
	}
}
