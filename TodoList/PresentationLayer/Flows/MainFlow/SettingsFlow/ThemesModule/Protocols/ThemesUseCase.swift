//
//  ThemesUseCase.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 02.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol ThemesInteractorInput: class {
	var isDarkModeEnabled: Bool { get }
	func setDarkMode(_ isOn: Bool)
}

protocol ThemesInteractorOutput: class {
	func didDarkModeChange(_ isOn: Bool)
}
