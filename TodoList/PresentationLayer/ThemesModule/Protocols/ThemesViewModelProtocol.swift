//
//  ThemesViewModelProtocol.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 20.07.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol ThemesViewModelProtocol {
	var isDarkMode: Box<Bool> { get }

	func setDarkMode(_ isSwitchOn: Bool)
	func didLoad()
}
