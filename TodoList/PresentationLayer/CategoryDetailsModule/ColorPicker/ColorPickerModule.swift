//
//  ColorPickerModule.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 15.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

class ColorPickerModule {
	func build() -> UIView {
		let view = Bundle.main.loadNibNamed("ColorPickerView", owner: ColorPickerView.self, options: nil)?.first as! ColorPickerView
		let presenter = ColorPickerPresenter()
		view.presenter = presenter
		presenter.view = view
		return view
	}
}
