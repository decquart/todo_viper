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
	func updateIcon(_ imagePath: String)
}

class IconPickerPresenter: IconPickerInput {
	weak var view: IconPickerOutput?
	weak var detailsPresenter: AddTaskOutput?

	func updateIcon(_ imagePath: String) {
		detailsPresenter?.updateIcon(imagePath)
	}
}
