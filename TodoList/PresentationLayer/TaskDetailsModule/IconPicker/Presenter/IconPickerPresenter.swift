//
//  IconPickerPresenter.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 26.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import Foundation

protocol IconPickerOutput: class {
	func iconDidSelect(_ imageData: Data)
}

protocol IconPickerInput: class {
	func updateIcon(_ imageData: Data)
}

class IconPickerPresenter: IconPickerInput {
	weak var view: IconPickerOutput?
	weak var detailsPresenter: AddTaskOutput?

	func updateIcon(_ imageData: Data) {
		detailsPresenter?.updateIcon(imageData)
	}
}
