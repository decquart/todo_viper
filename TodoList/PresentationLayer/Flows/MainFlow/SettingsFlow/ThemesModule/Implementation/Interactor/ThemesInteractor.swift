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
	let themeService: ThemeSettingsServiceProtocol

	init(themeService: ThemeSettingsServiceProtocol) {
		self.themeService = themeService
	}
}

//MARK: - ThemesInteractorInput
extension ThemesInteractor: ThemesInteractorInput {
	var isDarkModeEnabled: Bool {
		return themeService.isDarkModeEnabled
	}

	func setDarkMode(_ isOn: Bool) {
		themeService.setDarkModeVisble(isOn)

		output?.didDarkModeChange(isOn)
	}
}
