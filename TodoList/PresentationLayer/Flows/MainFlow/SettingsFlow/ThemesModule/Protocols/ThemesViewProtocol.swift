//
//  ThemesViewProtocol.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 20.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol ThemesViewProtocol {
	var presenter: ThemesPresenterProtocol! { get }

	func updateDarkModeSwitch(_ isOn: Bool)
}
