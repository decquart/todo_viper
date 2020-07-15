//
//  ColorPickerPresenterProtocol.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 15.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol ColorPickerPresenterProtocol: class {
	var view: ColorPickerViewProtocol! { get }
	var detailsPresenter: CategoryDetailsPresenterProtocol? { get }
	var colorNames: [String] { get }

	func didSelectColor(at index: Int)
}
