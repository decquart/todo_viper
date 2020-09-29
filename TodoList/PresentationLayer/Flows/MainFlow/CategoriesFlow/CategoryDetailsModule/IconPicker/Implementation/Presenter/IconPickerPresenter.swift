//
//  IconPickerPresenter.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 26.06.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

class IconPickerPresenter: IconPickerPresenterProtocol {
	unowned var view: IconPickerViewProtocol
	unowned var detailsPresenter: CategoryDetailsPresenterProtocol
	
	let imageNames = ["shopping", "todo", "work"]

	init(view: IconPickerViewProtocol, detailsPresenter: CategoryDetailsPresenterProtocol) {
		self.view = view
		self.detailsPresenter = detailsPresenter
	}

	func updateIcon(at index: Int) {
		detailsPresenter.updateIcon(imageNames[index])
	}
}
