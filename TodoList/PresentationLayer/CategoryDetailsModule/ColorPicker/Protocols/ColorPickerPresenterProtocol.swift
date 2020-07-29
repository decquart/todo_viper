//
//  ColorPickerPresenterProtocol.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 15.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol ColorPickerPresenterProtocol: class {
	var detailsPresenter: CategoryDetailsPresenterProtocol? { get }
	var colors: [Color] { get }
	var selectedColorIndex: Int { get }

	func didSelectColor(at index: Int)
}
