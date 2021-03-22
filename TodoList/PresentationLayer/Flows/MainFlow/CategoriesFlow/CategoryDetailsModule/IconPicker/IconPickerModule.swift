//
//  IconPickerModule.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 14.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

final class IconPickerModule {
	func build(_ detailsPresenter: CategoryDetailsPresenterProtocol) -> UIView {
		let view = Bundle.main.loadNibNamed("IconPickerView", owner: IconPickerView.self, options: nil)?.first as! IconPickerView
		let presenter = IconPickerPresenter(view: view, detailsPresenter: detailsPresenter)
		view.presenter = presenter

		return view
	}
}
