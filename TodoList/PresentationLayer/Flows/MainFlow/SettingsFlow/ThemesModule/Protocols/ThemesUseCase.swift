//
//  ThemesUseCase.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 02.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

protocol ThemesInteractorInput: class {
	func saveSelectedColor(color: Color)
	func applySelectedColor()
}

protocol ThemesInteractorOutput: class {
	func didSaveColor()
	func didApplyColor()
}
