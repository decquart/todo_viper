//
//  ColorPickerPresenter.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 15.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

class ColorPickerPresenter: ColorPickerPresenterProtocol {
	weak var view: ColorPickerViewProtocol!
	weak var detailsPresenter: CategoryDetailsPresenterProtocol?

	var colorNames: [String] {
		return ["CustomBlue", "CustomGreen", "CustomIndigo", "CustomOrange", "CustomPink", "CustomPurple", "CustomRed", "CustomTeal", "CustomYellow"]
	}

	func didSelectColor(at index: Int) {
		detailsPresenter?.updateColor(colorNames[index])
	}
}
