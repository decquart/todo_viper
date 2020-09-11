//
//  ThemesInteractor.swift
//  TodoList
//
//  Created by Volodymyr Myhailyuk on 02.09.2020.
//  Copyright © 2020 Volodymyr Mykhailiuk. All rights reserved.
//

import UIKit

final class ThemesInteractor {
	weak var output: ThemesInteractorOutput?
	private var themeService: ThemeSettingsServiceProtocol
	private var selectedColor: Color = .customBlue

	init(themeService: ThemeSettingsServiceProtocol) {
		self.themeService = themeService
	}
}

//MARK: - ThemesInteractorInput
extension ThemesInteractor: ThemesInteractorInput {
	func saveSelectedColor(color: Color) {
		selectedColor = color
	}

	func applySelectedColor() {
		UINavigationBar.appearance().tintColor = selectedColor.uiColor
		UITabBar.appearance().tintColor = selectedColor.uiColor
		themeService.applicationColor = selectedColor

		output?.didApplyColor()
	}
}
